% ---------------------------- Thesis 2020 --------------------------------
%% ONLY TO GET THE DATA
%%
% SECTIONS ALONG LONGITUDES ONLY
% running ORCA12 model configuration from NEMO for current velocities
% from 1988 to 2007 - 20 years data, 0.08 resolution 

clear
%close all 
fclose all;
clc
% Warning: If this script is being ran from Gandy's compute, use this path:
% cd /Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics
% Otherwise:NOCS uses:cd /noc/msm/scratch/nemo/rma/ARIANE/hires8807PacEtropics/
% -------------------------------------------------------------------------
% info
% T0000.nc ORCA0083-N01_19880105d05T.nc --> 1988 01 05
% T0002.nc ORCA0083-N01_19880115d05T.nc
% end data
% W1458.nc ORCA0083-N01_20071226d05W.nc
% W1459.nc ORCA0083-N01_20071231d05W.nc
% -------------------------------------------------------------------------
% satscript
% -------------------------------------------------------------------------

%%  along specific latitudes
% 3S(index=147); 5S(index=123); 6S(index=110); 7S(index=98) ; 8S(index=86)
% 9S(index=74) ; 10S(index=62); 11S(index=50); 12S(index=37)

% from 77.25ºW to 85ºW: (index= 1021:1:1114)
% from 78.25ºW to 85ºW: (index= 1021:1:1102)
% from 78.5ºW to 85ºW: (index= 1021:1:1099)
% from 79ºW to 85ºW: (index= 1021:1:1093)
% from 80ºW to 85ºW: (index= 1021:1081)
% from 81ºW to 85ºW: (index= 1021:1:1069)

% and depths 0 to 410m (index 0 to 38)
% idays = 73 = 1year;

% lons(indx,1) 
iLat_select = 9; % S

fopen all;
 
lon_i=1021:1:1099; %  from 78.5ºW to 85ºW
lat_i=74; % 9S 
dep_i=1:1:38;
 
fday = 1460; % for 20 years -- 73*20=1460
Uvelall_sec = NaN(length(lon_i),length(dep_i),fday); % zonal
Vvelall_sec = NaN(length(lon_i),length(dep_i),fday); % meridional
Wvelall_sec = NaN(length(lon_i),length(dep_i),fday); % vertical
%  
 for iday = 1:fday % 1 TO 6 will be a month
     i = iday-1;
     iday
     if(i <= 9)
         fname1 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/U000',num2str(i),'.nc']);
         fname2 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/V000',num2str(i),'.nc']);
         fname3 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/W000',num2str(i),'.nc']);
     end
     
     if(i >= 10) && (i <= 99)
         fname1 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/U00',num2str(i),'.nc']);
         fname2 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/V00',num2str(i),'.nc']);
         fname3 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/W00',num2str(i),'.nc']);
     end
     
     if(i >= 100) && (i <= 999)
         fname1 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/U0',num2str(i),'.nc']);
         fname2 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/V0',num2str(i),'.nc']);
         fname3 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/W0',num2str(i),'.nc']);
     end
     
     if(i >= 1000)
         fname1 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/U',num2str(i),'.nc']);
         fname2 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/V',num2str(i),'.nc']);
         fname3 = char(['/Volumes/GANDY_4TB/nemo/ARIANE/hires8807PacEtropics/W',num2str(i),'.nc']);
     end
     
     % getting variable from frame 1
     ncid = netcdf.open(fname1);
     varid = netcdf.inqVarID(ncid, 'vozocrtx'); % Zonal Current
     Uvel = netcdf.getVar(ncid, varid);
     
     % getting variable from frame 2
     ncid = netcdf.open(fname2);
     varid = netcdf.inqVarID(ncid, 'vomecrty'); % Meridional Current
     Vvel = netcdf.getVar(ncid, varid);
     
     % getting variable from frame 3
     ncid = netcdf.open(fname3);
     varid = netcdf.inqVarID(ncid, 'vovecrtz'); % Vertical Current
     Wvel = netcdf.getVar(ncid, varid);
     
     varid = netcdf.inqVarID(ncid, 'depthw'); % Depth
     deps = netcdf.getVar(ncid, varid);
     
     varid = netcdf.inqVarID(ncid, 'nav_lat'); % lat
     lats = netcdf.getVar(ncid, varid);
     
     varid = netcdf.inqVarID(ncid, 'nav_lon'); % Lon
     lons = netcdf.getVar(ncid, varid);
     
     
     % for zonal current m/s
     Uvels_sec = Uvel(lon_i,lat_i,dep_i);
     Uvels_sec = permute(Uvels_sec,[1 3 2]);
     Uvelall_sec(:,:,iday) = Uvels_sec;
     
     % for meridional current m/s
     Vvels_sec = Vvel(lon_i,lat_i,dep_i);
     Vvels_sec = permute(Vvels_sec,[1 3 2]);
     Vvelall_sec(:,:,iday) = Vvels_sec;
     
     % for vertical current m/s
     Wvels_sec = Wvel(lon_i,lat_i,dep_i);
     Wvels_sec = permute(Wvels_sec,[1 3 2]);
     Wvelall_sec(:,:,iday) = Wvels_sec;
     
     % for lats in specific area
     lat_sec = lats(1,lat_i);
     lon_sec = lons(lon_i,dep_i);
     
 end

%%
clear fname1 fname2 fname3 ncid varid Uvels_sec Vvels_sec Wvels_sec lon_i lat_i dep_i fday i iday
clear Wvel Vvel Uvel iLat_select lats lons
% 
% saving data
save('Uvelall_sec','-v7.3','-nocompression');
save('Vvelall_sec','-v7.3','-nocompression');    
save('Wvelall_sec','-v7.3','-nocompression');   
save('lat_sec','-v7.3','-nocompression'); 
save('lon_sec','-v7.3','-nocompression'); 
save('deps','-v7.3','-nocompression'); 

%% getting ranges

% Uvelclm_min = min(Uvelclm_sec(:))
% Uvelclm_max = max(Uvelclm_sec(:))
% 
% Vvelclm_min = min(Vvelclm_sec(:))
% Vvelclm_max = max(Vvelclm_sec(:))
% 
% Wvelclm_min = min(Wvelclm_sec(:))
% Wvelclm_max = max(Wvelclm_sec(:))

