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

## Next Steps

- Apply mrdegibbs at the DWI stage  
- Compare results across axes  
- Improve preprocessing to reduce noise and artifacts  

## Notes

This pipeline is developed based on guidance from Prof. Badea.
