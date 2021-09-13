% automatic stopping,
% if there is no auto_p in the mat file, auto_p = 0.8 (the first time)

% clear; close all;
%
% load('parameter/2021_AOS.mat')
% AOS_Res_2021 = cell(30,8);
% for num=21:30
%     img   = parameter_AOS_2021{num, 2}; % image_name
%     std_n = parameter_AOS_2021{num, 3}; % std_n
%     sigma = parameter_AOS_2021{num, 4}; % sigma
%     K1    = parameter_AOS_2021{num, 5}; % K1
%     index = parameter_AOS_2021{num, 7}; % index
%
%     tau = 2;
%     auto_p = 1.1;
%
%     img_path = 'TestImage/';
%     image_name = [img_path, img];
%     name_mat = [image_name '_' num2str(std_n) '_addnoise.mat'];
%     load (name_mat)
%
%     [PSNR,MAE,SNR,SSIM,t,var,I_AOS,iter] = ...
%     Implicit_Scheme_AOS_v3(Ig, In, tau, sigma, K1, K1, std_n, auto_p);
%
%     dif = In - I_AOS;
%     I_dif_2 = uint8(dif + 128);
%
%     imwrite(uint8(I_AOS), ...
%         ['resImg/' img '_' num2str(std_n) '_AOS_smooth.png' ]);
%     imwrite(uint8(I_dif_2), ...
%         ['resImg/' img '_' num2str(std_n) '_AOS_dif.png']);
%
%     AOS_Res_2021{num,1} = img;
%     AOS_Res_2021{num,2} = std_n;
%     AOS_Res_2021{num,3} = PSNR(end);
%     AOS_Res_2021{num,4} = SSIM(end);
%     AOS_Res_2021{num,5} = sigma;
%     AOS_Res_2021{num,6} = iter;
%     AOS_Res_2021{num,7} = K1;
%     AOS_Res_2021{num,8} = t;
%     save(['resImg/AOS_' img '_' num2str(std_n) '_res.mat'])
%     clear('MAE', 'PSNR', 'SNR', 'SSIM', 't', 'var', 'I_AOS', 'iter', 'dif', 'I_dif_2', 'Ig', 'In');
% end
% save('resImg/AOS_Res_2021','AOS_Res_2021');

clear; close all;

%     img   = parameter_AOS_2021{num, 2}; % image_name
%     std_n = parameter_AOS_2021{num, 3}; % std_n
%     sigma = parameter_AOS_2021{num, 4}; % sigma
%     K1    = parameter_AOS_2021{num, 5}; % K1
%     index = parameter_AOS_2021{num, 7}; % index
img = 'GZC01';
std_n = 20;
sigma = 0;
K1 = 1;
index = [];

tau = 2;
auto_p = 1;

img_path = 'TestImage/';
image_name = [img_path, img];
name_mat = [image_name '_' num2str(std_n) '_addnoise.mat'];
load (name_mat)

[PSNR,MAE,SNR,SSIM,t,var,I_AOS,iter] = ...
    Implicit_Scheme_AOS_v3(Ig, In, tau, sigma, K1, K1, std_n, auto_p);

dif = In - I_AOS;
I_dif_2 = uint8(dif + 128);

imwrite(uint8(I_AOS), ...
    ['synthetic/' img '_' num2str(std_n) '_AOS_smooth.png' ]);
imwrite(uint8(I_dif_2), ...
    ['synthetic/' img '_' num2str(std_n) '_AOS_dif.png']);

AOS_Res_2021{1,1} = img;
AOS_Res_2021{1,2} = std_n;
AOS_Res_2021{1,3} = PSNR(end);
AOS_Res_2021{1,4} = SSIM(end);
AOS_Res_2021{1,5} = sigma;
AOS_Res_2021{1,6} = iter;
AOS_Res_2021{1,7} = K1;
AOS_Res_2021{1,8} = t;
save(['synthetic/AOS_' img '_' num2str(std_n) '_res.mat'])
save(['synthetic/' img '_AOS_Res_2021','AOS_Res_2021']);
