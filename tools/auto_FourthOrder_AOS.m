% 半隐格式，全部采用中心差分， AOS迭代求解
function [PSNR,MAE,SNR,SSIM,t,var,J,iter] =...
    auto_Implicit_Scheme_AOS_v3(Io, In, tau, sigma, K1, K2, std_n, auto_p)

J = In;
[m,n] = size(In);
I_original_loc = Io(5:(m-5),5:(n-5));

dif = J - In;
dif = dif.^2;
nl = sum(dif(:))/m/n;
Var = nl;

% noiselevel(1) = nl;

figure(400),imshow(In,[])
t = 0;
i = 1;

std = std_n^2*auto_p;
while(Var < std)
% for i=1:iter
    tic;
    J0 = J;
    % Explicit scheme for Jcoef
    Jcoef = J;
    %     Jcoef_x2 = Jcoef(:,[2:end end])+Jcoef(:,[1 1:end-1])-2*Jcoef;
    %     Jcoef_y2 = Jcoef([2:end end],:)+Jcoef([1 1:end-1],:)-2*Jcoef;
    %     [Jcoef1, Jcoef2] = DiffCoef(Jcoef, sigma, K1, K2, model);
    %
    %     Jcoef_2x = Jcoef_x2./Jcoef1;
    %     Jcoef_2y = Jcoef_y2./Jcoef2;
    %
    %     JJx = Jcoef_2x(:,[2:end end])+Jcoef_2x(:,[1 1:end-1])-2*Jcoef_2x;
    %     JJy = Jcoef_2y([2:end end],:)+Jcoef_2y([1 1:end-1],:)-2*Jcoef_2y;
    %     Term = tau*(JJx+JJy);
    %     Jcoef = Jcoef - Term;
    
    [A_1,A_2,B,C,D,E,F,G,H,I] = coeff(Jcoef, tau, sigma, K1, K2);
    %% AOS迭代求解 -- j方向
    for i_1 = 1:m   %分别对每一列进行处理
        DC_i = zeros(n,n);
        for k1 = 1:n
            DC_i(k1,k1) = 1 + 2*A_1(i_1,k1);
        end
        for k2 = 1:n-1
            DC_i(k2,k2+1) = 2*D(i_1,k2);
            DC_i(k2+1,k2) = 2*B(i_1,k2+1);
        end
        for k3 = 1:n-2
            DC_i(k3,k3+2) = 2*E(i_1,k3);
            DC_i(k3+2,k3) = 2*C(i_1,k3+2);
        end
        J(i_1,:) = J(i_1,:)/DC_i;
    end
    
    %% AOS迭代求解 -- i方向
    T = J0.';
    for j_1 = 1:n   %分别对每一列进行处理
        DC_j = zeros(m,m);
        for k1 = 1:m
            DC_j(k1,k1) = 1 + 2*A_2(k1,j_1);
        end
        for k2 = 1:m-1
            DC_j(k2,k2+1) = 2*H(k2,j_1);
            DC_j(k2+1,k2) = 2*F(k2+1,j_1);
        end
        for k3 = 1:m-2
            DC_j(k3,k3+2) = 2*I(k3,j_1);
            DC_j(k3+2,k3) = 2*G(k3+2,j_1);
        end
        T(j_1,:) = T(j_1,:)/DC_j;
    end
    J0 = T.';
    J = (J0 + J)/2;
    toc;
    t = t + toc;
    
%     if( mod(i,1)==0 )
%         pause(0.05);
%         hold on;
%         imshow(uint8(J));
%         str=['Smothed Image, iter=',num2str(i)];
%         title(str);
%         hold off;
%     end
    
    %% PSNR、MAE等指标计算
    J_loc=J(5:(m-5),5:(n-5));
    PSNR(i) = psnr(J_loc,I_original_loc);
    SNR(i) = snr(J_loc,I_original_loc);
    MAE(i) = mae(J_loc,I_original_loc);
    SSIM(i) = ssim(J_loc,I_original_loc);
    dif = J - In;
    dif = dif.^2;
    Var = sum(dif(:))/m/n;
    var(i) = Var;
    i = i+1;
end
iter = i-1;
figure(401),imshow(uint8(J))
end


%% 隐格式中u_ij^n+1对应的系数--AOS
function [A_1,A_2,B,C,D,E,F,G,H,I] = coeff(In, tau, sigma, K1, K2)
[ny,nx] = size(In);
[J1, J2] = DiffCoef(In, sigma, K1, K2);
% J1 = A_diffcoe(In); %A3
J1_1 = J1(:,[2:end end]); %A1
J1_2 = J1(:,[1 1:end-1]); %A2

% J2 = B_diffcoe(In); %B3
% J2 = J1;%B3
J2_1 = J2([2:end end],:); %B1
J2_2 = J2([1 1:end-1],:); %B2

tJ1 = tau./J1;
tJ1_1 = tau./J1_1;
tJ1_2 = tau./J1_2;
tJ2 = tau./J2;
tJ2_1 = tau./J2_1;
tJ2_2 = tau./J2_2;
%% 各项系数
A_1 =  tJ1_1 + tJ1_2 + 4*tJ1 ;
A_2 =  tJ2_1 + tJ2_2 + 4*tJ2;
B = -2*tJ1_2 -2*tJ1;
C = tJ1_2;
D = -2*tJ1_1 - 2*tJ1;
E = tJ1_1;
F = -2*tJ2_2 - 2*tJ2;
G = tJ2_2;
H = -2*tJ2_1 - 2*tJ2;
I = tJ2_1;

%% 边界条件
A_1([2:end-1],nx) =  tJ1([2:end-1],nx) + tJ1_2([2:end-1],nx);
% A_2([2:end-1],nx) = 1 + tau./J2_1([2:end-1],nx) + tau./J2_2([2:end-1],nx) + 4*tau./J2([2:end-1],nx);
A_1(1,nx) =  tJ1(1,nx) + tJ1_2(1,nx);
A_2(1,nx) =  tJ2_1(1,nx) + tJ2(1,nx);
A_1(ny,nx) =  tJ1(ny,nx) + tJ1_2(ny,nx);
A_2(ny,nx) =  tJ2(ny,nx) + tJ2_2(ny,nx);
A_1([2:end-1],1) =  tJ1_1([2:end-1],1) + tJ1([2:end-1],1);
%     + tau./J2_1([2:end-1],1) + tau./J2_2([2:end-1],1) + 4*tau./J2([2:end-1],1);
A_1(1,1) =  tJ1_1(1,1) + tJ1(1,1);
A_2(1,1) =  tJ2_1(1,1) + tJ2(1,1) ;
A_1(ny,1) =  tJ1_1(end,1) + tJ1(end,1);
A_2(ny,1) =  tJ2(ny,1) + tJ2_2(ny,1);

A_2(ny,[2:end-1]) =  tJ2(ny,[2:end-1]) + tJ2_2(ny,[2:end-1]);
%     + tau./J1_1(ny,[2:end-1]) + tau./J1_2(ny,[2:end-1]) + 4*tau./J1(ny,[2:end-1]);

A_2(1,[2:end-1]) =  tJ2_1(1,[2:end-1]) + tJ2(1,[2:end-1]);
%     + tau./J1_1(1,[2:end-1]) + tau./J1_2(1,[2:end-1]) + 4*tau./J1(1,[2:end-1]);

B(:,nx) = -2*tJ1_2(:,nx) - tJ1(:,nx);
F(ny,:) = -2*tJ2_2(ny,:) - tJ2(ny,:);
D(:,1) = -2*tJ1_1(:,1) - tJ1(:,1);
H(1,:) = -2*tJ2_1(1,:) - tJ2(1,:);

D(:,nx-1) = -1*tJ1_1(:,nx-1) - 2*tJ1(:,nx-1);
B(:,2) =  -1*tJ1_2(:,2)  -2*tJ1(:,2) ;
F(2,:) =  -1*tJ2_2(2,:) - 2*tJ2(2,:);
H(ny-1,:) = -1*tJ2_1(ny-1,:) - 2*tJ2(ny-1,:);

G([1 2],:) = 0;
F(1,:) = 0;
H(ny,:) = 0;
I([ny-1 ny],:) = 0;
B(:,1) = 0;
C(:,[1 2]) = 0;
D(:,nx) = 0;
E(:,[nx-1 nx]) = 0;

end

function [Ja, Jb] = DiffCoef(In, sigma, K1, K2)

gama = 1e-4;

if sigma ~= 0
    siz = sigma*6;
    In = imgaussian(In,sigma,siz);
end

Jx = (In(:,[2:end end]) - In(:,[1 1:end-1]))/2;
Jy = (In([2:end end],:) - In([1 1:end-1],:))/2;

Jxx = In(:,[2:end end]) + In(:,[1 1:end-1]) - 2*In;
Jyy = In([2:end end],:) + In([1 1:end-1],:) - 2*In;

%% sqrt
Ja = sqrt(1 + (Jx/K1).^2).*abs(Jxx + gama);
Jb = sqrt(1 + (Jy/K2).^2).*abs(Jyy + gama);

end