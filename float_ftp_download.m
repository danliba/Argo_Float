%%ftp for floats 1st try
clear all
close all
clc; 
ftpobj1=ftp('ftp.ifremer.fr');
yy=2021;
mm=3;
dast=15;%dia de inicio 
folder=sprintf('ifremer/argo/geo/pacific_ocean/%d/%02d',yy,mm);
hdir=dir(ftpobj1,folder);
path0=cd(ftpobj1,folder);

for ifloat=dast:1:size(hdir,1)

%ifloat=1:1:size(hdir,1)
fname=hdir(ifloat).name;
mfile=sprintf('D:\\CIO\\Kelvin-cromwell\\float_demo\\float_%d%02d%d',yy,mm,dast);
float_get=mget(ftpobj1,fname,mfile);
    formatSpec= 'Float %d%02d%s.nc file has been successfully downloaded';
    floto=sprintf(formatSpec,yy,mm,num2str(ifloat));
  disp(floto)
end
