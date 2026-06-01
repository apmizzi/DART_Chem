function plot_timeseries_multi_year_TRACER_I_CHEM_DA_diagnostics
   clear all;
%
   YYYY_STR=2006;
   YYYY_END=2020;
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
   missing=-999;
%
   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
   cmap=desired_colors;
%
   sys_cmd=strcat('rm -rf TRACER_I_CHEM_DA_',string(YYYY_STR),'-', ...
   string(YYYY_END),'_multi_year_da_diagnostics.eps');
   save_file=strcat('TRACER_I_CHEM_DA_',string(YYYY_STR),'-', ...
   string(YYYY_END),'_multi_year_da_diagnostics.eps')
   rc=system(sys_cmd);
   iyear=YYYY_STR;
   nyr_cnt=0.;
   while (iyear<=YYYY_END);
      nyr_cnt=nyr_cnt+1;
      DATE_STR=iyear*1000000+MMDDHH_STR;
      DATE_END=iyear*1000000+MMDDHH_END;
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
	 data_file=strcat('/da_diagnostics_d01_',string(YYYY),'-',F_MM_str,'-',F_DD_str,'_',F_HH_str,':00:00');
         data_dir=strcat('/da_diagnostics/',string(idate),data_file);
         data_file=strcat(data_path,data_dir);
%
% Read data for plotting
%
% CO field
         state_var='TRACER_I_CO_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_prior_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: co prior conus mn %d \n',co_prior_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_CO_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_post_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_CO_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_prior_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_CO_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_post_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_CO_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_incr_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_CO_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_infl_prior_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_CO_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_infl_post_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_CO_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_prior_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_CO_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_post_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_CO_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_prior_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_CO_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_post_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
% 
         state_var='TRACER_I_CO_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_incr_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_CO_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_infl_prior_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_CO_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         co_infl_post_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
% O3 field
         state_var='TRACER_I_O3_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_prior_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: o3 prior conus mn %d \n',o3_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_O3_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_post_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_O3_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_prior_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_O3_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_post_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_O3_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_incr_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%        
         state_var='TRACER_I_O3_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_infl_prior_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%        
         state_var='TRACER_I_O3_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_infl_post_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_O3_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_prior_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_O3_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_post_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_O3_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_prior_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_O3_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_post_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_O3_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_incr_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_O3_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_infl_prior_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_O3_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         o3_infl_post_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
% NO2 field
         state_var='TRACER_I_NO2_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_prior_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: no2 prior conus mn %d \n',no2_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_NO2_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_post_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_NO2_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_prior_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_NO2_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_post_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_NO2_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_incr_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%        
         state_var='TRACER_I_NO2_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_infl_prior_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%        
         state_var='TRACER_I_NO2_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_infl_post_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_NO2_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_prior_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_NO2_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_post_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_NO2_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_prior_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_NO2_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_post_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_NO2_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_incr_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_NO2_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_infl_prior_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_NO2_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         no2_infl_post_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
% SO2 field
         state_var='TRACER_I_SO2_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_prior_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: so2 prior conus mn %d \n',so2_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_SO2_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_post_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_SO2_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_prior_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_SO2_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_post_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_SO2_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_incr_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_SO2_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_infl_prior_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_SO2_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_infl_post_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_SO2_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_prior_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_SO2_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_post_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_SO2_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_prior_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_SO2_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_post_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_SO2_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_incr_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_SO2_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_infl_prior_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_SO2_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         so2_infl_post_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl));
%        
%	 fprintf('MM,DD,HH %d %d %d \n',MM,DD,HH)
         [MM,DD,HH]=date_increment(MM,DD,HH,incr);	 
%	 fprintf('MM,DD,HH %d %d %d \n',MM,DD,HH)
         idate=YYYY*1000000 + MM*10000 + DD*100 + HH;
      end
      iyear=iyear+1;
   end
%
% Average the intra-annual data      
% CO
   co_prior_emn_conus_grmn=zeros(1,nyr_cnt);
   co_post_emn_conus_grmn=zeros(1,nyr_cnt);
   co_prior_esd_conus_grmn=zeros(1,nyr_cnt);
   co_post_esd_conus_grmn=zeros(1,nyr_cnt);
   co_incr_conus_grmn=zeros(1,nyr_cnt);
   co_prior_infl_conus_grmn=zeros(1,nyr_cnt);
   co_post_infl_conus_grmn=zeros(1,nyr_cnt);
   co_prior_emn_urban_grmn=zeros(1,nyr_cnt);
   co_post_emn_urban_grmn=zeros(1,nyr_cnt);
   co_prior_esd_urban_grmn=zeros(1,nyr_cnt);
   co_post_esd_urban_grmn=zeros(1,nyr_cnt);
   co_incr_urban_grmn=zeros(1,nyr_cnt);
   co_prior_infl_urban_grmn=zeros(1,nyr_cnt);
   co_post_infl_urban_grmn=zeros(1,nyr_cnt);
%
% O3
   o3_prior_emn_conus_grmn=zeros(1,nyr_cnt);
   o3_post_emn_conus_grmn=zeros(1,nyr_cnt);
   o3_prior_esd_conus_grmn=zeros(1,nyr_cnt);
   o3_post_esd_conus_grmn=zeros(1,nyr_cnt);
   o3_incr_conus_grmn=zeros(1,nyr_cnt);
   o3_prior_infl_conus_grmn=zeros(1,nyr_cnt);
   o3_post_infl_conus_grmn=zeros(1,nyr_cnt);
   o3_prior_emn_urban_grmn=zeros(1,nyr_cnt);
   o3_post_emn_urban_grmn=zeros(1,nyr_cnt);
   o3_prior_esd_urban_grmn=zeros(1,nyr_cnt);
   o3_post_esd_urban_grmn=zeros(1,nyr_cnt);
   o3_incr_urban_grmn=zeros(1,nyr_cnt);
   o3_prior_infl_urban_grmn=zeros(1,nyr_cnt);
   o3_post_infl_urban_grmn=zeros(1,nyr_cnt);
%
% NO2
   no2_prior_emn_conus_grmn=zeros(1,nyr_cnt);
   no2_post_emn_conus_grmn=zeros(1,nyr_cnt);
   no2_prior_esd_conus_grmn=zeros(1,nyr_cnt);
   no2_post_esd_conus_grmn=zeros(1,nyr_cnt);
   no2_incr_conus_grmn=zeros(1,nyr_cnt);
   no2_prior_infl_conus_grmn=zeros(1,nyr_cnt);
   no2_post_infl_conus_grmn=zeros(1,nyr_cnt);
   no2_prior_emn_urban_grmn=zeros(1,nyr_cnt);
   no2_post_emn_urban_grmn=zeros(1,nyr_cnt);
   no2_prior_esd_urban_grmn=zeros(1,nyr_cnt);
   no2_post_esd_urban_grmn=zeros(1,nyr_cnt);
   no2_incr_urban_grmn=zeros(1,nyr_cnt);
   no2_prior_infl_urban_grmn=zeros(1,nyr_cnt);
   no2_post_infl_urban_grmn=zeros(1,nyr_cnt);
%
% SO2
   so2_prior_emn_conus_grmn=zeros(1,nyr_cnt);
   so2_post_emn_conus_grmn=zeros(1,nyr_cnt);
   so2_prior_esd_conus_grmn=zeros(1,nyr_cnt);
   so2_post_esd_conus_grmn=zeros(1,nyr_cnt);
   so2_incr_conus_grmn=zeros(1,nyr_cnt);
   so2_prior_infl_conus_grmn=zeros(1,nyr_cnt);
   so2_post_infl_conus_grmn=zeros(1,nyr_cnt);
   so2_prior_emn_urban_grmn=zeros(1,nyr_cnt);
   so2_post_emn_urban_grmn=zeros(1,nyr_cnt);
   so2_prior_esd_urban_grmn=zeros(1,nyr_cnt);
   so2_post_esd_urban_grmn=zeros(1,nyr_cnt);
   so2_incr_urban_grmn=zeros(1,nyr_cnt);
   so2_prior_infl_urban_grmn=zeros(1,nyr_cnt);
   so2_post_infl_urban_grmn=zeros(1,nyr_cnt);
%
   for iyr=1:nyr_cnt
% CO
      co_prior_emn_conus_grmn(iyr)=mean(co_prior_emn_conus_mn(iyr,:),'omitnan');
      co_post_emn_conus_grmn(iyr)=mean(co_post_emn_conus_mn(iyr,:),'omitnan');
      co_prior_esd_conus_grmn(iyr)=mean(co_prior_esd_conus_mn(iyr,:),'omitnan');
      co_post_esd_conus_grmn(iyr)=mean(co_post_esd_conus_mn(iyr,:),'omitnan');
      co_incr_conus_grmn(iyr)=mean(co_incr_conus_mn(iyr,:),'omitnan');
      co_prior_infl_conus_grmn(iyr)=mean(co_infl_prior_conus_mn(iyr,:),'omitnan');
      co_post_infl_conus_grmn(iyr)=mean(co_infl_post_conus_mn(iyr,:),'omitnan');
      co_prior_emn_urban_grmn(iyr)=mean(co_prior_emn_urban_mn(iyr,:),'omitnan');
      co_post_emn_urban_grmn(iyr)=mean(co_post_emn_urban_mn(iyr,:),'omitnan');
      co_prior_esd_urban_grmn(iyr)=mean(co_prior_esd_urban_mn(iyr,:),'omitnan');
      co_post_esd_urban_grmn(iyr)=mean(co_post_esd_urban_mn(iyr,:),'omitnan');
      co_incr_urban_grmn(iyr)=mean(co_incr_urban_mn(iyr,:),'omitnan');
      co_prior_infl_urban_grmn(iyr)=mean(co_infl_prior_urban_mn(iyr,:),'omitnan');
      co_post_infl_urban_grmn(iyr)=mean(co_infl_post_urban_mn(iyr,:),'omitnan');
% O3
      o3_prior_emn_conus_grmn(iyr)=mean(o3_prior_emn_conus_mn(iyr,:),'omitnan');
      o3_post_emn_conus_grmn(iyr)=mean(o3_post_emn_conus_mn(iyr,:),'omitnan');
      o3_prior_esd_conus_grmn(iyr)=mean(o3_prior_esd_conus_mn(iyr,:),'omitnan');
      o3_post_esd_conus_grmn(iyr)=mean(o3_post_esd_conus_mn(iyr,:),'omitnan');
      o3_incr_conus_grmn(iyr)=mean(o3_incr_conus_mn(iyr,:),'omitnan');
      o3_prior_infl_conus_grmn(iyr)=mean(o3_infl_prior_conus_mn(iyr,:),'omitnan');
      o3_post_infl_conus_grmn(iyr)=mean(o3_infl_post_conus_mn(iyr,:),'omitnan');
      o3_prior_emn_urban_grmn(iyr)=mean(o3_prior_emn_urban_mn(iyr,:),'omitnan');
      o3_post_emn_urban_grmn(iyr)=mean(o3_post_emn_urban_mn(iyr,:),'omitnan');
      o3_prior_esd_urban_grmn(iyr)=mean(o3_prior_esd_urban_mn(iyr,:),'omitnan');
      o3_post_esd_urban_grmn(iyr)=mean(o3_post_esd_urban_mn(iyr,:),'omitnan');
      o3_incr_urban_grmn(iyr)=mean(o3_incr_urban_mn(iyr,:),'omitnan');
      o3_prior_infl_urban_grmn(iyr)=mean(o3_infl_prior_urban_mn(iyr,:),'omitnan');
      o3_post_infl_urban_grmn(iyr)=mean(o3_infl_post_urban_mn(iyr,:),'omitnan');
% NO2
      no2_prior_emn_conus_grmn(iyr)=mean(no2_prior_emn_conus_mn(iyr,:),'omitnan');
      no2_post_emn_conus_grmn(iyr)=mean(no2_post_emn_conus_mn(iyr,:),'omitnan');
      no2_prior_esd_conus_grmn(iyr)=mean(no2_prior_esd_conus_mn(iyr,:),'omitnan');
      no2_post_esd_conus_grmn(iyr)=mean(no2_post_esd_conus_mn(iyr,:),'omitnan');
      no2_incr_conus_grmn(iyr)=mean(no2_incr_conus_mn(iyr,:),'omitnan');
      no2_prior_infl_conus_grmn(iyr)=mean(no2_infl_prior_conus_mn(iyr,:),'omitnan');
      no2_post_infl_conus_grmn(iyr)=mean(no2_infl_post_conus_mn(iyr,:),'omitnan');
      no2_prior_emn_urban_grmn(iyr)=mean(no2_prior_emn_urban_mn(iyr,:),'omitnan');
      no2_post_emn_urban_grmn(iyr)=mean(no2_post_emn_urban_mn(iyr,:),'omitnan');
      no2_prior_esd_urban_grmn(iyr)=mean(no2_prior_esd_urban_mn(iyr,:),'omitnan');
      no2_post_esd_urban_grmn(iyr)=mean(no2_post_esd_urban_mn(iyr,:),'omitnan');
      no2_incr_urban_grmn(iyr)=mean(no2_incr_urban_mn(iyr,:),'omitnan');
      no2_prior_infl_urban_grmn(iyr)=mean(no2_infl_prior_urban_mn(iyr,:),'omitnan');
      no2_post_infl_urban_grmn(iyr)=mean(no2_infl_post_urban_mn(iyr,:),'omitnan');
% SO2
      so2_prior_emn_conus_grmn(iyr)=mean(so2_prior_emn_conus_mn(iyr,:),'omitnan');
      so2_post_emn_conus_grmn(iyr)=mean(so2_post_emn_conus_mn(iyr,:),'omitnan');
      so2_prior_esd_conus_grmn(iyr)=mean(so2_prior_esd_conus_mn(iyr,:),'omitnan');
      so2_post_esd_conus_grmn(iyr)=mean(so2_post_esd_conus_mn(iyr,:),'omitnan');
      so2_incr_conus_grmn(iyr)=mean(so2_incr_conus_mn(iyr,:),'omitnan');
      so2_prior_infl_conus_grmn(iyr)=mean(so2_infl_prior_conus_mn(iyr,:),'omitnan');
      so2_post_infl_conus_grmn(iyr)=mean(so2_infl_post_conus_mn(iyr,:),'omitnan');
      so2_prior_emn_urban_grmn(iyr)=mean(so2_prior_emn_urban_mn(iyr,:),'omitnan');
      so2_post_emn_urban_grmn(iyr)=mean(so2_post_emn_urban_mn(iyr,:),'omitnan');
      so2_prior_esd_urban_grmn(iyr)=mean(so2_prior_esd_urban_mn(iyr,:),'omitnan');
      so2_post_esd_urban_grmn(iyr)=mean(so2_post_esd_urban_mn(iyr,:),'omitnan');
      so2_incr_urban_grmn(iyr)=mean(so2_incr_urban_mn(iyr,:),'omitnan');
      so2_prior_infl_urban_grmn(iyr)=mean(so2_infl_prior_urban_mn(iyr,:),'omitnan');
      so2_post_infl_urban_grmn(iyr)=mean(so2_infl_post_urban_mn(iyr,:),'omitnan');
   end
   for iyr=1:nyr_cnt
      if(~isnan(co_prior_esd_conus_grmn(iyr)))
         co_prior_esd_conus_grmn(:)=sqrt(co_prior_esd_conus_grmn(:));
      end
      if(~isnan(co_post_esd_conus_grmn(iyr)))
         co_post_esd_conus_grmn(:)=sqrt(co_post_esd_conus_grmn(:));
      end
      if(~isnan(co_prior_esd_urban_grmn(iyr)))
         co_prior_esd_urban_grmn(:)=sqrt(co_prior_esd_urban_grmn(:));
      end
      if(~isnan(co_post_esd_urban_grmn(iyr)))
         co_post_esd_urban_grmn(:)=sqrt(co_post_esd_urban_grmn(:));
      end
      if(~isnan(o3_prior_esd_conus_grmn(iyr)))
         o3_prior_esd_conus_grmn(:)=sqrt(o3_prior_esd_conus_grmn(:));
      end
      if(~isnan(o3_post_esd_conus_grmn(iyr)))
         o3_post_esd_conus_grmn(:)=sqrt(o3_post_esd_conus_grmn(:));
      end
      if(~isnan(o3_prior_esd_urban_grmn(iyr)))
         o3_prior_esd_urban_grmn(:)=sqrt(o3_prior_esd_urban_grmn(:));
      end
      if(~isnan(o3_post_esd_urban_grmn(iyr)))
         o3_post_esd_urban_grmn(:)=sqrt(o3_post_esd_urban_grmn(:));
      end
      if(~isnan(no2_prior_esd_conus_grmn(iyr)))
         no2_prior_esd_conus_grmn(:)=sqrt(no2_prior_esd_conus_grmn(:));
      end
      if(~isnan(no2_post_esd_conus_grmn(iyr)))
         no2_post_esd_conus_grmn(:)=sqrt(no2_post_esd_conus_grmn(:));
      end
      if(~isnan(no2_prior_esd_urban_grmn(iyr)))
         no2_prior_esd_urban_grmn(:)=sqrt(no2_prior_esd_urban_grmn(:));
      end
      if(~isnan(no2_post_esd_urban_grmn(iyr)))
         no2_post_esd_urban_grmn(:)=sqrt(no2_post_esd_urban_grmn(:));
      end
      if(~isnan(so2_prior_esd_conus_grmn(iyr)))
         so2_prior_esd_conus_grmn(:)=sqrt(so2_prior_esd_conus_grmn(:));
      end
      if(~isnan(so2_post_esd_conus_grmn(iyr)))
         so2_post_esd_conus_grmn(:)=sqrt(so2_post_esd_conus_grmn(:));
      end
      if(~isnan(so2_prior_esd_urban_grmn(iyr)))
         so2_prior_esd_urban_grmn(:)=sqrt(so2_prior_esd_urban_grmn(:));
      end
      if(~isnan(so2_post_esd_urban_grmn(iyr)))
         so2_post_esd_urban_grmn(:)=sqrt(so2_post_esd_urban_grmn(:));
      end
   end
%
% PLOT TIMESERIES OF SPATIAL MEAN PRIOR ENSEMBLE MEAN
%
% CO
      ymn1=min(min(co_prior_emn_conus_grmn,co_post_emn_conus_grmn));
      ymx1=max(max(co_prior_emn_conus_grmn,co_post_emn_conus_grmn));
      ymn2=min(min(co_prior_emn_urban_grmn,co_post_emn_urban_grmn));
      ymx2=max(max(co_prior_emn_urban_grmn,co_post_emn_urban_grmn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  CO Time Series'}),'Year','Degree (K)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      co_prior_emn_conus_grmn,co_prior_emn_urban_grmn,co_post_emn_conus_grmn,co_post_emn_urban_grmn, ...
      co_post_esd_conus_grmn,YYYY_STR,YYYY_END);
%
      for i=1:nyr_cnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=co_prior_esd_conus_grmn(i)/co_prior_emn_conus_grmn(i)*1.e2;
         rel_prior_sprd_urb(i)=co_prior_esd_urban_grmn(i)/co_prior_emn_urban_grmn(i)*1.e2;
         rel_post_sprd_con(i)=co_post_esd_conus_grmn(i)/co_post_emn_conus_grmn(i)*1.e2;
         rel_post_sprd_urb(i)=co_post_esd_urban_grmn(i)/co_post_emn_urban_grmn(i)*1.e2;
         rel_incr_con(i)=co_incr_conus_grmn(i)/co_post_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=co_incr_urban_grmn(i)/co_post_emn_urban_mn(i)*1.e2;
      end
% Relative Spread
      ymn1=min(min(rel_prior_sprd_con,rel_prior_sprd_urb));
      ymx1=max(max(rel_prior_sprd_con,rel_prior_sprd_urb));
      ymn2=min(min(rel_post_sprd_con,rel_post_sprd_urb));
      ymx2=max(max(rel_post_sprd_con,rel_post_sprd_urb));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
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
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  CO Relative Spread'}),'Year','Magnitude (%)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      rel_prior_sprd_con,rel_prior_sprd_urb,rel_post_sprd_con,rel_post_sprd_urb, ...
      err_zero,YYYY_STR,YYYY_END);
% Relative Increment
      ymn1=min(min(rel_incr_con,rel_incr_urb));
      ymx1=max(max(rel_incr_con,rel_incr_urb));
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
      rs = plot_series_2(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  CO Relative Increment'}),'Year','Magnitude (%)', ...
      'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb,YYYY_STR,YYYY_END);
% Inflation
      ymn1=min(min(co_prior_infl_conus_grmn,co_prior_infl_urban_grmn));
      ymx1=max(max(co_prior_infl_conus_grmn,co_prior_infl_urban_grmn));
      ymn2=min(min(co_post_infl_conus_grmn,co_post_infl_urban_grmn));
      ymx2=max(max(co_post_infl_conus_grmn,co_post_infl_urban_grmn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
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
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  CO Inflation'}),'Year','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      co_prior_infl_conus_grmn,co_prior_infl_urban_grmn,co_post_infl_conus_grmn,co_post_infl_urban_grmn, ...
      err_zero,YYYY_STR,YYYY_END);
%
% O3
      ymn1=min(min(o3_prior_emn_conus_grmn,o3_post_emn_conus_grmn));
      ymx1=max(max(o3_prior_emn_conus_grmn,o3_post_emn_conus_grmn));
      ymn2=min(min(o3_prior_emn_urban_grmn,o3_post_emn_urban_grmn));
      ymx2=max(max(o3_prior_emn_urban_grmn,o3_post_emn_urban_grmn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  O3 Time Series'}),'Year','Velocity (m/s)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      o3_prior_emn_conus_grmn,o3_prior_emn_urban_grmn,o3_post_emn_conus_grmn,o3_post_emn_urban_grmn, ...
      o3_post_esd_conus_grmn,YYYY_STR,YYYY_END);
%
      for i=1:nyr_cnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=o3_prior_esd_conus_grmn(i)/o3_prior_emn_conus_grmn(i)*1.e2;
         rel_prior_sprd_urb(i)=o3_prior_esd_urban_grmn(i)/o3_prior_emn_urban_grmn(i)*1.e2;
         rel_post_sprd_con(i)=o3_post_esd_conus_grmn(i)/o3_post_emn_conus_grmn(i)*1.e2;
         rel_post_sprd_urb(i)=o3_post_esd_urban_grmn(i)/o3_post_emn_urban_grmn(i)*1.e2;
         rel_incr_con(i)=o3_incr_conus_grmn(i)/o3_post_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=o3_incr_urban_grmn(i)/o3_post_emn_urban_mn(i)*1.e2;
      end
% Relative Spread
      ymn1=min(min(rel_prior_sprd_con,rel_prior_sprd_urb));
      ymx1=max(max(rel_prior_sprd_con,rel_prior_sprd_urb));
      ymn2=min(min(rel_post_sprd_con,rel_post_sprd_urb));
      ymx2=max(max(rel_post_sprd_con,rel_post_sprd_urb));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
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
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  O3 Relative Spread'}),'Year','Magnitude (%)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      rel_prior_sprd_con,rel_prior_sprd_urb,rel_post_sprd_con,rel_post_sprd_urb, ...
      err_zero,YYYY_STR,YYYY_END);
% Relative Increment
      ymn1=min(min(rel_incr_con,rel_incr_urb));
      ymx1=max(max(rel_incr_con,rel_incr_urb));
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
      rs = plot_series_2(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  O3 Relative Increment'}),'Year','Magnitude (%)', ...
      'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb,YYYY_STR,YYYY_END);
% Inflation
      ymn1=min(min(o3_prior_infl_conus_grmn,o3_prior_infl_urban_grmn));
      ymx1=max(max(o3_prior_infl_conus_grmn,o3_prior_infl_urban_grmn));
      ymn2=min(min(o3_post_infl_conus_grmn,o3_post_infl_urban_grmn));
      ymx2=max(max(o3_post_infl_conus_grmn,o3_post_infl_urban_grmn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
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
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  O3 Inflation'}),'Year','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      o3_prior_infl_conus_grmn,o3_prior_infl_urban_grmn,o3_post_infl_conus_grmn,o3_post_infl_urban_grmn, ...
      err_zero,YYYY_STR,YYYY_END);
%
% NO2
      ymn1=min(min(no2_prior_emn_conus_grmn,no2_post_emn_conus_grmn));
      ymx1=max(max(no2_prior_emn_conus_grmn,no2_post_emn_conus_grmn));
      ymn2=min(min(no2_prior_emn_urban_grmn,no2_post_emn_urban_grmn));
      ymx2=max(max(no2_prior_emn_urban_grmn,no2_post_emn_urban_grmn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  NO2 Time Series'}),'Year','Velocity (m/s)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      no2_prior_emn_conus_grmn,no2_prior_emn_urban_grmn,no2_post_emn_conus_grmn,no2_post_emn_urban_grmn, ...
      no2_post_esd_conus_grmn,YYYY_STR,YYYY_END);
%
      for i=1:nyr_cnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=no2_prior_esd_conus_grmn(i)/no2_prior_emn_conus_grmn(i)*1.e2;
         rel_prior_sprd_urb(i)=no2_prior_esd_urban_grmn(i)/no2_prior_emn_urban_grmn(i)*1.e2;
         rel_post_sprd_con(i)=no2_post_esd_conus_grmn(i)/no2_post_emn_conus_grmn(i)*1.e2;
         rel_post_sprd_urb(i)=no2_post_esd_urban_grmn(i)/no2_post_emn_urban_grmn(i)*1.e2;
         rel_incr_con(i)=no2_incr_conus_grmn(i)/no2_post_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=no2_incr_urban_grmn(i)/no2_post_emn_urban_mn(i)*1.e2;
      end
% Relative Spread
      ymn1=min(min(rel_prior_sprd_con,rel_prior_sprd_urb));
      ymx1=max(max(rel_prior_sprd_con,rel_prior_sprd_urb));
      ymn2=min(min(rel_post_sprd_con,rel_post_sprd_urb));
      ymx2=max(max(rel_post_sprd_con,rel_post_sprd_urb));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
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
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  NO2 Relative Spread'}),'Year','Magnitude (%)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      rel_prior_sprd_con,rel_prior_sprd_urb,rel_post_sprd_con,rel_post_sprd_urb, ...
      err_zero,YYYY_STR,YYYY_END);
% Relative Increment
      ymn1=min(min(rel_incr_con,rel_incr_urb));
      ymx1=max(max(rel_incr_con,rel_incr_urb));
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
      rs = plot_series_2(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  NO2 Relative Increment'}),'Year','Magnitude (%)', ...
      'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb,YYYY_STR,YYYY_END);
% Inflation
      ymn1=min(min(no2_prior_infl_conus_grmn,no2_prior_infl_urban_grmn));
      ymx1=max(max(no2_prior_infl_conus_grmn,no2_prior_infl_urban_grmn));
      ymn2=min(min(no2_post_infl_conus_grmn,no2_post_infl_urban_grmn));
      ymx2=max(max(no2_post_infl_conus_grmn,no2_post_infl_urban_grmn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
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
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  NO2 Inflation'}),'Year','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      no2_prior_infl_conus_grmn,no2_prior_infl_urban_grmn,no2_post_infl_conus_grmn,no2_post_infl_urban_grmn, ...
      err_zero,YYYY_STR,YYYY_END);
%
% SO2
      ymn1=min(min(so2_prior_emn_conus_grmn,so2_post_emn_conus_grmn));
      ymx1=max(max(so2_prior_emn_conus_grmn,so2_post_emn_conus_grmn));
      ymn2=min(min(so2_prior_emn_urban_grmn,so2_post_emn_urban_grmn));
      ymx2=max(max(so2_prior_emn_urban_grmn,so2_post_emn_urban_grmn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  SO2 Time Series'}),'Year','Mixing Ratio (pptv)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      so2_prior_emn_conus_grmn,so2_prior_emn_urban_grmn,so2_post_emn_conus_grmn,so2_post_emn_urban_grmn, ...
      so2_post_esd_conus_grmn,YYYY_STR,YYYY_END);
%
      for i=1:nyr_cnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=so2_prior_esd_conus_grmn(i)/so2_prior_emn_conus_grmn(i)*1.e2;
         rel_prior_sprd_urb(i)=so2_prior_esd_urban_grmn(i)/so2_prior_emn_urban_grmn(i)*1.e2;
         rel_post_sprd_con(i)=so2_post_esd_conus_grmn(i)/so2_post_emn_conus_grmn(i)*1.e2;
         rel_post_sprd_urb(i)=so2_post_esd_urban_grmn(i)/so2_post_emn_urban_grmn(i)*1.e2;
         rel_incr_con(i)=so2_incr_conus_grmn(i)/so2_post_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=so2_incr_urban_grmn(i)/so2_post_emn_urban_mn(i)*1.e2;
      end
% Relative Spread
      ymn1=min(min(rel_prior_sprd_con,rel_prior_sprd_urb));
      ymx1=max(max(rel_prior_sprd_con,rel_prior_sprd_urb));
      ymn2=min(min(rel_post_sprd_con,rel_post_sprd_urb));
      ymx2=max(max(rel_post_sprd_con,rel_post_sprd_urb));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
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
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  SO2 Relative Spread'}),'Year','Magnitude (%)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      rel_prior_sprd_con,rel_prior_sprd_urb,rel_post_sprd_con,rel_post_sprd_urb, ...
      err_zero,YYYY_STR,YYYY_END);
% Relative Increment
      ymn1=min(min(rel_incr_con,rel_incr_urb));
      ymx1=max(max(rel_incr_con,rel_incr_urb));
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
      rs = plot_series_2(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  SO2 Relative Increment'}),'Year','Magnitude (%)', ...
      'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb,YYYY_STR,YYYY_END);
% Inflation
      ymn1=min(min(so2_prior_infl_conus_grmn,so2_prior_infl_urban_grmn));
      ymx1=max(max(so2_prior_infl_conus_grmn,so2_prior_infl_urban_grmn));
      ymn2=min(min(so2_post_infl_conus_grmn,so2_post_infl_urban_grmn));
      ymx2=max(max(so2_post_infl_conus_grmn,so2_post_infl_urban_grmn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
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
      rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
      {':  SO2 Inflation'}),'Year','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,nyr_cnt,ymx,ymn, ...
      so2_prior_infl_conus_grmn,so2_prior_infl_urban_grmn,so2_post_infl_conus_grmn,so2_post_infl_urban_grmn, ...
      err_zero,YYYY_STR,YYYY_END);
   return
end   
%
function [rs] = plot_series_2(ptitle,xtitle,ytitle,leg1,leg2, ...
   save_file,ntim,ymx,ymn,fld_1,fld_2,YYYY_STR,YYYY_END)
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   step=2;
   xtickindx=1:step:ntim;
   xticklabl=YYYY_STR:step:YYYY_END;
   xticksiz=size(xticklabl);
   for idx=1:xticksiz(2)
     xtickstr(idx)=string(xticklabl(idx));
   end
   err_zero(1:ntim)=0.;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',14, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','normal','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',1.5);
   box(axes1,'on');   hold(axes1,'all');
   set(gca,'XTick',xtickindx);
   set(gca,'XTickLabel',xtickstr);
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
   save_file,ntim,ymx,ymn,fld_1,fld_2,fld_3,fld_4,err_1,YYYY_STR,YYYY_END)
   siz=50;
   step=2;
   nend=ntim-1;
   index=0:1:ntim-1;
   xtickindx=1:step:ntim;
   xticklabl=YYYY_STR:step:YYYY_END;
   xticksiz=size(xticklabl);
   xticksiz(2);
   for idx=1:xticksiz(2)
     xtickstr(idx)=string(xticklabl(idx));
   end
   err_zero(1:ntim)=0.;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',14, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','normal','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',1.5);
   box(axes1,'on');   hold(axes1,'all');
   set(gca,'XTick',xtickindx);
   set(gca,'XTickLabel',xtickstr);
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
