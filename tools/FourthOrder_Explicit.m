function [MAE, PSNR, SNR, SSIM, t, var, J]=...
    Forth_Order_nocross(Io,In,tau,K1,K2,sigma,iter)

[Nx,Ny]=size(In);
a=5;
a1=5;
b=5;
b1=5;

J=In;

I_original_loc=Io(a:(Nx-a1),b:(Ny-b1));

gama = 1e-2;

% Var = sum(sum((J-In).^2))/(Nx*Ny);
% i = 1;
t = 0;

% automatic stopping
% std = std_n^2*auto_p;
% while(Var < std)
for i=1:iter
    tic;
    
    Jx=(J(:,[2:end end])-J(:,[1 1:end-1]))./2;
    Jy=(J([2:end end],:)-J([1 1:end-1],:))./2;
    Jx2=J(:,[2:end end])+J(:,[1 1:end-1])-2*J;
    Jy2=J([2:end end],:)+J([1 1:end-1],:)-2*J;
    
    if sigma ~= 0
        %         Ng=ceil(6*sigma)+1;
        %         Gaussian=fspecial('gaussian',[Ng,Ng],sigma);
        %         C=conv2(J,Gaussian,'same');
        siz = sigma*6;
        C = imgaussian(J,sigma,siz);
        Jx1=(C(:,[2:end end])-C(:,[1 1:end-1]))./2;
        Jy1=(C([2:end end],:)-C([1 1:end-1],:))./2;
    else
        Jx1= Jx;
        Jy1= Jy;
    end
    
    
    J_2x=Jx2./((1+Jx1.^2/(K1.^2)).^(0.5).*(abs(Jx2) + gama));
    J_2y=Jy2./((1+Jy1.^2/(K2.^2)).^(0.5).*(abs(Jy2) + gama));
    
    %     J_2x=Jx2./((1+Jx1.^2/(K1^2)).*(abs(Jx2) + gama));
    %     J_2y=Jy2./((1+Jy1.^2/(K2^2)).*(abs(Jy2) + gama));
    
    JJx=J_2x(:,[2:end end])+J_2x(:,[1 1:end-1])-2*J_2x;
    JJy=J_2y([2:end end],:)+J_2y([1 1:end-1],:)-2*J_2y;
    Term=tau*(JJx+JJy);
    J=J-Term;
    
    toc;
    t = t+toc;
    
    %     if( mod(i,20)==0 )
    %         pause(0.05);
    %         hold on;
    %         imshow(uint8(J));
    %         str=['Smothed Image, iter=',num2str(i)];
    %         title(str);
    %         %    title('Smothed Image, iter=',num2str(i));
    %         hold off;
    %     end
    
    Var = sum(sum((J-In).^2))/(Nx*Ny);
    var(i) = Var;
    J_loc=J(a:(Nx-a1),b:(Ny-b1));
    PSNR(i)=psnr(J_loc,I_original_loc);
    SNR(i)=snr(J_loc,I_original_loc);
    MAE(i)=mae(J_loc,I_original_loc);
    SSIM(i) = ssim(J_loc,I_original_loc);
%     i = i+1;
end
% iter = i-1;
