function plot_timeseries_yearly_TRACER_I_EMIS_DA_diagnostics
   clear all;
%
   YYYY_STR=2005;
   YYYY_END=2005;
   MMDDHH_STR=040203;
   MMDDHH_END=040300;
   wrf_vert=[1,5,10];
   incr=3;
   levl=1;
   fac=1;
   nx=440;
   ny=284;
   nz_chemi=20;
   nz_fire=1;
   f_incr=0;
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
      sys_cmd=strcat('rm -rf TRACER_I_EMIS_DA_',string(DATE_STR),'-', ...
      string(DATE_END),'_yearly_da_diagnostics.eps');
      save_file=strcat('TRACER_I_EMIS_DA_',string(DATE_STR),'-', ...
      string(DATE_END),'_yearly_da_diagnostics.eps')
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
	 data_file=strcat('/da_diagnostics_d01_',string(YYYY),'-',F_MM_str,'-',F_DD_str,'_',F_HH_str,':00:00');
         data_dir=strcat('/da_diagnostics/',string(idate),data_file);
         data_file=strcat(data_path,data_dir);
%
% Read data for plotting
%
% E_CO field
         state_var='TRACER_I_E_CO_ARC_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_arc_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_CO_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_prior_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: e_co prior conus mn %d \n',e_co_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_E_CO_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_post_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_CO_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_prior_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_CO_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_post_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_CO_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_incr_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_CO_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_infl_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_E_CO_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_infl_post_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_E_CO_ARC_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_arc_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_CO_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_prior_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_CO_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_post_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_CO_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_prior_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_CO_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_post_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
% 
         state_var='TRACER_I_E_CO_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_incr_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_CO_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_infl_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_E_CO_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_co_infl_post_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
% E_NO2 field
         state_var='TRACER_I_E_NO2_ARC_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_arc_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%         
         state_var='TRACER_I_E_NO2_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_prior_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: e_no2 prior conus mn %d \n',e_no2_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_E_NO2_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_post_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_NO2_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_prior_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_NO2_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_post_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_NO2_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_incr_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%        
         state_var='TRACER_I_E_NO2_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_infl_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%        
         state_var='TRACER_I_E_NO2_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_infl_post_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_E_NO2_ARC_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_arc_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_NO2_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_prior_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_NO2_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_post_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_NO2_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_prior_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_NO2_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_post_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_NO2_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_incr_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_NO2_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_infl_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_E_NO2_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_no2_infl_post_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
% E_SO2 field
         state_var='TRACER_I_E_SO2_ARC_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_arc_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%         
         state_var='TRACER_I_E_SO2_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_prior_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: e_so2 prior conus mn %d \n',e_so2_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_E_SO2_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_post_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_SO2_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_prior_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_SO2_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_post_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_SO2_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_incr_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%        
         state_var='TRACER_I_E_SO2_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_infl_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%        
         state_var='TRACER_I_E_SO2_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_infl_post_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_E_SO2_ARC_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_arc_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_SO2_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_prior_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_SO2_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_post_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_SO2_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_prior_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_SO2_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_post_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_SO2_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_incr_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_SO2_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_infl_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_E_SO2_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         e_so2_infl_post_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
% EBU_IN_CO field
         state_var='TRACER_I_EBU_IN_CO_ARC_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_arc_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_CO_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_prior_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: ebu_in_co prior conus mn %d \n',ebu_in_co_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_EBU_IN_CO_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_post_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_CO_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_prior_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_CO_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_post_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_CO_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_incr_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_CO_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_infl_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_EBU_IN_CO_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_infl_post_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_EBU_IN_CO_ARC_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_arc_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_CO_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_prior_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_CO_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_post_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_CO_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_prior_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_CO_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_post_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
% 
         state_var='TRACER_I_EBU_IN_CO_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_incr_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_CO_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_infl_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_EBU_IN_CO_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_co_infl_post_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
% EBU_IN_NO2 field
         state_var='TRACER_I_EBU_IN_NO2_ARC_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_arc_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_NO2_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_prior_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: ebu_in_no2 prior conus mn %d \n',ebu_in_no2_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_EBU_IN_NO2_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_post_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_NO2_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_prior_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_NO2_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_post_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_NO2_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_incr_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%        
         state_var='TRACER_I_EBU_IN_NO2_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_infl_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%        
         state_var='TRACER_I_EBU_IN_NO2_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_infl_post_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_EBU_IN_NO2_ARC_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_arc_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_NO2_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_prior_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_NO2_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_post_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_NO2_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_prior_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_NO2_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_post_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_NO2_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_incr_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_NO2_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_infl_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_EBU_IN_NO2_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_no2_infl_post_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
% EBU_IN_SO2 field
         state_var='TRACER_I_EBU_IN_SO2_ARC_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_arc_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_SO2_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_prior_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: ebu_in_so2 prior conus mn %d \n',ebu_in_so2_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_EBU_IN_SO2_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_post_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_SO2_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_prior_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_SO2_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_post_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_SO2_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_incr_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%        
         state_var='TRACER_I_EBU_IN_SO2_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_infl_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%        
         state_var='TRACER_I_EBU_IN_SO2_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_infl_post_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_EBU_IN_SO2_ARC_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_arc_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_SO2_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_prior_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_SO2_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_post_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_SO2_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_prior_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_SO2_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_post_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_SO2_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_incr_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_SO2_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_infl_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_EBU_IN_SO2_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         ebu_in_so2_infl_post_urban_mn(ncnt)=fld_full(wrf_vert(levl));
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
% E_CO
      ymn1=min(min(e_co_prior_emn_conus_mn,e_co_post_emn_conus_mn));
      ymx1=max(max(e_co_prior_emn_conus_mn,e_co_post_emn_conus_mn));
      ymn2=min(min(e_co_prior_emn_urban_mn,e_co_post_emn_urban_mn));
      ymx2=max(max(e_co_prior_emn_urban_mn,e_co_post_emn_urban_mn));
      ymn3=min(min(e_co_arc_prior_conus_mn,e_co_arc_prior_urban_mn));
      ymx3=max(max(e_co_arc_prior_conus_mn,e_co_arc_prior_urban_mn));
      ymn=min([ymn1,ymn2,ymn3]);
      ymx=max([ymx1,ymx2,ymx3]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_6(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_CO Time Series'}),'Date/Time','Flux (mol km^{-2} h^{1}))', ...
      'AR Prior CONUS','AR Prior URBAN','DA Prior CONUS','DA Prior Urban', ...
      'DA Post CONUS','DA Post URBAN',save_file,ncnt,ymx,ymn, ...
      e_co_arc_prior_conus_mn,e_co_arc_prior_urban_mn,e_co_prior_emn_conus_mn, ...
      e_co_prior_emn_urban_mn,e_co_post_emn_conus_mn,e_co_post_emn_urban_mn, ...
      e_co_post_esd_conus_mn);
%
      for i=1:ncnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=e_co_prior_esd_conus_mn(i)/e_co_prior_emn_conus_mn(i)*1.e2;
         rel_prior_sprd_urb(i)=e_co_prior_esd_urban_mn(i)/e_co_prior_emn_urban_mn(i)*1.e2;
         rel_post_sprd_con(i)=e_co_post_esd_conus_mn(i)/e_co_prior_emn_conus_mn(i)*1.e2;
         rel_post_sprd_urb(i)=e_co_post_esd_urban_mn(i)/e_co_prior_emn_urban_mn(i)*1.e2;
         rel_incr_con(i)=e_co_incr_conus_mn(i)/e_co_prior_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=e_co_incr_urban_mn(i)/e_co_prior_emn_urban_mn(i)*1.e2;
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_CO Relative Spread'}),'Date/Time','Magnitude (%)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      rel_prior_sprd_con,rel_prior_sprd_urb,rel_post_sprd_con,rel_post_sprd_urb, ...
      err_zero);
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
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_CO Relative Increment'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb);
% Inflation
      ymn1=min(min(e_co_infl_prior_conus_mn,e_co_infl_prior_urban_mn));
      ymx1=max(max(e_co_infl_prior_conus_mn,e_co_infl_prior_urban_mn));
      ymn2=min(min(e_co_infl_post_conus_mn,e_co_infl_post_urban_mn));
      ymx2=max(max(e_co_infl_post_conus_mn,e_co_infl_post_urban_mn));
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_CO Inflation'}),'Date/Time','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      e_co_infl_prior_conus_mn,e_co_infl_prior_urban_mn,e_co_infl_post_conus_mn,e_co_infl_post_urban_mn, ...
      err_zero);
%
% E_NO2
      ymn1=min(min(e_no2_prior_emn_conus_mn,e_no2_post_emn_conus_mn));
      ymx1=max(max(e_no2_prior_emn_conus_mn,e_no2_post_emn_conus_mn));
      ymn2=min(min(e_no2_prior_emn_urban_mn,e_no2_post_emn_urban_mn));
      ymx2=max(max(e_no2_prior_emn_urban_mn,e_no2_post_emn_urban_mn));
      ymn3=min(min(e_no2_arc_prior_conus_mn,e_no2_arc_prior_urban_mn));
      ymx3=max(max(e_no2_arc_prior_conus_mn,e_no2_arc_prior_urban_mn));
      ymn=min([ymn1,ymn2,ymn3]);
      ymx=max([ymx1,ymx2,ymx3]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_6(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_NO2 Time Series'}),'Date/Time','Flux (mol km^{-2} h^{1}))', ...
      'AR Prior CONUS','AR Prior URBAN','DA Prior CONUS','DA Prior Urban', ...
      'DA Post CONUS','DA Post URBAN',save_file,ncnt,ymx,ymn, ...
      e_no2_arc_prior_conus_mn,e_no2_arc_prior_urban_mn,e_no2_prior_emn_conus_mn, ...
      e_no2_prior_emn_urban_mn,e_no2_post_emn_conus_mn,e_no2_post_emn_urban_mn, ...
      e_no2_post_esd_conus_mn);
%
      for i=1:ncnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=e_no2_prior_esd_conus_mn(i)/e_no2_prior_emn_conus_mn(i)*1.e2;
         rel_prior_sprd_urb(i)=e_no2_prior_esd_urban_mn(i)/e_no2_prior_emn_urban_mn(i)*1.e2;
         rel_post_sprd_con(i)=e_no2_post_esd_conus_mn(i)/e_no2_prior_emn_conus_mn(i)*1.e2;
         rel_post_sprd_urb(i)=e_no2_post_esd_urban_mn(i)/e_no2_prior_emn_urban_mn(i)*1.e2;
         rel_incr_con(i)=e_no2_incr_conus_mn(i)/e_no2_prior_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=e_no2_incr_urban_mn(i)/e_no2_prior_emn_urban_mn(i)*1.e2;
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_NO2 Relative Spread'}),'Date/Time','Magnitude (%)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      rel_prior_sprd_con,rel_prior_sprd_urb,rel_post_sprd_con,rel_post_sprd_urb, ...
      err_zero);
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
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_NO2 Relative Increment'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb);
% Inflation
      ymn1=min(min(e_no2_infl_prior_conus_mn,e_no2_infl_prior_urban_mn));
      ymx1=max(max(e_no2_infl_prior_conus_mn,e_no2_infl_prior_urban_mn));
      ymn2=min(min(e_no2_infl_post_conus_mn,e_no2_infl_post_urban_mn));
      ymx2=max(max(e_no2_infl_post_conus_mn,e_no2_infl_post_urban_mn));
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_NO2 Inflation'}),'Date/Time','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      e_no2_infl_prior_conus_mn,e_no2_infl_prior_urban_mn,e_no2_infl_post_conus_mn,e_no2_infl_post_urban_mn, ...
      err_zero);
%
% E_SO2
      ymn1=min(min(e_so2_prior_emn_conus_mn,e_so2_post_emn_conus_mn));
      ymx1=max(max(e_so2_prior_emn_conus_mn,e_so2_post_emn_conus_mn));
      ymn2=min(min(e_so2_prior_emn_urban_mn,e_so2_post_emn_urban_mn));
      ymx2=max(max(e_so2_prior_emn_urban_mn,e_so2_post_emn_urban_mn));
      ymn3=min(min(e_so2_arc_prior_conus_mn,e_so2_arc_prior_urban_mn));
      ymx3=max(max(e_so2_arc_prior_conus_mn,e_so2_arc_prior_urban_mn));
      ymn=min([ymn1,ymn2,ymn3]);
      ymx=max([ymx1,ymx2,ymx3]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_6(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_SO2 Time Series'}),'Date/Time','Flux (mol km^{-2} h^{1}))', ...
      'AR Prior CONUS','AR Prior URBAN','DA Prior CONUS','DA Prior Urban', ...
      'DA Post CONUS','DA Post URBAN',save_file,ncnt,ymx,ymn, ...
      e_so2_arc_prior_conus_mn,e_so2_arc_prior_urban_mn,e_so2_prior_emn_conus_mn, ...
      e_so2_prior_emn_urban_mn,e_so2_post_emn_conus_mn,e_so2_post_emn_urban_mn, ...
      e_so2_post_esd_conus_mn);
%
      for i=1:ncnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=e_so2_prior_esd_conus_mn(i)/e_so2_prior_emn_conus_mn(i)*1.e2;
         rel_prior_sprd_urb(i)=e_so2_prior_esd_urban_mn(i)/e_so2_prior_emn_urban_mn(i)*1.e2;
         rel_post_sprd_con(i)=e_so2_post_esd_conus_mn(i)/e_so2_prior_emn_conus_mn(i)*1.e2;
         rel_post_sprd_urb(i)=e_so2_post_esd_urban_mn(i)/e_so2_prior_emn_urban_mn(i)*1.e2;
         rel_incr_con(i)=e_so2_incr_conus_mn(i)/e_so2_prior_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=e_so2_incr_urban_mn(i)/e_so2_prior_emn_urban_mn(i)*1.e2;
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_SO2 Relative Spread'}),'Date/Time','Magnitude (%)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      rel_prior_sprd_con,rel_prior_sprd_urb,rel_post_sprd_con,rel_post_sprd_urb, ...
      err_zero);
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
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_SO2 Relative Increment'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb);
% Inflation
      ymn1=min(min(e_so2_infl_prior_conus_mn,e_so2_infl_prior_urban_mn));
      ymx1=max(max(e_so2_infl_prior_conus_mn,e_so2_infl_prior_urban_mn));
      ymn2=min(min(e_so2_infl_post_conus_mn,e_so2_infl_post_urban_mn));
      ymx2=max(max(e_so2_infl_post_conus_mn,e_so2_infl_post_urban_mn));
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  E\_SO2 Inflation'}),'Date/Time','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      e_so2_infl_prior_conus_mn,e_so2_infl_prior_urban_mn,e_so2_infl_post_conus_mn,e_so2_infl_post_urban_mn, ...
      err_zero);
%
% EBU_IN_CO
      ymn1=min(min(ebu_in_co_prior_emn_conus_mn,ebu_in_co_post_emn_conus_mn));
      ymx1=max(max(ebu_in_co_prior_emn_conus_mn,ebu_in_co_post_emn_conus_mn));
      ymn2=min(min(ebu_in_co_prior_emn_urban_mn,ebu_in_co_post_emn_urban_mn));
      ymx2=max(max(ebu_in_co_prior_emn_urban_mn,ebu_in_co_post_emn_urban_mn));
      ymn3=min(min(ebu_in_co_arc_prior_conus_mn,ebu_in_co_arc_prior_urban_mn));
      ymx3=max(max(ebu_in_co_arc_prior_conus_mn,ebu_in_co_arc_prior_urban_mn));
      ymn=min([ymn1,ymn2,ymn3]);
      ymx=max([ymx1,ymx2,ymx3]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_6(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_CO Time Series'}),'Date/Time','Flux (mol km^{-2} h^{1}))', ...
      'AR Prior CONUS','AR Prior URBAN','DA Prior CONUS','DA Prior Urban', ...
      'DA Post CONUS','DA Post URBAN',save_file,ncnt,ymx,ymn, ...
      ebu_in_co_arc_prior_conus_mn,ebu_in_co_arc_prior_urban_mn,ebu_in_co_prior_emn_conus_mn, ...
      ebu_in_co_prior_emn_urban_mn,ebu_in_co_post_emn_conus_mn,ebu_in_co_post_emn_urban_mn, ...
      ebu_in_co_post_esd_conus_mn);
%
      for i=1:ncnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=ebu_in_co_prior_esd_conus_mn(i)/ebu_in_co_prior_emn_conus_mn(i)*1.e2;
         rel_prior_sprd_urb(i)=ebu_in_co_prior_esd_urban_mn(i)/ebu_in_co_prior_emn_urban_mn(i)*1.e2;
         rel_post_sprd_con(i)=ebu_in_co_post_esd_conus_mn(i)/ebu_in_co_prior_emn_conus_mn(i)*1.e2;
         rel_post_sprd_urb(i)=ebu_in_co_post_esd_urban_mn(i)/ebu_in_co_prior_emn_urban_mn(i)*1.e2;
         rel_incr_con(i)=ebu_in_co_incr_conus_mn(i)/ebu_in_co_prior_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=ebu_in_co_incr_urban_mn(i)/ebu_in_co_prior_emn_urban_mn(i)*1.e2;
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_CO Relative Spread'}),'Date/Time','Magnitude (%)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      rel_prior_sprd_con,rel_prior_sprd_urb,rel_post_sprd_con,rel_post_sprd_urb, ...
      err_zero);
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
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_CO Relative Increment'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb);
% Inflation
      ymn1=min(min(ebu_in_co_infl_prior_conus_mn,ebu_in_co_infl_prior_urban_mn));
      ymx1=max(max(ebu_in_co_infl_prior_conus_mn,ebu_in_co_infl_prior_urban_mn));
      ymn2=min(min(ebu_in_co_infl_post_conus_mn,ebu_in_co_infl_post_urban_mn));
      ymx2=max(max(ebu_in_co_infl_post_conus_mn,ebu_in_co_infl_post_urban_mn));
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_CO Inflation'}),'Date/Time','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      ebu_in_co_infl_prior_conus_mn,ebu_in_co_infl_prior_urban_mn,ebu_in_co_infl_post_conus_mn,ebu_in_co_infl_post_urban_mn, ...
      err_zero);
%
% EBU_IN_NO2
      ymn1=min(min(ebu_in_no2_prior_emn_conus_mn,ebu_in_no2_post_emn_conus_mn));
      ymx1=max(max(ebu_in_no2_prior_emn_conus_mn,ebu_in_no2_post_emn_conus_mn));
      ymn2=min(min(ebu_in_no2_prior_emn_urban_mn,ebu_in_no2_post_emn_urban_mn));
      ymx2=max(max(ebu_in_no2_prior_emn_urban_mn,ebu_in_no2_post_emn_urban_mn));
      ymn3=min(min(ebu_in_no2_arc_prior_conus_mn,ebu_in_no2_arc_prior_urban_mn));
      ymx3=max(max(ebu_in_no2_arc_prior_conus_mn,ebu_in_no2_arc_prior_urban_mn));
      ymn=min([ymn1,ymn2,ymn3]);
      ymx=max([ymx1,ymx2,ymx3]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_6(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_NO2 Time Series'}),'Date/Time','Flux (mol km^{-2} h^{1}))', ...
      'AR Prior CONUS','AR Prior URBAN','DA Prior CONUS','DA Prior Urban', ...
      'DA Post CONUS','DA Post URBAN',save_file,ncnt,ymx,ymn, ...
      ebu_in_no2_arc_prior_conus_mn,ebu_in_no2_arc_prior_urban_mn,ebu_in_no2_prior_emn_conus_mn, ...
      ebu_in_no2_prior_emn_urban_mn,ebu_in_no2_post_emn_conus_mn,ebu_in_no2_post_emn_urban_mn, ...
      ebu_in_no2_post_esd_conus_mn);
%
      for i=1:ncnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=ebu_in_no2_prior_esd_conus_mn(i)/ebu_in_no2_prior_emn_conus_mn(i)*1.e2;
         rel_prior_sprd_urb(i)=ebu_in_no2_prior_esd_urban_mn(i)/ebu_in_no2_prior_emn_urban_mn(i)*1.e2;
         rel_post_sprd_con(i)=ebu_in_no2_post_esd_conus_mn(i)/ebu_in_no2_prior_emn_conus_mn(i)*1.e2;
         rel_post_sprd_urb(i)=ebu_in_no2_post_esd_urban_mn(i)/ebu_in_no2_prior_emn_urban_mn(i)*1.e2;
         rel_incr_con(i)=ebu_in_no2_incr_conus_mn(i)/ebu_in_no2_prior_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=ebu_in_no2_incr_urban_mn(i)/ebu_in_no2_prior_emn_urban_mn(i)*1.e2;
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_NO2 Relative Spread'}),'Date/Time','Magnitude (%)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      rel_prior_sprd_con,rel_prior_sprd_urb,rel_post_sprd_con,rel_post_sprd_urb, ...
      err_zero);
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
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_NO2 Relative Increment'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb);
% Inflation
      ymn1=min(min(ebu_in_no2_infl_prior_conus_mn,ebu_in_no2_infl_prior_urban_mn));
      ymx1=max(max(ebu_in_no2_infl_prior_conus_mn,ebu_in_no2_infl_prior_urban_mn));
      ymn2=min(min(ebu_in_no2_infl_post_conus_mn,ebu_in_no2_infl_post_urban_mn));
      ymx2=max(max(ebu_in_no2_infl_post_conus_mn,ebu_in_no2_infl_post_urban_mn));
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_NO2 Inflation'}),'Date/Time','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      ebu_in_no2_infl_prior_conus_mn,ebu_in_no2_infl_prior_urban_mn,ebu_in_no2_infl_post_conus_mn,ebu_in_no2_infl_post_urban_mn, ...
      err_zero);
%
% EBU_IN_SO2
      ymn1=min(min(ebu_in_so2_prior_emn_conus_mn,ebu_in_so2_post_emn_conus_mn));
      ymx1=max(max(ebu_in_so2_prior_emn_conus_mn,ebu_in_so2_post_emn_conus_mn));
      ymn2=min(min(ebu_in_so2_prior_emn_urban_mn,ebu_in_so2_post_emn_urban_mn));
      ymx2=max(max(ebu_in_so2_prior_emn_urban_mn,ebu_in_so2_post_emn_urban_mn));
      ymn3=min(min(ebu_in_so2_arc_prior_conus_mn,ebu_in_so2_arc_prior_urban_mn));
      ymx3=max(max(ebu_in_so2_arc_prior_conus_mn,ebu_in_so2_arc_prior_urban_mn));
      ymn=min([ymn1,ymn2,ymn3]);
      ymx=max([ymx1,ymx2,ymx3]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_6(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_SO2 Time Series'}),'Date/Time','Flux (mol km^{-2} h^{1}))', ...
      'AR Prior CONUS','AR Prior URBAN','DA Prior CONUS','DA Prior Urban', ...
      'DA Post CONUS','DA Post URBAN',save_file,ncnt,ymx,ymn, ...
      ebu_in_so2_arc_prior_conus_mn,ebu_in_so2_arc_prior_urban_mn,ebu_in_so2_prior_emn_conus_mn, ...
      ebu_in_so2_prior_emn_urban_mn,ebu_in_so2_post_emn_conus_mn,ebu_in_so2_post_emn_urban_mn, ...
      ebu_in_so2_post_esd_conus_mn);
%
      for i=1:ncnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=ebu_in_so2_prior_esd_conus_mn(i)/ebu_in_so2_prior_emn_conus_mn(i)*1.e2;
         rel_prior_sprd_urb(i)=ebu_in_so2_prior_esd_urban_mn(i)/ebu_in_so2_prior_emn_urban_mn(i)*1.e2;
         rel_post_sprd_con(i)=ebu_in_so2_post_esd_conus_mn(i)/ebu_in_so2_prior_emn_conus_mn(i)*1.e2;
         rel_post_sprd_urb(i)=ebu_in_so2_post_esd_urban_mn(i)/ebu_in_so2_prior_emn_urban_mn(i)*1.e2;
         rel_incr_con(i)=ebu_in_so2_incr_conus_mn(i)/ebu_in_so2_prior_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=ebu_in_so2_incr_urban_mn(i)/ebu_in_so2_prior_emn_urban_mn(i)*1.e2;
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_SO2 Relative Spread'}),'Date/Time','Magnitude (%)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      rel_prior_sprd_con,rel_prior_sprd_urb,rel_post_sprd_con,rel_post_sprd_urb, ...
      err_zero);
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
      rs = plot_series_2(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_SO2 Relative Increment'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb);
% Inflation
      ymn1=min(min(ebu_in_so2_infl_prior_conus_mn,ebu_in_so2_infl_prior_urban_mn));
      ymx1=max(max(ebu_in_so2_infl_prior_conus_mn,ebu_in_so2_infl_prior_urban_mn));
      ymn2=min(min(ebu_in_so2_infl_post_conus_mn,ebu_in_so2_infl_post_urban_mn));
      ymx2=max(max(ebu_in_so2_infl_post_conus_mn,ebu_in_so2_infl_post_urban_mn));
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
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  EBU\_IN\_SO2 Inflation'}),'Date/Time','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      ebu_in_so2_infl_prior_conus_mn,ebu_in_so2_infl_prior_urban_mn,ebu_in_so2_infl_post_conus_mn,ebu_in_so2_infl_post_urban_mn, ...
      err_zero);
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
   save_file,ntim,ymx,ymn,fld_1,fld_2,fld_3,fld_4,fld_5,fld_6,err_1)
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   err_zero(1:ntim)=0.;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',14, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','bold','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',2);
   box(axes1,'on');
   hold(axes1,'all');
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
   errorbar(index,fld_1,err_zero,'-o','LineWidth',1.75,'Color','g')
   errorbar(index,fld_2,err_zero,'--o','LineWidth',1.75,'Color','g')
   errorbar(index,fld_3,err_1,'-o','LineWidth',1.75,'Color','r')
   errorbar(index,fld_4,err_zero,'--o','LineWidth',1.75,'Color','r')
   errorbar(index,fld_5,err_zero,'-o','LineWidth',1.75,'Color','b')
   errorbar(index,fld_6,err_zero,'--o','LineWidth',1.75,'Color','b')
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
   title(ptitle,'Fontsize',14,'FontWeight','bold');
   ax=gca;
   ax.TitleHorizontalAlignment,'center';
   xlabel(xtitle,'FontSize',14);
   ylabel(ytitle,'FontSize',14);
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
