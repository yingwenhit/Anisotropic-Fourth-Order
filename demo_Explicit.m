clear all; close all;
addpath('tools');

img   = 'lena'; % image_name
std_n = 40; % std_n
sigma = 1; % sigma
K1    = 4; % K1
iter  = 5358; % index

tau = 0.01;


img_path = 'Test_Images/';
image_name = [img_path, img];
name_mat = [image_name '_' num2str(std_n) '_addnoise.mat'];
load (name_mat)

[MAE, PSNR, SNR, SSIM, t, var, I_explicit] = ...
    FourthOrder_Explicit(Ig,In,tau,K1,K1,sigma,iter);

dif = In - I_explicit;
I_dif_2 = uint8(dif + 128);

% imwrite(uint8(I_explicit), ...
%     [img '_' num2str(std_n) '_explicit_smooth.png' ]);
% imwrite(uint8(I_dif_2), ...
%     [img '_' num2str(std_n) '_explicit_dif.png']);

[maxPSNR, idx_psnr] = max(PSNR);
