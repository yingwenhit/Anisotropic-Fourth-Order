clear; close all;
addpath('tools')

%% parameter
gama = 1e-2;
K1 = 1;
sigma = 0;
M = [];
T = [];
TM = 0.05;
iter = 2061;

std_n = 15;
img = 'GZC02';
% name_mat = 'GZC02_15_addnoise.mat';
name_mat = ['Test_Images/' img '_' num2str(std_n) '_addnoise.mat'];
load (name_mat)

%% FED denoising
[MAE, PSNR, SNR, SSIM, t, var, I_FED] ...
    = FourthOrder_FED(Ig, In, TM, sigma, K1, gama, iter);

dif = In - I_FED;
I_dif_2 = uint8(dif + 128);

% imwrite(uint8(I_FED), ...
%     [img '_' num2str(std_n) '_FED_smooth.png' ]);
% imwrite(uint8(I_dif_2), ...
%     [img '_' num2str(std_n) '_FED_dif.png']);

% save(['FED_' img '_' num2str(std_n) '_res.mat'])
% save([img '_FED_Res_2021'], 'FED_Res_2021');


