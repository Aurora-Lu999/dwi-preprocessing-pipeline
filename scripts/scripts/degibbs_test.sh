# Test mrdegibbs with different axes (B25122902)

# Step 1: Convert eddy-corrected DWI
mrconvert all_niis/B25122902_DTI_eddy.nii.gz dwi_eddy.mif \
-fslgrad all_niis/B25122902_DTI_eddy.bvec all_niis/B25122902_DTI.bval

# Step 2: Fix stride
mrconvert dwi_eddy.mif dwi_eddy_strided.mif -stride 0,0,0,1

# Step 3: Apply mrdegibbs with different axes
mrdegibbs dwi_eddy_strided.mif dwi_degibbs_01.mif -axes 0,1
mrdegibbs dwi_eddy_strided.mif dwi_degibbs_12.mif -axes 1,2
mrdegibbs dwi_eddy_strided.mif dwi_degibbs_02.mif -axes 0,2

# Step 4: Convert mask
mrconvert all_niis/B25122902_mask_in_b0.nii.gz mask.mif

# Step 5: Tensor fitting + FA (each version)

# axes 0,1
dwi2tensor dwi_degibbs_01.mif -mask mask.mif tensor_01.mif
tensor2metric tensor_01.mif -fa fa_01.mif
mrconvert fa_01.mif fa_01.nii.gz

# axes 1,2
dwi2tensor dwi_degibbs_12.mif -mask mask.mif tensor_12.mif
tensor2metric tensor_12.mif -fa fa_12.mif
mrconvert fa_12.mif fa_12.nii.gz

# axes 0,2
dwi2tensor dwi_degibbs_02.mif -mask mask.mif tensor_02.mif
tensor2metric tensor_02.mif -fa fa_02.mif
mrconvert fa_02.mif fa_02.nii.gz
