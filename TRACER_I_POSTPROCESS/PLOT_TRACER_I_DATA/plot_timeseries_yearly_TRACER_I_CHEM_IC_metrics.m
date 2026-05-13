function plot_timeseries_yearly_TRACER_I_CHEM_IC_metrics
   clear all;
%
   YYYY_STR=2008;
   YYYY_END=2023;
   MMDDHH_STR=040200;
   MMDDHH_END=040300;
%
% Post files use f_incr=0
% Prior files use f_incr=3
   f_incr=3;
   f_incr=0;
%
   wrf_vert=[10,14,18,21,23,25,27,29,31,34];
   incr=3;
   levl=1;
   fac=1000.;
   nx=440;
   ny=284;
   nz=50;
%
% set colormap
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
      if(f_incr==0)
         sys_cmd=strcat('rm -rf TRACER_I_CHEM_FC_POSTS_',string(DATE_STR),'-', ...
         string(DATE_END),'_yearly_metrics.eps');
         save_file=strcat('TRACER_I_CHEM_FC_POSTS_',string(DATE_STR),'-', ...
         string(DATE_END),'_yearly_metrics.eps')
      else
         sys_cmd=strcat('rm -rf TRACER_I_CHEM_FC_PRIORS_',string(DATE_STR),'-', ...
         string(DATE_END),'_yearly_metrics.eps');
         save_file=strcat('TRACER_I_CHEM_FC_PRIORS_',string(DATE_STR),'-', ...
         string(DATE_END),'_yearly_metrics.eps');
      end
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
	 data_file=strcat('/ens_stats_d01_',string(YYYY),'-',F_MM_str,'-',F_DD_str,'_',F_HH_str,':00:00');
         data_dir=strcat('/ensemble_stats/',string(idate),data_file);
         data_file=strcat(data_path,data_dir);
%
% Read data for plotting
%
% CO field
         state_var='TRACER_I_CO_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_traceri_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
         fprintf('CO TRACER-I CONUS MN at %6.2f \n',co_traceri_conus_mn(ncnt))
%        
         state_var='TRACER_I_CO_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_traceri_conus_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
         fprintf('CO TRACER-I CONUS SD at %6.2f \n',co_traceri_conus_sd(ncnt))
%        
         state_var='TCR2_CO_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_tcr2_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         co_tcr2_conus_mn(ncnt)
%        
         state_var='WRFCMAQ_CO_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_wrfcmaq_conus_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         co_wrfcmaq_conus_mn(ncnt)
%        
         state_var='CAMCHEM_CO_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_camchem_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         co_camchem_conus_mn(ncnt)
%        
         state_var='TRACER_I_CO_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_traceri_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         co_traceri_urban_mn(ncnt)
%        
         state_var='TRACER_I_CO_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_traceri_urban_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         co_traceri_urban_sd(ncnt)
%        
         state_var='TCR2_CO_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_tcr2_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         co_tcr2_urban_mn(ncnt)
%        
         state_var='WRFCMAQ_CO_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_wrfcmaq_urban_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         co_wrfcmaq_urban_mn(ncnt)
%        
         state_var='CAMCHEM_CO_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_camchem_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         co_camchem_urban_mn(1)
%        
         state_var='TRACER_I_CO_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_traceri_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         co_traceri_rural_mn(ncnt)
%        
         state_var='TRACER_I_CO_RURAL_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_traceri_rural_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         co_traceri_rural_sd(1)
%        
         state_var='TCR2_CO_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_tcr2_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         co_tcr2_rural_mn(1)
%        
         state_var='WRFCMAQ_CO_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_wrfcmaq_rural_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         co_wrfcmaq_rural_mn(ncnt)
%        
         state_var='CAMCHEM_CO_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         co_camchem_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         co_camchem_rural_mn(1)
%        
% O3 field
         state_var='TRACER_I_O3_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_traceri_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
         fprintf('O3 TRACER-I CONUS MN at %6.2f \n',o3_traceri_conus_mn(ncnt))
%        
         state_var='TRACER_I_O3_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_traceri_conus_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
         fprintf('O3 TRACER-I CONUS SD at %6.2f \n \n',o3_traceri_conus_sd(ncnt))
%        
         state_var='TCR2_O3_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_tcr2_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         o3_tcr2_conus_mn(ncnt)
%        
         state_var='WRFCMAQ_O3_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_wrfcmaq_conus_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         o3_wrfcmaq_conus_mn(ncnt)
%        
         state_var='CAMCHEM_O3_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_camchem_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         o3_camchem_conus_mn(ncnt)
%        
         state_var='TRACER_I_O3_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_traceri_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         o3_traceri_urban_mn(ncnt)
%        
         state_var='TRACER_I_O3_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_traceri_urban_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         o3_traceri_urban_sd(ncnt)
%        
         state_var='TCR2_O3_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_tcr2_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         o3_tcr2_urban_mn(ncnt)
%        
         state_var='WRFCMAQ_O3_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_wrfcmaq_urban_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         o3_wrfcmaq_urban_mn(ncnt)
%        
         state_var='CAMCHEM_O3_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_camchem_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         o3_camchem_urban_mn(ncnt)
%        
         state_var='TRACER_I_O3_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_traceri_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         o3_traceri_rural_mn(ncnt)
%        
         state_var='TRACER_I_O3_RURAL_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_traceri_rural_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         o3_traceri_rural_sd(ncnt)
%        
         state_var='TCR2_O3_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_tcr2_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         o3_tcr2_rural_mn(ncnt)
%        
         state_var='WRFCMAQ_O3_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_wrfcmaq_rural_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         o3_wrfcmaq_rural_mn(ncnt)
%        
         state_var='CAMCHEM_O3_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         o3_camchem_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         o3_camchem_rural_mn(ncnt)
%        
% NO2    field
         state_var='TRACER_I_NO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_traceri_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         no2_traceri_conus_mn(ncnt)
%        
         state_var='TRACER_I_NO2_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_traceri_conus_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         no2_traceri_conus_sd(ncnt)
%        
         state_var='TCR2_NO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_tcr2_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         no2_tcr2_conus_mn(ncnt)
%        
         state_var='WRFCMAQ_NO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_wrfcmaq_conus_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         no2_wrfcmaq_conus_mn(ncnt)
%        
         state_var='CAMCHEM_NO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_camchem_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         no2_camchem_conus_mn(ncnt)
%        
         state_var='TRACER_I_NO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_traceri_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         no2_traceri_urban_mn(ncnt)
%        
         state_var='TRACER_I_NO2_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_traceri_urban_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         no2_traceri_urban_sd(ncnt)
%        
         state_var='TCR2_NO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_tcr2_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         no2_tcr2_urban_mn(ncnt)
%        
         state_var='WRFCMAQ_NO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_wrfcmaq_urban_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         no2_wrfcmaq_urban_mn(ncnt)
%        
         state_var='CAMCHEM_NO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_camchem_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         no2_camchem_urban_mn(ncnt)
%        
         state_var='TRACER_I_NO2_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_traceri_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         no2_traceri_rural_mn(ncnt)
%        
         state_var='TRACER_I_NO2_RURAL_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_traceri_rural_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         no2_traceri_rural_sd(ncnt)
%        
         state_var='TCR2_NO2_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_tcr2_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         no2_tcr2_rural_mn(ncnt)
%        
         state_var='WRFCMAQ_NO2_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_wrfcmaq_rural_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         no2_wrfcmaq_rural_mn(ncnt)
%        
         state_var='CAMCHEM_NO2_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         no2_camchem_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         no2_camchem_rural_mn(ncnt)
%        
% SO2    field
         state_var='TRACER_I_SO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_traceri_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         so2_traceri_conus_mn(ncnt)
%        
         state_var='TRACER_I_SO2_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_traceri_conus_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         so2_traceri_conus_sd(ncnt)
%        
         state_var='TCR2_SO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_tcr2_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         so2_tcr2_conus_mn(ncnt)
%        
         state_var='WRFCMAQ_SO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_wrfcmaq_conus_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         so2_wrfcmaq_conus_mn(ncnt)
%        
         state_var='CAMCHEM_SO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_camchem_conus_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         so2_camchem_conus_mn(ncnt)
%        
         state_var='TRACER_I_SO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_traceri_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         so2_traceri_urban_mn(ncnt)
%        
         state_var='TRACER_I_SO2_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_traceri_urban_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         so2_traceri_urban_sd(ncnt)
%        
         state_var='TCR2_SO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_tcr2_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         so2_tcr2_urban_mn(ncnt)
%        
         state_var='WRFCMAQ_SO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_wrfcmaq_urban_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         so2_wrfcmaq_urban_mn(ncnt)
%        
         state_var='CAMCHEM_SO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_camchem_urban_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         so2_camchem_urban_mn(ncnt)
%        
         state_var='TRACER_I_SO2_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_traceri_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         so2_traceri_rural_mn(ncnt)
%        
         state_var='TRACER_I_SO2_RURAL_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_traceri_rural_sd(ncnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%         so2_traceri_rural_sd(ncnt)
%        
         state_var='TCR2_SO2_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_tcr2_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%         so2_tcr2_rural_mn(ncnt)
%        
         state_var='WRFCMAQ_SO2_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_wrfcmaq_rural_mn(ncnt)=fld_full(wrf_vert(levl));         %ppbv
%         so2_wrfcmaq_rural_mn(ncnt)
%        
         state_var='CAMCHEM_SO2_RURAL_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
         so2_camchem_rural_mn(ncnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%         so2_camchem_rural_mn(ncnt)
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
% CO
      ymn1=min(min(co_traceri_conus_mn,co_traceri_urban_mn));
      ymx1=max(max(co_traceri_conus_mn,co_traceri_urban_mn));
      ymn2=min(min(co_tcr2_conus_mn,co_tcr2_urban_mn));
      ymx2=max(max(co_tcr2_conus_mn,co_tcr2_urban_mn));
      ymn3=min(min(co_camchem_conus_mn,co_camchem_urban_mn));
      ymx3=max(max(co_camchem_conus_mn,co_camchem_urban_mn));
      ymn4=min(min(co_wrfcmaq_conus_mn,co_wrfcmaq_urban_mn));
      ymx4=max(max(co_wrfcmaq_conus_mn,co_wrfcmaq_urban_mn));
      ymn=min([ymn1,ymn2,ymn3,ymn4]);
      ymx=max([ymx1,ymx2,ymx3,ymx4]);
      ymn=0.9*ymn;
      ymx=1.1*ymx;
      rs = plot_series_8(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  CO Time Series'}),'Date/Time','Mixing Ratio (ppb)', ...
      'TRCR1 CONUS','TRCR1 URBAN','TCR2_CONUS','TCR2_URBAN', ...
      'CMAQ CONUS','CMAQ URBAN', ...
      'CAMC CONUS','CAMC URBAN',save_file,ncnt,ymx,ymn, ...
      co_traceri_conus_mn,co_traceri_urban_mn,co_tcr2_conus_mn, ...
      co_tcr2_urban_mn,co_wrfcmaq_conus_mn,co_wrfcmaq_urban_mn, ...
      co_camchem_conus_mn,co_camchem_urban_mn, ...
      co_traceri_conus_sd,co_traceri_urban_sd,f_incr);
%
% O3
      ymn1=min(min(o3_traceri_conus_mn,o3_traceri_urban_mn));
      ymx1=max(max(o3_traceri_conus_mn,o3_traceri_urban_mn));
      ymn2=min(min(o3_tcr2_conus_mn,o3_tcr2_urban_mn));
      ymx2=max(max(o3_tcr2_conus_mn,o3_tcr2_urban_mn));
      ymn3=min(min(o3_camchem_conus_mn,o3_camchem_urban_mn));
      ymx3=max(max(o3_camchem_conus_mn,o3_camchem_urban_mn));
      ymn4=min(min(o3_wrfcmaq_conus_mn,o3_wrfcmaq_urban_mn));
      ymx4=max(max(o3_wrfcmaq_conus_mn,o3_wrfcmaq_urban_mn));
      ymn=min([ymn1,ymn2,ymn3,ymn4]);
      ymx=max([ymx1,ymx2,ymx3,ymx4]);
      ymn=0.9*ymn;
      ymx=1.1*ymx;
      rs = plot_series_8(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  O3 Time Series'}),'Date/Time','Mixing Ratio (ppb)', ...
      'TRCR1 CONUS','TRCR1 URBAN','TCR2 CONUS','TCR2 URBAN', ...
      'CMAQ CONUS','CMAQ URBAN','CAMC CONUS','CAMC URBAN',save_file,ncnt,ymx,ymn, ...
      o3_traceri_conus_mn,o3_traceri_urban_mn,o3_tcr2_conus_mn, ...
      o3_tcr2_urban_mn,o3_wrfcmaq_conus_mn,o3_wrfcmaq_urban_mn, ...
      o3_camchem_conus_mn,o3_camchem_urban_mn, ...
      o3_traceri_conus_sd,o3_traceri_urban_sd,f_incr);
%
% NO2
      ymn1=min(min(no2_traceri_conus_mn,no2_traceri_urban_mn));
      ymx1=max(max(no2_traceri_conus_mn,no2_traceri_urban_mn));
      ymn2=min(min(no2_tcr2_conus_mn,no2_tcr2_urban_mn));
      ymx2=max(max(no2_tcr2_conus_mn,no2_tcr2_urban_mn));
      ymn3=min(min(no2_camchem_conus_mn,no2_camchem_urban_mn));
      ymx3=max(max(no2_camchem_conus_mn,no2_camchem_urban_mn));
      ymn4=min(min(no2_wrfcmaq_conus_mn,no2_wrfcmaq_urban_mn));
      ymx4=max(max(no2_wrfcmaq_conus_mn,no2_wrfcmaq_urban_mn));
      ymn=min([ymn1,ymn2,ymn3,ymn4]);
      ymx=max([ymx1,ymx2,ymx3,ymx4]);
      ymn=0.9*ymn;
      ymn=0.;
      ymx=1.1*ymx;
      rs = plot_series_8(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  NO2 Time Series'}),'Date/Time','Mixing Ratio (ppb)', ...
      'TRCR1 CONUS','TRCR1 URBAN','TCR2 CONUS','TCR2 URBAN', ...
      'CMAQ CONUS','CMAQ URBAN','CAMC CONUS','CAMC URBAN',save_file,ncnt,ymx,ymn, ...
      no2_traceri_conus_mn,no2_traceri_urban_mn,no2_tcr2_conus_mn, ...
      no2_tcr2_urban_mn,no2_wrfcmaq_conus_mn,no2_wrfcmaq_urban_mn, ...
      no2_camchem_conus_mn,no2_camchem_urban_mn, ...
      no2_traceri_conus_sd,no2_traceri_urban_sd,f_incr);
%
% SO2
      ymn1=min(min(so2_traceri_conus_mn,so2_traceri_urban_mn));
      ymx1=max(max(so2_traceri_conus_mn,so2_traceri_urban_mn));
      ymn2=min(min(so2_tcr2_conus_mn,so2_tcr2_urban_mn));
      ymx2=max(max(so2_tcr2_conus_mn,so2_tcr2_urban_mn));
      ymn3=min(min(so2_camchem_conus_mn,so2_camchem_urban_mn));
      ymx3=max(max(so2_camchem_conus_mn,so2_camchem_urban_mn));
      ymn4=min(min(so2_wrfcmaq_conus_mn,so2_wrfcmaq_urban_mn));
      ymx4=max(max(so2_wrfcmaq_conus_mn,so2_wrfcmaq_urban_mn));
      ymn=min([ymn1,ymn2,ymn3,ymn4]);
      ymx=max([ymx1,ymx2,ymx3,ymx4]);
      ymn=0.9*ymn;
      ymn=0.;
      ymx=1.1*ymx;
      rs = plot_series_8(strcat({month_str},string(DD),{', '},string(YYYY), ...
      {':  SO2 Time Series'}),'Date/Time','Mixing Ratio (ppb)', ...
      'TRCR1 CONUS','TRCR1 URBAN','TCR2 CONUS','TCR2 URBAN', ...
      'CMAQ CONUS','CMAQ URBAN','CAMC CONUS','CAMC URBAN',save_file,ncnt,ymx,ymn, ...
      so2_traceri_conus_mn,so2_traceri_urban_mn,so2_tcr2_conus_mn, ...
      so2_tcr2_urban_mn,so2_wrfcmaq_conus_mn,so2_wrfcmaq_urban_mn, ...
      so2_camchem_conus_mn,so2_camchem_urban_mn, ...
      so2_traceri_conus_sd,so2_traceri_urban_sd,f_incr);
      iyear=iyear+1;
   end
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
   box(axes1,'on');
   hold(axes1,'all');
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
