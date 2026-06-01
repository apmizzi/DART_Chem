function plot_timeseries_multi_year_TRACER_I_EMIS_IC_metrics
   clear all;
%
   YYYY_STR=2006;
   YYYY_END=2018;
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
%
% Post files use f_incr=0
% Prior files use f_incr=3
   f_incr=3;
   f_incr=0;
%
   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
   cmap=desired_colors;
%
   if(f_incr==0)
      sys_cmd=strcat('rm -rf TRACER_I_EMIS_IC_POSTS_',string(YYYY_STR),'-', ...
      string(YYYY_END),'_multi_year_metrics.eps');
      save_file=strcat('TRACER_I_EMIS_IC_POSTS_',string(YYYY_STR),'-', ...
      string(YYYY_END),'_multi_year_metrics.eps');
   else
      sys_cmd=strcat('rm -rf TRACER_I_EMIS_IC_FRIORS_',string(YYYY_STR),'-', ...
      string(YYYY_END),'_multi_year_metrics.eps');
      save_file=strcat('TRACER_I_EMIS_IC_PRIORS_',string(YYYY_STR),'-', ...
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
	 data_file=strcat('/emissions_stats_d01_',string(YYYY),'-',F_MM_str,'-',F_DD_str,'_',F_HH_str,':00:00');
         data_dir=strcat('/emissions_stats/',string(idate),data_file);
         data_file=strcat(data_path,data_dir);
%
% Read data for plotting
%
% E_CO field
         state_var='TRACER_I_E_CO_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_co_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: e_co conus mn %d \n',e_co_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_E_CO_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_co_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_CO_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_co_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: e_co conus mn %d \n',e_co_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_E_CO_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_co_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
% E_NO2 field
         state_var='TRACER_I_E_NO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_no2_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: e_no2 conus mn %d \n',e_no2_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_E_NO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_no2_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_NO2_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_no2_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: e_no2 conus mn %d \n',e_no2_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_E_NO2_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_no2_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
% E_SO2 field
         state_var='TRACER_I_E_SO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_so2_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: e_so2 conus mn %d \n',e_so2_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_E_SO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_so2_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_E_SO2_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_so2_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: e_so2 conus mn %d \n',e_so2_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_E_SO2_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         e_so2_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
% EBU_IN_CO field
         state_var='TRACER_I_EBU_IN_CO_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_co_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: ebu_in_co conus mn %d \n',ebu_in_co_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_EBU_IN_CO_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_co_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_CO_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_co_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: ebu_in_co conus mn %d \n',ebu_in_co_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_EBU_IN_CO_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_co_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
% EBU_IN_NO2 field
         state_var='TRACER_I_EBU_IN_NO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_no2_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: ebu_in_no2 conus mn %d \n',ebu_in_no2_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_EBU_IN_NO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_no2_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_NO2_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_no2_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: ebu_in_no2 conus mn %d \n',ebu_in_no2_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_EBU_IN_NO2_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_no2_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
% EBU_IN_SO2 field
         state_var='TRACER_I_EBU_IN_SO2_CONUS_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_so2_emn_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: ebu_in_so2 conus mn %d \n',ebu_in_so2_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_EBU_IN_SO2_URBAN_MN'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_so2_emn_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
%
         state_var='TRACER_I_EBU_IN_SO2_CONUS_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_so2_esd_conus_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
         fprintf('APM: ebu_in_so2 conus mn %d \n',ebu_in_so2_emn_conus_mn(nyr_cnt,ncnt))
%         
         state_var='TRACER_I_EBU_IN_SO2_URBAN_SD'; 
         clear fld_full
         fld_full=double(ncread(data_file,state_var));
	 if(fld_full==missing)
	    fld_full=NaN;
	 end
         ebu_in_so2_esd_urban_mn(nyr_cnt,ncnt)=fld_full(wrf_vert(levl))*fac;
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
% E_CO
   e_co_traceri_conus_grmn=zeros(1,nyr_cnt);
   e_co_traceri_urban_grmn=zeros(1,nyr_cnt);
   e_co_traceri_rural_grmn=zeros(1,nyr_cnt);
   e_co_traceri_conus_grsd=zeros(1,nyr_cnt);
   e_co_traceri_urban_grsd=zeros(1,nyr_cnt);
   e_co_traceri_rural_grsd=zeros(1,nyr_cnt);
% E_NO2
   no2_traceri_conus_grmn=zeros(1,nyr_cnt);
   no2_traceri_urban_grmn=zeros(1,nyr_cnt);
   no2_traceri_rural_grmn=zeros(1,nyr_cnt);
   no2_traceri_conus_grsd=zeros(1,nyr_cnt);
   no2_traceri_urban_grsd=zeros(1,nyr_cnt);
   no2_traceri_rural_grsd=zeros(1,nyr_cnt);
% E_SO2
   so2_traceri_conus_grmn=zeros(1,nyr_cnt);
   so2_traceri_urban_grmn=zeros(1,nyr_cnt);
   so2_traceri_rural_grmn=zeros(1,nyr_cnt);
   so2_traceri_conus_grsd=zeros(1,nyr_cnt);
   so2_traceri_urban_grsd=zeros(1,nyr_cnt);
   so2_traceri_rural_grsd=zeros(1,nyr_cnt);
% EBU_IN_CO
   ebu_in_co_traceri_conus_grmn=zeros(1,nyr_cnt);
   ebu_in_co_traceri_urban_grmn=zeros(1,nyr_cnt);
   ebu_in_co_traceri_rural_grmn=zeros(1,nyr_cnt);
   ebu_in_co_traceri_conus_grsd=zeros(1,nyr_cnt);
   ebu_in_co_traceri_urban_grsd=zeros(1,nyr_cnt);
   ebu_in_co_traceri_rural_grsd=zeros(1,nyr_cnt);


% EBU_IN_NO2
   ebu_in_no2_traceri_conus_grmn=zeros(1,nyr_cnt);
   ebu_in_no2_traceri_urban_grmn=zeros(1,nyr_cnt);
   ebu_in_no2_traceri_rural_grmn=zeros(1,nyr_cnt);
   ebu_in_no2_traceri_conus_grsd=zeros(1,nyr_cnt);
   ebu_in_no2_traceri_urban_grsd=zeros(1,nyr_cnt);
   ebu_in_no2_traceri_rural_grsd=zeros(1,nyr_cnt);

% EBU_IN_SO2
   ebu_in_so2_traceri_conus_grmn=zeros(1,nyr_cnt);
   ebu_in_so2_traceri_urban_grmn=zeros(1,nyr_cnt);
   ebu_in_so2_traceri_rural_grmn=zeros(1,nyr_cnt);
   ebu_in_so2_traceri_conus_grsd=zeros(1,nyr_cnt);
   ebu_in_so2_traceri_urban_grsd=zeros(1,nyr_cnt);
   ebu_in_so2_traceri_rural_grsd=zeros(1,nyr_cnt);
%
   for iyr=1:nyr_cnt
% E_CO
      e_co_traceri_conus_grmn(iyr)=mean(e_co_emn_conus_mn(iyr,:),'omitnan');
      e_co_traceri_urban_grmn(iyr)=mean(e_co_emn_urban_mn(iyr,:),'omitnan');
      e_co_traceri_conus_grsd(iyr)=mean(e_co_esd_conus_mn(iyr,:).^2,'omitnan');
      e_co_traceri_urban_grsd(iyr)=mean(e_co_esd_urban_mn(iyr,:).^2,'omitnan');
% E_NO2
      e_no2_traceri_conus_grmn(iyr)=mean(e_no2_emn_conus_mn(iyr,:),'omitnan');
      e_no2_traceri_urban_grmn(iyr)=mean(e_no2_emn_urban_mn(iyr,:),'omitnan');
      e_no2_traceri_conus_grsd(iyr)=mean(e_no2_esd_conus_mn(iyr,:).^2,'omitnan');
      e_no2_traceri_urban_grsd(iyr)=mean(e_no2_esd_urban_mn(iyr,:).^2,'omitnan');
% E_SO2
      e_so2_traceri_conus_grmn(iyr)=mean(e_so2_emn_conus_mn(iyr,:),'omitnan');
      e_so2_traceri_urban_grmn(iyr)=mean(e_so2_emn_urban_mn(iyr,:),'omitnan');
      e_so2_traceri_conus_grsd(iyr)=mean(e_so2_esd_conus_mn(iyr,:).^2,'omitnan');
      e_so2_traceri_urban_grsd(iyr)=mean(e_so2_esd_urban_mn(iyr,:).^2,'omitnan');
% EBU_IN_CO
      ebu_in_co_traceri_conus_grmn(iyr)=mean(ebu_in_co_emn_conus_mn(iyr,:),'omitnan');
      ebu_in_co_traceri_urban_grmn(iyr)=mean(ebu_in_co_emn_urban_mn(iyr,:),'omitnan');
      ebu_in_co_traceri_conus_grsd(iyr)=mean(ebu_in_co_esd_conus_mn(iyr,:).^2,'omitnan');
      ebu_in_co_traceri_urban_grsd(iyr)=mean(ebu_in_co_esd_urban_mn(iyr,:).^2,'omitnan');
% EBU_IN_NO2
      ebu_in_no2_traceri_conus_grmn(iyr)=mean(ebu_in_no2_emn_conus_mn(iyr,:),'omitnan');
      ebu_in_no2_traceri_urban_grmn(iyr)=mean(ebu_in_no2_emn_urban_mn(iyr,:),'omitnan');
      ebu_in_no2_traceri_conus_grsd(iyr)=mean(ebu_in_no2_esd_conus_mn(iyr,:).^2,'omitnan');
      ebu_in_no2_traceri_urban_grsd(iyr)=mean(ebu_in_no2_esd_urban_mn(iyr,:).^2,'omitnan');
% EBU_IN_SO2
      ebu_in_so2_traceri_conus_grmn(iyr)=mean(ebu_in_so2_emn_conus_mn(iyr,:),'omitnan');
      ebu_in_so2_traceri_urban_grmn(iyr)=mean(ebu_in_so2_emn_urban_mn(iyr,:),'omitnan');
      ebu_in_so2_traceri_conus_grsd(iyr)=mean(ebu_in_so2_esd_conus_mn(iyr,:).^2,'omitnan');
      ebu_in_so2_traceri_urban_grsd(iyr)=mean(ebu_in_so2_esd_urban_mn(iyr,:).^2,'omitnan');
   end
   for iyr=1:nyr_cnt
% E_CO
      if(~isnan(e_co_traceri_conus_grsd(iyr)))
         e_co_traceri_conus_grsd(iyr)=sqrt(e_co_traceri_conus_grsd(iyr));
      end
      if(~isnan(e_co_traceri_urban_grsd(iyr)))
         e_co_traceri_urban_grsd(iyr)=sqrt(e_co_traceri_urban_grsd(iyr));
      end
% E_NO2
  if(~isnan(e_no2_traceri_conus_grsd(iyr)))
         e_no2_traceri_conus_grsd(iyr)=sqrt(e_no2_traceri_conus_grsd(iyr));
      end
      if(~isnan(e_no2_traceri_urban_grsd(iyr)))
         e_no2_traceri_urban_grsd(iyr)=sqrt(e_no2_traceri_urban_grsd(iyr));
      end
% E_SO2
      if(~isnan(e_so2_traceri_conus_grsd(iyr)))
         e_so2_traceri_conus_grsd(iyr)=sqrt(e_so2_traceri_conus_grsd(iyr));
      end
      if(~isnan(e_so2_traceri_urban_grsd(iyr)))
         e_so2_traceri_urban_grsd(iyr)=sqrt(e_so2_traceri_urban_grsd(iyr));
      end
% EBU_IN_CO
      if(~isnan(ebu_in_co_traceri_conus_grsd(iyr)))
         ebu_in_co_traceri_conus_grsd(iyr)=sqrt(ebu_in_co_traceri_conus_grsd(iyr));
      end
      if(~isnan(ebu_in_co_traceri_urban_grsd(iyr)))
         ebu_in_co_traceri_urban_grsd(iyr)=sqrt(ebu_in_co_traceri_urban_grsd(iyr));
      end
% EBU_IN_NO2
      if(~isnan(ebu_in_no2_traceri_conus_grsd(iyr)))
         ebu_in_no2_traceri_conus_grsd(iyr)=sqrt(ebu_in_no2_traceri_conus_grsd(iyr));
      end
      if(~isnan(ebu_in_no2_traceri_urban_grsd(iyr)))
         ebu_in_no2_traceri_urban_grsd(iyr)=sqrt(ebu_in_no2_traceri_urban_grsd(iyr));
      end
% EBU_IN_SO2
      if(~isnan(ebu_in_so2_traceri_conus_grsd(iyr)))
         ebu_in_so2_traceri_conus_grsd(iyr)=sqrt(ebu_in_so2_traceri_conus_grsd(iyr));
      end
      if(~isnan(ebu_in_so2_traceri_urban_grsd(iyr)))
         ebu_in_so2_traceri_urban_grsd(iyr)=sqrt(ebu_in_so2_traceri_urban_grsd(iyr));
      end
   end
%
% E_CO
   temp_conus_mn(:)=e_co_traceri_comus_grmn(:)-e_co_tracer_conus_grsd(:);
   temp_conus_mx(:)=e_co_traceri_comus_grmn(:)+e_co_tracer_conus_grsd(:);
   temp_urban_mn(:)=e_co_traceri_urban_grmn(:)-e_co_tracer_conus_grsd(:);
   temp_urban_mx(:)=e_co_traceri_urban_grmn(:)+e_co_tracer_conus_grsd(:);
%   ymn1=min(min(e_co_traceri_conus_grmn,e_co_traceri_urban_grmn));
%   ymx1=max(max(e_co_traceri_conus_grmn,e_co_traceri_urban_grmn));
   ymn1=min(min(temp_conus_mn,temp_urban_mn));
   ymx1=max(max(temp_conus_mx,temp_urban_mx));
   ymn=min([ymn1]);
   ymx=max([ymx1]);
   ymn=0.99*ymn;
   ymx=1.01*ymx;
   rs = plot_series_2(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  E\_CO Time Series'}),'Year','Flux (mol km^{-2} h^{1})', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn,e_co_traceri_conus_grmn, ...
   e_co_traceri_urban_grmn,e_co_traceri_conus_grsd,YYYY_STR,YYYY_END);
%
% E_NO2
   temp_conus_mn(:)=e_no2_traceri_comus_grmn(:)-e_no2_tracer_conus_grsd(:);
   temp_conus_mx(:)=e_no2_traceri_comus_grmn(:)+e_no2_tracer_conus_grsd(:);
   temp_urban_mn(:)=e_no2_traceri_urban_grmn(:)-e_no2_tracer_conus_grsd(:);
   temp_urban_mx(:)=e_no2_traceri_urban_grmn(:)+e_no2_tracer_conus_grsd(:);
%   ymn1=min(min(e_no2_traceri_conus_grmn,e_no2_traceri_urban_grmn));
%   ymx1=max(max(e_no2_traceri_conus_grmn,e_no2_traceri_urban_grmn));
   ymn1=min(min(temp_conus_mn,temp_urban_mn));
   ymx1=max(max(temp_conus_mx,temp_urban_mx));
   ymn=min([ymn1]);
   ymx=max([ymx1]);
   ymn=0.99*ymn;
   ymx=1.01*ymx;
   rs = plot_series_2(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  E\_NO2 Time Series'}),'Year','Flux (mol km^{-2} h^{1}))', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn,e_no2_traceri_conus_grmn, ...
   e_no2_traceri_urban_grmn,e_no2_traceri_conus_grsd,YYYY_STR,YYYY_END);
%
% E_SO2
   temp_conus_mn(:)=e_so2_traceri_comus_grmn(:)-e_so2_tracer_conus_grsd(:);
   temp_conus_mx(:)=e_so2_traceri_comus_grmn(:)+e_so2_tracer_conus_grsd(:);
   temp_urban_mn(:)=e_so2_traceri_urban_grmn(:)-e_so2_tracer_conus_grsd(:);
   temp_urban_mx(:)=e_so2_traceri_urban_grmn(:)+e_so2_tracer_conus_grsd(:);
%   ymn1=min(min(e_so2_traceri_conus_grmn,e_so2_traceri_urban_grmn));
%   ymx1=max(max(e_so2_traceri_conus_grmn,e_so2_traceri_urban_grmn));
   ymn1=min(min(temp_conus_mn,temp_urban_mn));
   ymx1=max(max(temp_conus_mx,temp_urban_mx));
   ymn=min([ymn1]);
   ymx=max([ymx1]);
   ymn=0.99*ymn;
   ymx=1.01*ymx;
   rs = plot_series_2(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  E\_SO2 Time Series'}),'Year','Flux (mol km^{-2} h^{1}))', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn,e_so2_traceri_conus_grmn, ...
   e_so2_traceri_urban_grmn,e_so2_traceri_conus_grsd,YYYY_STR,YYYY_END);
%
% EBU_IN_CO
   temp_conus_mn(:)=ebu_in_co_traceri_comus_grmn(:)-ebu_in_co_tracer_conus_grsd(:);
   temp_conus_mx(:)=ebu_in_co_traceri_comus_grmn(:)+ebu_in_co_tracer_conus_grsd(:);
   temp_urban_mn(:)=ebu_in_co_traceri_urban_grmn(:)-ebu_in_co_tracer_conus_grsd(:);
   temp_urban_mx(:)=ebu_in_co_traceri_urban_grmn(:)+ebu_in_co_tracer_conus_grsd(:);
%   ymn1=min(min(ebu_in_co_traceri_conus_grmn,ebu_in_co_traceri_urban_grmn));
%   ymx1=max(max(ebu_in_co_traceri_conus_grmn,ebu_in_co_traceri_urban_grmn));
   ymn1=min(min(temp_conus_mn,temp_urban_mn));
   ymx1=max(max(temp_conus_mx,temp_urban_mx));
   ymn=min([ymn1]);
   ymx=max([ymx1]);
   ymn=0.99*ymn;
   ymx=1.01*ymx;
   rs = plot_series_2(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  EBU\_IN\_CO Time Series'}),'Year','Flux (mol km^{-2} h^{1}))', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn,ebu_in_co_traceri_conus_grmn, ...
   ebu_in_co_traceri_urban_grmn,ebu_in_co_traceri_conus_grsd,YYYY_STR,YYYY_END);
%
% EBU_IN_NO2
   temp_conus_mn(:)=ebu_in_no2_traceri_comus_grmn(:)-ebu_in_no2_tracer_conus_grsd(:);
   temp_conus_mx(:)=ebu_in_no2_traceri_comus_grmn(:)+ebu_in_no2_tracer_conus_grsd(:);
   temp_urban_mn(:)=ebu_in_no2_traceri_urban_grmn(:)-ebu_in_no2_tracer_conus_grsd(:);
   temp_urban_mx(:)=ebu_in_no2_traceri_urban_grmn(:)+ebu_in_no2_tracer_conus_grsd(:);
   ymn1=min(min(ebu_in_no2_traceri_conus_grmn,ebu_in_no2_traceri_urban_grmn));
%   ymx1=max(max(ebu_in_no2_traceri_conus_grmn,ebu_in_no2_traceri_urban_grmn));
%   ymn1=min(min(temp_conus_mn,temp_urban_mn));
   ymx1=max(max(temp_conus_mx,temp_urban_mx));
   ymn=min([ymn1]);
   ymx=max([ymx1]);
   ymn=0.99*ymn;
   ymx=1.01*ymx;
   rs = plot_series_2(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  EBU\_IN\_NO2 Time Series'}),'Year','Flux (mol km^{-2} h^{1}))', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn,ebu_in_no2_traceri_conus_grmn, ...
   ebu_in_no2_traceri_urban_grmn,ebu_in_no2_traceri_conus_grsd,YYYY_STR,YYYY_END);
%
% EBU_IN_SO2
   temp_conus_mn(:)=ebu_in_so2_traceri_comus_grmn(:)-ebu_in_so2_tracer_conus_grsd(:);
   temp_conus_mx(:)=ebu_in_so2_traceri_comus_grmn(:)+ebu_in_so2_tracer_conus_grsd(:);
   temp_urban_mn(:)=ebu_in_so2_traceri_urban_grmn(:)-ebu_in_so2_tracer_conus_grsd(:);
   temp_urban_mx(:)=ebu_in_so2_traceri_urban_grmn(:)+ebu_in_so2_tracer_conus_grsd(:);
%   ymn1=min(min(ebu_in_so2_traceri_conus_grmn,ebu_in_so2_traceri_urban_grmn));
%   ymx1=max(max(ebu_in_so2_traceri_conus_grmn,ebu_in_so2_traceri_urban_grmn));
   ymn1=min(min(temp_conus_mn,temp_urban_mn));
   ymx1=max(max(temp_conus_mx,temp_urban_mx));
   ymn=min([ymn1]);
   ymx=max([ymx1]);
   ymn=0.99*ymn;
   ymx=1.01*ymx;
   rs = plot_series_2(strcat(string(YYYY_STR),{' to '},string(YYYY_END), ...
   {':  EBU\_IN\_SO2 Time Series'}),'Year','Flux (mol km^{-2} h^{1}))', ...
   'CONUS','URBAN',save_file,nyr_cnt,ymx,ymn,ebu_in_so2_traceri_conus_grmn, ...
   ebu_in_so2_traceri_urban_grmn,ebu_in_so2_traceri_conus_grsd,YYYY_STR,YYYY_END);
   return
end   
%
function [rs] = plot_series_2(ptitle,xtitle,ytitle,leg1,leg2, ...
   save_file,ntim,ymx,ymn,fld_1,fld_2,err_fld,YYYY_STR,YYYY_END)
   siz=50;
   step=2;
   nend=ntim-1;
   index=0:1:ntim-1;
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
   errorbar(index,fld_1,err_fld,'-o','LineWidth',1.75,'Color','r')
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
