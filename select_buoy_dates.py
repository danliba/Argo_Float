# -*- coding: utf-8 -*-
"""
Created on Thu Apr  1 20:22:28 2021

@author: danli
"""
#ordenando las boyas como perfiles de flotadores 
from netCDF4 import Dataset
import os 
import numpy as np
from datetime import date
import functools 
import datetime
import pandas as pd
import matplotlib.pyplot as plt

path0='D:\\CIO\\pg_web\\flotos\\'
dir_list=os.listdir('D:\\CIO\\pg_web\\flotos\\'); check= 't'
buoy_list = [idx for idx in dir_list if idx[0].lower() == check.lower()]
today = date.today()
dirName = 'data_'+str(today)
#os.makedirs(dirName)    
def main():
    
    # Create directory
    dirName = 'data_'+str(today)
    try:
        # Create target Directory
        os.mkdir(dirName)
        print("Directory " , dirName ,  " Created ") 
    except FileExistsError:
        print("Directory " , dirName ,  " already exists")            
        
if __name__ == '__main__':
    main()
    
    
savedir = 'D:\\CIO\\pg_web\\flotos\\'+dirName
os.chdir(savedir)

for kk in range(len(buoy_list)):
    fn=buoy_list[kk]
    print(fn)
    #fn='t0n110w_dy.cdf'
    data=Dataset(path0+fn)
    
    lat = data.variables['lat'][:]
    lon = data.variables['lon'][:]
    depth = data.variables['depth'][:]
    time = data.variables['time'][:]
    
    starting_date = data.variables['time'].units[11:21]
    
    temp = data.variables['T_20'][:][:,:,0,0]
    creation_day=data.variables['time'].units; yy=int(creation_day[11:15]); mm=int(creation_day[16:18]); dd=int(creation_day[19:21])
    fecha=time+np.array(date.toordinal(date(yy,mm,dd)))
    temp=np.array(temp,dtype='float32').T
    
    #start 5 days before today
    today = date.today()
    yesterday = today - datetime.timedelta(days=5)#5 dias atrás
    ytd=yesterday.strftime("%Y-%m-%d")
    
    yrst=int(ytd[0:4]); most=int(ytd[5:7]); dast=int(ytd[8:10])
    date_start=np.array(date.toordinal(date(yrst,most,dast)))
    find_stdate=np.where(fecha==date_start)
    fdt=functools.reduce(lambda sub, ele: sub * 10 + ele, find_stdate)
    
    if len(fdt)==0:
        print("Starting date is out of range")
        continue
    
    indx_date=int(fdt)
    fecha_inicio=fecha[indx_date:]; 
        
    ending_date = date.fromordinal(int(fecha_inicio[-1])) 
    date_range = pd.date_range(start= starting_date, end=ending_date)
        
    temp[temp==1.0000000e+35] = np.nan; sst=temp[:,indx_date:]
    
    sst_prom=np.nanmean(sst,1)
    fig=plt.figure(figsize=(5,7))
    plt.plot(sst_prom,-depth,marker='*')
    plt.title('5 day mean '+fn)
    #boya_fn=np.concatenate((depth.reshape(-1,1),sst_prom.reshape(-1,1)),axis=1)
    #save the numpy array
    
    fn_save="SST-"+str(fn[:7])+".npz"
    np.savez(fn_save,depth=depth,sst=sst_prom,lon=lon,lat=lat)

    #npzfile2=np.load(fn_save,allow_pickle=True)
    #a=npzfile['arr_0']
