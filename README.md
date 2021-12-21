# Anisotropic-Fourth-Order
code of paper "A new anisotropic fourth-order diffusion equation model based on image features for image denoising"

* The file 'tools' includes the soure code. 
  - 'FourthOrder_AOS.m' -- AOS scheme
  - 'FourthOrder_FED.m' -- FED scheme
  - 'FourthOrder_Explicit.m' -- explicit scheme
  
* The file 'Test_Images' -- noisy images and original images.
* The file 'Results_Natural' -- denoising results of the synthetic images
* The file 'Results_Synthetic' -- denoising results of the natural images.
* The file 'parameter'
  - '2021_AOS.mat' -- the choice of parameters for the AOS scheme, from left to right: [], image_name, std_n, sigma, K1, PSNR, iter
  - '2021_FED.mat' -- the choice of parameters for the FED scheme, from left to right: [], image_name, std_n, sigma, K1, PSNR, iter
  - '2021_explicit.mat' -- the choice of parameters for the explicit scheme, from left to right: [], image_name, std_n, sigma, K1, PSNR, iter
  
------------------------------------------------------------------------------------------------------------------------------------------------

Demo
* Synthetic images:
  - geometry
    - 'demo_geometry_AOS.m' -- the AOS scheme (Figure 9).
    - 'demo_geometry_FED.m' -- the FED schemes (Figure 9).
  - slope-
    - 'demo_slope_1_AOS.m' -- the AOS scheme (Figure 11 and 12).
    - 'demo_slope_2_FED.m' -- the FED scheme (Figure 11 and 12).
  - slope-2
    - 'demo_slope_2_AOS.m' -- the AOS scheme (Figure 13).
    - 'demo_slope_2_FED.m' -- the FED scheme (Figure 13).

* Natural images: (subsection 5.3)
    - 'demo_AOS.m' -- the AOS scheme.
    - 'demo_FED.m' -- the AOS scheme.
    - 'demo_Explicit.m' -- the AOS scheme. 
  - batchtest: (test the 30 natural noisy images)
    - 'batchtest_AOS.m'
    - 'batchtest_FED.m'
    - 'batchtest_Explicit.m'

