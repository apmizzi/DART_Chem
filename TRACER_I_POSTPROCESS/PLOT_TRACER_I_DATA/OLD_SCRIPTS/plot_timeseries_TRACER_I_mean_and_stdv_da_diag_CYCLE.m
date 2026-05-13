function plot_timeseries_TRACER_I_mean_and_stdv_da_diag_CYCLE
   clear all;
%
   DATE_STR_PR=["2005040200","2005040203","2005040206","2005040209","2005040212","2005040215","2005040218","2005040221","2005040300","2005040303","2005040306","2005040309","2005040312","2005040315","2005040318","2005040321","2005040400"];
   DATE_STR_PO=["2005040206","2005040209","2005040212","2005040215","2005040218","2005040221","2005040300","2005040303","2005040306","2005040309","2005040312","2005040315","2005040318","2005040321","2005040400","2005040403"];
%
   ndates=17;
   ndates=7;
   wrf_vert=[10,14,18,21,23,25,27,29,31,34];
   levl=1;
   nx=440;
   ny=284;
   nz=50;
   num_mem=30;
   rc=system('rm -rf TRACER_I_MEAN_and_STDV_CHEM_DA_DIAG_CYCLE_timeseries.eps');
   save_file='TRACER_I_MEAN_and_STDV_CHEM_DA_DIAG_CYCLE_timeseries.eps';
%
% set colormap
   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
   cmap=desired_colors;
%
% CHEM DA
   path_data_inp='/nobackupp28/amizzi/OUTPUT_DATA/INPUT_2005_NOAA_EMISADJ_30MEMS';
   path_data_out='/nobackupp28/amizzi/OUTPUT_DATA/OUTPUT_2005_NOAA_EMISADJ_30MEMS_TEST';
%
% GRID DATA
% CHEM DA: WRF-Chem/DART data
   idate=1;
   date_chr=DATE_STR_PR(idate);
   file_date_pr=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
   date_chr=DATE_STR_PO(idate);
   file_date_po=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
   exp_pr=strcat(path_data_out,strcat('/',DATE_STR_PR(idate),'/wrfchem_cycle_cr/run_e001/wrfout_d01_',file_date_pr));
   if (idate==1)
      exp_pr=strcat(path_data_out,strcat('/',DATE_STR_PR(idate),'/wrfchem_initial/run_e001/wrfout_d01_',file_date_pr));
   end
   xlon=double(ncread(exp_pr,'XLONG'));
   xlat=double(ncread(exp_pr,'XLAT'));
%
% Loop through dates
   
   for idate=1:ndates
      fprintf('APM: Process date %s \n',DATE_STR_PO(idate))
      date_chr=DATE_STR_PR(idate);
      file_date_pr=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      date_chr=DATE_STR_PO(idate);
      file_date_po=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      co_mn_pr=zeros(nx,ny);
      o3_mn_pr=zeros(nx,ny);
      no2_mn_pr=zeros(nx,ny);
      so2_mn_pr=zeros(nx,ny);
      co_mn_po=zeros(nx,ny);
      o3_mn_po=zeros(nx,ny);
      no2_mn_po=zeros(nx,ny);
      so2_mn_po=zeros(nx,ny);
      co_sd_pr=zeros(nx,ny);
      o3_sd_pr=zeros(nx,ny);
      no2_sd_pr=zeros(nx,ny);
      so2_sd_pr=zeros(nx,ny);
      co_sd_po=zeros(nx,ny);
      o3_sd_po=zeros(nx,ny);
      no2_sd_po=zeros(nx,ny);
      so2_sd_po=zeros(nx,ny);
      co_inf_mn=zeros(nx,ny);
      o3_inf_mn=zeros(nx,ny);
      no2_inf_mn=zeros(nx,ny);
      so2_inf_mn=zeros(nx,ny);
      co_inf_sd=zeros(nx,ny);
      o3_inf_sd=zeros(nx,ny);
      no2_inf_sd=zeros(nx,ny);
      so2_inf_sd=zeros(nx,ny);
%
      mean_exp_pr=strcat(path_data_out,'/',DATE_STR_PO(idate),'/dart_filter/preassim_mean.nc');
      mean_exp_po=strcat(path_data_out,'/',DATE_STR_PO(idate),'/dart_filter/output_mean.nc');
      stdv_exp_pr=strcat(path_data_out,'/',DATE_STR_PO(idate),'/dart_filter/preassim_sd.nc');
      stdv_exp_po=strcat(path_data_out,'/',DATE_STR_PO(idate),'/dart_filter/output_sd.nc');
      inf_mn_po=strcat(path_data_out,'/',DATE_STR_PO(idate),'/dart_filter/input_postinf_mean.nc');
      inf_sd_po=strcat(path_data_out,'/',DATE_STR_PO(idate),'/dart_filter/input_postinf_sd.nc');
%
% CO PRIOR and POST FIELDS
      fac=1.e3;
      state_var='co'; 
      clear fld_full
      fld_full=double(ncread(mean_exp_pr,state_var));
      co_mn_pr(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(mean_exp_po,state_var));
      co_mn_po(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(stdv_exp_pr,state_var));
      co_sd_pr(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(stdv_exp_po,state_var));
      co_sd_po(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(inf_mn_po,state_var));
      co_inf_mn(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)));
      clear fld_full
      fld_full=double(ncread(inf_sd_po,state_var));
      co_inf_sd(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)));
%
% O3 PRIOR and POST FIELDS
      fac=1.e3;
      state_var='o3'; 
      clear fld_full
      fld_full=double(ncread(mean_exp_pr,state_var));
      o3_mn_pr(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(mean_exp_po,state_var));
      o3_mn_po(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(stdv_exp_pr,state_var));
      o3_sd_pr(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(stdv_exp_po,state_var));
      o3_sd_po(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(inf_mn_po,state_var));
      o3_inf_mn(:,:)=squeeze(fld_full(:,:,wrf_vert(levl))); %ppbv
      clear fld_full
      fld_full=double(ncread(inf_sd_po,state_var));
      o3_inf_sd(:,:)=squeeze(fld_full(:,:,wrf_vert(levl))); %ppbv
%
% NO2 PRIOR and POST FIELDS
      fac=1.e3;
      state_var='no2'; 
      clear fld_full
      fld_full=double(ncread(mean_exp_pr,state_var));
      no2_mn_pr(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(mean_exp_po,state_var));
      no2_mn_po(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(stdv_exp_pr,state_var));
      no2_sd_pr(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(stdv_exp_po,state_var));
      no2_sd_po(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(inf_mn_po,state_var));
      no2_inf_mn(:,:)=squeeze(fld_full(:,:,wrf_vert(levl))); %ppbv
      clear fld_full
      fld_full=double(ncread(inf_sd_po,state_var));
      no2_inf_sd(:,:)=squeeze(fld_full(:,:,wrf_vert(levl))); %ppbv
%
% SO2 PRIOR and POST FIELDS
      fac=1.e3;
      state_var='so2'; 
      clear fld_full
      fld_full=double(ncread(mean_exp_pr,state_var));
      so2_mn_pr(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(mean_exp_po,state_var));
      so2_mn_po(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(stdv_exp_pr,state_var));
      so2_sd_pr(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(stdv_exp_po,state_var));
      so2_sd_po(:,:)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac; %ppbv
      clear fld_full
      fld_full=double(ncread(inf_mn_po,state_var));
      so2_inf_mn(:,:)=squeeze(fld_full(:,:,wrf_vert(levl))); %ppbv
      clear fld_full
      fld_full=double(ncread(inf_sd_po,state_var));
      so2_inf_sd(:,:)=squeeze(fld_full(:,:,wrf_vert(levl))); %ppbv
%
% CO ENS MEAN and VARIANCE FIELDS
      co_mn_pr_mean(idate)=0;
      co_mn_pr_vari(idate)=0;
      co_mn_po_mean(idate)=0;
      co_mn_po_vari(idate)=0;
      co_sd_pr_mean(idate)=0;
      co_sd_pr_vari(idate)=0;
      co_sd_po_mean(idate)=0;
      co_sd_po_vari(idate)=0;
      co_vr_pr_mean(idate)=0;
      co_vr_pr_vari(idate)=0;
      co_vr_po_mean(idate)=0;
      co_vr_po_vari(idate)=0;
      co_inf_mn_mean(idate)=0;
      co_inf_mn_vari(idate)=0;
      co_inf_sd_mean(idate)=0;
      co_inf_sd_vari(idate)=0;
      co_inf_vr_mean(idate)=0;
      co_inf_vr_vari(idate)=0;
%
% O3 ENS MEAN and VARIANCE FIELDS
      o3_mn_pr_mean(idate)=0;
      o3_mn_pr_vari(idate)=0;
      o3_mn_po_mean(idate)=0;
      o3_mn_po_vari(idate)=0;
      o3_sd_pr_mean(idate)=0;
      o3_sd_pr_vari(idate)=0;
      o3_sd_po_mean(idate)=0;
      o3_sd_po_vari(idate)=0;
      o3_vr_pr_mean(idate)=0;
      o3_vr_pr_vari(idate)=0;
      o3_vr_po_mean(idate)=0;
      o3_vr_po_vari(idate)=0;
      o3_inf_mn_mean(idate)=0;
      o3_inf_mn_vari(idate)=0;
      o3_inf_sd_mean(idate)=0;
      o3_inf_sd_vari(idate)=0;
      o3_inf_vr_mean(idate)=0;
      o3_inf_vr_vari(idate)=0;
%
% NO2 ENS MEAN and VARIANCE FIELDS
      no2_mn_pr_mean(idate)=0;
      no2_mn_pr_vari(idate)=0;
      no2_mn_po_mean(idate)=0;
      no2_mn_po_vari(idate)=0;
      no2_sd_pr_mean(idate)=0;
      no2_sd_pr_vari(idate)=0;
      no2_sd_po_mean(idate)=0;
      no2_sd_po_vari(idate)=0;
      no2_vr_pr_mean(idate)=0;
      no2_vr_pr_vari(idate)=0;
      no2_vr_po_mean(idate)=0;
      no2_vr_po_vari(idate)=0;
      no2_inf_mn_mean(idate)=0;
      no2_inf_mn_vari(idate)=0;
      no2_inf_sd_mean(idate)=0;
      no2_inf_sd_vari(idate)=0;
      no2_inf_vr_mean(idate)=0;
      no2_inf_vr_vari(idate)=0;
%
% SO2 ENS MEAN and VARIANCE FIELDS
      so2_mn_pr_mean(idate)=0;
      so2_mn_pr_vari(idate)=0;
      so2_mn_po_mean(idate)=0;
      so2_mn_po_vari(idate)=0;
      so2_sd_pr_mean(idate)=0;
      so2_sd_pr_vari(idate)=0;
      so2_sd_po_mean(idate)=0;
      so2_sd_po_vari(idate)=0;
      so2_vr_pr_mean(idate)=0;
      so2_vr_pr_vari(idate)=0;
      so2_vr_po_mean(idate)=0;
      so2_vr_po_vari(idate)=0;
      so2_inf_mn_mean(idate)=0;
      so2_inf_mn_vari(idate)=0;
      so2_inf_sd_mean(idate)=0;
      so2_inf_sd_vari(idate)=0;
      so2_inf_vr_mean(idate)=0;
      so2_inf_vr_vari(idate)=0;
%
% Spatial mean      
      for i=1:nx
         for j=1:ny
% Spatial mean of ensemble mean	  
            co_mn_pr_mean(idate)=co_mn_pr_mean(idate)+co_mn_pr(i,j)/(nx*ny);
            o3_mn_pr_mean(idate)=o3_mn_pr_mean(idate)+o3_mn_pr(i,j)/(nx*ny);
            no2_mn_pr_mean(idate)=no2_mn_pr_mean(idate)+no2_mn_pr(i,j)/(nx*ny);
            so2_mn_pr_mean(idate)=so2_mn_pr_mean(idate)+so2_mn_pr(i,j)/(nx*ny);
%
            co_mn_po_mean(idate)=co_mn_po_mean(idate)+co_mn_po(i,j)/(nx*ny);
            o3_mn_po_mean(idate)=o3_mn_po_mean(idate)+o3_mn_po(i,j)/(nx*ny);
            no2_mn_po_mean(idate)=no2_mn_po_mean(idate)+no2_mn_po(i,j)/(nx*ny);
            so2_mn_po_mean(idate)=so2_mn_po_mean(idate)+so2_mn_po(i,j)/(nx*ny);
%
            co_inf_mn_mean(idate)=co_inf_mn_mean(idate)+co_inf_mn(i,j)/(nx*ny);
            o3_inf_mn_mean(idate)=o3_inf_mn_mean(idate)+o3_inf_mn(i,j)/(nx*ny);
            no2_inf_mn_mean(idate)=no2_inf_mn_mean(idate)+no2_inf_mn(i,j)/(nx*ny);
            so2_inf_mn_mean(idate)=so2_inf_mn_mean(idate)+so2_inf_mn(i,j)/(nx*ny);
% Spatial mean of ensemble variance	    
            co_vr_pr_mean(idate)=co_vr_pr_mean(idate)+(co_sd_pr(i,j)^2)/(nx*ny);
            o3_vr_pr_mean(idate)=o3_vr_pr_mean(idate)+(o3_sd_pr(i,j)^2)/(nx*ny);
            no2_vr_pr_mean(idate)=no2_vr_pr_mean(idate)+(no2_sd_pr(i,j)^2)/(nx*ny);
            so2_vr_pr_mean(idate)=so2_vr_pr_mean(idate)+(so2_sd_pr(i,j)^2)/(nx*ny);
%
            co_vr_po_mean(idate)=co_vr_po_mean(idate)+(co_sd_po(i,j)^2)/(nx*ny);
            o3_vr_po_mean(idate)=o3_vr_po_mean(idate)+(o3_sd_po(i,j)^2)/(nx*ny);
            no2_vr_po_mean(idate)=no2_vr_po_mean(idate)+(no2_sd_po(i,j)^2)/(nx*ny);
            so2_vr_po_mean(idate)=so2_vr_po_mean(idate)+(so2_sd_po(i,j)^2)/(nx*ny);
%
            co_inf_vr_mean(idate)=co_inf_vr_mean(idate)+(co_inf_sd(i,j)^2)/(nx*ny);
            o3_inf_vr_mean(idate)=o3_inf_vr_mean(idate)+(o3_inf_sd(i,j)^2)/(nx*ny);
            no2_inf_vr_mean(idate)=no2_inf_vr_mean(idate)+(no2_inf_sd(i,j)^2)/(nx*ny);
            so2_inf_vr_mean(idate)=so2_inf_vr_mean(idate)+(so2_inf_sd(i,j)^2)/(nx*ny);
	 end
      end
%
% Spatial variance
      for i=1:nx
         for j=1:ny
% Spatial variance of ensemble mean	  
            co_mn_pr_vari(idate)=co_mn_pr_vari(idate)+((co_mn_pr(i,j)- ...
            co_mn_pr_mean(idate))^2)/(nx*ny-1);
            o3_mn_pr_vari(idate)=o3_mn_pr_vari(idate)+((o3_mn_pr(i,j)- ...
            o3_mn_pr_mean(idate))^2)/(nx*ny-1);
            no2_mn_pr_vari(idate)=no2_mn_pr_vari(idate)+((no2_mn_pr(i,j)- ...
            no2_mn_pr_mean(idate))^2)/(nx*ny-1);
            so2_mn_pr_vari(idate)=so2_mn_pr_vari(idate)+((so2_mn_pr(i,j)- ...
            so2_mn_pr_mean(idate))^2)/(nx*ny-1);
%
            co_mn_po_vari(idate)=co_mn_po_vari(idate)+((co_mn_po(i,j)- ...
            co_mn_po_mean(idate))^2)/(nx*ny-1);
            o3_mn_po_vari(idate)=o3_mn_po_vari(idate)+((o3_mn_po(i,j)- ...
            o3_mn_po_mean(idate))^2)/(nx*ny-1);
            no2_mn_po_vari(idate)=no2_mn_po_vari(idate)+((no2_mn_po(i,j)- ...
            no2_mn_po_mean(idate))^2)/(nx*ny-1);
            so2_mn_po_vari(idate)=so2_mn_po_vari(idate)+((so2_mn_po(i,j)- ...
            so2_mn_po_mean(idate))^2)/(nx*ny-1);
%
            co_inf_mn_vari(idate)=co_inf_mn_vari(idate)+((co_inf_mn(i,j)- ...
            co_inf_mn_mean(idate))^2)/(nx*ny-1);
            o3_inf_mn_vari(idate)=o3_inf_mn_vari(idate)+((o3_inf_mn(i,j)- ...
            o3_inf_mn_mean(idate))^2)/(nx*ny-1);
            no2_inf_mn_vari(idate)=no2_inf_mn_vari(idate)+((no2_inf_mn(i,j)- ...
            no2_inf_mn_mean(idate))^2)/(nx*ny-1);
            so2_inf_mn_vari(idate)=so2_inf_mn_vari(idate)+((so2_inf_mn(i,j)- ...
            so2_inf_mn_mean(idate))^2)/(nx*ny-1);
% Spatial variances of ensemble variance
            co_vr_pr_vari(idate)=co_vr_pr_vari(idate)+((co_sd_pr(i,j)^2- ...
            co_vr_pr_mean(idate))^2)/(nx*ny-1);
            o3_vr_pr_vari(idate)=o3_vr_pr_vari(idate)+((o3_sd_pr(i,j)^2- ...
            o3_vr_pr_mean(idate))^2)/(nx*ny-1);
            no2_vr_pr_vari(idate)=no2_vr_pr_vari(idate)+((no2_sd_pr(i,j)^2- ...
            no2_vr_pr_mean(idate))^2)/(nx*ny-1);
            so2_vr_pr_vari(idate)=so2_vr_pr_vari(idate)+((so2_sd_pr(i,j)^2- ...
            so2_vr_pr_mean(idate))^2)/(nx*ny-1);
%
            co_vr_po_vari(idate)=co_vr_po_vari(idate)+((co_sd_po(i,j)^2- ...
            co_vr_po_mean(idate))^2)/(nx*ny-1);
            o3_vr_po_vari(idate)=o3_vr_po_vari(idate)+((o3_sd_po(i,j)^2- ...
            o3_vr_po_mean(idate))^2)/(nx*ny-1);
            no2_vr_po_vari(idate)=no2_vr_po_vari(idate)+((no2_sd_po(i,j)^2- ...
            no2_vr_po_mean(idate))^2)/(nx*ny-1);
            so2_vr_po_vari(idate)=so2_vr_po_vari(idate)+((so2_sd_po(i,j)^2- ...
            so2_vr_po_mean(idate))^2)/(nx*ny-1);
%
            co_inf_vr_vari(idate)=co_inf_vr_vari(idate)+((co_inf_sd(i,j)^2- ...
            co_inf_vr_mean(idate))^2)/(nx*ny-1);
            o3_inf_vr_vari(idate)=o3_inf_vr_vari(idate)+((o3_inf_sd(i,j)^2- ...
            o3_inf_vr_mean(idate))^2)/(nx*ny-1);
            no2_inf_vr_vari(idate)=no2_inf_vr_vari(idate)+((no2_inf_sd(i,j)^2- ...
            no2_inf_vr_mean(idate))^2)/(nx*ny-1);
            so2_inf_vr_vari(idate)=so2_inf_vr_vari(idate)+((so2_inf_sd(i,j)^2- ...
            so2_inf_vr_mean(idate))^2)/(nx*ny-1);
	 end
      end
%
      co_sd_pr_mean(idate)=sqrt(co_vr_pr_mean(idate));
      co_sd_po_mean(idate)=sqrt(co_vr_po_mean(idate));
      o3_sd_pr_mean(idate)=sqrt(o3_vr_pr_mean(idate));
      o3_sd_po_mean(idate)=sqrt(o3_vr_po_mean(idate));
      no2_sd_pr_mean(idate)=sqrt(no2_vr_pr_mean(idate));
      no2_sd_po_mean(idate)=sqrt(no2_vr_po_mean(idate));
      so2_sd_pr_mean(idate)=sqrt(so2_vr_pr_mean(idate));
      so2_sd_po_mean(idate)=sqrt(so2_vr_po_mean(idate));
%
      co_mn_pr_stdv(idate)=sqrt(co_mn_pr_vari(idate));
      co_mn_po_stdv(idate)=sqrt(co_mn_po_vari(idate));
      o3_mn_pr_stdv(idate)=sqrt(o3_mn_pr_vari(idate));
      o3_mn_po_stdv(idate)=sqrt(o3_mn_po_vari(idate));
      no2_mn_pr_stdv(idate)=sqrt(no2_mn_pr_vari(idate));
      no2_mn_po_stdv(idate)=sqrt(no2_mn_po_vari(idate));
      so2_mn_pr_stdv(idate)=sqrt(so2_mn_pr_vari(idate));
      so2_mn_po_stdv(idate)=sqrt(so2_mn_po_vari(idate));
%
      co_inf_mn_stdv(idate)=sqrt(co_inf_mn_vari(idate));
      o3_inf_mn_stdv(idate)=sqrt(o3_inf_mn_vari(idate));
      no2_inf_mn_stdv(idate)=sqrt(no2_inf_mn_vari(idate));
      so2_inf_mn_stdv(idate)=sqrt(so2_inf_mn_vari(idate));
%
      co_sd_pr_stdv(idate)=sqrt(sqrt(co_vr_pr_vari(idate)));
      co_sd_po_stdv(idate)=sqrt(sqrt(co_vr_po_vari(idate)));
      o3_sd_pr_stdv(idate)=sqrt(sqrt(o3_vr_pr_vari(idate)));
      o3_sd_po_stdv(idate)=sqrt(sqrt(o3_vr_po_vari(idate)));
      no2_sd_pr_stdv(idate)=sqrt(sqrt(no2_vr_pr_vari(idate)));
      no2_sd_po_stdv(idate)=sqrt(sqrt(no2_vr_po_vari(idate)));
      so2_sd_pr_stdv(idate)=sqrt(sqrt(so2_vr_pr_vari(idate)));
      so2_sd_po_stdv(idate)=sqrt(sqrt(so2_vr_po_vari(idate)));
%
      co_inf_sd_stdv(idate)=sqrt(sqrt(co_inf_vr_vari(idate)));
      o3_inf_sd_stdv(idate)=sqrt(sqrt(o3_inf_vr_vari(idate)));
      no2_inf_sd_stdv(idate)=sqrt(sqrt(no2_inf_vr_vari(idate)));
      so2_inf_sd_stdv(idate)=sqrt(sqrt(so2_inf_vr_vari(idate)));
%
% Relative metrics
      co_rel_sprd_pr(idate)=co_sd_pr_mean(idate)/co_mn_pr_mean(idate)*100.;
      co_rel_sprd_po(idate)=co_sd_po_mean(idate)/co_mn_pr_mean(idate)*100.;
      co_rel_incr(idate)=(co_mn_po_mean(idate)-co_mn_pr_mean(idate))/co_mn_pr_mean(idate)*100.;
      o3_rel_sprd_pr(idate)=o3_sd_pr_mean(idate)/o3_mn_pr_mean(idate)*100.;
      o3_rel_sprd_po(idate)=o3_sd_po_mean(idate)/o3_mn_pr_mean(idate)*100.;
      o3_rel_incr(idate)=(o3_mn_po_mean(idate)-o3_mn_pr_mean(idate))/co_mn_pr_mean(idate)*100.;
      no2_rel_sprd_pr(idate)=no2_sd_pr_mean(idate)/no2_mn_pr_mean(idate)*100.;
      no2_rel_sprd_po(idate)=no2_sd_po_mean(idate)/no2_mn_pr_mean(idate)*100.;
      no2_rel_incr(idate)=(no2_mn_po_mean(idate)-no2_mn_pr_mean(idate))/no2_mn_pr_mean(idate)*100.;
      so2_rel_sprd_pr(idate)=so2_sd_pr_mean(idate)/so2_mn_pr_mean(idate)*100.;
      so2_rel_sprd_po(idate)=so2_sd_po_mean(idate)/so2_mn_pr_mean(idate)*100.;
      so2_rel_incr(idate)=(so2_mn_po_mean(idate)-so2_mn_pr_mean(idate))/so2_mn_pr_mean(idate)*100.;
   end
%
% PLOT TIMESERIES OF SPATIAL MEAN PRIOR ENSEMBLE MEAN
% CO
%   ymn=min(min(co_mn_pr_mean,co_mn_po_mean));
%   ymx=max(max(co_mn_pr_mean,co_mn_po_mean));   
%   rs = plot_series_2('Ens Mean CO Time Series','Date','Mixing Ratio (ppb)', ...
%   'PRIOR','POST',save_file,ndates,ymx,ymn,co_mn_pr_mean,co_mn_po_mean);
%
%   ymn=min(min(co_sd_pr_mean,co_sd_po_mean));
%   ymx=max(max(co_sd_pr_mean,co_sd_po_mean));   
%   rs = plot_series_2('Ens Sprd CO Time Series','Date','Mixing Ratio (ppb)', ...
%   'PRIOR','POST',save_file,ndates,ymx,ymn,co_sd_pr_mean,co_sd_po_mean);
%
   ymnn(1)=min(co_rel_sprd_pr);
   ymnn(2)=min(co_rel_sprd_po);
   ymnn(3)=min(co_rel_incr);
   ymn1=min(ymnn);
   ymxx(1)=max(co_rel_sprd_pr);
   ymxx(2)=max(co_rel_sprd_po);
   ymxx(3)=max(co_rel_incr);
   ymx1=max(ymxx);
   ymn1=-10;
   ymx1=50.;
%
   ymn2=min(co_inf_mn_mean);
   ymx2=max(co_inf_mn_mean);
%   
   rs = plot_series_4_yy('Ens DA Metrics CO','Date','Percent (%)','Inflation ( )', ...
   'R-Sprd PR','R-Sprd PO','R-Incr','Infl',save_file,ndates,ymx1,ymn1, ...
   co_rel_sprd_pr,co_rel_sprd_po,co_rel_incr,ymx2,ymn2,co_inf_mn_mean);
%
% O3
   ymnn(1)=min(o3_rel_sprd_pr);
   ymnn(2)=min(o3_rel_sprd_po);
   ymnn(3)=min(o3_rel_incr);
   ymn1=min(ymnn);
   ymxx(1)=max(o3_rel_sprd_pr);
   ymxx(2)=max(o3_rel_sprd_po);
   ymxx(3)=max(o3_rel_incr);
   ymx1=max(ymxx);
   ymn1=-10;
   ymx1=40.;
%
   ymn2=min(o3_inf_mn_mean);
   ymx2=max(o3_inf_mn_mean);
%   
   rs = plot_series_4_yy('Ens DA Metrics O3','Date','Percent (%)','Inflation ( )', ...
   'R-Sprd PR','R-Sprd PO','R-Incr','Infl',save_file,ndates,ymx1,ymn1, ...
   o3_rel_sprd_pr,o3_rel_sprd_po,o3_rel_incr,ymx2,ymn2,o3_inf_mn_mean);
%
% NO2
   ymnn(1)=min(no2_rel_sprd_pr);
   ymnn(2)=min(no2_rel_sprd_po);
   ymnn(3)=min(no2_rel_incr);
   ymn1=min(ymnn);
   ymxx(1)=max(no2_rel_sprd_pr);
   ymxx(2)=max(no2_rel_sprd_po);
   ymxx(3)=max(no2_rel_incr);
   ymx1=max(ymxx);
   ymn1=-10;
   ymx1=100.;
%
   ymn2=min(no2_inf_mn_mean);
   ymx2=max(no2_inf_mn_mean);
%   
   rs = plot_series_4_yy('Ens DA Metrics NO2','Date','Percent (%)','Inflation ( )', ...
   'R-Sprd PR','R-Sprd PO','R-Incr','Infl',save_file,ndates,ymx1,ymn1, ...
   no2_rel_sprd_pr,no2_rel_sprd_po,no2_rel_incr,ymx2,ymn2,no2_inf_mn_mean);
%
% SO2
   ymnn(1)=min(so2_rel_sprd_pr);
   ymnn(2)=min(so2_rel_sprd_po);
   ymnn(3)=min(so2_rel_incr);
   ymn1=min(ymnn);
   ymxx(1)=max(so2_rel_sprd_pr);
   ymxx(2)=max(so2_rel_sprd_po);
   ymxx(3)=max(so2_rel_incr);
   ymx1=max(ymxx);
   ymn1=-10;
   ymx1=170.;
%
   ymn2=min(so2_inf_mn_mean);
   ymx2=max(so2_inf_mn_mean);
%   
   rs = plot_series_4_yy('Ens DA Metrics SO2','Date','Percent (%)','Inflation ( )', ...
   'R-Sprd PR','R-Sprd PO','R-Incr','Infl',save_file,ndates,ymx1,ymn1, ...
   so2_rel_sprd_pr,so2_rel_sprd_po,so2_rel_incr,ymx2,ymn2,so2_inf_mn_mean);
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
function [rs] = plot_series_3(ptitle,xtitle,ytitle,leg1,leg2,leg3,save_file,ntim, ...
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
   print(gcf,'-dpsc2','-append',save_file);   
   rs=0;
end
%
function [rs] = plot_series_4_yy(ptitle,xtitle,ytitle1,ytitle2,leg1,leg2,leg3,leg4, ...
   save_file,ntim,ymx1,ymn1,fld_1,fld_2,fld_3,ymx2,ymn2,fld_4)
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',15, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','bold','XLim',[0. nend], ...
   'YLim',[ymn1 ymx1],'LineWidth',2,XAxisLocation='bottom',YAxisLocation='left');
   box(axes1,'on');
   hold(axes1,'all');
%
   set(gca,'XTick',[0,8,16,24,32]);
   set(gca,'XTickLabel',{'7/15','7/17','7/19','7/21','7/23'});
   set(gca,'YColor','k');
%
   s1=scatter(index,fld_1,siz,'o','fill','MarkerFaceColor','b','DisplayName',leg1);
   s2=scatter(index,fld_2,siz,'o','fill','MarkerFaceColor','r','DisplayName',leg2);
   s3=scatter(index,fld_3,siz,'o','fill','MarkerFaceColor','g','DisplayName',leg3);
%
   h1=plot(index,fld_1,'b--o','DisplayName',leg1);
   h2=plot(index,fld_2,'r--o','DisplayName',leg2);
   h3=plot(index,fld_3,'g--o','DisplayName',leg3);
%
   set(h1,'LineWidth',2.3);
   set(h2,'LineWidth',2.3);
   set(h3,'LineWidth',2.3);
   ylabel(ytitle1,'FontSize',16);
%
   yyaxis right
   set(gca,'YColor','k');
   s4=scatter(index,fld_4,siz,'o','fill','MarkerFaceColor','m','DisplayName',leg4);
   h4=plot(index,fld_4,'m--o','DisplayName',leg4);
   set(h4,'LineWidth',2.3);
%
   title(ptitle,'Fontsize',18,'FontWeight','bold');
   xlabel(xtitle,'FontSize',16);
   ylabel(ytitle2,'FontSize',16);
   hold off
   hleg1=legend([s1,s2,s3,s4]);
   set(hleg1,'Location','NorthWest','FontSize',10,'FontWeight','bold');
   print(gcf,'-dpsc2','-append',save_file);   
   rs=0;
end
%
