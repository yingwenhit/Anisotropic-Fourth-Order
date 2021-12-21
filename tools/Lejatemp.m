function jx=Lejatemp(j,order,n)

for l=1:n
    temp=1;
    for k=1:j
    temp=temp*abs(l-order(k));
    end
tempx(l)=temp;
end
[~,jxtemp]=max(tempx);
jx=jxtemp;