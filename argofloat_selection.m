function [lon1,lat1,temp1,sal1,depth1,indx_float]=argofloat_selection(x,y,T,S,D)

%%range
range0=[140 290 -2 2];

x=x';
y=y';

x(x<0)=x(x<0)+360;
iter=0;
for id=1:1:size(x,1)
   iter=iter+1;
if range0(1)<=x(id) && x(id)<=range0(2)
   x0(iter,1)=true;
else
    x0(iter,1)=false;
end

if range0(3)<=y(id) && y(id)<=range0(4)
    y0(iter,1)=true;
else
    y0(iter,1)=false;
end

if x0(id)==1 && y0(id)==1
    a(iter,1)=true;
else
    a(iter,1)=false;
end

end
indx_float=find(a==1);
lon1=x(indx_float);
lat1=y(indx_float);
temp1=T(:,indx_float);
sal1=S(:,indx_float);
depth1=D(:,indx_float);

end
