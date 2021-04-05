# -*- coding: utf-8 -*-
"""
Created on Thu Apr  1 19:33:38 2021

@author: danli
"""
import ftplib
from datetime import date
import datetime

ftp = ftplib.FTP('ftp.ifremer.fr')
ftp.login('', '')

#hoy
today = date.today()
yesterday = today - datetime.timedelta(days=5)#5 dias atrás
ytd=yesterday.strftime("%Y/%m/%d")
dast=int(ytd[8:10]) #dia de inicio
yy=int(ytd[:4])
mm=int(ytd[5:7])
#ftp 
ftp.cwd('ifremer/argo/geo/pacific_ocean/%d/%02d' % (yy,mm))
print(ftp.cwd)
dir_list = []
ftp.dir(dir_list.append)

##find requested day
for ii in range(dast-1,len(dir_list),1):
    #print(ii)
    dir_list_sel=dir_list [ii][56:] 
    file = open(dir_list_sel, 'wb')
    ftp.retrbinary('RETR ' + dir_list_sel, file.write)
    file.close()
    print('Float' + dir_list_sel +'file has been successfully downloaded')
  
import sys
sys.modules[__name__].__dict__.clear()
# %%boyas 

import ftplib

ftp = ftplib.FTP('ftp.pmel.noaa.gov')
ftp.login('taopmelftp', 'G10b@LCh@Ng3')

#savedir = '/mnt/d/CIO/Kelvin-cromwell/boyas/pg_web'
#os.chdir(savedir)

ftp.cwd('/cdf/sites/daily')
print(ftp.cwd)
dir_list = []
ftp.dir(dir_list.append)

#latitudes=[0,2,5,8,9]
latitudes=[0]
for ff in range(len(latitudes)):
    lat=latitudes[ff]; 
    buoy_list=[95,110,125,140,155,170,180]
    for jj in range(0,len(buoy_list)):
        pattern= 't%dn%dw_dy.cdf' % (lat,buoy_list[jj])#north-west
        pattern2= 't%ds%dw_dy.cdf' % (lat,buoy_list[jj])#south-west
        for ii in range (1,len(dir_list)):
            dir_list_end=dir_list [ii][56:]
            #north-west
            if dir_list_end==pattern:
                file = open(dir_list_end, 'wb')
                ftp.retrbinary('RETR ' + dir_list_end, file.write)
                file.close()
                print(dir_list_end)
            #south-west
            if  dir_list_end==pattern2:
                file = open(dir_list_end, 'wb')
                ftp.retrbinary('RETR ' + dir_list_end, file.write)
                file.close()
                print(dir_list_end)
                
    
    buoy_list=[137,147,156,165]
    for jj in range(0,len(buoy_list)):
        pattern= 't%dn%de_dy.cdf' % (lat,buoy_list[jj])#north-east
        pattern2= 't%ds%de_dy.cdf' % (lat,buoy_list[jj])#south-east
        for ii in range (1,len(dir_list)):
            dir_list_end=dir_list [ii][56:]
            if dir_list_end==pattern:#north-east
                file = open(dir_list_end, 'wb')
                ftp.retrbinary('RETR ' + dir_list_end, file.write)
                file.close()
                print(dir_list_end)
            if dir_list_end==pattern2:#south-east
                file = open(dir_list_end, 'wb')
                ftp.retrbinary('RETR ' + dir_list_end, file.write)
                file.close()
                print(dir_list_end)










