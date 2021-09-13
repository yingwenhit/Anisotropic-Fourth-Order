clear all
close all
% BOX

% I = imread('./access-Fourth-resubmit/res_smooth_dif/natural/07_50_addnoise.png');
% figure,imshow(I)
% load 07_50_TDM.mat

ImgPath = './resImg/AOS/';
ImgName = 'AOS_im_73_30_res.mat';
load([ImgPath ImgName]);
Is = I_AOS;
% Is = imread('./DnCNNres/save_DnCNN_sigma50_2020-12-08-13-53-49/Fourth_Order_Test_Image/07_50_addnoise_psnr26.43.png');
% figure,imshow(Is,[])

%% im_73
x1 = 99;
y1 = 83;
x2 = 129;
y2 = 161;
x_1 = 1;
y_1 = 186;
x_2 = 60;
y_2 = 341;

% %% butterfly
% x1 = 204;
% y1 = 166;
% x2 = 248;
% y2 = 200;
% x_1 = 169;
% y_1 = 1;
% x_2 = 256;
% y_2 = 68;

% %% lena
% x1 = 106;
% y1 = 189;
% x2 = 146;
% y2 = 247;
% x_1 = 223;
% y_1 = 256;
% x_2 = 302;
% y_2 = 371;

% %% 07
% x1 = 40;
% y1 = 92;
% x2 = 79;
% y2 = 137;
% x_1 = 179;
% y_1 = 167;
% x_2 = 256;
% y_2 = 256;

Is_p = Is([x1+1:x2-1], [y1+1:y2-1]);
Is_z = imresize(Is_p, 2);
Is([x_1+1:x_2-1], [y_1+1:y_2-1]) = Is_z;

IS(:,:,1) = Is;
IS(:,:,2) = Is;
IS(:,:,3) = Is;

IS([x1,x2],[y1:y2],1) = 255;
IS([x1:x2],[y1,y2],1) = 255;
IS([x1,x2],[y1:y2],2) = 0;
IS([x1:x2],[y1,y2],2) = 0;
IS([x1,x2],[y1:y2],3) = 0;
IS([x1:x2],[y1,y2],3) = 0;

IS([x_1,x_2],[y_1:y_2],1) = 255;
IS([x_1:x_2],[y_1,y_2],1) = 255;
IS([x_1,x_2],[y_1:y_2],2) = 0;
IS([x_1:x_2],[y_1,y_2],2) = 0;
IS([x_1,x_2],[y_1:y_2],3) = 0;
IS([x_1:x_2],[y_1,y_2],3) = 0;

figure,imshow(uint8(IS))
imwrite(uint8(IS), 'im_73_30_AOS_smooth.png')