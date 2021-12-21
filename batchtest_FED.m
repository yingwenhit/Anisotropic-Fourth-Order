clear; close all;
addpath('tools');

load('parameter/2021_FED.mat')
for num=1:30
    %     model, img_name, std_n, sigma, k, PSNR, M
    img   = parameter_FED_2021{num, 2}; % image_name
    std_n = parameter_FED_2021{num, 3}; % std_n
    sigma = parameter_FED_2021{num, 4}; % sigma
    K1    = parameter_FED_2021{num, 5}; % K1
    iter = parameter_FED_2021{num, 7}; % index
    
    img_path = 'Test_Images/';
    image_name = [img_path, img];
    name_mat = [image_name '_' num2str(std_n) '_addnoise.mat'];
    load (name_mat)
    
    %%% parameter
    gama = 1e-2;
    TM = 2;
    
    [MAE, PSNR, SNR, SSIM, t, var, I_FED] ...
        = FourthOrder_FED(Ig, In, TM, sigma, K1, gama, iter);
    
    dif = In - I_FED;
    I_dif_2 = uint8(dif + 128);
    
%     imwrite(uint8(I_FED), ...
%         ['resImg/' img '_' num2str(std_n) '_FED_smooth.png' ]);
%     imwrite(uint8(I_dif_2), ...
%         ['resImg/' img '_' num2str(std_n) '_FED_dif.png']);
    
    [maxPSNR, idx_psnr] = max(PSNR);
    
%     save(['FED_' img '_' num2str(std_n) '_res.mat'])
%     clear('MAE', 'PSNR', 'SNR', 'SSIM', 't', 'var', 'I_FED', 'iter', 'dif', 'I_dif_2', 'Ig', 'In');
end