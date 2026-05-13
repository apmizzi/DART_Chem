function plot_timeseries_yearly_TRACER_I_MET_DA_diagnostics
   clear all;
%
   YYYY_STR=2005;
   YYYY_END=2005;
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
      sys_cmd=strcat('rm -rf TRACER_I_MET_DA_',string(DATE_STR),'-', ...
      string(DATE_END),'_yearly_da_diagnostics.eps');
      save_file=strcat('TRACER_I_MET_DA_',string(DATE_STR),'-', ...
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
% T field
         state_var='TRACER_I_T_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_prior_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: t prior conus mn %d \n',t_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_T_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_post_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_T_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_prior_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_T_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_post_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_T_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_incr_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_T_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_infl_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_T_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_infl_post_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_T_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_prior_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_T_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_post_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_T_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_prior_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_T_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_post_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
% 
         state_var='TRACER_I_T_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_incr_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_T_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_infl_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_T_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         t_infl_post_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
% U field
         state_var='TRACER_I_U_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_prior_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: u prior conus mn %d \n',u_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_U_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_post_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_U_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_prior_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_U_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_post_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_U_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_incr_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%        
         state_var='TRACER_I_U_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_infl_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%        
         state_var='TRACER_I_U_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_infl_post_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_U_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_prior_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_U_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_post_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_U_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_prior_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_U_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_post_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_U_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_incr_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_U_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_infl_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_U_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         u_infl_post_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
% V field
         state_var='TRACER_I_V_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_prior_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: v prior conus mn %d \n',v_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_V_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_post_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_V_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_prior_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_V_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_post_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_V_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_incr_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%        
         state_var='TRACER_I_V_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_infl_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%        
         state_var='TRACER_I_V_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_infl_post_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_V_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_prior_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_V_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_post_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_V_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_prior_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_V_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_post_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_V_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_incr_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_V_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_infl_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_V_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         v_infl_post_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
% Q field
         state_var='TRACER_I_Q_EMN_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_prior_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*qfac;
         fprintf('APM: q prior conus mn %d \n',q_prior_emn_conus_mn(ncnt))
%         
         state_var='TRACER_I_Q_EMN_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_post_emn_conus_mn(ncnt)=fld_full(wrf_vert(levl))*qfac;
%
         state_var='TRACER_I_Q_ESD_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_prior_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*qfac;
%
         state_var='TRACER_I_Q_ESD_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_post_esd_conus_mn(ncnt)=fld_full(wrf_vert(levl))*qfac;
%
         state_var='TRACER_I_Q_INCR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_incr_conus_mn(ncnt)=fld_full(wrf_vert(levl))*qfac;
%
         state_var='TRACER_I_Q_INFL_PRIOR_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_infl_prior_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_Q_INFL_POST_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_infl_post_conus_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_Q_EMN_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_prior_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*qfac;
%
         state_var='TRACER_I_Q_EMN_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_post_emn_urban_mn(ncnt)=fld_full(wrf_vert(levl))*qfac;
%
         state_var='TRACER_I_Q_ESD_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_prior_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*qfac;
%
         state_var='TRACER_I_Q_ESD_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_post_esd_urban_mn(ncnt)=fld_full(wrf_vert(levl))*qfac;
%
         state_var='TRACER_I_Q_INCR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_incr_urban_mn(ncnt)=fld_full(wrf_vert(levl))*qfac;
%
         state_var='TRACER_I_Q_INFL_PRIOR_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_infl_prior_urban_mn(ncnt)=fld_full(wrf_vert(levl));
%
         state_var='TRACER_I_Q_INFL_POST_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         q_infl_post_urban_mn(ncnt)=fld_full(wrf_vert(levl));
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
% T
      ymn1=min(min(t_prior_emn_conus_mn,t_post_emn_conus_mn));
      ymx1=max(max(t_prior_emn_conus_mn,t_post_emn_conus_mn));
      ymn2=min(min(t_prior_emn_urban_mn,t_post_emn_urban_mn));
      ymx2=max(max(t_prior_emn_urban_mn,t_post_emn_urban_mn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  T Time Series'}),'Date/Time','Temperature (K)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      t_prior_emn_conus_mn,t_prior_emn_urban_mn,t_post_emn_conus_mn,t_post_emn_urban_mn, ...
      t_post_esd_conus_mn);
%
      for i=1:ncnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=t_prior_esd_conus_mn(i)/t_prior_emn_conus_mn(i)*1.e2;
         rel_prior_sprd_urb(i)=t_prior_esd_urban_mn(i)/t_prior_emn_urban_mn(i)*1.e2;
         rel_post_sprd_con(i)=t_post_esd_conus_mn(i)/t_prior_emn_conus_mn(i)*1.e2;
         rel_post_sprd_urb(i)=t_post_esd_urban_mn(i)/t_prior_emn_urban_mn(i)*1.e2;
         rel_incr_con(i)=t_incr_conus_mn(i)/t_prior_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=t_incr_urban_mn(i)/t_prior_emn_urban_mn(i)*1.e2;
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
      {':  T Relative Spread'}),'Date/Time','Magnitude (%)', ...
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
      {':  T Relative Increment'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb);
% Inflation
      ymn1=min(min(t_infl_prior_conus_mn,t_infl_prior_urban_mn));
      ymx1=max(max(t_infl_prior_conus_mn,t_infl_prior_urban_mn));
      ymn2=min(min(t_infl_post_conus_mn,t_infl_post_urban_mn));
      ymx2=max(max(t_infl_post_conus_mn,t_infl_post_urban_mn));
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
      {':  T Inflation'}),'Date/Time','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      t_infl_prior_conus_mn,t_infl_prior_urban_mn,t_infl_post_conus_mn,t_infl_post_urban_mn, ...
      err_zero);
%
% U
      ymn1=min(min(u_prior_emn_conus_mn,u_post_emn_conus_mn));
      ymx1=max(max(u_prior_emn_conus_mn,u_post_emn_conus_mn));
      ymn2=min(min(u_prior_emn_urban_mn,u_post_emn_urban_mn));
      ymx2=max(max(u_prior_emn_urban_mn,u_post_emn_urban_mn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  U Time Series'}),'Date/Time','Velocity (m/s)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      u_prior_emn_conus_mn,u_prior_emn_urban_mn,u_post_emn_conus_mn,u_post_emn_urban_mn, ...
      u_post_esd_conus_mn);
%
      for i=1:ncnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=u_prior_esd_conus_mn(i)/u_prior_emn_conus_mn(i)*1.e2;
         rel_prior_sprd_urb(i)=u_prior_esd_urban_mn(i)/u_prior_emn_urban_mn(i)*1.e2;
         rel_post_sprd_con(i)=u_post_esd_conus_mn(i)/u_prior_emn_conus_mn(i)*1.e2;
         rel_post_sprd_urb(i)=u_post_esd_urban_mn(i)/u_prior_emn_urban_mn(i)*1.e2;
         rel_incr_con(i)=u_incr_conus_mn(i)/u_prior_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=u_incr_urban_mn(i)/u_prior_emn_urban_mn(i)*1.e2;
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
      {':  U Relative Spread'}),'Date/Time','Magnitude (%)', ...
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
      {':  U Relative Increment'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb);
% Inflation
      ymn1=min(min(u_infl_prior_conus_mn,u_infl_prior_urban_mn));
      ymx1=max(max(u_infl_prior_conus_mn,u_infl_prior_urban_mn));
      ymn2=min(min(u_infl_post_conus_mn,u_infl_post_urban_mn));
      ymx2=max(max(u_infl_post_conus_mn,u_infl_post_urban_mn));
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
      {':  U Inflation'}),'Date/Time','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      u_infl_prior_conus_mn,u_infl_prior_urban_mn,u_infl_post_conus_mn,u_infl_post_urban_mn, ...
      err_zero);
%
% V
      ymn1=min(min(v_prior_emn_conus_mn,v_post_emn_conus_mn));
      ymx1=max(max(v_prior_emn_conus_mn,v_post_emn_conus_mn));
      ymn2=min(min(v_prior_emn_urban_mn,v_post_emn_urban_mn));
      ymx2=max(max(v_prior_emn_urban_mn,v_post_emn_urban_mn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  V Time Series'}),'Date/Time','Velocity (m/s)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      v_prior_emn_conus_mn,v_prior_emn_urban_mn,v_post_emn_conus_mn,v_post_emn_urban_mn, ...
      v_post_esd_conus_mn);
%
      for i=1:ncnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=v_prior_esd_conus_mn(i)/v_prior_emn_conus_mn(i)*1.e2;
         rel_prior_sprd_urb(i)=v_prior_esd_urban_mn(i)/v_prior_emn_urban_mn(i)*1.e2;
         rel_post_sprd_con(i)=v_post_esd_conus_mn(i)/v_prior_emn_conus_mn(i)*1.e2;
         rel_post_sprd_urb(i)=v_post_esd_urban_mn(i)/v_prior_emn_urban_mn(i)*1.e2;
         rel_incr_con(i)=v_incr_conus_mn(i)/v_prior_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=v_incr_urban_mn(i)/v_prior_emn_urban_mn(i)*1.e2;
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
      {':  V Relative Spread'}),'Date/Time','Magnitude (%)', ...
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
      {':  V Relative Increment'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb);
% Inflation
      ymn1=min(min(v_infl_prior_conus_mn,v_infl_prior_urban_mn));
      ymx1=max(max(v_infl_prior_conus_mn,v_infl_prior_urban_mn));
      ymn2=min(min(v_infl_post_conus_mn,v_infl_post_urban_mn));
      ymx2=max(max(v_infl_post_conus_mn,v_infl_post_urban_mn));
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
      {':  V Inflation'}),'Date/Time','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      v_infl_prior_conus_mn,v_infl_prior_urban_mn,v_infl_post_conus_mn,v_infl_post_urban_mn, ...
      err_zero);
%
% Q
      ymn1=min(min(q_prior_emn_conus_mn,q_post_emn_conus_mn));
      ymx1=max(max(q_prior_emn_conus_mn,q_post_emn_conus_mn));
      ymn2=min(min(q_prior_emn_urban_mn,q_post_emn_urban_mn));
      ymx2=max(max(q_prior_emn_urban_mn,q_post_emn_urban_mn));
      ymn=min([ymn1,ymn2]);
      ymx=max([ymx1,ymx2]);
      ymn=0.99*ymn;
      ymx=1.01*ymx;
      rs = plot_series_4(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  Q Time Series'}),'Date/Time','Mixing Ratio (pptv)', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      q_prior_emn_conus_mn,q_prior_emn_urban_mn,q_post_emn_conus_mn,q_post_emn_urban_mn, ...
      q_post_esd_conus_mn);
%
      for i=1:ncnt
         err_zero(i)=0.;
         rel_prior_sprd_con(i)=q_prior_esd_conus_mn(i)/q_prior_emn_conus_mn(i)*1.e2;
         rel_prior_sprd_urb(i)=q_prior_esd_urban_mn(i)/q_prior_emn_urban_mn(i)*1.e2;
         rel_posq_sprd_con(i)=q_post_esd_conus_mn(i)/q_prior_emn_conus_mn(i)*1.e2;
         rel_post_sprd_urb(i)=q_post_esd_urban_mn(i)/q_prior_emn_urban_mn(i)*1.e2;
         rel_incr_con(i)=q_incr_conus_mn(i)/q_prior_emn_conus_mn(i)*1.e2;
         rel_incr_urb(i)=q_incr_urban_mn(i)/q_prior_emn_urban_mn(i)*1.e2;
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
      {':  Q Relative Spread'}),'Date/Time','Magnitude (%)', ...
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
      {':  Q Relative Increment'}),'Date/Time','Magnitude (%)', ...
      'CONUS','URBAN',save_file,ncnt,ymx,ymn, ...
      rel_incr_con,rel_incr_urb);
% Inflation
      ymn1=min(min(q_infl_prior_conus_mn,q_infl_prior_urban_mn));
      ymx1=max(max(q_infl_prior_conus_mn,q_infl_prior_urban_mn));
      ymn2=min(min(q_infl_post_conus_mn,q_infl_post_urban_mn));
      ymx2=max(max(q_infl_post_conus_mn,q_infl_post_urban_mn));
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
      {':  Q Inflation'}),'Date/Time','Magnitude ( )', ...
      'Prior CONUS','Prior URBAN','Post CONUS','Post URBAN',save_file,ncnt,ymx,ymn, ...
      q_infl_prior_conus_mn,q_infl_prior_urban_mn,q_infl_post_conus_mn,q_infl_post_urban_mn, ...
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
   errorbar(index,fld_1,err_zero,'-o','LineWidth',1.75,'Color','g')
   errorbar(index,fld_2,err_zero,'--o','LineWidth',1.75,'Color','g')
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
