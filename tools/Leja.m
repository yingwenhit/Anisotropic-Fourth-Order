function orderx=Leja(tau)
[~, n]=size(tau);
order=zeros(1,n);
order(1,1)=n;
for j=1:n-1
  order(1,j+1)=Lejatemp(j,order,n);
end
orderx=zeros(1,n);
for i=1:n
    orderx(1,i)=tau(order(1,i));
end
   