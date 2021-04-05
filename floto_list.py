# -*- coding: utf-8 -*-
"""
Created on Fri Apr  2 17:19:30 2021

@author: danli
"""
from netCDF4 import Dataset
import netCDF4
import os 
import numpy as np
from datetime import date
import functools 
import datetime
import pandas as pd
import matplotlib.pyplot as plt

today = date.today()
dirName = 'data_'+str(today)

path0='D:\\CIO\\pg_web\\flotos\\'+dirName
dir_list=os.listdir('D:\\CIO\\pg_web\\flotos\\'+dirName); check= 'S'
floto_list = [idx for idx in dir_list if idx[0].lower() == check.lower()]

os.chdir(path0)#change directory to path0
lati=[];loni=[];
for kk in range(len(floto_list)):
    fn=floto_list[kk]
    fns=np.load(fn,allow_pickle=True)
       
    lat = fns['lat']
    lon = fns['lon']
    
    lati.append(lat); loni.append(lon);

lati=np.array(lati); loni=np.array(loni)
plt.plot(loni,lati,color='black', linestyle='dashed',linewidth=0.1,marker='o',markerfacecolor='green',markersize=5)
plt.xlabel('Longitud')
plt.ylabel('Latitud')