
clear; close all;
addpath('tools');

% the choice of parameters are given in './parameter/2021_AOS'
% from left to right: [], image_name, std_n, sigma, K1, PSNR, iter
    
img   = 'lena'; % image_name
std_n = 40; % std_n
sigma = 0.5; % sigma
K1    = 4; % K1
iter  = 31; % index
tau   = 2;

img_path = 'Test_Images/';
image_name = [img_path, img];
name_mat = [image_name '_' num2str(std_n) '_addnoise.mat'];
load (name_mat)

[PSNR,MAE,SNR,SSIM,t,var,I_AOS] = ...
    FourthOrder_AOS(Ig, In, tau, sigma, K1, K1, iter);

dif = In - I_AOS;
I_dif_2 = uint8(dif + 128);

[maxPSNR, idx_psnr] = max(PSNR);

% imwrite(uint8(I_AOS), ...
%     [img '_' num2str(std_n) '_AOS_smooth.png' ]);
% imwrite(uint8(I_dif_2), ...
%     [img '_' num2str(std_n) '_AOS_dif.png']);

