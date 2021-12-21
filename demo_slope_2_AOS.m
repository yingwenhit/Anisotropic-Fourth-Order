clear; close all;
addpath('tools')

img = 'GZC02';
std_n = 15;
sigma = 0;
K1 = 1;
iter = 1062;
tau = 0.1;

% name_mat = 'GZC02_15_addnoise.mat';
name_mat = ['Test_Images/' img '_' num2str(std_n) '_addnoise.mat'];
load (name_mat)

[PSNR,MAE,SNR,SSIM,t,var,I_AOS] = ...
FourthOrder_AOS(Ig, In, tau, sigma, K1, K1, iter);

dif = In - I_AOS;
I_dif_2 = uint8(dif + 128);

% imwrite(uint8(I_AOS), ...
%     [img '_' num2str(std_n) '_AOS_smooth.png' ]);
% imwrite(uint8(I_dif_2), ...
%     [img '_' num2str(std_n) '_AOS_dif.png']);

% save(['AOS_' img '_' num2str(std_n) '_res.mat'])
% save([img '_AOS_Res_2021'], 'AOS_Res_2021');
