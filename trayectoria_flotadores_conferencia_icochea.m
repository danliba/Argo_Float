%trayectoria flotadores 2ºN -10ºS/90ºW-70ºW
clear all;
close all;
clc;

path01='D:\CIO\Kelvin-cromwell\float_demo\float_2020011\perfiles\flotos'; 
path02='E:\ocean ecosystem dynamics laboratory\CIO\deepnija';
topofn='data.nc';
topofns=fullfile(path02,topofn);

hdir=dir(fullfile(path01,'f_*'));
%variables
lattopo=ncread(topofns,'Y');
lontoppo=ncread(topofns,'X');
topo=ncread(topofns,'bath');
topo=topo';

load coast
long(long<0)=long(long<0)+360;
%% graph

figure
P=get(gcf,'position');
P(3)=P(3)*2.5;
P(4)=P(4)*1.5;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

% pcolor(lontoppo,lattopo,topo); 
% shading flat;cmocean('topo'); 
% c=colorbar;
% c.Label.String='Depth in m';
% caxis([-4500 0]);
% hold on
gif('Flotadores_4.gif','frame',gcf,'delaytime',2,'nodither')
for ifloat=1:1:size(hdir,1)
    fname=hdir(ifloat).name;
    load(fname)   
%tiempo
formatout='dd/mm/yy';
d=datestr(datevec(timeis),formatout);
%  hold on

  subplot(1,2,1)
plot(lonis,latis,'o--','DisplayName',num2str(float));
legend;
hold on
plot(long,lat,'k');
set(gca,'xtick',[265:5:285],'xticklabel',[-95:5:-75],'xlim',[268 285]);
set(gca,'ytick',[-12:1:4],'yticklabel',[-12:1:4]);
ylim([-12 4]);
title('Ubicacion Argo Float 2ºN -10ºS/90ºW-70ºW'); 
ylabel('Latitud'); xlabel('Longitud');
text(lonis(1,1),latis(1,1),d(1,:),'color','k');
text(lonis(end,1),latis(end,1),d(end,:),'color','k');
hold on

 subplot(1,2,2)
    scatter(lonis,latis,30,-depthi); colormap jet; colorbar; caxis([-2000 0])
    hold on
    plot(long,lat,'k');
    set(gca,'xtick',[265:5:290],'xticklabel',[-95:5:-70],'xlim',[268 290]);
    set(gca,'ytick',[-12:1:4],'yticklabel',[-12:1:4]);
    ylim([-12 4]);
    title('Profundidad Argo Float 2ºN -10ºS/90ºW-70ºW'); 
    ylabel('Latitud'); xlabel('Longitud');
    text(lonis(1,1),latis(1,1),d(1,:),'color','k');
    text(lonis(end,1),latis(end,1),d(end,:),'color','k');
    hold on
     pause(2)
     gif
     clf
% %    

end
% 
% figure(1)
%  subplot(1,2,1)
% plot(long,lat,'k');

% text(255,-4,'Fuente: ARGO & NGDC','color','w','fontweight','bold');
% text(255,-4.5,'Procesamiento: CIO','color','w','fontweight','bold');

%saveas(gcf,'Ubicacion Argo Float vs batimetria 150E-85W.jpg','jpg');