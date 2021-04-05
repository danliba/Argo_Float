# -*- coding: utf-8 -*-
"""
Created on Thu Apr  1 22:16:11 2021

@author: danli
"""
#seleccionar flotadores
from netCDF4 import Dataset
import netCDF4
import os 
import numpy as np
from datetime import date
import functools 
import datetime
import pandas as pd
import matplotlib.pyplot as plt

path0='D:\\CIO\\pg_web\\flotos\\'
dir_list=os.listdir('D:\\CIO\\pg_web\\flotos\\'); check= '2'
floto_list = [idx for idx in dir_list if idx[0].lower() == check.lower()]
today = date.today()

dirName = 'data_'+str(today)
savedir = 'D:\\CIO\\pg_web\\flotos\\'+dirName
os.chdir(savedir)    
    
for kk in range(len(floto_list)):
    fn=floto_list[kk]
    #fn='t0n110w_dy.cdf'
    data=Dataset(path0+fn)
    
    lat = data.variables['LATITUDE'][:].T
    lon = data.variables['LONGITUDE'][:].T
    depth = data.variables['PRES'][:].T
    time = data.variables['JULD']
    jd = netCDF4.num2date(time[:],time.units)
    cycle_n=data.variables['CYCLE_NUMBER'][:]
    temp = data.variables['TEMP'][:].T
    sal = data.variables['PSAL'][:].T
    
    n_float_cum=[]
    
    for nflot in range(len(lon)):
        n_float=data.variables['PLATFORM_NUMBER'][nflot]
        dfloat=pd.DataFrame(n_float[0:6],columns=['Floto'])
        dfloat=dfloat['Floto'].str.decode("utf-8")
        dfloat=[dfloat[0],dfloat[1],dfloat[2],dfloat[3],dfloat[4],
                        dfloat[5]]
        dfloat=pd.DataFrame(dfloat).T
        df_flot = dfloat.iloc[:,0].map(str) + dfloat.iloc[:,1].map(str) + dfloat.iloc[:,2].map(str) + dfloat.iloc[:,3].map(str)+dfloat.iloc[:,4].map(str)+dfloat.iloc[:,5].map(str)
        n_float_cum.append(df_flot)
        
    number_floto=np.array(n_float_cum)
           
    starting_date = data.variables['JULD'].units[11:21]
    # plt.plot(lon,lat,color='black', linestyle='dashed',linewidth=0.1,marker='o',markerfacecolor='green',markersize=5)
    # plt.xlabel('Longitud')
    # plt.ylabel('Latitud')

    def argofloat_selection(x,y,T,S,D,NF,NC):
        range0=[140, 290, -1, 1]
        x=x.T; y=y.T
        
        x[x<0]=x[x<0]+360
        iter0=-1
        x0=[];x_cum=[]
        y0=[];y_cum=[]
        a=[];a_cum=[]
        for id in range(0,len(x),1):
            iter0=iter0+1
            
            if range0[0]<=x[id] and x[id]<=range0[1]:
                x0=True
                x_cum.append(x0)
            else:
                x0=False
                x_cum.append(x0)
                
            if range0[2]<=y[id] and y[id]<=range0[3]:
                y0=True
                y_cum.append(y0)
            else:
                y0=False
                y_cum.append(y0)
                
            if x_cum[id]==True and y_cum[id]==True:
                a=True
                a_cum.append(a)
            else:
                a=False
                a_cum.append(a)
                
        ab=np.array(a_cum)        
        indx_float=np.where(ab==True)
        indx_float=functools.reduce(lambda sub, ele: sub * 10 + ele, indx_float)
        lon1=x[indx_float]
        lat1=y[indx_float]
        temp1=T[:,indx_float]
        sal1=S[:,indx_float]
        depth1=D[:,indx_float]
        num_floto=NF[indx_float]
        num_cycle=NC[indx_float]
        return lon1,lat1,temp1,sal1,depth1,indx_float,num_floto,num_cycle
        
    [lon1,lat1,temp1,sal1,depth1,indx_float,num_floto,num_cycle]=argofloat_selection(lon,lat,temp,
                                                                                    sal,depth,number_floto,cycle_n)
   
    for istore in range(len(indx_float)):
       
       print(str(jd[-1])+'-----number of process-- '+ str(istore))
       tempi=temp1[:,istore]
       lati=lat1[istore]
       loni=lon1[istore]
       sali=sal[:,istore]
       depthi=depth1[:,istore]
       nfloto=np.array(num_floto[istore],dtype='int')
       ncycle=num_cycle[istore]
       timei=jd[-1]
       fn_save="SST-"+str(fn[:8])+'-lon-'+str(loni)+'-flotador_nº-'+str(nfloto)+'-ciclo-'+str(ncycle)+".npz"
       np.savez(fn_save,depth=depthi,sst=tempi,lon=loni,lat=lati,sal=sali,float_num=nfloto,cycle_num=ncycle,time=timei)

# %% filtrar

# function [lon1,lat1,temp1,sal1,depth1,indx_float]=argofloat_selection(x,y,T,S,D)

# %range
# range0=[140 290 -1 1];

# x=x';
# y=y';

# x(x<0)=x(x<0)+360;
# iter=0;
# for id=1:1:size(x,1)
#    iter=iter+1;
# if range0(1)<=x(id) && x(id)<=range0(2)
#    x0(iter,1)=true;
# else
#     x0(iter,1)=false;
# end

# if range0(3)<=y(id) && y(id)<=range0(4)
#     y0(iter,1)=true;
# else
#     y0(iter,1)=false;
# end

# if x0(id)==1 && y0(id)==1
#     a(iter,1)=true;
# else
#     a(iter,1)=false;
# end

# end
# indx_float=find(a==1);
# lon1=x(indx_float);
# lat1=y(indx_float);
# temp1=T(:,indx_float);
# sal1=S(:,indx_float);
# depth1=D(:,indx_float);

# end






