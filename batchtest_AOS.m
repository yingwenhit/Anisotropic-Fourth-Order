% automatic stopping,
% if there is no auto_p in the mat file, auto_p = 0.8 (the first time)

clear; close all;
addpath('tools');

load('parameter/2021_AOS.mat')
for num=1:30
    img   = parameter_AOS_2021{num, 2}; % image_name
    std_n = parameter_AOS_2021{num, 3}; % std_n
    sigma = parameter_AOS_2021{num, 4}; % sigma
    K1    = parameter_AOS_2021{num, 5}; % K1
    iter = parameter_AOS_2021{num, 7}; % index
    
    
    img_path = 'Test_Images/';
    image_name = [img_path, img];
    name_mat = [image_name '_' num2str(std_n) '_addnoise.mat'];
    load (name_mat)
    
    [PSNR,MAE,SNR,SSIM,t,var,I_AOS] = ...
        Implicit_Scheme_AOS_v3(Ig, In, tau, sigma, K1, K1, iter);
    
    dif = In - I_AOS;
    I_dif_2 = uint8(dif + 128);
    
    [maxPSNR, idx_psnr] = max(PSNR);
    
    imwrite(uint8(I_AOS), ...
        [img '_' num2str(std_n) '_AOS_smooth.png' ]);
    imwrite(uint8(I_dif_2), ...
        [img '_' num2str(std_n) '_AOS_dif.png']);
    
%     save(['resImg/AOS_' img '_' num2str(std_n) '_res.mat'])
%     clear('MAE', 'PSNR', 'SNR', 'SSIM', 't', 'var', 'I_AOS', 'iter', 'dif', 'I_dif_2', 'Ig', 'In');
end

