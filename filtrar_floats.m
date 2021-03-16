clear all
close all
clc

path01='D:\CIO\Kelvin-cromwell\float_demo\float_20210215';
hdir=dir(fullfile(path01,'2021*.nc'));
%%save to 

MD='D:\CIO\Kelvin-cromwell\float_demo\float_20210215\perfiles';
mkdir(MD)
%%code
for ifloat=1:1:size(hdir,1)
    fname=hdir(ifloat).name;

    %variables
    depth=ncread(fname,'PRES');
    temp=ncread(fname,'TEMP');
    salt=ncread(fname,'PSAL');
    lon0=ncread(fname,'LONGITUDE')';
    lat0=ncread(fname,'LATITUDE')';
    time0=ncread(fname,'JULD')';
    Nfloat=ncread(fname,'PLATFORM_NUMBER');
    cycle_number0=ncread(fname,'CYCLE_NUMBER');
    %numero de flotador
        for P_Num=1:1:size(Nfloat,2)
        floto=Nfloat(:,P_Num);
        numflot=floto';
        numflot=str2num(numflot);
        platform_number(P_Num,:)=numflot;
        end
    %fecha
     [yr0,mo0,da0,hr0,mi0,se0]=datevec(double(time0)+datenum(1950,1,1,0,0,0));
    date0=datenum(yr0,mo0,da0,0,0,0)';
    %Filtrar
    [lon1,lat1,T,S,D,indx0]=argofloat_selection(lon0,lat0,temp,salt,depth);

    timeis=date0(indx0);
    f_N=platform_number(indx0);
    c_n=cycle_number0(indx0);
for istore=1:1:size(indx0,1)
     disp(['number of process ... ',num2str(istore)])
    temperature=T(:,istore);
    salinity=S(:,istore);
    depth=D(:,istore);
    loni=lon1(istore);
    lati=lat1(istore);
    time=timeis(istore);
     [yr,mo,da,hr,mi,se]=datevec(double(time));
     float_number=f_N(istore);
     cycle_number=c_n(istore);
         mfile=fullfile(MD,[datestr(datenum(yr,mo,da,0,0,0),'yyyymmdd'),...
             '--', num2str(istore),'-nº_float_',num2str(float_number),'_nºcycle_',num2str(cycle_number),'_lon_',num2str(round(loni))]);
         save(mfile,'time','loni','lati','temperature','salinity','depth','cycle_number','float_number');
end
end