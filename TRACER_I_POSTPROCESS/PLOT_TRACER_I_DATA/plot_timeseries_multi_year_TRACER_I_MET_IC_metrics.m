function plot_timeseries_multi_year_TRACER_I_MET_IC_metrics
   clear all;
%
   YYYY_STR=2006;
   YYYY_END=2018;
   MMDDHH_STR=040200;
   MMDDHH_END=040300;
   wrf_vert=[10,14,18,21,23,25,27,29,31,34];
   incr=3;
   levl=1;
   fac=1.;
   qfac=1.e3;
   nx=440;
   ny=284;
   nz=50;
%
% Post files use f_incr=0
% Prior files use f_incr=3
   f_incr=3;
   f_incr=0;
%
% set colormap
   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
   cmap=desired_colors;
%
   if(f_incr==0)
      sys_cmd=strcat('rm -rf TRACER_I_MET_IC_POSTS_',string(YYYY_STR),'-', ...
      string(YYYY_END),'_multi_year_metrics.eps');
      save_file=strcat('TRACER_I_MET_IC_POSTS_',string(YYYY_STR),'-', ...
      string(YYYY_END),'_multi_year_metrics.eps');
   else
      sys_cmd=strcat('rm -rf TRACER_I_MET_IC_FRIORS_',string(YYYY_STR),'-', ...
      string(YYYY_END),'_multi_year_metrics.eps');
      save_file=strcat('TRACER_I_MET_IC_PRIORS_',string(YYYY_STR),'-', ...
      string(YYYY_END),'_multi_year_metrics.eps');
   end
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
	 data_file=strcat('/ens_stats_d01_',string(YYYY),'-',F_MM_str,'-',F_DD_str,'_',F_HH_str,':00:00');
         data_dir=strcat('/ensemble_stats/',string(idate),data_file);
         data_file=strcat(data_path,data_dir);
%
% Read data for plotting
%
% T field
         state_var='TRACER_I_T_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_traceri_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         fprintf('T TRACER-I CONUS MN at %6.2f \n \n',t_traceri_conus_mn(nyr_cnt,ncnt))
%        
         state_var='TRACER_I_T_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_traceri_conus_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         t_traceri_conus_sd(nyr_cnt,ncnt)
%
         state_var='TCR2_T_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_tcr2_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         t_tcr2_conus_mn(nyr_cnt,ncnt)
%        
         state_var='WRFCMAQ_T_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_wrfcmaq_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         t_wrfcmaq_conus_mn(nyr_cnt,ncnt)
%
         state_var='CAMCHEM_T_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_camchem_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         t_camchem_conus_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_T_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_traceri_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         t_traceri_urban_mn(nyr_cnt,ncnt)
%
         state_var='TRACER_I_T_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_traceri_urban_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         t_traceri_urban_sd(nyr_cnt,ncnt)
%        
         state_var='TCR2_T_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_tcr2_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         t_tcr2_urban_mn(nyr_cnt,ncnt)
%        
         state_var='WRFCMAQ_T_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_wrfcmaq_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         t_wrfcmaq_urban_mn(nyr_cnt,ncnt)
%        
         state_var='CAMCHEM_T_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_camchem_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         t_camchem_urban_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_T_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_traceri_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         t_traceri_rural_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_T_RURAL_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_traceri_rural_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         t_traceri_rural_sd(nyr_cnt,ncnt)
%        
         state_var='TCR2_T_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_tcr2_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         t_tcr2_rural_mn(nyr_cnt,ncnt)
%        
         state_var='WRFCMAQ_T_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_wrfcmaq_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         t_wrfcmaq_rural_mn(nyr_cnt,ncnt)
%        
         state_var='CAMCHEM_T_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         t_camchem_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         t_camchem_rural_mn(nyr_cnt,ncnt)
%
% U field
         state_var='TRACER_I_U_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_traceri_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         u_traceri_conus_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_U_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_traceri_conus_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         u_traceri_conus_sd(nyr_cnt,ncnt)
%        
         state_var='TCR2_U_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_tcr2_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         u_tcr2_conus_mn(nyr_cnt,ncnt)
%        
         state_var='WRFCMAQ_U_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_wrfcmaq_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         u_wrfcmaq_conus_mn(nyr_cnt,ncnt)
%        
         state_var='CAMCHEM_U_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_camchem_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         u_camchem_conus_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_U_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_traceri_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         u_traceri_urban_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_U_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_traceri_urban_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         u_traceri_urban_sd(nyr_cnt,ncnt)
%        
         state_var='TCR2_U_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_tcr2_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         u_tcr2_urban_mn(nyr_cnt,ncnt)
%        
         state_var='WRFCMAQ_U_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_wrfcmaq_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         u_wrfcmaq_urban_mn(nyr_cnt,ncnt)
%        
         state_var='CAMCHEM_U_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_camchem_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         u_camchem_urban_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_U_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_traceri_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         u_traceri_rural_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_U_RURAL_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_traceri_rural_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         u_traceri_rural_sd(nyr_cnt,ncnt)
%        
         state_var='TCR2_U_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_tcr2_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         u_tcr2_rural_mn(nyr_cnt,ncnt)
%        
         state_var='WRFCMAQ_U_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_wrfcmaq_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         u_wrfcmaq_rural_mn(nyr_cnt,ncnt)
%        
         state_var='CAMCHEM_U_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         u_camchem_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         u_camchem_rural_mn(nyr_cnt,ncnt)
%
% V field
         state_var='TRACER_I_V_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_traceri_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         v_traceri_conus_mn(nyr_cnt,ncnt)
%       
         state_var='TRACER_I_V_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_traceri_conus_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         v_traceri_conus_sd(nyr_cnt,ncnt)
%       
         state_var='TCR2_V_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_tcr2_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         v_tcr2_conus_mn(nyr_cnt,ncnt)
%       
         state_var='WRFCMAQ_V_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_wrfcmaq_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         v_wrfcmaq_conus_mn(nyr_cnt,ncnt)
%       
         state_var='CAMCHEM_V_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_camchem_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         v_camchem_conus_mn(nyr_cnt,ncnt)
%       
         state_var='TRACER_I_V_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_traceri_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         v_traceri_urban_mn(nyr_cnt,ncnt)
%       
         state_var='TRACER_I_V_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_traceri_urban_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         v_traceri_urban_sd(nyr_cnt,ncnt)
%       
         state_var='TCR2_V_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_tcr2_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         v_tcr2_urban_mn(nyr_cnt,ncnt)
%       
         state_var='WRFCMAQ_V_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_wrfcmaq_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         v_wrfcmaq_urban_mn(nyr_cnt,ncnt)
%       
         state_var='CAMCHEM_V_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_camchem_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         v_camchem_urban_mn(nyr_cnt,ncnt)
%       
         state_var='TRACER_I_V_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_traceri_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         v_traceri_rural_mn(nyr_cnt,ncnt)
%       
         state_var='TRACER_I_V_RURAL_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_traceri_rural_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         v_traceri_rural_sd(nyr_cnt,ncnt)
%       
         state_var='TCR2_V_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_tcr2_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         v_tcr2_rural_mn(nyr_cnt,ncnt)
%       
         state_var='WRFCMAQ_V_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_wrfcmaq_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         v_wrfcmaq_rural_mn(nyr_cnt,ncnt)
%       
         state_var='CAMCHEM_V_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         v_camchem_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         v_camchem_rural_mn(nyr_cnt,ncnt)
%
% Q field
         state_var='TRACER_I_Q_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_traceri_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;        %pptv
%         fprintf('Q TRACER-I CONUS MN at %6.4g \n \n',q_traceri_conus_mn(nyr_cnt,ncnt))
%        
         state_var='TRACER_I_Q_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_traceri_conus_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;        %pptv
%         fprintf('Q TRACER-I CONUS SD at %6.4g %6.2g \n \n',q_traceri_conus_sd(nyr_cnt,ncnt), ...
%         q_traceri_conus_sd(nyr_cnt,ncnt)/q_traceri_conus_mn(nyr_cnt,ncnt)*100.)
%        
         state_var='TCR2_Q_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_tcr2_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;            %pptv
%         q_tcr2_conus_mn(nyr_cnt,ncnt)
%        
         state_var='WRFCMAQ_Q_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_wrfcmaq_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;         %pptv
%         q_wrfcmaq_conus_mn(nyr_cnt,ncnt)
%        
         state_var='CAMCHEM_Q_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_camchem_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;         %pptv
%         q_camchem_conus_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_Q_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_traceri_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;        %pptv
%         q_traceri_urban_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_Q_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_traceri_urban_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;        %pptv
%         q_traceri_urban_sd(nyr_cnt,ncnt)
%        
         state_var='TCR2_Q_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_tcr2_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;            %pptv
%         q_tcr2_urban_mn(nyr_cnt,ncnt)
%        
         state_var='WRFCMAQ_Q_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_wrfcmaq_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;         %pptv
%         q_wrfcmaq_urban_mn(nyr_cnt,ncnt)
%        
         state_var='CAMCHEM_Q_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_camchem_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;         %pptv
%         q_camchem_urban_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_Q_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_traceri_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;        %pptv
%         q_traceri_rural_mn(nyr_cnt,ncnt)
%        
         state_var='TRACER_I_Q_RURAL_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_traceri_rural_sd(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;        %pptv
%         q_traceri_rural_sd(nyr_cnt,ncnt)
%        
         state_var='TCR2_Q_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_tcr2_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;            %pptv
%         q_tcr2_rural_mn(nyr_cnt,ncnt)
%        
         state_var='WRFCMAQ_Q_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_wrfcmaq_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;         %pptv
%         q_wrfcmaq_rural_mn(nyr_cnt,ncnt)
%        
         state_var='CAMCHEM_Q_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         q_camchem_rural_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*qfac;         %pptv
%         q_camchem_rural_mn(nyr_cnt,ncnt)
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
   t_traceri_conus_grmn=zeros(1,nyr_cnt);
   t_traceri_urban_grmn=zeros(1,nyr_cnt);
   t_traceri_rural_grmn=zeros(1,nyr_cnt);
   t_traceri_conus_grsd=zeros(1,nyr_cnt);
   t_traceri_urban_grsd=zeros(1,nyr_cnt);
   t_traceri_rural_grsd=zeros(1,nyr_cnt);
   t_wrfcmaq_conus_grmn=zeros(1,nyr_cnt);
   t_wrfcmaq_urban_grmn=zeros(1,nyr_cnt);
   t_wrfcmaq_rural_grmn=zeros(1,nyr_cnt);
   t_tcr2_conus_grmn=zeros(1,nyr_cnt);
   t_tcr2_urban_grmn=zeros(1,nyr_cnt);
   t_tcr2_rural_grmn=zeros(1,nyr_cnt);
   t_camchem_conus_grmn=zeros(1,nyr_cnt);
   t_camchem_urban_grmn=zeros(1,nyr_cnt);
   t_camchem_rural_grmn=zeros(1,nyr_cnt);
% U
   u_traceri_conus_grmn=zeros(1,nyr_cnt);
   u_traceri_urban_grmn=zeros(1,nyr_cnt);
   u_traceri_rural_grmn=zeros(1,nyr_cnt);
   u_traceri_conus_grsd=zeros(1,nyr_cnt);
   u_traceri_urban_grsd=zeros(1,nyr_cnt);
   u_traceri_rural_grsd=zeros(1,nyr_cnt);
   u_wrfcmaq_conus_grmn=zeros(1,nyr_cnt);
   u_wrfcmaq_urban_grmn=zeros(1,nyr_cnt);
   u_wrfcmaq_rural_grmn=zeros(1,nyr_cnt);
   u_tcr2_conus_grmn=zeros(1,nyr_cnt);
   u_tcr2_urban_grmn=zeros(1,nyr_cnt);
   u_tcr2_rural_grmn=zeros(1,nyr_cnt);
   u_camchem_conus_grmn=zeros(1,nyr_cnt);
   u_camchem_urban_grmn=zeros(1,nyr_cnt);
   u_camchem_rural_grmn=zeros(1,nyr_cnt);
% V
   v_traceri_conus_grmn=zeros(1,nyr_cnt);
   v_traceri_urban_grmn=zeros(1,nyr_cnt);
   v_traceri_rural_grmn=zeros(1,nyr_cnt);
   v_traceri_conus_grsd=zeros(1,nyr_cnt);
   v_traceri_urban_grsd=zeros(1,nyr_cnt);
   v_traceri_rural_grsd=zeros(1,nyr_cnt);
   v_wrfcmaq_conus_grmn=zeros(1,nyr_cnt);
   v_wrfcmaq_urban_grmn=zeros(1,nyr_cnt);
   v_wrfcmaq_rural_grmn=zeros(1,nyr_cnt);
   v_tcr2_conus_grmn=zeros(1,nyr_cnt);
   v_tcr2_urban_grmn=zeros(1,nyr_cnt);
   v_tcr2_rural_grmn=zeros(1,nyr_cnt);
   v_camchem_conus_grmn=zeros(1,nyr_cnt);
   v_camchem_urban_grmn=zeros(1,nyr_cnt);
   v_camchem_rural_grmn=zeros(1,nyr_cnt);
% Q
   q_traceri_conus_grmn=zeros(1,nyr_cnt);
   q_traceri_urban_grmn=zeros(1,nyr_cnt);
   q_traceri_rural_grmn=zeros(1,nyr_cnt);
   q_traceri_conus_grsd=zeros(1,nyr_cnt);
   q_traceri_urban_grsd=zeros(1,nyr_cnt);
   q_traceri_rural_grsd=zeros(1,nyr_cnt);
   q_wrfcmaq_conus_grmn=zeros(1,nyr_cnt);
   q_wrfcmaq_urban_grmn=zeros(1,nyr_cnt);
   q_wrfcmaq_rural_grmn=zeros(1,nyr_cnt);
   q_tcr2_conus_grmn=zeros(1,nyr_cnt);
   q_tcr2_urban_grmn=zeros(1,nyr_cnt);
   q_tcr2_rural_grmn=zeros(1,nyr_cnt);
   q_camchem_conus_grmn=zeros(1,nyr_cnt);
   q_camchem_urban_grmn=zeros(1,nyr_cnt);
   q_camchem_rural_grmn=zeros(1,nyr_cnt);
%
   for iyr=1:nyr_cnt
% T
      t_traceri_conus_grmn(iyr)=mean(t_traceri_conus_mn(iyr,:),'omitnan');
      t_traceri_urban_grmn(iyr)=mean(t_traceri_urban_mn(iyr,:),'omitnan');
      t_traceri_rural_grmn(iyr)=mean(t_traceri_rural_mn(iyr,:),'omitnan');
      t_traceri_conus_grsd(iyr)=mean(t_traceri_conus_sd(iyr,:).^2,'omitnan');
      t_traceri_urban_grsd(iyr)=mean(t_traceri_urban_sd(iyr,:).^2,'omitnan');
      t_traceri_rural_grsd(iyr)=mean(t_traceri_rural_sd(iyr,:).^2,'omitnan');
      t_wrfcmaq_conus_grmn(iyr)=mean(t_wrfcmaq_conus_mn(iyr,:),'omitnan');
      t_wrfcmaq_urban_grmn(iyr)=mean(t_wrfcmaq_urban_mn(iyr,:),'omitnan');
      t_wrfcmaq_rural_grmn(iyr)=mean(t_wrfcmaq_rural_mn(iyr,:),'omitnan');
      t_tcr2_conus_grmn(iyr)=mean(t_tcr2_conus_mn(iyr,:),'omitnan');
      t_tcr2_urban_grmn(iyr)=mean(t_tcr2_urban_mn(iyr,:),'omitnan');
      t_tcr2_rural_grmn(iyr)=mean(t_tcr2_rural_mn(iyr,:),'omitnan');
      t_camchem_conus_grmn(iyr)=mean(t_camchem_conus_mn(iyr,:),'omitnan');
      t_camchem_urban_grmn(iyr)=mean(t_camchem_urban_mn(iyr,:),'omitnan');
      t_camchem_rural_grmn(iyr)=mean(t_camchem_rural_mn(iyr,:),'omitnan');
% U
      u_traceri_conus_grmn(iyr)=mean(u_traceri_conus_mn(iyr,:),'omitnan');
      u_traceri_urban_grmn(iyr)=mean(u_traceri_urban_mn(iyr,:),'omitnan');
      u_traceri_rural_grmn(iyr)=mean(u_traceri_rural_mn(iyr,:),'omitnan');
      u_traceri_conus_grsd(iyr)=mean(u_traceri_conus_sd(iyr,:).^2,'omitnan');
      u_traceri_urban_grsd(iyr)=mean(u_traceri_urban_sd(iyr,:).^2,'omitnan');
      u_traceri_rural_grsd(iyr)=mean(u_traceri_rural_sd(iyr,:).^2,'omitnan');
      u_wrfcmaq_conus_grmn(iyr)=mean(u_wrfcmaq_conus_mn(iyr,:),'omitnan');
      u_wrfcmaq_urban_grmn(iyr)=mean(u_wrfcmaq_urban_mn(iyr,:),'omitnan');
      u_wrfcmaq_rural_grmn(iyr)=mean(u_wrfcmaq_rural_mn(iyr,:),'omitnan');
      u_tcr2_conus_grmn(iyr)=mean(u_tcr2_conus_mn(iyr,:),'omitnan');
      u_tcr2_urban_grmn(iyr)=mean(u_tcr2_urban_mn(iyr,:),'omitnan');
      u_tcr2_rural_grmn(iyr)=mean(u_tcr2_rural_mn(iyr,:),'omitnan');
      u_camchem_conus_grmn(iyr)=mean(u_camchem_conus_mn(iyr,:),'omitnan');
      u_camchem_urban_grmn(iyr)=mean(u_camchem_urban_mn(iyr,:),'omitnan');
      u_camchem_rural_grmn(iyr)=mean(u_camchem_rural_mn(iyr,:),'omitnan');
% V
      v_traceri_conus_grmn(iyr)=mean(v_traceri_conus_mn(iyr,:),'omitnan');
      v_traceri_urban_grmn(iyr)=mean(v_traceri_urban_mn(iyr,:),'omitnan');
      v_traceri_rural_grmn(iyr)=mean(v_traceri_rural_mn(iyr,:),'omitnan');
      v_traceri_conus_grsd(iyr)=mean(v_traceri_conus_sd(iyr,:).^2,'omitnan');
      v_traceri_urban_grsd(iyr)=mean(v_traceri_urban_sd(iyr,:).^2,'omitnan');
      v_traceri_rural_grsd(iyr)=mean(v_traceri_rural_sd(iyr,:).^2,'omitnan');
      v_wrfcmaq_conus_grmn(iyr)=mean(v_wrfcmaq_conus_mn(iyr,:),'omitnan');
      v_wrfcmaq_urban_grmn(iyr)=mean(v_wrfcmaq_urban_mn(iyr,:),'omitnan');
      v_wrfcmaq_rural_grmn(iyr)=mean(v_wrfcmaq_rural_mn(iyr,:),'omitnan');
      v_tcr2_conus_grmn(iyr)=mean(v_tcr2_conus_mn(iyr,:),'omitnan');
      v_tcr2_urban_grmn(iyr)=mean(v_tcr2_urban_mn(iyr,:),'omitnan');
      v_tcr2_rural_grmn(iyr)=mean(v_tcr2_rural_mn(iyr,:),'omitnan');
      v_camchem_conus_grmn(iyr)=mean(v_camchem_conus_mn(iyr,:),'omitnan');
      v_camchem_urban_grmn(iyr)=mean(v_camchem_urban_mn(iyr,:),'omitnan');
      v_camchem_rural_grmn(iyr)=mean(v_camchem_rural_mn(iyr,:),'omitnan');
% Q
      q_traceri_conus_grmn(iyr)=mean(q_traceri_conus_mn(iyr,:),'omitnan');
      q_traceri_urban_grmn(iyr)=mean(q_traceri_urban_mn(iyr,:),'omitnan');
      q_traceri_rural_grmn(iyr)=mean(q_traceri_rural_mn(iyr,:),'omitnan');
      q_traceri_conus_grsd(iyr)=mean(q_traceri_conus_sd(iyr,:).^2,'omitnan');
      q_traceri_urban_grsd(iyr)=mean(q_traceri_urban_sd(iyr,:).^2,'omitnan');
      q_traceri_rural_grsd(iyr)=mean(q_traceri_rural_sd(iyr,:).^2,'omitnan');
      q_wrfcmaq_conus_grmn(iyr)=mean(q_wrfcmaq_conus_mn(iyr,:),'omitnan');
      q_wrfcmaq_urban_grmn(iyr)=mean(q_wrfcmaq_urban_mn(iyr,:),'omitnan');
      q_wrfcmaq_rural_grmn(iyr)=mean(q_wrfcmaq_rural_mn(iyr,:),'omitnan');
      q_tcr2_conus_grmn(iyr)=mean(q_tcr2_conus_mn(iyr,:),'omitnan');
      q_tcr2_urban_grmn(iyr)=mean(q_tcr2_urban_mn(iyr,:),'omitnan');
      q_tcr2_rural_grmn(iyr)=mean(q_tcr2_rural_mn(iyr,:),'omitnan');
      q_camchem_conus_grmn(iyr)=mean(q_camchem_conus_mn(iyr,:),'omitnan');
      q_camchem_urban_grmn(iyr)=mean(q_camchem_urban_mn(iyr,:),'omitnan');
      q_camchem_rural_grmn(iyr)=mean(q_camchem_rural_mn(iyr,:),'omitnan');
   end
   for iyr=1:nyr_cnt
      if(~isnan(t_traceri_conus_grsd(iyr)))
         t_traceri_conus_grsd(iyr)=sqrt(t_traceri_conus_grsd(iyr));
      end
      if(~isnan(t_traceri_urban_grsd(iyr)))
         t_traceri_urban_grsd(iyr)=sqrt(t_traceri_urban_grsd(iyr));
      end
      if(~isnan(t_traceri_urban_grsd(iyr)))
         t_traceri_rural_grsd(iyr)=sqrt(t_traceri_rural_grsd(iyr));
      end
      if(~isnan(u_traceri_conus_grsd(iyr)))
         u_traceri_conus_grsd(iyr)=sqrt(u_traceri_conus_grsd(iyr));
      end
      if(~isnan(u_traceri_urban_grsd(iyr)))
         u_traceri_urban_grsd(iyr)=sqrt(u_traceri_urban_grsd(iyr));
      end
      if(~isnan(u_traceri_urban_grsd(iyr)))
         u_traceri_rural_grsd(iyr)=sqrt(u_traceri_rural_grsd(iyr));
      end
      if(~isnan(v_traceri_conus_grsd(iyr)))
         v_traceri_conus_grsd(iyr)=sqrt(v_traceri_conus_grsd(iyr));
      end
      if(~isnan(v_traceri_urban_grsd(iyr)))
         v_traceri_urban_grsd(iyr)=sqrt(v_traceri_urban_grsd(iyr));
      end
      if(~isnan(v_traceri_urban_grsd(iyr)))
         v_traceri_rural_grsd(iyr)=sqrt(v_traceri_rural_grsd(iyr));
      end
      if(~isnan(q_traceri_conus_grsd(iyr)))
         q_traceri_conus_grsd(iyr)=sqrt(q_traceri_conus_grsd(iyr));
      end
      if(~isnan(q_traceri_urban_grsd(iyr)))
         q_traceri_urban_grsd(iyr)=sqrt(q_traceri_urban_grsd(iyr));
      end
      if(~isnan(q_traceri_urban_grsd(iyr)))
         q_traceri_rural_grsd(iyr)=sqrt(q_traceri_rural_grsd(iyr));
      end
   end
%
% PLOT TIMESERIES OF SPATIAL MEAN PRIOR ENSEMBLE MEAN
% T
   ymn1=min(min(t_traceri_conus_grmn,t_traceri_urban_grmn));
   ymx1=max(max(t_traceri_conus_grmn,t_traceri_urban_grmn));
   ymn2=min(min(t_tcr2_conus_grmn,t_tcr2_urban_grmn));
   ymx2=max(max(t_tcr2_conus_grmn,t_tcr2_urban_grmn));
   ymn3=min(min(t_camchem_conus_grmn,t_camchem_urban_grmn));
   ymx3=max(max(t_camchem_conus_grmn,t_camchem_urban_grmn));
   ymn4=min(min(t_wrfcmaq_conus_grmn,t_wrfcmaq_urban_grmn));
   ymx4=max(max(t_wrfcmaq_conus_grmn,t_wrfcmaq_urban_grmn));
   ymn=min([ymn1,ymn2,ymn3,ymn4]);
   ymx=max([ymx1,ymx2,ymx3,ymx4]);
   ymn=0.995*ymn;
   ymx=1.005*ymx;
   rs = plot_series_8(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  T Time Series'}),'Year','Degree (K)', ....
   'TRCR1 CONUS','TRCR1 URBAN','TCR2 CONUS','TCR2 URBAN', ...
   'CMAQ CONUS','CMAQ URBAN','CAMC CONUS','CAMC URBAN',save_file,nyr_cnt,ymx,ymn, ...
   t_traceri_conus_grmn,t_traceri_urban_grmn,t_tcr2_conus_grmn, ...
   t_tcr2_urban_grmn,t_wrfcmaq_conus_grmn,t_wrfcmaq_urban_grmn, ...
   t_camchem_conus_grmn,t_camchem_urban_grmn, ...
   t_traceri_conus_grsd,t_traceri_urban_grsd,f_incr,YYYY_STR,YYYY_END);
%
% U
   u_ymn1=min(min(u_traceri_conus_grmn,u_traceri_urban_grmn));
   u_ymx1=max(max(u_traceri_conus_grmn,u_traceri_urban_grmn));
   u_ymn2=min(min(u_tcr2_conus_grmn,u_tcr2_urban_grmn));
   u_ymx2=max(max(u_tcr2_conus_grmn,u_tcr2_urban_grmn));
   u_ymn3=min(min(u_camchem_conus_grmn,u_camchem_urban_grmn));
   u_ymx3=max(max(u_camchem_conus_grmn,u_camchem_urban_grmn));
   u_ymn4=min(min(u_wrfcmaq_conus_grmn,u_wrfcmaq_urban_grmn));
   u_ymx4=max(max(u_wrfcmaq_conus_grmn,u_wrfcmaq_urban_grmn));
   v_ymn1=min(min(v_traceri_conus_grmn,v_traceri_urban_grmn));
   v_ymx1=max(max(v_traceri_conus_grmn,v_traceri_urban_grmn));
   v_ymn2=min(min(v_tcr2_conus_grmn,v_tcr2_urban_grmn));
   v_ymx2=max(max(v_tcr2_conus_grmn,v_tcr2_urban_grmn));
   v_ymn3=min(min(v_camchem_conus_grmn,v_camchem_urban_grmn));
   v_ymx3=max(max(v_camchem_conus_grmn,v_camchem_urban_grmn));
   v_ymn4=min(min(v_wrfcmaq_conus_grmn,v_wrfcmaq_urban_grmn));
   v_ymx4=max(max(v_wrfcmaq_conus_grmn,v_wrfcmaq_urban_grmn));
   ymn=min([u_ymn1,u_ymn2,u_ymn3,u_ymn4,v_ymn1,v_ymn2,v_ymn3,v_ymn4]);
   ymx=max([u_ymx1,u_ymx2,u_ymx3,u_ymx4,v_ymx1,v_ymx2,v_ymx3,v_ymx4]);
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
   rs = plot_series_8(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  U Time Series'}),'Year','Velocity (m/s)', ....
   'TRCR1 CONUS','TRCR1 URBAN','TCR2 CONUS','TCR2 URBAN', ...
   'CMAQ CONUS','CMAQ URBAN','CAMC CONUS','CAMC URBAN',save_file,nyr_cnt,ymx,ymn, ...
   u_traceri_conus_grmn,u_traceri_urban_grmn,u_tcr2_conus_grmn, ...
   u_tcr2_urban_grmn,u_wrfcmaq_conus_grmn,u_wrfcmaq_urban_grmn, ...
   u_camchem_conus_grmn,u_camchem_urban_grmn, ...
   u_traceri_conus_grsd,u_traceri_urban_grsd,f_incr,YYYY_STR,YYYY_END);
%
% V
   rs = plot_series_8(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  V Time Series'}),'Year','Velocity (m/s)', ....
   'TRCR1 CONUS','TRCR1 URBAN','TCR2 CONUS','TCR2 URBAN', ...
   'CMAQ CONUS','CMAQ URBAN','CAMC CONUS','CAMC URBAN',save_file,nyr_cnt,ymx,ymn, ...
   v_traceri_conus_grmn,v_traceri_urban_grmn,v_tcr2_conus_grmn, ...
   v_tcr2_urban_grmn,v_wrfcmaq_conus_grmn,v_wrfcmaq_urban_grmn, ...
   v_camchem_conus_grmn,v_camchem_urban_grmn, ...
   v_traceri_conus_grsd,v_traceri_urban_grsd,f_incr,YYYY_STR,YYYY_END);
%
% Q
   ymn1=min(min(q_traceri_conus_grmn,q_traceri_urban_grmn));
   ymx1=max(max(q_traceri_conus_grmn,q_traceri_urban_grmn));
   ymn2=min(min(q_tcr2_conus_grmn,q_tcr2_urban_grmn));
   ymx2=max(max(q_tcr2_conus_grmn,q_tcr2_urban_grmn));
   ymn3=min(min(q_camchem_conus_grmn,q_camchem_urban_grmn));
   ymx3=max(max(q_camchem_conus_grmn,q_camchem_urban_grmn));
   ymn=min([ymn1,ymn2,ymn3]);
   ymx=max([ymx1,ymx2,ymx3]);
   ymn=0.85*ymn;
   ymx=1.15*ymx;
   rs = plot_series_8(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  Q Time Series'}),'Year','Mixing Ratio (pptv)', ....
   'TRCR1 CONUS','TRCR1 URBAN','TCR2 CONUS','TCR2 URBAN', ...
   'CMAQ CONUS','CMAQ URBAN','CAMC CONUS','CAMC URBAN',save_file,nyr_cnt,ymx,ymn, ...
   q_traceri_conus_grmn,q_traceri_urban_grmn,q_tcr2_conus_grmn, ...
   q_tcr2_urban_grmn,q_wrfcmaq_conus_grmn,q_wrfcmaq_urban_grmn, ...
   q_camchem_conus_grmn,q_camchem_urban_grmn, ...
   q_traceri_conus_grsd,q_traceri_urban_grsd,f_incr,YYYY_STR,YYYY_END);
%
   return
end   
%
function [rs] = plot_series_2(ptitle,xtitle,ytitle,leg1,leg2,save_file,ntim, ...
   ymx,ymn,fld_1,fld_2)
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',15, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','bold','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',2);
   box(axes1,'on');
   hold(axes1,'all');
   set(gca,'XTick',[4,12,20,28,36]);
   set(gca,'XTickLabel',{'7/16','7/18','7/20','7/22','7/24'});
%
   scatter(index,fld_1,siz,'o','fill','MarkerFaceColor','k');
   scatter(index,fld_2,siz,'o','fill','MarkerFaceColor','m');
%
   h=plot(index,fld_1,'k--o',...
	  index,fld_2,'m--o');
%
   set(h(1),'LineWidth',2.3);
   set(h(2),'LineWidth',2.3);
%
   title(ptitle,'Fontsize',18,'FontWeight','bold');
   xlabel(xtitle,'FontSize',16);
   ylabel(ytitle,'FontSize',16);
   hleg=legend(leg1,leg2);
   set(hleg,'Location','NorthWest','FontSize',10,'FontWeight','bold');
   print(gcf,'-dpsc2','-append',save_file);
   rs=0;
end
%
function [rs] = plot_series_3(ptitle,xtitle,ytitle,leg1,leg2,leg3,file_save,ntim, ...
   ymx,ymn,fld_1,fld_2,fld_3)
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',15, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','bold','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',2);
   box(axes1,'on');
   hold(axes1,'all');
   set(gca,'XTick',[0,8,16,24,32]);
   set(gca,'XTickLabel',{'7/15','7/17','7/19','7/21','7/23'});
%
   scatter(index,fld_1,siz,'o','fill','MarkerFaceColor','b');
   scatter(index,fld_2,siz,'o','fill','MarkerFaceColor','r');
   scatter(index,fld_3,siz,'o','fill','MarkerFaceColor','g');
%
   h=plot(index,fld_1,'b--o', ...
	  index,fld_2,'r--o', ...
	  index,fld_3,'g--o');
%
   set(h(1),'LineWidth',2.3);
   set(h(2),'LineWidth',2.3);
   set(h(3),'LineWidth',2.3);
%
   title(ptitle,'Fontsize',18,'FontWeight','bold');
   xlabel(xtitle,'FontSize',16);
   ylabel(ytitle,'FontSize',16);
   hleg=legend(leg1,leg2,leg3);
   set(hleg,'Location','NorthWest','FontSize',10,'FontWeight','bold');
   print(gcf,'-dpsc','-append',file_save);
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
   set(gca,'XTick',[0,nend]);
   set(gca,'XTickLabel',{'2005','2023'});
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
save_file,ntim,ymx,ymn,fld_1,fld_2,fld_3,fld_4,fld_5,fld_6,fld_7,fld_8,err_1,err_2, ...
f_incr,YYYY_STR,YYYY_END)
   siz=50;
   step=2;
   nend=ntim-1;
   index=0:1:ntim-1;
   xtickindx=1:step:ntim;
   xticklabl=YYYY_STR:step:YYYY_END;
   xticksiz=size(xticklabl);
   xticksiz(2)
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
