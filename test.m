% automatic stopping
% std = std_n^2*0.9;

clear all; close all;

load('parameter/2021_expct.mat')
Exp_Res_2021 = cell(30,8);
for num=1:30
    img = parameter_exp_2021{num, 2}; % image_name
    std_n = parameter_exp_2021{num, 3}; % std_n
    sigma = parameter_exp_2021{num, 4}; % sigma
    K1 = parameter_exp_2021{num, 5}; % K1
    index = parameter_exp_2021{num, 7}; % index
    
    tau = 0.01;
    auto_p = 0.8;
    
    img_path = 'TestImage/';
    image_name = [img_path, img];
    name_mat = [image_name '_' num2str(std_n) '_addnoise.mat'];
    load (name_mat)
    
    [MAE, PSNR, SNR, SSIM, t, var, I_explicit, iter] = ...
        Forth_Order_nocross(Ig,In,tau,K1,K1,sigma,std_n,auto_p);
    
    dif = In - I_explicit;
    I_dif_2 = uint8(dif + 128);
   
    imwrite(uint8(I_explicit), ...
        ['resImg/' img '_' num2str(std_n) '_explicit_smooth.png' ]);
    imwrite(uint8(I_dif_2), ...
        ['resImg/' img '_' num2str(std_n) '_explicit_dif.png']);
    
    Exp_Res_2021{num,1} = img;
    Exp_Res_2021{num,2} = std_n;
    Exp_Res_2021{num,3} = PSNR(end);
    Exp_Res_2021{num,4} = SSIM(end);
    Exp_Res_2021{num,5} = sigma;
    Exp_Res_2021{num,6} = iter;
    Exp_Res_2021{num,7} = K1;
    Exp_Res_2021{num,8} = t;
    save(['resImg/' img '_' num2str(std_n) '_res.mat'])
    clear('MAE', 'PSNR', 'SNR', 'SSIM', 't', 'var', 'I_explicit', 'iter', 'dif', 'I_dif_2', 'Ig', 'In');
end
save('resImg/Exp_Res_2021','Exp_Res_2021');
% x=1:iter;
% figure(6);
% subplot(221);plot(x,PSNR);title('PSNR')
% subplot(222);plot(x,MAE);title('MAE')
% subplot(223);plot(x,SNR);title('SNR')
% subplot(224);plot(x,SSIM);title('SSIM')

