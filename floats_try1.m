%% saving data 
clear all
close all

%ruta
path01='D:\descargas\DataSelection_20200320_225440_9715145';

%lista de directorio
hdir=dir(fullfile(path01,'argo-profiles-*.nc*'));
  hdir(2) = [];
  hdir(4)= [];
  hdir(6)= [];
  hdir(12:16)=[];
  hdir(29)=[];
  hdir(28)=[];
  
%%rango de tiempo 
da0=[0 3];
mo0=[8];
yr0=[2019];

rangeT0=datenum(yr0,mo0,da0,0,0,0);

%%rango total de tiempo
daT=[0 30];

rangeT=datenum(yr0,mo0,daT,0,0,0);

%%rango de profundidad
range0=[0 100];
%loop que lee cada flotador desde 1 hasta el tamaño asignado hdir

for ifloat=1:1:5
   
    %llamando al archivo nc
    fname=hdir(ifloat).name;
    %leer la data
    depth0=ncread(fname,'PRES');
    temp0=ncread(fname,'TEMP');
     salt0=ncread(fname,'PSAL');
    lon0=ncread(fname,'LONGITUDE');
    lat0=ncread(fname,'LATITUDE');
    time0=ncread(fname,'JULD');
    
    %seleccionar solo columnas impares 
    depth=depth0(:,1:2:end);
    temp=temp0(:,1:2:end);
     salt=salt0(:,1:2:end);
    lon=lon0(1:2:end,:);
    lat=lat0(1:2:end,:);
    time=time0(1:2:end,:);
    
    %convertir julian days 
    [yr,mo,da,hr,mi,se]=datevec(double(time)+datenum(1950,1,1,0,0,0));
    
    disp(['number of process ... ',num2str(ifloat)])
%     disp(da)
%     pause(1)
     date=datenum(yr,mo,da,0,0,0);
    
     %encontrar el indx
     indxT0=find(rangeT0(1)<=date & date<=rangeT0(2));
     
     indxT=find(rangeT(1)<=date & date<=rangeT(2));
     
     [indxdep]=find(range0(1)<=depth(indxT(1:1:size(indxT,1),1:1:ifloat) & depth(indxT)<=range0(2)));
     
  
     %seleccionar la data hasta los 100m
     depthi=depth(indxdep);
     tempi=temp(indxdep); %%aqui es donde falla!!!
     %disp(tempi)
     %pause(1)
     tempi2=nanmean(tempi,1);
     %%seleccionar data por tiempo
     timeTi=date(indxT0);
%       indxt2=find(indxT0==1);
     %tempTi=tempi2(indxt2);

     %leer data
     lat2(1:size(lat,1),ifloat)=lat;
     lon2(1:size(lon,1),ifloat)=lon; 
     date2(1:size(date,1),ifloat)=date;
     timeT(1:size(timeTi,1),ifloat)=timeTi;
     tempT(1:size(tempi2,1),ifloat)=tempi2;
     INDX(1:size(indxT,1),ifloat)=indxT;
  
      date2(date2==0)=NaN;
      lat2(lat2==0)=NaN;
      lon2(lon2==0)=NaN;
      tempT(tempT==0)=NaN;

end

 Temperature(2,:)=tempT;
