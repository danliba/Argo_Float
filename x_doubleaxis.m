path0='D:\CIO';
fn='Pesca_imarpe.mat';
fn1='datos_pesca.xlsx';
load(fullfile(path0,fn));
datos=xlsread(fn1,'Hoja1');

clear pesca1 pesca2

pesca1=datos(1:35)'; pesca2=datos(36:70)';

%% plot
figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

x1=fecha1;
y1=pesca1;
plot(x1,y1,'o--','Color','r')
ax1 = gca; % current axes
ax1.XColor = 'r';
ax1.YColor = 'r';
datetick('x','dd/mmm/yy');
xlim([x1(1,1)-1 x1(end,1)+1]);
set(gca,'ytick',[0:10000:6*10e3],'yticklabel',[0:1000:6*10e3],'ylim',[0 6*10e3]);
legend('pesca segunda temporada 2019','northweast');
ylabel('TM');
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');

x2=fecha2;
y2=pesca2;
line(x2,y2,'Parent',ax2,'Color','k')
datetick('x','dd/mmm/yy');
xlim([x2(1,1)-1 x2(35,1)+1]);

set(gca,'ytick',[0:10000:6*10e3],'yticklabel',[0:1000:6*10e3],'ylim',[0 6*10e3]);
ylabel('TM');
legend('pesca primera temporada 2020');

%% plot 2
figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

yyaxis left
bar(fecha1,promedios1,'b')
ylabel('Promedios');
datetick('x','dd/mmm/yy','keeplimits');
yyaxis right
plot(fecha1,viajes1,'r','linewidth',2);
ylabel('Viajes');


