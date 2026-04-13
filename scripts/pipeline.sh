# Step 1: Extract mean b0
dwiextract all_niis/B25122902_DTI.nii.gz \
  -fslgrad all_niis/B25122902_DTI.bvec all_niis/B25122902_DTI.bval \
  -shells 25.0545 - \
| mrmath - mean all_niis/B25122902_mean_b0.nii.gz -axis 3

# Step 2: Register T2 to b0
flirt \
  -in all_niis/B25122902_T2.nii.gz \
  -ref all_niis/B25122902_mean_b0.nii.gz \
  -out all_niis/B25122902_T2_in_b0.nii.gz \
  -omat all_niis/B25122902_T2_to_b0.mat

# Step 3: Transform mask
flirt \
  -in masks/B25122902_mask_T2.nii.gz \
  -ref all_niis/B25122902_mean_b0.nii.gz \
  -applyxfm \
  -init all_niis/B25122902_T2_to_b0.mat \
  -out all_niis/B25122902_mask_in_b0.nii.gz \
  -interp nearestneighbour

# Step 4: Eddy correction
eddy_correct \
  all_niis/B25122902_DTI.nii.gz \
  all_niis/B25122902_DTI_eddy.nii.gz \
  0

# Step 5: Rotate bvecs
fdt_rotate_bvecs \
  all_niis/B25122902_DTI.bvec \
  all_niis/B25122902_DTI_eddy.eddy_parameters \
  all_niis/B25122902_DTI_eddy.bvec

# Step 6: Tensor fitting
dwi2tensor \
  all_niis/B25122902_DTI_eddy.nii.gz \
  all_niis/B25122902_tensor.mif \
  -fslgrad all_niis/B25122902_DTI_eddy.bvec all_niis/B25122902_DTI.bval \
  -mask all_niis/B25122902_mask_in_b0.nii.gz

tensor2metric \
  all_niis/B25122902_tensor.mif \
  -fa all_niis/B25122902_FA.nii.gz
