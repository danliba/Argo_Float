# -*- coding: utf-8 -*-
"""
Created on Fri Apr  2 18:36:33 2021

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
lati=[];lono=[];
temp_cum=np.zeros((297,int(len(floto_list))))
pres_cum=np.zeros((297,int(len(floto_list))))
lon_cum=np.zeros((297,int(len(floto_list))))

for kk in range(0,len(floto_list),1):
    fn=floto_list[kk]
    fns=np.load(fn,allow_pickle=True)
       
    lat = fns['lat']
    lon = fns['lon'] 
    depth=fns['depth']
    temp=fns['sst']
    loni,depi = np.meshgrid(lon,depth)
    lono.append(lon);
    data=[depth,temp,loni]
    df=pd.DataFrame(data).T
    
    # # sal_cum=np.zeros((310,int(len(data_cum))))
    # for kk in range(0,len(floto_list),1):
    #     #print(kk)
    ik=-1
    for iz in range(4,300+1,1):
        #print(iz)
    
        indx=np.where(np.array(df[0],dtype=int)==iz)
        indx=pd.DataFrame(functools.reduce(lambda sub, ele: sub * 10 + ele, indx))
        indx_data=np.array(indx)   
        ik=ik+1
        if len(indx_data)>1 :
            indx_data=indx[0]
        if len(indx[0])==1:
            #print('list is not empty')
            pres_cum[ik,kk]=np.around(df[0][int(indx_data)])
            temp_cum[ik,kk]=df[1][int(indx_data)]
            lon_cum[ik,kk]=df[2][int(indx_data)]
        else:
            pres_cum[ik,kk]=float('nan')
            temp_cum[ik,kk]=float('nan')
            lon_cum[ik,kk]=float('nan')

    print(fn+'-was succesfully processed')

lono=np.array(lono,dtype='float')
order = np.argsort(lono)
lonos=lono[order]
tempo=temp_cum[:,order]
preso=pres_cum[:,order]

#valores no repetidos
q=1 * np.round(lonos/1)
lon_unique=np.unique(q, return_index=True, return_inverse=True, return_counts=True, axis=None)
sst_unique=tempo[:,lon_unique[1]]

Y=np.array(list(range(4,300+1,1)))
xi,yi=np.meshgrid(lon_unique[0],Y)

## interpolacion

xi,di=np.meshgrid(list(range(len(lon_unique[0]))),Y);


#distance matrix
# def distance_matrix(x0, y0, x1, y1):
#     obs = np.vstack((x0, y0)).T
#     interp = np.vstack((x1, y1)).T

#     # Make a distance matrix between pairwise observations
#     # Note: from <http://stackoverflow.com/questions/1871536>
#     # (Yay for ufuncs!)
#     d0 = np.subtract.outer(obs[:,0], interp[:,0])
#     d1 = np.subtract.outer(obs[:,1], interp[:,1])

#     return np.hypot(d0, d1)

# # simple idw
# def simple_idw(x, y, z, xi, yi):
#     dist = distance_matrix(x,y, xi,yi)

#     # In IDW, weights are 1 / distance
#     weights = 1.0 / dist

#     # Make weights sum to one
#     weights /= weights.sum(axis=0)

#     # Multiply the weights for each interpolated point by all observed Z-values
#     zi = np.dot(weights.T, z)
#     return zi

    
# z=simple_idw(len(lon_unique[0]),Y,sst_unique,xi,yi)



plt.figure(figsize=(10,5))
vmin=8; vmax=32; step=2;#colorscale
cs = plt.pcolormesh(lon_unique[0], -Y, sst_unique, vmin=vmin, vmax=vmax, cmap='jet', shading='goraud')

contours= plt.contourf(lon_unique[0], -Y, sst_unique,levels=[10,11,12,15,20,25,28,30],cmap='jet',linewidths=0.5)
plt.clabel(contours, inline=True,fmt = '%2.0f',fontsize=10)
plt.ylim([-300,0])
cb = plt.colorbar(cs, pad=0.02, orientation='vertical', fraction=0.1)
cb.ax.locator_params(nbins=len(list(range(vmin,vmax,step))))
cb.ax.tick_params(direction='out')
cb.set_label('Temperature ($^\circ$C)')

