clear all;
close all;
clc;

path01='D:\CIO\Kelvin-cromwell\float_demo\float_20210215\perfiles'; 
path02='E:\ocean ecosystem dynamics laboratory\CIO\deepnija';
topofn='data.nc';
topofns=fullfile(path02,topofn);

hdir=dir(fullfile(path01,'2021*'));

for ifloat=1:1:size(hdir,1)
    fname=hdir(ifloat).name;
    load(fname)
    %variables
  lon(ifloat,:)=loni;
  lat(ifloat,:)=lati;
  
end

[lonb,Indx]=sort(lon(:,1),1);
lonb2=lon(Indx,:);
latb2=lat(Indx,:);
%% graph
latitude=ncread(topofns,'Y');
longitude=ncread(topofns,'X');
topo=ncread(topofns,'bath');
topo=topo';

figure
P=get(gcf,'position');
P(3)=P(3)*2.5;
P(4)=P(4)*0.7;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

pcolor(longitude,latitude,topo);
shading flat;cmocean('topo'); 
c=colorbar;
c.Label.String='Depth in m';
caxis([-4500 0]);
hold on
 plot(lonb2,latb2,'ko--','markerfacecolor','g');
set(gca,'xtick',[150:5:275],'xticklabel',[[150:5:180] [-175:5:-85]],'xlim',[140 280]);
set(gca,'ytick',[-5:1:5],'yticklabel',[-5:1:5]);
ylim([-5 5]);
title('Ubicacion Argo Float 150E-85W'); 
ylabel('Latitud'); xlabel('Longitud');
xlim([150 280]);
text(255,-4,'Fuente: ARGO & NGDC','color','w','fontweight','bold');
text(255,-4.5,'Procesamiento: CIO','color','w','fontweight','bold');

saveas(gcf,'Ubicacion Argo Float vs batimetria 150E-85W.jpg','jpg');