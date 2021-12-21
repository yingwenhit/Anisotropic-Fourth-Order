function [MAE, PSNR, SNR, SSIM, t, var, J] ...
    = Forth_Order_nocross_FED_v2(Io, In, TM, sigma, k, gama, iter)
%% prepare for FED

% gama = 1;
miumax = 32/gama;
[tautemp, n] = FED(TM,miumax);
Tau = Leja(tautemp);

% count = 1;
[Nx,Ny]=size(In);
a=5;
a1=5;
b=5;
b1=5;

J=In;

I_original_loc=Io(a:(Nx-a1),b:(Ny-b1));
figure(400),imshow(In,[])

t = 0;
% for j = 1:M
% Var = sum(sum((J-In).^2))/(Nx*Ny);

% std = std_n^2*auto_p;
% while(Var < std)
for count=1:iter
    for i=1:n
        tau = Tau(i);
        %% fourth order nocross PDE
        tic;
        J_c = J;
        [J] = fourth_order_nocross(J, J_c, sigma, gama, tau, k);
        toc;
        t = t+toc;
    end
    
    J_loc=J(a:(Nx-a1),b:(Ny-b1));
    PSNR(count) = psnr(J_loc,I_original_loc);
    SNR(count)  = snr(J_loc,I_original_loc);
    MAE(count)  = mae(J_loc,I_original_loc);
    SSIM(count) = ssim(J_loc,I_original_loc);
    Var = sum(sum((J-In).^2))/(Nx*Ny);
    var(count) = Var;
%     count = count + 1;
    
end
% iter = count + 1;
end

function [J] = fourth_order_nocross(J, J_c, sigma, gama, tau, k)

Jx  = (J_c(:,[2:end end])-J_c(:,[1 1:end-1]))./2;
Jy  = (J_c([2:end end],:)-J_c([1 1:end-1],:))./2;
Jx2 = J_c(:,[2:end end])+J_c(:,[1 1:end-1])-2*J_c;
Jy2 = J_c([2:end end],:)+J_c([1 1:end-1],:)-2*J_c;

if sigma ~= 0
    siz = sigma*6;
    C = imgaussian(J,sigma,siz);
    Jx1 = (C(:,[2:end end])-C(:,[1 1:end-1]))./2;
    Jy1 = (C([2:end end],:)-C([1 1:end-1],:))./2;
else
    Jx1 = Jx;
    Jy1 = Jy;
end

%% sqrt
J_2x = Jx2./(sqrt(1+(Jx1/k).^2).*(abs(Jx2) + gama));
J_2y = Jy2./(sqrt(1+(Jy1/k).^2).*(abs(Jy2) + gama));

% J_2x = Jx2./((1+(Jx1/k).^2).*(abs(Jx2) + gama));
% J_2y = Jy2./((1+(Jy1/k).^2).*(abs(Jy2) + gama));

JJx = J_2x(:,[2:end end])+J_2x(:,[1 1:end-1])-2*J_2x;
JJy = J_2y([2:end end],:)+J_2y([1 1:end-1],:)-2*J_2y;
Term = tau*(JJx + JJy);

J = J - Term;
end

