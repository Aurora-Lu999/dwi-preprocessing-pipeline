# DWI Preprocessing Pipeline

This project implements a diffusion MRI preprocessing pipeline for mouse brain data.

## Current Pipeline

- Low-b volume extraction and mean b0 generation  
- T2-to-DWI registration (FLIRT)  
- Manual mask transformation to diffusion space  
- N4 bias field correction  
- Eddy correction  
- Tensor fitting (dtifit) to generate FA maps  

## Results

The FA maps look reasonably consistent across methods, although some noise and blurring remain.

## Additional Test: Gibbs Ringing Correction

I evaluated the effect of `mrdegibbs` using different axis configurations (0,1), (1,2), and (0,2).

Results:
- DWI and FA maps were visually similar across all three configurations
- Suggesting that axis selection is not a major factor for this dataset

## Next Steps

- Improve preprocessing to reduce noise and artifacts  

## Notes

This pipeline is developed based on guidance from Dr. Badea.
