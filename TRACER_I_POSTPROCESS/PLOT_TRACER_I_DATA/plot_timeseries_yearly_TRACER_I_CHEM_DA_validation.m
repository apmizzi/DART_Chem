function plot_timeseries_yearly_TRACER_I_CHEM_DA_validation
   clear all;
%
   YYYY_STR=2006;
   YYYY_END=2006;
   MMDDHH_STR=040203;
   MMDDHH_END=040300;
   wrf_vert=[10,14,18,21,23,25,27,29,31,34];
   incr=3;
   levl=1;
   fac=1.e3;
   nx=440;
   ny=284;
   f_incr=0;
   nz=50;
%

   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
   cmap=desired_colors;
%
   iyear=YYYY_STR;
   while (iyear<=YYYY_END);
      DATE_STR=iyear*1000000+MMDDHH_STR;
      DATE_END=iyear*1000000+MMDDHH_END;
      sys_cmd=strcat('rm -rf TRACER_I_CHEM_DA_',string(DATE_STR),'-', ...
      string(DATE_END),'_yearly_da_validation.eps');
      save_file=strcat('TRACER_I_CHEM_DA_',string(DATE_STR),'-', ...
      string(DATE_END),'_yearly_da_validation.eps')
      rc=system(sys_cmd);
      ncnt=0;
      idate=DATE_STR;
      while (idate<=DATE_END);
         ncnt=ncnt+1;
         fprintf('APM: Read data at %d \n',idate)
%
% CHEM DA
         YYYY=floor(idate/1000000);
         MM=floor((idate-YYYY*1000000)/10000);
         DD=floor((idate-YYYY*1000000-MM*10000)/100);
         HH=floor(idate-YYYY*1000000-MM*10000-DD*100);
	 [F_MM,F_DD,F_HH]=date_increment(MM,DD,HH,f_incr);
% 
         MM_str=string(MM);
         F_MM_str=string(F_MM);
         if(MM<10)
            MM_str=strcat('0',string(MM));
         end
         if(F_MM<10)
            F_MM_str=strcat('0',string(F_MM));
         end
         DD_str=string(DD);
         F_DD_str=string(F_DD);
         if(DD<10)
            DD_str=strcat('0',string(DD));
         end
         if(F_DD<10)
            F_DD_str=strcat('0',string(F_DD));
         end
         HH_str=string(HH);
         F_HH_str=string(F_HH);
         if(HH<10)
            HH_str=strcat('0',string(HH));
         end
         if(F_HH<10)
            F_HH_str=strcat('0',string(F_HH));
         end
         data_path=strcat('/nobackupp28/amizzi/OUTPUT_DATA/OUTPUT_',string(YYYY),'_NOAA_EMISADJ_30MEMS');
	 data_file=strcat('/da_validation_d01_',string(YYYY),'-',F_MM_str,'-',F_DD_str,'_',F_HH_str,':00:00');
         data_dir=strcat('/da_validation/',string(idate),data_file);
         data_file=strcat(data_path,data_dir);
%
% Read data for plotting
%
% CONUS CO field
         state_var='AIRN_CO_CONUS_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_conus_mn_ens_mn(ncnt)=fld_full*fac;
         fprintf('APM: co conus mn %d \n',co_conus_mn_ens_mn(ncnt))
%         
         state_var='AIRN_CO_CONUS_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_conus_mn_obs_val(ncnt)=fld_full*fac;
%
         state_var='AIRN_CO_CONUS_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_conus_vr_ens_mn(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_CO_CONUS_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_conus_vr_obs_val(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_CO_CONUS_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_conus_nmb(ncnt)=fld_full;
%
         state_var='AIRN_CO_CONUS_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_conus_rmse(ncnt)=fld_full*fac;
%
         state_var='AIRN_CO_CONUS_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_conus_rcor(ncnt)=fld_full;
%
% URBAN CO field
         state_var='AIRN_CO_URBAN_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_urban_mn_ens_mn(ncnt)=fld_full*fac;
         fprintf('APM: co urban mn %d \n',co_urban_mn_ens_mn(ncnt))
%         
         state_var='AIRN_CO_URBAN_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_urban_mn_obs_val(ncnt)=fld_full*fac;
%
         state_var='AIRN_CO_URBAN_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_urban_vr_ens_mn(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_CO_URBAN_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_urban_vr_obs_val(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_CO_URBAN_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_urban_nmb(ncnt)=fld_full;
%
         state_var='AIRN_CO_URBAN_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_urban_rmse(ncnt)=fld_full*fac;
%
         state_var='AIRN_CO_URBAN_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_urban_rcor(ncnt)=fld_full;
%
% CONUS O3 field
         state_var='AIRN_O3_CONUS_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_conus_mn_ens_mn(ncnt)=fld_full*fac;
         fprintf('APM: o3 conus mn %d \n',o3_conus_mn_ens_mn(ncnt))
%         
         state_var='AIRN_O3_CONUS_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_conus_mn_obs_val(ncnt)=fld_full*fac;
%
         state_var='AIRN_O3_CONUS_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_conus_vr_ens_mn(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_O3_CONUS_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_conus_vr_obs_val(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_O3_CONUS_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_conus_nmb(ncnt)=fld_full;
%
         state_var='AIRN_O3_CONUS_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_conus_rmse(ncnt)=fld_full*fac;
%
         state_var='AIRN_O3_CONUS_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_conus_rcor(ncnt)=fld_full;
%
% URBAN O3 field
         state_var='AIRN_O3_URBAN_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_urban_mn_ens_mn(ncnt)=fld_full*fac;
         fprintf('APM: o3 urban mn %d \n',o3_urban_mn_ens_mn(ncnt))
%         
         state_var='AIRN_O3_URBAN_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_urban_mn_obs_val(ncnt)=fld_full*fac;
%
         state_var='AIRN_O3_URBAN_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_urban_vr_ens_mn(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_O3_URBAN_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_urban_vr_obs_val(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_O3_URBAN_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_urban_nmb(ncnt)=fld_full;
%
         state_var='AIRN_O3_URBAN_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_urban_rmse(ncnt)=fld_full*fac;
%
         state_var='AIRN_O3_URBAN_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_urban_rcor(ncnt)=fld_full;
%
% CONUS NO2 field
         state_var='AIRN_NO2_CONUS_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_conus_mn_ens_mn(ncnt)=fld_full*fac;
         fprintf('APM: no2 conus mn %d \n',no2_conus_mn_ens_mn(ncnt))
%         
         state_var='AIRN_NO2_CONUS_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_conus_mn_obs_val(ncnt)=fld_full*fac;
%
         state_var='AIRN_NO2_CONUS_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_conus_vr_ens_mn(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_NO2_CONUS_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_conus_vr_obs_val(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_NO2_CONUS_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_conus_nmb(ncnt)=fld_full;
%
         state_var='AIRN_NO2_CONUS_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_conus_rmse(ncnt)=fld_full*fac;
%
         state_var='AIRN_NO2_CONUS_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_conus_rcor(ncnt)=fld_full;
%
% URBAN NO2 field
         state_var='AIRN_NO2_URBAN_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_urban_mn_ens_mn(ncnt)=fld_full*fac;
         fprintf('APM: no2 urban mn %d \n',no2_urban_mn_ens_mn(ncnt))
%         
         state_var='AIRN_NO2_URBAN_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_urban_mn_obs_val(ncnt)=fld_full*fac;
%
         state_var='AIRN_NO2_URBAN_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_urban_vr_ens_mn(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_NO2_URBAN_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_urban_vr_obs_val(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_NO2_URBAN_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_urban_nmb(ncnt)=fld_full;
%
         state_var='AIRN_NO2_URBAN_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_urban_rmse(ncnt)=fld_full*fac;
%
         state_var='AIRN_NO2_URBAN_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_urban_rcor(ncnt)=fld_full;
%
% CONUS SO2 field
         state_var='AIRN_SO2_CONUS_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_conus_mn_ens_mn(ncnt)=fld_full*fac;
         fprintf('APM: so2 conus mn %d \n',so2_conus_mn_ens_mn(ncnt))
%         
         state_var='AIRN_SO2_CONUS_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_conus_mn_obs_val(ncnt)=fld_full*fac;
%
         state_var='AIRN_SO2_CONUS_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_conus_vr_ens_mn(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_SO2_CONUS_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_conus_vr_obs_val(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_SO2_CONUS_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_conus_nmb(ncnt)=fld_full;
%
         state_var='AIRN_SO2_CONUS_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_conus_rmse(ncnt)=fld_full*fac;
%
         state_var='AIRN_SO2_CONUS_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_conus_rcor(ncnt)=fld_full;
%
% URBAN SO2 field
         state_var='AIRN_SO2_URBAN_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_urban_mn_ens_mn(ncnt)=fld_full*fac;
         fprintf('APM: so2 urban mn %d \n',so2_urban_mn_ens_mn(ncnt))
%         
         state_var='AIRN_SO2_URBAN_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_urban_mn_obs_val(ncnt)=fld_full*fac;
%
         state_var='AIRN_SO2_URBAN_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_urban_vr_ens_mn(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_SO2_URBAN_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_urban_vr_obs_val(ncnt)=fld_full*fac*fac;
%
         state_var='AIRN_SO2_URBAN_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_urban_nmb(ncnt)=fld_full;
%
         state_var='AIRN_SO2_URBAN_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_urban_rmse(ncnt)=fld_full*fac;
%
         state_var='AIRN_SO2_URBAN_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_urban_rcor(ncnt)=fld_full;
%
%	 fprintf('MM,DD,HH %d %d %d \n',MM,DD,HH)
         [MM,DD,HH]=date_increment(MM,DD,HH,incr);	 
%	 fprintf('MM,DD,HH %d %d %d \n',MM,DD,HH)
         idate=YYYY*1000000 + MM*10000 + DD*100 + HH;
      end
%
% PLOT TIMESERIES OF SPATIAL MEAN PRIOR ENSEMBLE MEAN
      if(MM==4)
         month_str='April ';
      elseif(MM==5)
         month_str='May ';
      elseif(MM==6)
         month_str='June ';
      elseif(MM==7)
         month_str='July ';
      elseif(MM==8)
         month_str='August ';
      elseif(MM==9)
         month_str='September ';
      elseif(MM==10)
         month_str='October ';
      end
%
% CO Mean
      ymn1=min(min(co_conus_mn_ens_mn,co_conus_mn_obs_val));
      ymx1=max(max(co_conus_mn_ens_mn,co_conus_mn_obs_val));
      ymn2=min(min(co_urban_mn_ens_mn,co_urban_mn_obs_val));
      ymx2=max(max(co_urban_mn_ens_mn,co_urban_mn_obs_val));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      co_conus_sd=sqrt(co_conus_vr_ens_mn);
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  CO MN Time Series'}),'Date/Time','Mixing Ratio (ppbv)', ...
      'CO TRC CONUS','CO TRC URBAN','CO OBS CONUS','CO OBS URBAN',save_file,ncnt,ymx,ymn, ...
      co_conus_mn_ens_mn,co_urban_mn_ens_mn,co_conus_mn_obs_val,co_urban_mn_obs_val, ...
      co_conus_sd);
%
% Variance
      scale=1.e-4
      ymn1=min(min(co_conus_vr_ens_mn,co_conus_vr_obs_val));
      ymx1=max(max(co_conus_vr_ens_mn,co_conus_vr_obs_val));
      ymn2=min(min(co_urban_vr_ens_mn,co_urban_vr_obs_val));
      ymx2=max(max(co_urban_vr_ens_mn,co_urban_vr_obs_val));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn*scale;
      ymn=0.
      ymx=1.01*ymx*scale;
      zero_err=zeros(1,ncnt);
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  CO VR Time Series (scaled 10^{-4})'}),'Date/Time','Mixing Ratio (ppbv^2)', ...
      'CO TRC CONUS','CO TRC URBAN','CO OBS CONUS','CO OBS URBAN',save_file,ncnt,ymx,ymn, ...
      co_conus_vr_ens_mn*scale,co_urban_vr_ens_mn*scale,co_conus_vr_obs_val*scale, ...
      co_urban_vr_obs_val*scale,zero_err);
%
% NMB
      ymn1=min(min(co_conus_nmb,co_urban_nmb));
      ymx1=max(max(co_conus_nmb,co_urban_nmb));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  CO NMB Time Series'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      co_conus_nmb,co_urban_nmb);
%
% RMSE
      ymn1=min(min(co_conus_rmse,co_urban_rmse));
      ymx1=max(max(co_conus_rmse,co_urban_rmse));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  CO RMSE Time Series'}),'Date/Time','Mixing Ratio (ppbv)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      co_conus_rmse,co_urban_rmse);
%
% RCOR
      ymn1=min(min(co_conus_rcor,co_urban_rcor));
      ymx1=max(max(co_conus_rcor,co_urban_rcor));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  CO R Time Series'}),'Date/Time','Magnitude ( )', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      co_conus_rcor,co_urban_rcor);
%
% O3 Mean
      ymn1=min(min(o3_conus_mn_ens_mn,o3_conus_mn_obs_val));
      ymx1=max(max(o3_conus_mn_ens_mn,o3_conus_mn_obs_val));
      ymn2=min(min(o3_urban_mn_ens_mn,o3_urban_mn_obs_val));
      ymx2=max(max(o3_urban_mn_ens_mn,o3_urban_mn_obs_val));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      o3_conus_sd=sqrt(o3_conus_vr_ens_mn);
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  O3 MN Time Series'}),'Date/Time','Mixing Ratio (ppbv)', ...
      'O3 TRC CONUS','O3 TRC URBAN','O3 OBS CONUS','O3 OBS URBAN',save_file,ncnt,ymx,ymn, ...
      o3_conus_mn_ens_mn,o3_urban_mn_ens_mn,o3_conus_mn_obs_val,o3_urban_mn_obs_val, ...
      o3_conus_sd);
%
% Variance
      scale=1.;
      ymn1=min(min(o3_conus_vr_ens_mn,o3_conus_vr_obs_val));
      ymx1=max(max(o3_conus_vr_ens_mn,o3_conus_vr_obs_val));
      ymn2=min(min(o3_urban_vr_ens_mn,o3_urban_vr_obs_val));
      ymx2=max(max(o3_urban_vr_ens_mn,o3_urban_vr_obs_val));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn*scale;
      ymn=0.;
      ymx=1.01*ymx*scale;
      zero_err=zeros(1,ncnt);
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  O3 VR Time Series (scaled 10^4'}),'Date/Time','Mixing Ratio (ppbv^2)', ...
      'O3 TRC CONUS','O3 TRC URBAN','O3 OBS CONUS','O3 OBS URBAN',save_file,ncnt,ymx,ymn, ...
      o3_conus_vr_ens_mn,o3_urban_vr_ens_mn,o3_conus_vr_obs_val,o3_urban_vr_obs_val, ...
      zero_err);
%
% NMB
      ymn1=min(min(o3_conus_nmb,o3_urban_nmb));
      ymx1=max(max(o3_conus_nmb,o3_urban_nmb));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  O3 NMB Time Series'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      o3_conus_nmb,o3_urban_nmb);
%
% RMSE
      ymn1=min(min(o3_conus_rmse,o3_urban_rmse));
      ymx1=max(max(o3_conus_rmse,o3_urban_rmse));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  O3 RMSE Time Series'}),'Date/Time','Mixing Ratio (ppbv)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      o3_conus_rmse,o3_urban_rmse);
%
% RCOR
      ymn1=min(min(o3_conus_rcor,o3_urban_rcor));
      ymx1=max(max(o3_conus_rcor,o3_urban_rcor));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  O3 R Time Series'}),'Date/Time','Magnitude ( )', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      o3_conus_rcor,o3_urban_rcor);
%
% NO2 Mean
      ymn1=min(min(no2_conus_mn_ens_mn,no2_conus_mn_obs_val));
      ymx1=max(max(no2_conus_mn_ens_mn,no2_conus_mn_obs_val));
      ymn2=min(min(no2_urban_mn_ens_mn,no2_urban_mn_obs_val));
      ymx2=max(max(no2_urban_mn_ens_mn,no2_urban_mn_obs_val));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      no2_conus_sd=sqrt(no2_conus_vr_ens_mn);
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  NO2 MN Time Series'}),'Date/Time','Mixing Ratio (ppbv)', ...
      'NO2 TRC CONUS','NO2 TRC URBAN','NO2 OBS CONUS','NO2 OBS URBAN',save_file,ncnt,ymx,ymn, ...
      no2_conus_mn_ens_mn,no2_urban_mn_ens_mn,no2_conus_mn_obs_val,no2_urban_mn_obs_val, ...
      no2_conus_sd);
%
% Variance
      ymn1=min(min(no2_conus_vr_ens_mn,no2_conus_vr_obs_val));
      ymx1=max(max(no2_conus_vr_ens_mn,no2_conus_vr_obs_val));
      ymn2=min(min(no2_urban_vr_ens_mn,no2_urban_vr_obs_val));
      ymx2=max(max(no2_urban_vr_ens_mn,no2_urban_vr_obs_val));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      zero_err=zeros(ncnt);
      zero_err=zeros(1,ncnt);
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  NO2 VR Time Series'}),'Date/Time','{Mixing Ratio} {(ppbv^2})', ...
      'NO2 TRC CONUS','NO2 TRC URBAN','NO2 OBS CONUS','NO2 OBS URBAN',save_file,ncnt,ymx,ymn, ...
      no2_conus_vr_ens_mn,no2_urban_vr_ens_mn,no2_conus_vr_obs_val,no2_urban_vr_obs_val, ...
      zero_err);
%
% NMB
      ymn1=min(min(no2_conus_nmb,no2_urban_nmb));
      ymx1=max(max(no2_conus_nmb,no2_urban_nmb));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  NO2 NMB Time Series'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      no2_conus_nmb,no2_urban_nmb);
%
% RMSE
      ymn1=min(min(no2_conus_rmse,no2_urban_rmse));
      ymx1=max(max(no2_conus_rmse,no2_urban_rmse));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  NO2 RMSE Time Series'}),'Date/Time','Mixing Ratio (ppbv)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      no2_conus_rmse,no2_urban_rmse);
%
% RCOR
      ymn1=min(min(no2_conus_rcor,no2_urban_rcor));
      ymx1=max(max(no2_conus_rcor,no2_urban_rcor));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  NO2 R Time Series'}),'Date/Time','Magnitude ( )', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      no2_conus_rcor,no2_urban_rcor);
%
% SO2 Mean
      ymn1=min(min(so2_conus_mn_ens_mn,so2_conus_mn_obs_val));
      ymx1=max(max(so2_conus_mn_ens_mn,so2_conus_mn_obs_val));
      ymn2=min(min(so2_urban_mn_ens_mn,so2_urban_mn_obs_val));
      ymx2=max(max(so2_urban_mn_ens_mn,so2_urban_mn_obs_val));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      so2_conus_sd=sqrt(so2_conus_vr_ens_mn);
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  SO2 MN Time Series'}),'Date/Time','Mixing Ratio (ppbv)', ...
      'SO2 TRC CONUS','SO2 TRC URBAN','SO2 OBS CONUS','SO2 OBS URBAN',save_file,ncnt,ymx,ymn, ...
      so2_conus_mn_ens_mn,so2_urban_mn_ens_mn,so2_urban_mn_obs_val,so2_urban_mn_obs_val, ...
      so2_conus_sd);
%
% Variance
      ymn1=min(min(so2_conus_vr_ens_mn,so2_conus_vr_obs_val));
      ymx1=max(max(so2_conus_vr_ens_mn,so2_conus_vr_obs_val));
      ymn2=min(min(so2_urban_vr_ens_mn,so2_urban_vr_obs_val));
      ymx2=max(max(so2_urban_vr_ens_mn,so2_urban_vr_obs_val));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymn=0.;
      ymx=1.01*ymx;
      zero_err=zeros(1,ncnt);
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  SO2 VR Time Series'}),'Date/Time','{Mixing Ratio} {(ppbv^2})', ...
      'SO2 TRC CONUS','SO2 TRC URBAN','SO2 OBS CONUS','SO2 OBS URBAN',save_file,ncnt,ymx,ymn, ...
      so2_conus_vr_ens_mn,so2_urban_vr_ens_mn,so2_conus_vr_obs_val,so2_urban_vr_obs_val, ...
      zero_err);
%
% NMB
      ymn1=min(min(so2_conus_nmb,so2_urban_nmb));
      ymx1=max(max(so2_conus_nmb,so2_urban_nmb));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  SO2 NMB Time Series'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      so2_conus_nmb,so2_urban_nmb);
%
% RMSE
      ymn1=min(min(so2_conus_rmse,so2_urban_rmse));
      ymx1=max(max(so2_conus_rmse,so2_urban_rmse));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  SO2 RMSE Time Series'}),'Date/Time','Mixing Ratio (ppbv)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      so2_conus_rmse,so2_urban_rmse);
%
% RCOR
      ymn1=min(min(so2_conus_rcor,so2_urban_rcor));
      ymx1=max(max(so2_conus_rcor,so2_urban_rcor));
      ymn=max([ymn1]);
      ymx=max([ymx1]);
      if(ymn>=0)
         ymn=0.85*ymn;
      else
         ymn=1.15*ymn;
      end	
      if(ymx>=0)
         ymx=1.15*ymx;
      else
         ymx=0.85*ymx;
      end	
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  SO2 R Time Series'}),'Date/Time','Magnitude ( )', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      so2_conus_rcor,so2_urban_rcor);




      
return
		  
%
      iyear=iyear+1;
   end		 
   return
end   
%
function [rs] = plot_series_2(ptitle,xtitle,ytitle,leg1,leg2, ...
   save_file,ntim,ymx,ymn,fld_1,fld_2)
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   err_zero(1:ntim)=0.;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',14, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','normal','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',1.5);
   box(axes1,'on');   hold(axes1,'all');
   set(gca,'XTick',[0,1,2,3,4,5,6,nend]);
   set(gca,'XTickLabel',{'03','06','09','12','15','18','21','00'});
%
%   scatter(index,fld_1,siz,'o','fill','MarkerFaceColor','r');
%   scatter(index,fld_2,siz,'o','fill','MarkerFaceColor','r');
%   scatter(index,fld_3,siz,'o','fill','MarkerFaceColor','b');
%   scatter(index,fld_4,siz,'o','fill','MarkerFaceColor','b');
%   scatter(index,fld_5,siz,'o','fill','MarkerFaceColor','g');
%   scatter(index,fld_6,siz,'o','fill','MarkerFaceColor','g');
%
   errorbar(index,fld_1,err_zero,'-o','LineWidth',1.75,'Color','r')
   errorbar(index,fld_2,err_zero,'--o','LineWidth',1.75,'Color','r')
%
%   h=plot(index,fld_1,'r-', ...
%	  index,fld_2,'r--', ...
%	  index,fld_3,'b-', ...
%	  index,fld_4,'b--', ...
%	  index,fld_5,'g-', ...
%	  index,fld_6,'g--');
%
%   set(h(1),'LineWidth',2.3);
%   set(h(2),'LineWidth',2.3);
%   set(h(3),'LineWidth',2.3);
%   set(h(4),'LineWidth',2.3);
%   set(h(5),'LineWidth',2.3);
%   set(h(6),'LineWidth',2.3);
%
   title(ptitle,'Fontsize',14,'FontWeight','normal');
   ax=gca;
   ax.TitleHorizontalAlignment,'center';
   xlabel(xtitle,'FontSize',14);
   ylabel(ytitle,'FontSize',14);
   hleg=legend(leg1,leg2);
   set(hleg,'Location','northeastoutside','FontSize',8,'FontWeight','normal');
   print(gcf,'-dpsc2','-append',save_file);
   rs=0;
end
%
function [rs] = plot_series_3(ptitle,xtitle,ytitle,leg1,leg2,leg3, ...
   save_file,ntim,ymx,ymn,fld_1,fld_2,fld_3)
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   err_zero(1:ntim)=0.;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',14, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','normal','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',1.5);
   box(axes1,'on');   hold(axes1,'all');
   set(gca,'XTick',[0,1,2,3,4,5,6,nend]);
   set(gca,'XTickLabel',{'03','06','09','12','15','18','21','00'});
%
%   scatter(index,fld_1,siz,'o','fill','MarkerFaceColor','r');
%   scatter(index,fld_2,siz,'o','fill','MarkerFaceColor','r');
%   scatter(index,fld_3,siz,'o','fill','MarkerFaceColor','b');
%   scatter(index,fld_4,siz,'o','fill','MarkerFaceColor','b');
%   scatter(index,fld_5,siz,'o','fill','MarkerFaceColor','g');
%   scatter(index,fld_6,siz,'o','fill','MarkerFaceColor','g');
%
   errorbar(index,fld_1,err_zero,'-o','LineWidth',1.75,'Color','r')
   errorbar(index,fld_2,err_zero,'-o','LineWidth',1.75,'Color','b')
   errorbar(index,fld_3,err_zero,'-o','LineWidth',1.75,'Color','g')
%
%   h=plot(index,fld_1,'r-', ...
%	  index,fld_2,'r--', ...
%	  index,fld_3,'b-', ...
%	  index,fld_4,'b--', ...
%	  index,fld_5,'g-', ...
%	  index,fld_6,'g--');
%
%   set(h(1),'LineWidth',2.3);
%   set(h(2),'LineWidth',2.3);
%   set(h(3),'LineWidth',2.3);
%   set(h(4),'LineWidth',2.3);
%   set(h(5),'LineWidth',2.3);
%   set(h(6),'LineWidth',2.3);
%
   title(ptitle,'Fontsize',14,'FontWeight','normal');
   ax=gca;
   ax.TitleHorizontalAlignment,'center';
   xlabel(xtitle,'FontSize',14);
   ylabel(ytitle,'FontSize',14);
   hleg=legend(leg1,leg2,leg3);
   set(hleg,'Location','northeastoutside','FontSize',8,'FontWeight','normal');
   print(gcf,'-dpsc2','-append',save_file);
   rs=0;
end
%
function [rs] = plot_series_4(ptitle,xtitle,ytitle,leg1,leg2,leg3,leg4, ...
   save_file,ntim,ymx,ymn,fld_1,fld_2,fld_3,fld_4,err_1)
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   err_zero(1:ntim)=0.;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',14, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','normal','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',1.5);
   box(axes1,'on');   hold(axes1,'all');
   set(gca,'XTick',[0,1,2,3,4,5,6,nend]);
   set(gca,'XTickLabel',{'03','06','09','12','15','18','21','00'});
%
%   scatter(index,fld_1,siz,'o','fill','MarkerFaceColor','r');
%   scatter(index,fld_2,siz,'o','fill','MarkerFaceColor','r');
%   scatter(index,fld_3,siz,'o','fill','MarkerFaceColor','b');
%   scatter(index,fld_4,siz,'o','fill','MarkerFaceColor','b');
%   scatter(index,fld_5,siz,'o','fill','MarkerFaceColor','g');
%   scatter(index,fld_6,siz,'o','fill','MarkerFaceColor','g');
%
   errorbar(index,fld_1,err_1,'-o','LineWidth',1.75,'Color','r')
   errorbar(index,fld_2,err_zero,'--o','LineWidth',1.75,'Color','r')
   errorbar(index,fld_3,err_zero,'-o','LineWidth',1.75,'Color','b')
   errorbar(index,fld_4,err_zero,'--o','LineWidth',1.75,'Color','b')
%
%   h=plot(index,fld_1,'r-', ...
%	  index,fld_2,'r--', ...
%	  index,fld_3,'b-', ...
%	  index,fld_4,'b--', ...
%	  index,fld_5,'g-', ...
%	  index,fld_6,'g--');
%
%   set(h(1),'LineWidth',2.3);
%   set(h(2),'LineWidth',2.3);
%   set(h(3),'LineWidth',2.3);
%   set(h(4),'LineWidth',2.3);
%   set(h(5),'LineWidth',2.3);
%   set(h(6),'LineWidth',2.3);
%
   title(ptitle,'Fontsize',14,'FontWeight','normal');
   ax=gca;
   ax.TitleHorizontalAlignment,'center';
   xlabel(xtitle,'FontSize',14);
   ylabel(ytitle,'FontSize',14);
   hleg=legend(leg1,leg2,leg3,leg4);
   set(hleg,'Location','northeastoutside','FontSize',8,'FontWeight','normal');
   print(gcf,'-dpsc2','-append',save_file);
   rs=0;
end
%
function [rs] = plot_series_6(ptitle,xtitle,ytitle,leg1,leg2,leg3,leg4,leg5,leg6, ...
   save_file,ntim,ymx,ymn,fld_1,fld_2,fld_3,fld_4,fld_5,fld_6,err_1,err_2)
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   err_zero(1:ntim)=0.;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',15, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','bold','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',2);
   box(axes1,'on');
   hold(axes1,'all');
   set(gca,'XTick',[0,1,2,3,4,5,6,7,nend]);
   set(gca,'XTickLabel',{'00','03','06','09','12','15','18','21','00'});
%
%   scatter(index,fld_1,siz,'o','fill','MarkerFaceColor','r');
%   scatter(index,fld_2,siz,'o','fill','MarkerFaceColor','r');
%   scatter(index,fld_3,siz,'o','fill','MarkerFaceColor','b');
%   scatter(index,fld_4,siz,'o','fill','MarkerFaceColor','b');
%   scatter(index,fld_5,siz,'o','fill','MarkerFaceColor','g');
%   scatter(index,fld_6,siz,'o','fill','MarkerFaceColor','g');
%
   errorbar(index,fld_1,err_1,'-o','LineWidth',2.3,'Color','r')
   errorbar(index,fld_2,err_zero,'--o','LineWidth',2.3,'Color','r')
   errorbar(index,fld_3,err_zero,'-o','LineWidth',2.3,'Color','b')
   errorbar(index,fld_4,err_zero,'--o','LineWidth',2.3,'Color','b')
   errorbar(index,fld_5,err_zero,'-o','LineWidth',2.3,'Color','g')
   errorbar(index,fld_6,err_zero,'--o','LineWidth',2.3,'Color','g')
%
%   h=plot(index,fld_1,'r-', ...
%	  index,fld_2,'r--', ...
%	  index,fld_3,'b-', ...
%	  index,fld_4,'b--', ...
%	  index,fld_5,'g-', ...
%	  index,fld_6,'g--');
%
%   set(h(1),'LineWidth',2.3);
%   set(h(2),'LineWidth',2.3);
%   set(h(3),'LineWidth',2.3);
%   set(h(4),'LineWidth',2.3);
%   set(h(5),'LineWidth',2.3);
%   set(h(6),'LineWidth',2.3);
%
   title(ptitle,'Fontsize',18,'FontWeight','bold');
   xlabel(xtitle,'FontSize',16);
   ylabel(ytitle,'FontSize',16);
   hleg=legend(leg1,leg2,leg3,leg4,leg5,leg6);
   set(hleg,'Location','northeastoutside','FontSize',8,'FontWeight','bold');
   print(gcf,'-dpsc2','-append',save_file);
   rs=0;
end
%
function [rs] = plot_series_8(ptitle,xtitle,ytitle,leg1,leg2,leg3,leg4,leg5,leg6,leg7,leg8, ...
   save_file,ntim,ymx,ymn,fld_1,fld_2,fld_3,fld_4,fld_5,fld_6,fld_7,fld_8,err_1,err_2,f_incr)
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   err_zero(1:ntim)=0.;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',14, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','normal','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',1.5);
   box(axes1,'on');   hold(axes1,'all');
   set(gca,'XTick',[0,1,2,3,4,5,6,7,nend]);
   if(f_incr==0) 
      set(gca,'XTickLabel',{'00','03','06','09','12','15','18','21','00'});
   else
      set(gca,'XTickLabel',{'03','06','09','12','15','18','21','00','03'});
   end
%
%   scatter(index,fld_1,siz,'o','fill','MarkerFaceColor','r');
%   scatter(index,fld_2,siz,'o','fill','MarkerFaceColor','r');
%   scatter(index,fld_3,siz,'o','fill','MarkerFaceColor','b');
%   scatter(index,fld_4,siz,'o','fill','MarkerFaceColor','b');
%   scatter(index,fld_5,siz,'o','fill','MarkerFaceColor','g');
%   scatter(index,fld_6,siz,'o','fill','MarkerFaceColor','g');
%
   errorbar(index,fld_1,err_1,'-o','LineWidth',1.75,'Color','r')
   errorbar(index,fld_2,err_zero,'--o','LineWidth',1.75,'Color','r')
   errorbar(index,fld_3,err_zero,'-o','LineWidth',1.75,'Color','b')
   errorbar(index,fld_4,err_zero,'--o','LineWidth',1.75,'Color','b')
   errorbar(index,fld_5,err_zero,'-o','LineWidth',1.75,'Color','g')
   errorbar(index,fld_6,err_zero,'--o','LineWidth',1.75,'Color','g')
   errorbar(index,fld_7,err_zero,'-o','LineWidth',1.75,'Color','m')
   errorbar(index,fld_8,err_zero,'--o','LineWidth',1.75,'Color','m')
%
%   h=plot(index,fld_1,'r-', ...
%	  index,fld_2,'r--', ...
%	  index,fld_3,'b-', ...
%	  index,fld_4,'b--', ...
%	  index,fld_5,'g-', ...
%	  index,fld_6,'g--');
%
%   set(h(1),'LineWidth',2.3);
%   set(h(2),'LineWidth',2.3);
%   set(h(3),'LineWidth',2.3);
%   set(h(4),'LineWidth',2.3);
%   set(h(5),'LineWidth',2.3);
%   set(h(6),'LineWidth',2.3);
%
   title(ptitle,'Fontsize',14,'FontWeight','normal');
   ax=gca;
   ax.TitleHorizontalAlignment,'center';
   xlabel(xtitle,'FontSize',14);
   ylabel(ytitle,'FontSize',14);
   hleg=legend(leg1,leg2,leg3,leg4,leg5,leg6,leg7,leg8);
   set(hleg,'Location','northeastoutside','FontSize',8,'FontWeight','normal');
   print(gcf,'-dpsc2','-append',save_file);
   rs=0;
end
%
function [MM,DD,HH]=date_increment(MM,DD,HH,f_incr)	 
   HH = HH + f_incr;
   if(HH>=24)
      HH=0;
      DD=DD+1;
      if(MM==4 & DD>30)
         DD=1;
         MM=MM+1;
      elseif(MM==5 & DD>31)
         DD=1;
         MM=MM+1;
      elseif(MM==6 & DD>30)
         DD=1;
         MM=MM+1;
      elseif(MM==7 & DD>31)
         DD=1;
         MM=MM+1;
      elseif(MM==8 & DD>31)
         DD=1;
         MM=MM+1;
      elseif(MM==9 & DD>30)
         DD=1;
         MM=MM+1;
      elseif(MM==10 & DD>31)
         DD=1;
         MM=MM+1;
      end	   
   end
end
%
