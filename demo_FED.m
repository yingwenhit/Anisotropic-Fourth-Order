clear; close all;
addpath('tools');

% the choice of parameters are given in './parameter/2021_FED'
% from left to right: [], image_name, std_n, sigma, K1, PSNR, iter


%     model, img_name, std_n, sigma, k, PSNR, M
img   = 'lena'; % image_name
std_n = 40; % std_n
sigma = 1.2; % sigma
K1    = 4; % K1
iter  = 25; % index

img_path = 'Test_Images/';
image_name = [img_path, img];
name_mat = [image_name '_' num2str(std_n) '_addnoise.mat'];
load (name_mat)

% %% parameter
gama = 1e-2;
TM = 2;
[MAE, PSNR, SNR, SSIM, t, var, I_FED] ...
    = FourthOrder_FED(Ig, In, TM, sigma, K1, gama, iter);

dif = In - I_FED;
I_dif_2 = uint8(dif + 128);

% imwrite(uint8(I_FED), ...
%     [img '_' num2str(std_n) '_FED_smooth.png' ]);
% imwrite(uint8(I_dif_2), ...
%     [img '_' num2str(std_n) '_FED_dif.png']);

[maxPSNR, idx_psnr] = max(PSNR);




