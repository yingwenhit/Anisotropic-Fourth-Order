clear all
close all

load fig10.mat

index = 74;

R = Ig;
G = Ig;
B = Ig;
R(:,index) = 255*ones(300,1);
G(:,index) = 0*ones(300,1);
B(:,index) = 0*ones(300,1);
Ig_rgb(:,:,1) = R;
Ig_rgb(:,:,2) = G;
Ig_rgb(:,:,3) = B;
Ig_rgb = uint8(Ig_rgb);
% figure,imshow(Ig_rgb)
imwrite(Ig_rgb,'fig10_a.png')

Ig1 = Ig(:,index);
FED1 = FED(:, index);
AOS1 = AOS(:, index);
LLT1 = LLT(:, index);

x = 1:300;
figure,
p = plot(x, Ig1,  x, LLT1, x, FED1, x, AOS1);
p(1).LineWidth = 1.5;
p(2).LineWidth = 1.5;
p(3).LineWidth = 1.5;
p(4).LineWidth = 1.5;
% p(1).Color = '#00FFFF';
% p(2).Color = '#EDB120';
% p(3).Color = 'r';%'#77AC30';
% p(4).Color = 'b';
legend('Original', 'LLT', 'FED', 'AOS')


