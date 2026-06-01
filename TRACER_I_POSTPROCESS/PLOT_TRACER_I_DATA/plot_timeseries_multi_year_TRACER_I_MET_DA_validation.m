function plot_timeseries_multi_year_TRACER_I_MET_DA_validation
   clear all;
%
   YYYY_STR=2006;
   YYYY_END=2020;
   MMDDHH_STR=040203;
   MMDDHH_END=040300;
   wrf_vert=[10,14,18,21,23,25,27,29,31,34];
   incr=3;
   levl=1;
   fac=1.;
   qfac=1.e3;
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
   sys_cmd=strcat('rm -rf TRACER_I_MET_DA_',string(YYYY_STR),'-', ...
   string(YYYY_END),'_multi_year_da_validation.eps');
   save_file=strcat('TRACER_I_MET_DA_',string(YYYY_STR),'-', ...
   string(YYYY_END),'_multi_year_da_validation.eps')
   rc=system(sys_cmd);
   iyear=YYYY_STR;
   nyr_cnt=0;
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
	 data_file=strcat('/da_validation_d01_',string(YYYY),'-',F_MM_str,'-',F_DD_str,'_',F_HH_str,':00:00');
         data_dir=strcat('/da_validation/',string(idate),data_file);
         data_file=strcat(data_path,data_dir);
%
% Read data for plotting
%
% CONUS T field
         state_var='RADS_T_CONUS_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_conus_mn_ens_mn(nyr_cnt,ncnt)=fld_full;
         fprintf('APM: t conus mn %d \n',t_conus_mn_ens_mn(ncnt))
%
         state_var='RADS_T_CONUS_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_conus_mn_obs_val(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_T_CONUS_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_conus_vr_ens_mn(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_T_CONUS_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_conus_vr_obs_val(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_T_CONUS_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_conus_nmb(nyr_cnt,ncnt)=fld_full;
%
         state_var='RADS_T_CONUS_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_conus_rmse(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_T_CONUS_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_conus_rcor(nyr_cnt,ncnt)=fld_full;
%
% URBAN T field
         state_var='RADS_T_URBAN_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_urban_mn_ens_mn(nyr_cnt,ncnt)=fld_full*fac;
         fprintf('APM: t urban mn %d \n',t_urban_mn_ens_mn(ncnt))
%         
         state_var='RADS_T_URBAN_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_urban_mn_obs_val(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_T_URBAN_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_urban_vr_ens_mn(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_T_URBAN_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_urban_vr_obs_val(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_T_URBAN_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_urban_nmb(nyr_cnt,ncnt)=fld_full;
%
         state_var='RADS_T_URBAN_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_urban_rmse(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_T_URBAN_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_urban_rcor(nyr_cnt,ncnt)=fld_full;
%
% CONUS U field
         state_var='RADS_U_CONUS_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_conus_mn_ens_mn(nyr_cnt,ncnt)=fld_full*fac;
         fprintf('APM: u conus mn %d \n',u_conus_mn_ens_mn(nyr_cnt,ncnt))
%         
         state_var='RADS_U_CONUS_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_conus_mn_obs_val(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_U_CONUS_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_conus_vr_ens_mn(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_U_CONUS_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_conus_vr_obs_val(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_U_CONUS_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_conus_nmb(nyr_cnt,ncnt)=fld_full;
%
         state_var='RADS_U_CONUS_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_conus_rmse(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_U_CONUS_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_conus_rcor(nyr_cnt,ncnt)=fld_full;
%
% URBAN U field
         state_var='RADS_U_URBAN_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_urban_mn_ens_mn(nyr_cnt,ncnt)=fld_full*fac;
         fprintf('APM: u urban mn %d \n',u_urban_mn_ens_mn(nyr_cnt,ncnt))
%         
         state_var='RADS_U_URBAN_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_urban_mn_obs_val(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_U_URBAN_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_urban_vr_ens_mn(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_U_URBAN_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_urban_vr_obs_val(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_U_URBAN_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_urban_nmb(nyr_cnt,ncnt)=fld_full;
%
         state_var='RADS_U_URBAN_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_urban_rmse(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_U_URBAN_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_urban_rcor(nyr_cnt,ncnt)=fld_full;
%
% CONUS V field
         state_var='RADS_V_CONUS_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_conus_mn_ens_mn(nyr_cnt,ncnt)=fld_full*fac;
         fprintf('APM: v conus mn %d \n',v_conus_mn_ens_mn(nyr_cnt,ncnt))
%         
         state_var='RADS_V_CONUS_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_conus_mn_obs_val(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_V_CONUS_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_conus_vr_ens_mn(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_V_CONUS_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_conus_vr_obs_val(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_V_CONUS_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_conus_nmb(nyr_cnt,ncnt)=fld_full;
%
         state_var='RADS_V_CONUS_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_conus_rmse(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_V_CONUS_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_conus_rcor(nyr_cnt,ncnt)=fld_full;
%
% URBAN V field
         state_var='RADS_V_URBAN_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_urban_mn_ens_mn(nyr_cnt,ncnt)=fld_full*fac;
         fprintf('APM: v urban mn %d \n',v_urban_mn_ens_mn(nyr_cnt,ncnt))
%         
         state_var='RADS_V_URBAN_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_urban_mn_obs_val(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_V_URBAN_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_urban_vr_ens_mn(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_V_URBAN_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_urban_vr_obs_val(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_V_URBAN_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_urban_nmb(nyr_cnt,ncnt)=fld_full;
%
         state_var='RADS_V_URBAN_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_urban_rmse(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_V_URBAN_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_urban_rcor(nyr_cnt,ncnt)=fld_full;
%
% CONUS Q field
         state_var='RADS_Q_CONUS_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_conus_mn_ens_mn(nyr_cnt,ncnt)=fld_full*fac;
         fprintf('APM: q conus mn %d \n',q_conus_mn_ens_mn(nyr_cnt,ncnt))
%         
         state_var='RADS_Q_CONUS_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_conus_mn_obs_val(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_Q_CONUS_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_conus_vr_ens_mn(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_Q_CONUS_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_conus_vr_obs_val(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_Q_CONUS_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_conus_nmb(nyr_cnt,ncnt)=fld_full;
%
         state_var='RADS_Q_CONUS_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_conus_rmse(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_Q_CONUS_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_conus_rcor(nyr_cnt,ncnt)=fld_full;
%
% URBAN Q field
         state_var='RADS_Q_URBAN_MN_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_urban_mn_ens_mn(nyr_cnt,ncnt)=fld_full*fac;
         fprintf('APM: q urban mn %d \n',q_urban_mn_ens_mn(nyr_cnt,ncnt))
%         
         state_var='RADS_Q_URBAN_MN_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_urban_mn_obs_val(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_Q_URBAN_VR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_urban_vr_ens_mn(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_Q_URBAN_VR_OBS_VAL'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_urban_vr_obs_val(nyr_cnt,ncnt)=fld_full*fac*fac;
%
         state_var='RADS_Q_URBAN_NMB_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_urban_nmb(nyr_cnt,ncnt)=fld_full;
%
         state_var='RADS_Q_URBAN_RMSE_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_urban_rmse(nyr_cnt,ncnt)=fld_full*fac;
%
         state_var='RADS_Q_URBAN_RCOR_ENS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_urban_rcor(nyr_cnt,ncnt)=fld_full;
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
% T
   t_conus_mn_ens_mn_grmn=zeros(1,nyr_cnt);
   t_conus_mn_obs_val_grmn=zeros(1,nyr_cnt);
   t_conus_vr_ens_mn_grmn=zeros(1,nyr_cnt);
   t_conus_vr_obs_val_grmn=zeros(1,nyr_cnt);
   t_conus_nmb_grmn=zeros(1,nyr_cnt);
   t_conus_rmse_grmn=zeros(1,nyr_cnt);
   t_conus_rcor_grmn=zeros(1,nyr_cnt);
   t_urban_mn_ens_mn_grmn=zeros(1,nyr_cnt);
   t_urban_mn_obs_val_grmn=zeros(1,nyr_cnt);
   t_urban_vr_ens_mn_grmn=zeros(1,nyr_cnt);
   t_urban_vr_obs_val_grmn=zeros(1,nyr_cnt);
   t_urban_nmb_grmn=zeros(1,nyr_cnt);
   t_urban_rmse_grmn=zeros(1,nyr_cnt);
   t_urban_rcor_grmn=zeros(1,nyr_cnt);
% U
   u_conus_mn_ens_mn_grmn=zeros(1,nyr_cnt);
   u_conus_mn_obs_val_grmn=zeros(1,nyr_cnt);
   u_conus_vr_ens_mn_grmn=zeros(1,nyr_cnt);
   u_conus_vr_obs_val_grmn=zeros(1,nyr_cnt);
   u_conus_nmb_grmn=zeros(1,nyr_cnt);
   u_conus_rmse_grmn=zeros(1,nyr_cnt);
   u_conus_rcor_grmn=zeros(1,nyr_cnt);
   u_urban_mn_ens_mn_grmn=zeros(1,nyr_cnt);
   u_urban_mn_obs_val_grmn=zeros(1,nyr_cnt);
   u_urban_vr_ens_mn_grmn=zeros(1,nyr_cnt);
   u_urban_vr_obs_val_grmn=zeros(1,nyr_cnt);
   u_urban_nmb_grmn=zeros(1,nyr_cnt);
   u_urban_rmse_grmn=zeros(1,nyr_cnt);
   u_urban_rcor_grmn=zeros(1,nyr_cnt);
% V
   v_conus_mn_ens_mn_grmn=zeros(1,nyr_cnt);
   v_conus_mn_obs_val_grmn=zeros(1,nyr_cnt);
   v_conus_vr_ens_mn_grmn=zeros(1,nyr_cnt);
   v_conus_vr_obs_val_grmn=zeros(1,nyr_cnt);
   v_conus_nmb_grmn=zeros(1,nyr_cnt);
   v_conus_rmse_grmn=zeros(1,nyr_cnt);
   v_conus_rcor_grmn=zeros(1,nyr_cnt);
   v_urban_mn_ens_mn_grmn=zeros(1,nyr_cnt);
   v_urban_mn_obs_val_grmn=zeros(1,nyr_cnt);
   v_urban_vr_ens_mn_grmn=zeros(1,nyr_cnt);
   v_urban_vr_obs_val_grmn=zeros(1,nyr_cnt);
   v_urban_nmb_grmn=zeros(1,nyr_cnt);
   v_urban_rmse_grmn=zeros(1,nyr_cnt);
   v_urban_rcor_grmn=zeros(1,nyr_cnt);
% Q
   q_conus_mn_ens_mn_grmn=zeros(1,nyr_cnt);
   q_conus_mn_obs_val_grmn=zeros(1,nyr_cnt);
   q_conus_vr_ens_mn_grmn=zeros(1,nyr_cnt);
   q_conus_vr_obs_val_grmn=zeros(1,nyr_cnt);
   q_conus_nmb_grmn=zeros(1,nyr_cnt);
   q_conus_rmse_grmn=zeros(1,nyr_cnt);
   q_conus_rcor_grmn=zeros(1,nyr_cnt);
   q_urban_mn_ens_mn_grmn=zeros(1,nyr_cnt);
   q_urban_mn_obs_val_grmn=zeros(1,nyr_cnt);
   q_urban_vr_ens_mn_grmn=zeros(1,nyr_cnt);
   q_urban_vr_obs_val_grmn=zeros(1,nyr_cnt);
   q_urban_nmb_grmn=zeros(1,nyr_cnt);
   q_urban_rmse_grmn=zeros(1,nyr_cnt);
   q_urban_rcor_grmn=zeros(1,nyr_cnt);      
   for iyr=1:nyr_cnt
% CO
      t_conus_mn_ens_mn_grmn(iyr)=mean(t_conus_mn_ens_mn(iyr,:),'omitnan');
      t_conus_mn_obs_val_grmn(iyr)=mean(t_conus_mn_obs_val(iyr,:),'omitnan');
      t_conus_vr_ens_mn_grmn(iyr)=mean(t_conus_vr_ens_mn(iyr,:),'omitnan');
      t_conus_vr_obs_val_grmn(iyr)=mean(t_conus_vr_obs_val(iyr,:),'omitnan');
      t_conus_nmb_grmn(iyr)=mean(t_conus_nmb(iyr,:),'omitnan');
      t_conus_rmse_grmn(iyr)=mean(t_conus_rmse(iyr,:),'omitnan');
      t_conus_rcor_grmn(iyr)=mean(t_conus_rcor(iyr,:),'omitnan');
      t_urban_mn_ens_mn_grmn(iyr)=mean(t_urban_mn_ens_mn(iyr,:),'omitnan');
      t_urban_mn_obs_val_grmn(iyr)=mean(t_urban_mn_obs_val(iyr,:),'omitnan');
      t_urban_vr_ens_mn_grmn(iyr)=mean(t_urban_vr_ens_mn(iyr,:),'omitnan');
      t_urban_vr_obs_val_grmn(iyr)=mean(t_urban_vr_obs_val(iyr,:),'omitnan');
      t_urban_nmb_grmn(iyr)=mean(t_urban_nmb(iyr,:),'omitnan');
      t_urban_rmse_grmn(iyr)=mean(t_urban_rmse(iyr,:),'omitnan');
      t_urban_rcor_grmn(iyr)=mean(t_urban_rcor(iyr,:),'omitnan');
% U
      u_conus_mn_ens_mn_grmn(iyr)=mean(u_conus_mn_ens_mn(iyr,:),'omitnan');
      u_conus_mn_obs_val_grmn(iyr)=mean(u_conus_mn_obs_val(iyr,:),'omitnan');
      u_conus_vr_ens_mn_grmn(iyr)=mean(u_conus_vr_ens_mn(iyr,:),'omitnan');
      u_conus_vr_obs_val_grmn(iyr)=mean(u_conus_vr_obs_val(iyr,:),'omitnan');
      u_conus_nmb_grmn(iyr)=mean(u_conus_nmb(iyr,:),'omitnan');
      u_conus_rmse_grmn(iyr)=mean(u_conus_rmse(iyr,:),'omitnan');
      u_conus_rcor_grmn(iyr)=mean(u_conus_rcor(iyr,:),'omitnan');
      u_urban_mn_ens_mn_grmn(iyr)=mean(u_urban_mn_ens_mn(iyr,:),'omitnan');
      u_urban_mn_obs_val_grmn(iyr)=mean(u_urban_mn_obs_val(iyr,:),'omitnan');
      u_urban_vr_ens_mn_grmn(iyr)=mean(u_urban_vr_ens_mn(iyr,:),'omitnan');
      u_urban_vr_obs_val_grmn(iyr)=mean(u_urban_vr_obs_val(iyr,:),'omitnan');
      u_urban_nmb_grmn(iyr)=mean(u_urban_nmb(iyr,:),'omitnan');
      u_urban_rmse_grmn(iyr)=mean(u_urban_rmse(iyr,:),'omitnan');
      u_urban_rcor_grmn(iyr)=mean(u_urban_rcor(iyr,:),'omitnan');
% V
      v_conus_mn_ens_mn_grmn(iyr)=mean(v_conus_mn_ens_mn(iyr,:),'omitnan');
      v_conus_mn_obs_val_grmn(iyr)=mean(v_conus_mn_obs_val(iyr,:),'omitnan');
      v_conus_vr_ens_mn_grmn(iyr)=mean(v_conus_vr_ens_mn(iyr,:),'omitnan');
      v_conus_vr_obs_val_grmn(iyr)=mean(v_conus_vr_obs_val(iyr,:),'omitnan');
      v_conus_nmb_grmn(iyr)=mean(v_conus_nmb(iyr,:),'omitnan');
      v_conus_rmse_grmn(iyr)=mean(v_conus_rmse(iyr,:),'omitnan');
      v_conus_rcor_grmn(iyr)=mean(v_conus_rcor(iyr,:),'omitnan');
      v_urban_mn_ens_mn_grmn(iyr)=mean(v_urban_mn_ens_mn(iyr,:),'omitnan');
      v_urban_mn_obs_val_grmn(iyr)=mean(v_urban_mn_obs_val(iyr,:),'omitnan');
      v_urban_vr_ens_mn_grmn(iyr)=mean(v_urban_vr_ens_mn(iyr,:),'omitnan');
      v_urban_vr_obs_val_grmn(iyr)=mean(v_urban_vr_obs_val(iyr,:),'omitnan');
      v_urban_nmb_grmn(iyr)=mean(v_urban_nmb(iyr,:),'omitnan');
      v_urban_rmse_grmn(iyr)=mean(v_urban_rmse(iyr,:),'omitnan');
      v_urban_rcor_grmn(iyr)=mean(v_urban_rcor(iyr,:),'omitnan');
% Q
      q_conus_mn_ens_mn_grmn(iyr)=mean(q_conus_mn_ens_mn(iyr,:),'omitnan');
      q_conus_mn_obs_val_grmn(iyr)=mean(q_conus_mn_obs_val(iyr,:),'omitnan');
      q_conus_vr_ens_mn_grmn(iyr)=mean(q_conus_vr_ens_mn(iyr,:),'omitnan');
      q_conus_vr_obs_val_grmn(iyr)=mean(q_conus_vr_obs_val(iyr,:),'omitnan');
      q_conus_nmb_grmn(iyr)=mean(q_conus_nmb(iyr,:),'omitnan');
      q_conus_rmse_grmn(iyr)=mean(q_conus_rmse(iyr,:),'omitnan');
      q_conus_rcor_grmn(iyr)=mean(q_conus_rcor(iyr,:),'omitnan');
      q_urban_mn_ens_mn_grmn(iyr)=mean(q_urban_mn_ens_mn(iyr,:),'omitnan');
      q_urban_mn_obs_val_grmn(iyr)=mean(q_urban_mn_obs_val(iyr,:),'omitnan');
      q_urban_vr_ens_mn_grmn(iyr)=mean(q_urban_vr_ens_mn(iyr,:),'omitnan');
      q_urban_vr_obs_val_grmn(iyr)=mean(q_urban_vr_obs_val(iyr,:),'omitnan');
      q_urban_nmb_grmn(iyr)=mean(q_urban_nmb(iyr,:),'omitnan');
      q_urban_rmse_grmn(iyr)=mean(q_urban_rmse(iyr,:),'omitnan');
      q_urban_rcor_grmn(iyr)=mean(q_urban_rcor(iyr,:),'omitnan');
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
% T Mean
   ymn1=min(min(t_conus_mn_ens_mn_grmn,t_conus_mn_obs_val_grmn));
   ymx1=max(max(t_conus_mn_ens_mn_grmn,t_conus_mn_obs_val_grmn));
   ymn2=min(min(t_urban_mn_ens_mn_grmn,t_urban_mn_obs_val_grmn));
   ymx2=max(max(t_urban_mn_ens_mn_grmn,t_urban_mn_obs_val_grmn));
   ymn=min([ymn1,ymn2]);
   ymx=max([ymx1,ymx2]);
   ymn=0.99*ymn;
   ymx=1.01*ymx;
   t_conus_sd=sqrt(t_conus_vr_ens_mn_grmn);
   rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  T MN Time Series'}),'Year','Degree (K)', ...
   'T TRC CONUS','T TRC URBAN','T OBS CONUS','T OBS URBAN',save_file,nyr_cnt,ymx,ymn, ...
   t_conus_mn_ens_mn_grmn,t_urban_mn_ens_mn_grmn,t_conus_mn_obs_val_grmn, ...
   t_urban_mn_obs_val_grmn,t_conus_sd,YYYY_STR,YYYY_END);
%
% Variance
   scale=1.e-4;
   ymn1=min(min(t_conus_vr_ens_mn_grmn,t_conus_vr_obs_val_grmn));
   ymx1=max(max(t_conus_vr_ens_mn_grmn,t_conus_vr_obs_val_grmn));
   ymn2=min(min(t_urban_vr_ens_mn_grmn,t_urban_vr_obs_val_grmn));
   ymx2=max(max(t_urban_vr_ens_mn_grmn,t_urban_vr_obs_val_grmn));
   ymn=min([ymn1,ymn2]);
   ymx=max([ymx1,ymx2]);
   ymn=0.99*ymn*scale;
   ymn=0.;
   ymx=1.01*ymx*scale;
   zero_err=zeros(1,nyr_cnt);
   rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  T VR Time Series (scaled 10^{-4})'}),'Year','Degree (K^2)', ...
   'T TRC CONUS','T TRC URBAN','T OBS CONUS','T OBS URBAN',save_file,nyr_cnt,ymx,ymn, ...
   t_conus_vr_ens_mn_grmn*scale,t_urban_vr_ens_mn_grmn*scale,t_conus_vr_obs_val_grmn*scale, ...
   t_urban_vr_obs_val_grmn*scale,zero_err,YYYY_STR,YYYY_END);
%
% NMB
   ymn1=min(min(t_conus_nmb_grmn,t_urban_nmb_grmn));
   ymx1=max(max(t_conus_nmb_grmn,t_urban_nmb_grmn));
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
   {':  T NMB Time Series'}),'Year','Magnitude (%)', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   t_conus_nmb_grmn,t_urban_nmb_grmn,YYYY_STR,YYYY_END);
%
% RMSE
   ymn1=min(min(t_conus_rmse_grmn,t_urban_rmse_grmn));
   ymx1=max(max(t_conus_rmse_grmn,t_urban_rmse_grmn));
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
   {':  T RMSE Time Series'}),'Year','Degree (K)', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   t_conus_rmse_grmn,t_urban_rmse_grmn,YYYY_STR,YYYY_END);
%
% RCOR
   ymn1=min(min(t_conus_rcor_grmn,t_urban_rcor_grmn));
   ymx1=max(max(t_conus_rcor_grmn,t_urban_rcor_grmn));
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
   {':  T R Time Series'}),'Year','Magnitude ( )', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   t_conus_rcor_grmn,t_urban_rcor_grmn,YYYY_STR,YYYY_END);
%
% U Mean
   ymn1=min(min(u_conus_mn_ens_mn_grmn,u_conus_mn_obs_val_grmn));
   ymx1=max(max(u_conus_mn_ens_mn_grmn,u_conus_mn_obs_val_grmn));
   ymn2=min(min(u_urban_mn_ens_mn_grmn,u_urban_mn_obs_val_grmn));
   ymx2=max(max(u_urban_mn_ens_mn_grmn,u_urban_mn_obs_val_grmn));
   ymn=min([ymn1,ymn2]);
   ymx=max([ymx1,ymx2]);
   ymn=0.99*ymn;
   ymx=1.01*ymx;
   u_conus_sd=sqrt(u_conus_vr_ens_mn_grmn);
   rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  U MN Time Series'}),'Year','Velocity (m/s)', ...
   'U TRC CONUS','U TRC URBAN','U OBS CONUS','U OBS URBAN',save_file,nyr_cnt,ymx,ymn, ...
   u_conus_mn_ens_mn_grmn,u_urban_mn_ens_mn_grmn,u_conus_mn_obs_val_grmn, ...
   u_urban_mn_obs_val_grmn,u_conus_sd,YYYY_STR,YYYY_END);
%
% Variance
   scale=1.e-4;
   ymn1=min(min(u_conus_vr_ens_mn_grmn,u_conus_vr_obs_val_grmn));
   ymx1=max(max(u_conus_vr_ens_mn_grmn,u_conus_vr_obs_val_grmn));
   ymn2=min(min(u_urban_vr_ens_mn_grmn,u_urban_vr_obs_val_grmn));
   ymx2=max(max(u_urban_vr_ens_mn_grmn,u_urban_vr_obs_val_grmn));
   ymn=min([ymn1,ymn2]);
   ymx=max([ymx1,ymx2]);
   ymn=0.99*ymn*scale;
   ymn=0.;
   ymx=1.01*ymx*scale;
   zero_err=zeros(1,nyr_cnt);
   rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  U VR Time Series (scaled 10^{-4})'}),'Year','Velocity ((m/s)^2)', ...
   'U TRC CONUS','U TRC URBAN','U OBS CONUS','U OBS URBAN',save_file,nyr_cnt,ymx,ymn, ...
   u_conus_vr_ens_mn_grmn*scale,u_urban_vr_ens_mn_grmn*scale,u_conus_vr_obs_val_grmn*scale, ...
   u_urban_vr_obs_val_grmn*scale,zero_err,YYYY_STR,YYYY_END);
%
% NMB
   ymn1=min(min(u_conus_nmb_grmn,u_urban_nmb_grmn));
   ymx1=max(max(u_conus_nmb_grmn,u_urban_nmb_grmn));
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
   {':  U NMB Time Series'}),'Year','Magnitude (%)', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   u_conus_nmb_grmn,u_urban_nmb_grmn,YYYY_STR,YYYY_END);
%
% RMSE
   ymn1=min(min(u_conus_rmse_grmn,u_urban_rmse_grmn));
   ymx1=max(max(u_conus_rmse_grmn,u_urban_rmse_grmn));
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
   {':  U RMSE Time Series'}),'Year','Velocity (m/s)', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   u_conus_rmse_grmn,u_urban_rmse_grmn,YYYY_STR,YYYY_END);
%
% RCOR
   ymn1=min(min(u_conus_rcor_grmn,u_urban_rcor_grmn));
   ymx1=max(max(u_conus_rcor_grmn,u_urban_rcor_grmn));
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
   {':  U R Time Series'}),'Year','Magnitude ( )', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   u_conus_rcor_grmn,u_urban_rcor_grmn,YYYY_STR,YYYY_END);
%
% V Mean
   ymn1=min(min(v_conus_mn_ens_mn_grmn,v_conus_mn_obs_val_grmn));
   ymx1=max(max(v_conus_mn_ens_mn_grmn,v_conus_mn_obs_val_grmn));
   ymn2=min(min(v_urban_mn_ens_mn_grmn,v_urban_mn_obs_val_grmn));
   ymx2=max(max(v_urban_mn_ens_mn_grmn,v_urban_mn_obs_val_grmn));
   ymn=min([ymn1,ymn2]);
   ymx=max([ymx1,ymx2]);
   ymn=0.99*ymn;
   ymx=1.01*ymx;
   v_conus_sd=sqrt(v_conus_vr_ens_mn_grmn);
   rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  V MN Time Series'}),'Year','Velocity (m/s)', ...
   'V TRC CONUS','V TRC URBAN','V OBS CONUS','V OBS URBAN',save_file,nyr_cnt,ymx,ymn, ...
   v_conus_mn_ens_mn_grmn,v_urban_mn_ens_mn_grmn,v_conus_mn_obs_val_grmn, ...
   v_urban_mn_obs_val_grmn,v_conus_sd,YYYY_STR,YYYY_END);
%
% Variance
   scale=1.e-4;
   ymn1=min(min(v_conus_vr_ens_mn_grmn,v_conus_vr_obs_val_grmn));
   ymx1=max(max(v_conus_vr_ens_mn_grmn,v_conus_vr_obs_val_grmn));
   ymn2=min(min(v_urban_vr_ens_mn_grmn,v_urban_vr_obs_val_grmn));
   ymx2=max(max(v_urban_vr_ens_mn_grmn,v_urban_vr_obs_val_grmn));
   ymn=min([ymn1,ymn2]);
   ymx=max([ymx1,ymx2]);
   ymn=0.99*ymn*scale;
   ymn=0.;
   ymx=1.01*ymx*scale;
   zero_err=zeros(1,nyr_cnt);
   rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  V VR Time Series (scaled 10^{-4})'}),'Year','Velocity ((m/s)^2)', ...
   'V TRC CONUS','V TRC URBAN','V OBS CONUS','V OBS URBAN',save_file,nyr_cnt,ymx,ymn, ...
   v_conus_vr_ens_mn_grmn*scale,v_urban_vr_ens_mn_grmn*scale,v_conus_vr_obs_val_grmn*scale, ...
   v_urban_vr_obs_val_grmn*scale,zero_err,YYYY_STR,YYYY_END);
%
% NMB
   ymn1=min(min(v_conus_nmb_grmn,v_urban_nmb_grmn));
   ymx1=max(max(v_conus_nmb_grmn,v_urban_nmb_grmn));
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
   {':  V NMB Time Series'}),'Year','Magnitude (%)', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   v_conus_nmb_grmn,v_urban_nmb_grmn,YYYY_STR,YYYY_END);
%
% RMSE
   ymn1=min(min(v_conus_rmse_grmn,v_urban_rmse_grmn));
   ymx1=max(max(v_conus_rmse_grmn,v_urban_rmse_grmn));
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
   {':  V RMSE Time Series'}),'Year','Velocity (m/s)', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   v_conus_rmse_grmn,v_urban_rmse_grmn,YYYY_STR,YYYY_END);
%
% RCOR
   ymn1=min(min(v_conus_rcor_grmn,v_urban_rcor_grmn));
   ymx1=max(max(v_conus_rcor_grmn,v_urban_rcor_grmn));
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
   {':  V R Time Series'}),'Year','Magnitude ( )', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   v_conus_rcor_grmn,v_urban_rcor_grmn,YYYY_STR,YYYY_END);
%
% Q Mean
   ymn1=min(min(q_conus_mn_ens_mn_grmn,q_conus_mn_obs_val_grmn));
   ymx1=max(max(q_conus_mn_ens_mn_grmn,q_conus_mn_obs_val_grmn));
   ymn2=min(min(q_urban_mn_ens_mn_grmn,q_urban_mn_obs_val_grmn));
   ymx2=max(max(q_urban_mn_ens_mn_grmn,q_urban_mn_obs_val_grmn));
   ymn=min([ymn1,ymn2]);
   ymx=max([ymx1,ymx2]);
   ymn=0.99*ymn;
   ymx=1.01*ymx;
   q_conus_sd=sqrt(q_conus_vr_ens_mn_grmn);
   rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  Q MN Time Series'}),'Year','Mixing Ratio (pptv)', ...
   'Q TRC CONUS','Q TRC URBAN','Q OBS CONUS','Q OBS URBAN',save_file,nyr_cnt,ymx,ymn, ...
   q_conus_mn_ens_mn_grmn,q_urban_mn_ens_mn_grmn,q_conus_mn_obs_val_grmn, ...
   q_urban_mn_obs_val_grmn,q_conus_sd,YYYY_STR,YYYY_END);
%
% Variance
   scale=1.e-4;
   ymn1=min(min(q_conus_vr_ens_mn_grmn,q_conus_vr_obs_val_grmn));
   ymx1=max(max(q_conus_vr_ens_mn_grmn,q_conus_vr_obs_val_grmn));
   ymn2=min(min(q_urban_vr_ens_mn_grmn,q_urban_vr_obs_val_grmn));
   ymx2=max(max(q_urban_vr_ens_mn_grmn,q_urban_vr_obs_val_grmn));
   ymn=min([ymn1,ymn2]);
   ymx=max([ymx1,ymx2]);
   ymn=0.99*ymn*scale;
   ymn=0.;
   ymx=1.01*ymx*scale;
   zero_err=zeros(1,nyr_cnt);
   rs = plot_series_4(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  Q VR Time Series (scaled 10^{-4})'}),'Year','Mixing Ratio (pptv^2)', ...
   'Q TRC CONUS','Q TRC URBAN','Q OBS CONUS','Q OBS URBAN',save_file,nyr_cnt,ymx,ymn, ...
   q_conus_vr_ens_mn_grmn*scale,q_urban_vr_ens_mn_grmn*scale,q_conus_vr_obs_val_grmn*scale, ...
   q_urban_vr_obs_val_grmn*scale,zero_err,YYYY_STR,YYYY_END);
%
% NMB
   ymn1=min(min(q_conus_nmb_grmn,q_urban_nmb_grmn));
   ymx1=max(max(q_conus_nmb_grmn,q_urban_nmb_grmn));
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
   {':  Q NMB Time Series'}),'Year','Magnitude (%)', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   q_conus_nmb_grmn,q_urban_nmb_grmn,YYYY_STR,YYYY_END);
%
% RMSE
   ymn1=min(min(q_conus_rmse_grmn,q_urban_rmse_grmn));
   ymx1=max(max(q_conus_rmse_grmn,q_urban_rmse_grmn));
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
   {':  Q RMSE Time Series'}),'Year','Mixing Ratio (pptv)', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   q_conus_rmse_grmn,q_urban_rmse_grmn,YYYY_STR,YYYY_END);
%
% RCOR
   ymn1=min(min(q_conus_rcor_grmn,q_urban_rcor_grmn));
   ymx1=max(max(q_conus_rcor_grmn,q_urban_rcor_grmn));
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
   {':  Q R Time Series'}),'Year','Magnitude ( )', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn, ...
   q_conus_rcor_grmn,q_urban_rcor_grmn,YYYY_STR,YYYY_END);
%
end   
%
function [rs] = plot_series_2(ptitle,xtitle,ytitle,leg1,leg2, ...
   save_file,ntim,ymx,ymn,fld_1,fld_2,YYYY_STR,YYYY_END)
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
