clear all; close all;
addpath('tools');


load('parameter/2021_explicit.mat')
for num=1:30
    img = parameter_exp_2021{num, 2}; % image_name
    std_n = parameter_exp_2021{num, 3}; % std_n
    sigma = parameter_exp_2021{num, 4}; % sigma
    K1 = parameter_exp_2021{num, 5}; % K1
    iter = parameter_exp_2021{num, 7}; % index
    
    tau = 0.01;
    
    img_path = 'Test_Images/';
    image_name = [img_path, img];
    name_mat = [image_name '_' num2str(std_n) '_addnoise.mat'];
    load (name_mat)
    
    [MAE, PSNR, SNR, SSIM, t, var, I_explicit] = ...
        FourthOrder_Explicit(Ig,In,tau,K1,K1,sigma,iter);
    
    dif = In - I_explicit;
    I_dif_2 = uint8(dif + 128);
    
    imwrite(uint8(I_explicit), ...
        [img '_' num2str(std_n) '_explicit_smooth.png' ]);
    imwrite(uint8(I_dif_2), ...
        [img '_' num2str(std_n) '_explicit_dif.png']);
    
    [maxPSNR, idx_psnr] = max(PSNR);
    
%     save([img '_' num2str(std_n) '_res.mat'])
%     clear('MAE', 'PSNR', 'SNR', 'SSIM', 't', 'var', 'I_explicit', 'iter', 'dif', 'I_dif_2', 'Ig', 'In', 'maxPSNR', 'idx_psnr');
end