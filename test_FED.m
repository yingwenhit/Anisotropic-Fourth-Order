% automatic stopping
% the first time: std = std_n^2*0.7;

% clear; close all;
%
% load('parameter/2021_FED.mat')
% FED_Res_2021 = cell(30,8);
% for num=1:30
%     %     if mod(num,5) == 1 || mod(num,5)==2
%     %     model, img_name, std_n, sigma, k, PSNR, M
%     img   = parameter_FED_2021{num, 2}; % image_name
%     std_n = parameter_FED_2021{num, 3}; % std_n
%     sigma = parameter_FED_2021{num, 4}; % sigma
%     K1    = parameter_FED_2021{num, 5}; % K1
%     index = parameter_FED_2021{num, 7}; % index
%
%     img_path = 'TestImage/';
%     image_name = [img_path, img];
%     name_mat = [image_name '_' num2str(std_n) '_addnoise.mat'];
%     load (name_mat)
%
%     % %% parameter
%     gama = 1e-2;
%     TM = 2;
%     auto_p = 0.8;
%     [MAE, PSNR, SNR, SSIM, t, var, I_FED, iter] ...
%         = Forth_Order_nocross_FED_v2(Ig, In, TM, sigma, K1, gama, std_n, auto_p);
%
%     dif = In - I_FED;
%     I_dif_2 = uint8(dif + 128);
%
%     imwrite(uint8(I_FED), ...
%         ['resImg/' img '_' num2str(std_n) '_FED_smooth.png' ]);
%     imwrite(uint8(I_dif_2), ...
%         ['resImg/' img '_' num2str(std_n) '_FED_dif.png']);
%
%     FED_Res_2021{num,1} = img;
%     FED_Res_2021{num,2} = std_n;
%     FED_Res_2021{num,3} = PSNR(end);
%     FED_Res_2021{num,4} = SSIM(end);
%     FED_Res_2021{num,5} = sigma;
%     FED_Res_2021{num,6} = iter;
%     FED_Res_2021{num,7} = K1;
%     FED_Res_2021{num,8} = t;
%     save(['resImg/FED_' img '_' num2str(std_n) '_res.mat'])
%     clear('MAE', 'PSNR', 'SNR', 'SSIM', 't', 'var', 'I_FED', 'iter', 'dif', 'I_dif_2', 'Ig', 'In');
%     %     end
% end
% save('resImg/FED_Res_2021','FED_Res_2021');


%% synthetic image: Article3, std_n = 40
clear; close all;

%% parameter
gama = 1e-2;
K1 = 1;
sigma = 0;
M = [];
T = [];
TM = 2;

std_n = 20;
img = 'GZC01';
img_path = 'TestImage/';
image_name = [img_path, img];
name_mat = [image_name '_' num2str(std_n) '_addnoise.mat'];
load (name_mat)

%% FED denoising
auto_p = 1;
[MAE, PSNR, SNR, SSIM, t, var, I_FED, iter] ...
    = Forth_Order_nocross_FED_v2(Ig, In, TM, sigma, K1, gama, std_n, auto_p);

dif = In - I_FED;
I_dif_2 = uint8(dif + 128);

imwrite(uint8(I_FED), ...
    ['synthetic/' img '_' num2str(std_n) '_FED_smooth.png' ]);
imwrite(uint8(I_dif_2), ...
    ['synthetic/' img '_' num2str(std_n) '_FED_dif.png']);

FED_Res_2021{1,1} = img;
FED_Res_2021{1,2} = std_n;
FED_Res_2021{1,3} = PSNR(end);
FED_Res_2021{1,4} = SSIM(end);
FED_Res_2021{1,5} = sigma;
FED_Res_2021{1,6} = iter;
FED_Res_2021{1,7} = K1;
FED_Res_2021{1,8} = t;
save(['synthetic/FED_' img '_' num2str(std_n) '_res.mat'])
save(['synthetic/' img '_FED_Res_2021'],'FED_Res_2021');


