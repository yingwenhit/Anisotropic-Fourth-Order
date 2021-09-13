function [tau, n] = FED(TM,miumax)%TM = T/M
% function [tau, n] = FED(M,T,miumax)
% a = T/M*3/2*miumax;
a = TM*3/2*miumax;
temptn = sqrt(4*a + 1)/2 - 1/2;
n = ceil(temptn);
tn = 2/miumax/3*(n^2+n);
% q = T/(M*tn);
q = TM/tn;
c = 1/miumax; 
A=zeros(1,n);
b=zeros(1,n);
for i=1:n
   b(i)=pi*(2*(i-1)+1)/(4*n+2);
   A(i)= (cos(b(i)))^2;   
end
tau=c*q./A;