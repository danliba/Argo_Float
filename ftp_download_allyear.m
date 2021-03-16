%%ftp for floats 1st try
clear all
close all
clc; 
yy=2020; most=3; moen=7;
%desde febrero hasta julio
for im=most:1:moen
mm=im;
dast=1;
ftpobj1=ftp('ftp.ifremer.fr');
folder=sprintf('ifremer/argo/geo/pacific_ocean/%d/%02d',yy,mm);
hdir=dir(ftpobj1,folder);
path0=cd(ftpobj1,folder);

for ifloat=dast:1:size(hdir,1)
fname=hdir(ifloat).name;
mfile='D:\\CIO\\Kelvin-cromwell\\float_demo\\float_2020011';
%mfile=sprintf('D:\\CIO\\Kelvin-cromwell\\float_demo\\float_%d%02d%d',yy,mm,dast);
float_get=mget(ftpobj1,fname,mfile);
    formatSpec= 'Float %d%02d%02s.nc file has been successfully downloaded';
    floto=sprintf(formatSpec,yy,mm,num2str(ifloat));
  disp(floto)
end
end