clear all;
close all;
clc;

path01='D:\CIO\Kelvin-cromwell\float_demo\float_2020011\perfiles'; 

hdir=dir(fullfile(path01,'20*'));

for ifloat=1:1:size(hdir,1)
    fname=hdir(ifloat).name;
    floto=fname(22:28);
    hdirflot=dir(fullfile(path01,sprintf('*%s*',floto)));
    
    for iselect=1:1:size(hdirflot,1)
    floto_selected=hdirflot(iselect).name;
    load(floto_selected,'loni','lati','cycle_number','time','depth')
    depth(isnan(depth))=0;
    d=max(depth);
    %variables
      lonis(iselect,:)=loni;
      latis(iselect,:)=lati;
      ciclo(iselect,:)=cycle_number;
      timeis(iselect,:)=time;
      depthi(iselect,:)=d;
    end
    float=str2num(floto);
    MD='D:\CIO\Kelvin-cromwell\float_demo\float_2020011\perfiles\flotos';
    mkdir(MD);
    mfile=fullfile(MD,['f_',floto]);
    save(mfile,'ciclo','lonis','latis','ciclo','timeis','float','depthi');
  
end