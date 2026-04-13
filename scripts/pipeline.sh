# Step 0: go to project folder
cd ~/aurora/data/GLP_1

# Step 1: generate mean b0 from the lowest b-value shell
dwiextract all_niis/B25122902_DTI.nii.gz \
  -fslgrad all_niis/B25122902_DTI.bvec all_niis/B25122902_DTI.bval \
  -shells 25.0545 - \
| mrmath - mean all_niis/B25122902_mean_b0.nii.gz -axis 3

# Step 2: register T2 to diffusion reference
flirt \
  -in all_niis/B25122902_T2.nii.gz \
  -ref all_niis/B25122902_mean_b0.nii.gz \
  -out all_niis/B25122902_T2_in_b0.nii.gz \
  -omat all_niis/B25122902_T2_to_b0.mat

# Step 3: transform manual mask into diffusion space
flirt \
  -in masks/B25122902_mask_T2.nii.gz \
  -ref all_niis/B25122902_mean_b0.nii.gz \
  -applyxfm \
  -init all_niis/B25122902_T2_to_b0.mat \
  -out all_niis/B25122902_mask_in_b0.nii.gz \
  -interp nearestneighbour

# Step 4: N4 bias field correction on mean b0
N4BiasFieldCorrection \
  -d 3 \
  -i all_niis/B25122902_mean_b0.nii.gz \
  -o all_niis/B25122902_mean_b0_N4.nii.gz

# Step 5: eddy correction
eddy_correct \
  all_niis/B25122902_DTI.nii.gz \
  all_niis/B25122902_DTI_eddy.nii.gz \
  0

# Step 6: rotate bvecs after eddy correction
fdt_rotate_bvecs \
  all_niis/B25122902_DTI.bvec \
  all_niis/B25122902_DTI_eddy.bvec \
  all_niis/B25122902_DTI_eddy.ecclog

# Step 7: tensor fitting with FSL dtifit
dtifit \
  -k all_niis/B25122902_DTI_eddy.nii.gz \
  -o all_niis/B25122902_dtifit \
  -m all_niis/B25122902_mask_in_b0.nii.gz \
  -r all_niis/B25122902_DTI_eddy.bvec \
  -b all_niis/B25122902_DTI.bval
