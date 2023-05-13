%%read pesca
path0='D:\CIO';
filename=['pesca_icochea','.txt'];
fns=fullfile(path0,filename);
fid1=fopen(filename,'r');


A=fgetl(fid1);

pesca1=[]; viajes1=[]; promedios1=[]; fecha1=[];
pesca2=[]; viajes2=[]; promedios2=[]; fecha2=[];

k=0;
A=fgetl(fid1);

while A~=-1
    k=k+1;

%variables    
B=strsplit(A,' ');
a=str2num(B{3}); b=num2str(a(1,1)); c=num2str(a(1,2)); d=strcat(b,c);
pesca1(k,1)=str2num(d); 
viajes1(k,1)=str2num(B{4}); 
promedios1(k,1)=str2num(B{5});

aa=str2num(B{8}); bb=num2str(aa(1,1)); cc=num2str(aa(1,2)); dd=strcat(bb,cc);
pesca2(k,1)=str2num(dd); 
viajes2(k,1)=str2num(B{9}); 
promedios2(k,1)=str2num(B{10});

%meses y dias
C=strsplit(A,'.');
da=str2num(C{1});
mo=str2num(C{2});

C2=strsplit(B{6},'.');
da2=str2num(C2{1});
mo2=str2num(C2{2});
yr2=str2num(C2{3});
fecha2(k,1)=datenum(yr2,mo2,da2,0,0,0);

datdisp2(k,:)=datestr(datenum(yr2,mo2,da2,0,0,0));
%años
Dfecha=strsplit(C{3},' ');
yr=str2num(Dfecha{1});

fecha1(k,:)=datenum(yr,mo,da,0,0,0);
datdisp1(k,:)=datestr(datenum(yr,mo,da,0,0,0));
A=fgetl(fid1);
end
fclose(fid1);

save('Pesca_imarpe','pesca1','pesca2','promedios1','promedios2','viajes1','viajes2','fecha1','fecha2');

