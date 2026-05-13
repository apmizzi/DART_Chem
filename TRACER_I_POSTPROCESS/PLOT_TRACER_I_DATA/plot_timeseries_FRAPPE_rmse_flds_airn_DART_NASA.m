function plot_timeseries_FRAPPE_rmse_flds_airn_DART_NASA
   clear all;
   fclose('all');
%
   mopitt_prs=[1000,900,800,700,600,500,400,300,200,100];
   mop_npr=10;
   missing=-99999;
   ntim=25;
   nx=179;
   ny=139;
   nz=36;
   num_mem=10;
   DATE_STR=2014071406;
   DATE_END=2014071606;
   DATE_END=2014072018;
   rc=system('rm -rf FRAPPE_PRIOR_MEAN_AIRNOW_TIMESERIES_NASA.eps');
   rc=system('rm -rf FRAPPE_PRIOR_RMSE_AIRNOW_TIMESERIES_NASA.eps');
   rc=system('rm -rf FRAPPE_PRIOR_BIAS_AIRNOW_TIMESERIES_NASA.eps');
%
% CHEM DA
   path_data_control='/nobackupp11/amizzi/OUTPUT_DATA/real_FRAPPE_CONTROL_NASA/';
   path_data_allchem='/nobackupp11/amizzi/OUTPUT_DATA/real_FRAPPE_ALLCHEM_RELAX_NASA/';
   path_data_emisadj='/nobackupp11/amizzi/OUTPUT_DATA/real_FRAPPE_ALLCHEM_EMISS_ADJ_NASA/';
%
% set colormap
   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
%
% now decide on the colormap
   cmap=desired_colors;
%
   DATE_INC=6;
   DATE=DATE_STR;
%
   itim=0;
   control_co_mn_ob=zeros(ntim);
   control_co_mn_pr=zeros(ntim);
   control_co_sd_pr=zeros(ntim);
   control_co_mn_po=zeros(ntim);
   control_co_sd_po=zeros(ntim);
   control_co_bias_pr=zeros(ntim);
   control_co_bias_po=zeros(ntim);
   control_co_rmse_pr=zeros(ntim);
   control_co_rmse_po=zeros(ntim);
%
   control_o3_mn_ob=zeros(ntim);
   control_o3_mn_pr=zeros(ntim);
   control_o3_sd_pr=zeros(ntim);
   control_o3_mn_po=zeros(ntim);
   control_o3_sd_po=zeros(ntim);
   control_o3_bias_pr=zeros(ntim);
   control_o3_bias_po=zeros(ntim);
   control_o3_rmse_pr=zeros(ntim);
   control_o3_rmse_po=zeros(ntim);
%
   control_no2_mn_ob=zeros(ntim);
   control_no2_mn_pr=zeros(ntim);
   control_no2_sd_pr=zeros(ntim);
   control_no2_mn_po=zeros(ntim);
   control_no2_sd_po=zeros(ntim);
   control_no2_bias_pr=zeros(ntim);
   control_no2_bias_po=zeros(ntim);
   control_no2_rmse_pr=zeros(ntim);
   control_no2_rmse_po=zeros(ntim);
%
   control_so2_mn_ob=zeros(ntim);
   control_so2_mn_pr=zeros(ntim);
   control_so2_sd_pr=zeros(ntim);
   control_so2_mn_po=zeros(ntim);
   control_so2_sd_po=zeros(ntim);
   control_so2_bias_pr=zeros(ntim);
   control_so2_bias_po=zeros(ntim);
   control_so2_rmse_pr=zeros(ntim);
   control_so2_rmse_po=zeros(ntim);
%
   control_pm10_mn_ob=zeros(ntim);
   control_pm10_mn_pr=zeros(ntim);
   control_pm10_sd_pr=zeros(ntim);
   control_pm10_mn_po=zeros(ntim);
   control_pm10_sd_po=zeros(ntim);
   control_pm10_bias_pr=zeros(ntim);
   control_pm10_bias_po=zeros(ntim);
   control_pm10_rmse_pr=zeros(ntim);
   control_pm10_rmse_po=zeros(ntim);
%
   control_pm25_mn_ob=zeros(ntim);
   control_pm25_mn_pr=zeros(ntim);
   control_pm25_sd_pr=zeros(ntim);
   control_pm25_mn_po=zeros(ntim);
   control_pm25_sd_po=zeros(ntim);
   control_pm25_bias_pr=zeros(ntim);
   control_pm25_bias_po=zeros(ntim);
   control_pm25_rmse_pr=zeros(ntim);
   control_pm25_rmse_po=zeros(ntim);
%
   allchem_co_mn_ob=zeros(ntim);
   allchem_co_mn_pr=zeros(ntim);
   allchem_co_sd_pr=zeros(ntim);
   allchem_co_mn_po=zeros(ntim);
   allchem_co_sd_po=zeros(ntim);
   allchem_co_bias_pr=zeros(ntim);
   allchem_co_bias_po=zeros(ntim);
   allchem_co_rmse_pr=zeros(ntim);
   allchem_co_rmse_po=zeros(ntim);
%
   allchem_o3_mn_ob=zeros(ntim);
   allchem_o3_mn_pr=zeros(ntim);
   allchem_o3_sd_pr=zeros(ntim);
   allchem_o3_mn_po=zeros(ntim);
   allchem_o3_sd_po=zeros(ntim);
   allchem_o3_bias_pr=zeros(ntim);
   allchem_o3_bias_po=zeros(ntim);
   allchem_o3_rmse_pr=zeros(ntim);
   allchem_o3_rmse_po=zeros(ntim);
%
   allchem_no2_mn_ob=zeros(ntim);
   allchem_no2_mn_pr=zeros(ntim);
   allchem_no2_sd_pr=zeros(ntim);
   allchem_no2_mn_po=zeros(ntim);
   allchem_no2_sd_po=zeros(ntim);
   allchem_no2_bias_pr=zeros(ntim);
   allchem_no2_bias_po=zeros(ntim);
   allchem_no2_rmse_pr=zeros(ntim);
   allchem_no2_rmse_po=zeros(ntim);
%
   allchem_so2_mn_ob=zeros(ntim);
   allchem_so2_mn_pr=zeros(ntim);
   allchem_so2_sd_pr=zeros(ntim);
   allchem_so2_mn_po=zeros(ntim);
   allchem_so2_sd_po=zeros(ntim);
   allchem_so2_bias_pr=zeros(ntim);
   allchem_so2_bias_po=zeros(ntim);
   allchem_so2_rmse_pr=zeros(ntim);
   allchem_so2_rmse_po=zeros(ntim);
%
   allchem_pm10_mn_ob=zeros(ntim);
   allchem_pm10_mn_pr=zeros(ntim);
   allchem_pm10_sd_pr=zeros(ntim);
   allchem_pm10_mn_po=zeros(ntim);
   allchem_pm10_sd_po=zeros(ntim);
   allchem_pm10_bias_pr=zeros(ntim);
   allchem_pm10_bias_po=zeros(ntim);
   allchem_pm10_rmse_pr=zeros(ntim);
   allchem_pm10_rmse_po=zeros(ntim);
%
   allchem_pm25_mn_ob=zeros(ntim);
   allchem_pm25_mn_pr=zeros(ntim);
   allchem_pm25_sd_pr=zeros(ntim);
   allchem_pm25_mn_po=zeros(ntim);
   allchem_pm25_sd_po=zeros(ntim);
   allchem_pm25_bias_pr=zeros(ntim);
   allchem_pm25_bias_po=zeros(ntim);
   allchem_pm25_rmse_pr=zeros(ntim);
   allchem_pm25_rmse_po=zeros(ntim);
%
   emisadj_co_mn_ob=zeros(ntim);
   emisadj_co_mn_pr=zeros(ntim);
   emisadj_co_sd_pr=zeros(ntim);
   emisadj_co_mn_po=zeros(ntim);
   emisadj_co_sd_po=zeros(ntim);
   emisadj_co_bias_pr=zeros(ntim);
   emisadj_co_bias_po=zeros(ntim);
   emisadj_co_rmse_pr=zeros(ntim);
   emisadj_co_rmse_po=zeros(ntim);
%
   emisadj_o3_mn_ob=zeros(ntim);
   emisadj_o3_mn_pr=zeros(ntim);
   emisadj_o3_sd_pr=zeros(ntim);
   emisadj_o3_mn_po=zeros(ntim);
   emisadj_o3_sd_po=zeros(ntim);
   emisadj_o3_bias_pr=zeros(ntim);
   emisadj_o3_bias_po=zeros(ntim);
   emisadj_o3_rmse_pr=zeros(ntim);
   emisadj_o3_rmse_po=zeros(ntim);
%
   emisadj_no2_mn_ob=zeros(ntim);
   emisadj_no2_mn_pr=zeros(ntim);
   emisadj_no2_sd_pr=zeros(ntim);
   emisadj_no2_mn_po=zeros(ntim);
   emisadj_no2_sd_po=zeros(ntim);
   emisadj_no2_bias_pr=zeros(ntim);
   emisadj_no2_bias_po=zeros(ntim);
   emisadj_no2_rmse_pr=zeros(ntim);
   emisadj_no2_rmse_po=zeros(ntim);
%
   emisadj_so2_mn_ob=zeros(ntim);
   emisadj_so2_mn_pr=zeros(ntim);
   emisadj_so2_sd_pr=zeros(ntim);
   emisadj_so2_mn_po=zeros(ntim);
   emisadj_so2_sd_po=zeros(ntim);
   emisadj_so2_bias_pr=zeros(ntim);
   emisadj_so2_bias_po=zeros(ntim);
   emisadj_so2_rmse_pr=zeros(ntim);
   emisadj_so2_rmse_po=zeros(ntim);
%
   emisadj_pm10_mn_ob=zeros(ntim);
   emisadj_pm10_mn_pr=zeros(ntim);
   emisadj_pm10_sd_pr=zeros(ntim);
   emisadj_pm10_mn_po=zeros(ntim);
   emisadj_pm10_sd_po=zeros(ntim);
   emisadj_pm10_bias_pr=zeros(ntim);
   emisadj_pm10_bias_po=zeros(ntim);
   emisadj_pm10_rmse_pr=zeros(ntim);
   emisadj_pm10_rmse_po=zeros(ntim);
%
   emisadj_pm25_mn_ob=zeros(ntim);
   emisadj_pm25_mn_pr=zeros(ntim);
   emisadj_pm25_sd_pr=zeros(ntim);
   emisadj_pm25_mn_po=zeros(ntim);
   emisadj_pm25_sd_po=zeros(ntim);
   emisadj_pm25_bias_pr=zeros(ntim);
   emisadj_pm25_bias_po=zeros(ntim);
   emisadj_pm25_rmse_pr=zeros(ntim);
   emisadj_pm25_rmse_po=zeros(ntim);
%
   while (DATE <= DATE_END)
      itim=itim+1;
      DATE_FILE=DATE;
      date_chr=int2str(DATE_FILE);
      file_date=strcat(date_chr(1:4),'-',date_chr(5:6),'-', ...
      date_chr(7:8),'_',date_chr(9:10),':00:00');
%
      control_dart=strcat(path_data_control,strcat(date_chr,'/dart_filter/obs_seq.final'));
      allchem_dart=strcat(path_data_allchem,strcat(date_chr,'/dart_filter/obs_seq.final'));
      emisadj_dart=strcat(path_data_emisadj,strcat(date_chr,'/dart_filter/obs_seq.final'));
      control_dart
      fid_control=fopen(control_dart);
%
% GET OBSERVATIONS - CONTROL
      clear obs_co_val obs_co_prior_mean obs_co_post_mean obs_co_prior_sprd obs_co_post_sprd;
      clear obs_o3_val obs_o3_prior_mean obs_o3_post_mean obs_o3_prior_sprd obs_o3_post_sprd;
      clear obs_no2_val obs_no2_prior_mean obs_no2_post_mean obs_no2_prior_sprd obs_no2_post_sprd;
      clear obs_so2_val obs_so2_prior_mean obs_so2_post_mean obs_so2_prior_sprd obs_so2_post_sprd;
      clear obs_pm10_val obs_pm10_prior_mean obs_pm10_post_mean obs_pm10_prior_sprd obs_pm10_post_sprd;
      clear obs_pm25_val obs_pm25_prior_mean obs_pm25_post_mean obs_pm25_prior_sprd obs_pm25_post_sprd;
      clear obs_x obs_y obs_z obs_qc obs_npr obs_npr_mdl obs_psfc obs_prior obs_avk;
      clear obs_swt obs_prs obs_hgt nobs_co nobs_o3 nobs_no2 nobs_so2 nobs_pm10 nobs_pm25;
      clear ncnt obsx obsy obsxval;
      [obs_co_val,obs_co_prior_mean,obs_co_post_mean,obs_co_prior_sprd,obs_co_post_sprd, ...
      obs_o3_val,obs_o3_prior_mean,obs_o3_post_mean,obs_o3_prior_sprd,obs_o3_post_sprd, ...
      obs_no2_val,obs_no2_prior_mean,obs_no2_post_mean,obs_no2_prior_sprd,obs_no2_post_sprd, ...
      obs_so2_val,obs_so2_prior_mean,obs_so2_post_mean,obs_so2_prior_sprd,obs_so2_post_sprd, ...
      obs_pm10_val,obs_pm10_prior_mean,obs_pm10_post_mean,obs_pm10_prior_sprd,obs_pm10_post_sprd, ...
      obs_pm25_val,obs_pm25_prior_mean,obs_pm25_post_mean,obs_pm25_prior_sprd,obs_pm25_post_sprd, ...
      nobs_co,nobs_o3,nobs_no2,nobs_so2,nobs_pm10,nobs_pm25]=read_obs_seq(fid_control,'AIRNOW',num_mem);
      fclose(fid_control);
%      fprintf('no2 obs %d prior %d post %d \n',obs_no2_val(1),obs_no2_prior_mean(1),obs_no2_post_mean(1))
%      fprintf('no2 obs %d prior %d post %d \n',obs_no2_val(nobs_no2/2),obs_no2_prior_mean(nobs_no2/2),obs_no2_post_mean(nobs_no2/2))
%      fprintf('no2 obs %d prior %d post %d \n',obs_no2_val(nobs_no2),obs_no2_prior_mean(nobs_no2),obs_no2_post_mean(nobs_no2))
%
% SKILL METRICS - CONTROL
      [control_co_mn_ob(itim),control_co_mn_pr(itim), ...
      control_co_sd_pr(itim),control_co_mn_po(itim), ...
      control_co_sd_po(itim),control_co_bias_pr(itim), ...
      control_co_bias_po(itim),control_co_rmse_pr(itim), ...
      control_co_rmse_po(itim)]= ...
      skill_metrics(nobs_co,obs_co_val,obs_co_prior_mean,obs_co_prior_sprd,obs_co_post_mean, ...
      obs_co_post_sprd);
%	
      [control_o3_mn_ob(itim),control_o3_mn_pr(itim), ...
      control_o3_sd_pr(itim),control_o3_mn_po(itim), ...
      control_o3_sd_po(itim),control_o3_bias_pr(itim), ...
      control_o3_bias_po(itim),control_o3_rmse_pr(itim), ...
      control_o3_rmse_po(itim)]= ...
      skill_metrics(nobs_o3,obs_o3_val,obs_o3_prior_mean,obs_o3_prior_sprd,obs_o3_post_mean, ...
      obs_o3_post_sprd);
%
      [control_no2_mn_ob(itim),control_no2_mn_pr(itim), ...
      control_no2_sd_pr(itim),control_no2_mn_po(itim), ...
      control_no2_sd_po(itim),control_no2_bias_pr(itim), ...
      control_no2_bias_po(itim),control_no2_rmse_pr(itim), ...
      control_no2_rmse_po(itim)]= ...
      skill_metrics(nobs_no2,obs_no2_val,obs_no2_prior_mean,obs_no2_prior_sprd,obs_no2_post_mean, ...
      obs_no2_post_sprd);
      fprintf('itim %d no2_mn_ob %d no2_mn_pr %d no2_mn_po %d \n', ...
      itim,control_no2_mn_ob(itim),control_no2_mn_pr(itim),control_no2_mn_po(itim))
%
      [control_so2_mn_ob(itim),control_so2_mn_pr(itim), ...
      control_so2_sd_pr(itim),control_so2_mn_po(itim), ...
      control_so2_sd_po(itim),control_so2_bias_pr(itim), ...
      control_so2_bias_po(itim),control_so2_rmse_pr(itim), ...
      control_so2_rmse_po(itim)]= ...
      skill_metrics(nobs_so2,obs_so2_val,obs_so2_prior_mean,obs_so2_prior_sprd,obs_so2_post_mean, ...
      obs_so2_post_sprd);
%
      [control_pm10_mn_ob(itim),control_pm10_mn_pr(itim), ...
      control_pm10_sd_pr(itim),control_pm10_mn_po(itim), ...
      control_pm10_sd_po(itim),control_pm10_bias_pr(itim), ...
      control_pm10_bias_po(itim),control_pm10_rmse_pr(itim), ...
      control_pm10_rmse_po(itim)]= ...
      skill_metrics(nobs_pm10,obs_pm10_val,obs_pm10_prior_mean,obs_pm10_prior_sprd,obs_pm10_post_mean, ...
      obs_pm10_post_sprd);
%
      [control_pm25_mn_ob(itim),control_pm25_mn_pr(itim), ...
      control_pm25_sd_pr(itim),control_pm25_mn_po(itim), ...
      control_pm25_sd_po(itim),control_pm25_bias_pr(itim), ...
      control_pm25_bias_po(itim),control_pm25_rmse_pr(itim), ...
      control_pm25_rmse_po(itim)]= ...
      skill_metrics(nobs_pm25,obs_pm25_val,obs_pm25_prior_mean,obs_pm25_prior_sprd,obs_pm25_post_mean, ...
      obs_pm25_post_sprd);
%
%      fprintf('co_mn_ob %d %d %d \n',control_co_mn_ob(itim), ...
%      control_co_mn_ob(itim),control_co_mn_ob(itim)) 
%      fprintf('co_mn_pr %d %d %d \n',control_co_mn_pr(itim), ...
%      control_co_mn_pr(itim),control_co_mn_pr(itim)) 
%      fprintf('co_mn_po %d %d %d \n',control_co_mn_po(itim), ...
%      control_co_mn_po(itim),control_co_mn_po(itim)) 
%      fprintf('co_bias_pr %d %d %d \n',control_co_bias_pr(itim), ...
%      control_co_bias_pr(itim),control_co_bias_pr(itim)) 
%      fprintf('co_bias_po %d %d %d \n',control_co_bias_po(itim), ...
%      control_co_bias_po(itim),control_co_bias_po(itim)) 
%      fprintf('co_rmse_pr %d %d %d \n',control_co_rmse_pr(itim), ...
%      control_co_rmse_pr(itim),control_co_rmse_pr(itim)) 
%      fprintf('co_rmse_po %d %d %d \n',control_co_rmse_po(itim), ...
%      control_co_rmse_po(itim),control_co_rmse_po(itim))
%
% GET OBSERVATIONS - ALLCHEM
      clear obs_co_val obs_co_prior_mean obs_co_post_mean obs_co_prior_sprd obs_co_post_sprd;
      clear obs_o3_val obs_o3_prior_mean obs_o3_post_mean obs_o3_prior_sprd obs_o3_post_sprd;
      clear obs_no2_val obs_no2_prior_mean obs_no2_post_mean obs_no2_prior_sprd obs_no2_post_sprd;
      clear obs_so2_val obs_so2_prior_mean obs_so2_post_mean obs_so2_prior_sprd obs_so2_post_sprd;
      clear obs_pm10_val obs_pm10_prior_mean obs_pm10_post_mean obs_pm10_prior_sprd obs_pm10_post_sprd;
      clear obs_pm25_val obs_pm25_prior_mean obs_pm25_post_mean obs_pm25_prior_sprd obs_pm25_post_sprd;
      clear obs_x obs_y obs_z obs_qc obs_npr obs_npr_mdl obs_psfc obs_prior obs_avk;
      clear obs_swt obs_prs obs_hgt nobs_co nobs_o3 nobs_no2 nobs_so2 nobs_pm10 nobs_pm25;
      clear ncnt obsx obsy obsxval;
      allchem_dart
      fid_allchem=fopen(allchem_dart);
      [obs_co_val,obs_co_prior_mean,obs_co_post_mean,obs_co_prior_sprd,obs_co_post_sprd, ...
      obs_o3_val,obs_o3_prior_mean,obs_o3_post_mean,obs_o3_prior_sprd,obs_o3_post_sprd, ...
      obs_no2_val,obs_no2_prior_mean,obs_no2_post_mean,obs_no2_prior_sprd,obs_no2_post_sprd, ...
      obs_so2_val,obs_so2_prior_mean,obs_so2_post_mean,obs_so2_prior_sprd,obs_so2_post_sprd, ...
      obs_pm10_val,obs_pm10_prior_mean,obs_pm10_post_mean,obs_pm10_prior_sprd,obs_pm10_post_sprd, ...
      obs_pm25_val,obs_pm25_prior_mean,obs_pm25_post_mean,obs_pm25_prior_sprd,obs_pm25_post_sprd, ...
      nobs_co,nobs_o3,nobs_no2,nobs_so2,nobs_pm10,nobs_pm25]=read_obs_seq(fid_allchem,'AIRNOW',num_mem);
      fclose(fid_allchem);
%
% SKILL METRICS - ALLCHEM
      [allchem_co_mn_ob(itim),allchem_co_mn_pr(itim), ...
      allchem_co_sd_pr(itim),allchem_co_mn_po(itim), ...
      allchem_co_sd_po(itim),allchem_co_bias_pr(itim), ...
      allchem_co_bias_po(itim),allchem_co_rmse_pr(itim), ...
      allchem_co_rmse_po(itim)]= ...
      skill_metrics(nobs_co,obs_co_val,obs_co_prior_mean,obs_co_prior_sprd,obs_co_post_mean, ...
      obs_co_post_sprd);
%	
      [allchem_o3_mn_ob(itim),allchem_o3_mn_pr(itim), ...
      allchem_o3_sd_pr(itim),allchem_o3_mn_po(itim), ...
      allchem_o3_sd_po(itim),allchem_o3_bias_pr(itim), ...
      allchem_o3_bias_po(itim),allchem_o3_rmse_pr(itim), ...
      allchem_o3_rmse_po(itim)]= ...
      skill_metrics(nobs_o3,obs_o3_val,obs_o3_prior_mean,obs_o3_prior_sprd,obs_o3_post_mean, ...
      obs_o3_post_sprd);
%
      [allchem_no2_mn_ob(itim),allchem_no2_mn_pr(itim), ...
      allchem_no2_sd_pr(itim),allchem_no2_mn_po(itim), ...
      allchem_no2_sd_po(itim),allchem_no2_bias_pr(itim), ...
      allchem_no2_bias_po(itim),allchem_no2_rmse_pr(itim), ...
      allchem_no2_rmse_po(itim)]= ...
      skill_metrics(nobs_no2,obs_no2_val,obs_no2_prior_mean,obs_no2_prior_sprd,obs_no2_post_mean, ...
      obs_no2_post_sprd);
      fprintf('itim %d no2_mn_ob %d no2_mn_pr %d no2_mn_po %d \n', ...
      itim,allchem_no2_mn_ob(itim),allchem_no2_mn_pr(itim),allchem_no2_mn_po(itim))
%
      [allchem_so2_mn_ob(itim),allchem_so2_mn_pr(itim), ...
      allchem_so2_sd_pr(itim),allchem_so2_mn_po(itim), ...
      allchem_so2_sd_po(itim),allchem_so2_bias_pr(itim), ...
      allchem_so2_bias_po(itim),allchem_so2_rmse_pr(itim), ...
      allchem_so2_rmse_po(itim)]= ...
      skill_metrics(nobs_so2,obs_so2_val,obs_so2_prior_mean,obs_so2_prior_sprd,obs_so2_post_mean, ...
      obs_so2_post_sprd);
%
      [allchem_pm10_mn_ob(itim),allchem_pm10_mn_pr(itim), ...
      allchem_pm10_sd_pr(itim),allchem_pm10_mn_po(itim), ...
      allchem_pm10_sd_po(itim),allchem_pm10_bias_pr(itim), ...
      allchem_pm10_bias_po(itim),allchem_pm10_rmse_pr(itim), ...
      allchem_pm10_rmse_po(itim)]= ...
      skill_metrics(nobs_pm10,obs_pm10_val,obs_pm10_prior_mean,obs_pm10_prior_sprd,obs_pm10_post_mean, ...
      obs_pm10_post_sprd);
%
      [allchem_pm25_mn_ob(itim),allchem_pm25_mn_pr(itim), ...
      allchem_pm25_sd_pr(itim),allchem_pm25_mn_po(itim), ...
      allchem_pm25_sd_po(itim),allchem_pm25_bias_pr(itim), ...
      allchem_pm25_bias_po(itim),allchem_pm25_rmse_pr(itim), ...
      allchem_pm25_rmse_po(itim)]= ...
      skill_metrics(nobs_pm25,obs_pm25_val,obs_pm25_prior_mean,obs_pm25_prior_sprd,obs_pm25_post_mean, ...
      obs_pm25_post_sprd);
%
% GET OBSERVATIONS - EMISADJ
      clear obs_co_val obs_co_prior_mean obs_co_post_mean obs_co_prior_sprd obs_co_post_sprd;
      clear obs_o3_val obs_o3_prior_mean obs_o3_post_mean obs_o3_prior_sprd obs_o3_post_sprd;
      clear obs_no2_val obs_no2_prior_mean obs_no2_post_mean obs_no2_prior_sprd obs_no2_post_sprd;
      clear obs_so2_val obs_so2_prior_mean obs_so2_post_mean obs_so2_prior_sprd obs_so2_post_sprd;
      clear obs_pm10_val obs_pm10_prior_mean obs_pm10_post_mean obs_pm10_prior_sprd obs_pm10_post_sprd;
      clear obs_pm25_val obs_pm25_prior_mean obs_pm25_post_mean obs_pm25_prior_sprd obs_pm25_post_sprd;
      clear obs_x obs_y obs_z obs_qc obs_npr obs_npr_mdl obs_psfc obs_prior obs_avk;
      clear obs_swt obs_prs obs_hgt nobs_co nobs_o3 nobs_no2 nobs_so2 nobs_pm10 nobs_pm25;
      clear ncnt obsx obsy obsxval;
      emisadj_dart
      fid_emisadj=fopen(emisadj_dart);
      [obs_co_val,obs_co_prior_mean,obs_co_post_mean,obs_co_prior_sprd,obs_co_post_sprd, ...
      obs_o3_val,obs_o3_prior_mean,obs_o3_post_mean,obs_o3_prior_sprd,obs_o3_post_sprd, ...
      obs_no2_val,obs_no2_prior_mean,obs_no2_post_mean,obs_no2_prior_sprd,obs_no2_post_sprd, ...
      obs_so2_val,obs_so2_prior_mean,obs_so2_post_mean,obs_so2_prior_sprd,obs_so2_post_sprd, ...
      obs_pm10_val,obs_pm10_prior_mean,obs_pm10_post_mean,obs_pm10_prior_sprd,obs_pm10_post_sprd, ...
      obs_pm25_val,obs_pm25_prior_mean,obs_pm25_post_mean,obs_pm25_prior_sprd,obs_pm25_post_sprd, ...
      nobs_co,nobs_o3,nobs_no2,nobs_so2,nobs_pm10,nobs_pm25]=read_obs_seq(fid_emisadj,'AIRNOW',num_mem);
%
% SKILL METRICS - EMISADJ
      [emisadj_co_mn_ob(itim),emisadj_co_mn_pr(itim), ...
      emisadj_co_sd_pr(itim),emisadj_co_mn_po(itim), ...
      emisadj_co_sd_po(itim),emisadj_co_bias_pr(itim), ...
      emisadj_co_bias_po(itim),emisadj_co_rmse_pr(itim), ...
      emisadj_co_rmse_po(itim)]= ...
      skill_metrics(nobs_co,obs_co_val,obs_co_prior_mean,obs_co_prior_sprd,obs_co_post_mean, ...
      obs_co_post_sprd);
%	
      [emisadj_o3_mn_ob(itim),emisadj_o3_mn_pr(itim), ...
      emisadj_o3_sd_pr(itim),emisadj_o3_mn_po(itim), ...
      emisadj_o3_sd_po(itim),emisadj_o3_bias_pr(itim), ...
      emisadj_o3_bias_po(itim),emisadj_o3_rmse_pr(itim), ...
      emisadj_o3_rmse_po(itim)]= ...
      skill_metrics(nobs_o3,obs_o3_val,obs_o3_prior_mean,obs_o3_prior_sprd,obs_o3_post_mean, ...
      obs_o3_post_sprd);
%
      [emisadj_no2_mn_ob(itim),emisadj_no2_mn_pr(itim), ...
      emisadj_no2_sd_pr(itim),emisadj_no2_mn_po(itim), ...
      emisadj_no2_sd_po(itim),emisadj_no2_bias_pr(itim), ...
      emisadj_no2_bias_po(itim),emisadj_no2_rmse_pr(itim), ...
      emisadj_no2_rmse_po(itim)]= ...
      skill_metrics(nobs_no2,obs_no2_val,obs_no2_prior_mean,obs_no2_prior_sprd,obs_no2_post_mean, ...
      obs_no2_post_sprd);
      fprintf('itim %d no2_mn_ob %d no2_mn_pr %d no2_mn_po %d \n', ...
      itim,emisadj_no2_mn_ob(itim),emisadj_no2_mn_pr(itim),emisadj_no2_mn_po(itim))
%
      [emisadj_so2_mn_ob(itim),emisadj_so2_mn_pr(itim), ...
      emisadj_so2_sd_pr(itim),emisadj_so2_mn_po(itim), ...
      emisadj_so2_sd_po(itim),emisadj_so2_bias_pr(itim), ...
      emisadj_so2_bias_po(itim),emisadj_so2_rmse_pr(itim), ...
      emisadj_so2_rmse_po(itim)]= ...
      skill_metrics(nobs_so2,obs_so2_val,obs_so2_prior_mean,obs_so2_prior_sprd,obs_so2_post_mean, ...
      obs_so2_post_sprd);
%
      [emisadj_pm10_mn_ob(itim),emisadj_pm10_mn_pr(itim), ...
      emisadj_pm10_sd_pr(itim),emisadj_pm10_mn_po(itim), ...
      emisadj_pm10_sd_po(itim),emisadj_pm10_bias_pr(itim), ...
      emisadj_pm10_bias_po(itim),emisadj_pm10_rmse_pr(itim), ...
      emisadj_pm10_rmse_po(itim)]= ...
      skill_metrics(nobs_pm10,obs_pm10_val,obs_pm10_prior_mean,obs_pm10_prior_sprd,obs_pm10_post_mean, ...
      obs_pm10_post_sprd);
%
      [emisadj_pm25_mn_ob(itim),emisadj_pm25_mn_pr(itim), ...
      emisadj_pm25_sd_pr(itim),emisadj_pm25_mn_po(itim), ...
      emisadj_pm25_sd_po(itim),emisadj_pm25_bias_pr(itim), ...
      emisadj_pm25_bias_po(itim),emisadj_pm25_rmse_pr(itim), ...
      emisadj_pm25_rmse_po(itim)]= ...
      skill_metrics(nobs_pm25,obs_pm25_val,obs_pm25_prior_mean,obs_pm25_prior_sprd,obs_pm25_post_mean, ...
      obs_pm25_post_sprd);
%
      DATE=DATE+DATE_INC;
      if (mod(DATE,100) == 24)
         DATE=(int32(DATE)/int32(100)+1)*100;
      end
   end
   nntim=itim;
   for itim=1:nntim
      for ipr=1:mop_npr
         obs_co(itim,ipr)=(control_co_mn_ob(itim,ipr)+ ...   
         allchem_co_mn_ob(itim,ipr)+emisadj_co_mn_ob(itim,ipr))/3.;
         obs_o3(itim,ipr)=(control_o3_mn_ob(itim,ipr)+ ...   
         allchem_o3_mn_ob(itim,ipr)+emisadj_o3_mn_ob(itim,ipr))/3.;
         obs_no2(itim,ipr)=(control_no2_mn_ob(itim,ipr)+ ...   
         allchem_no2_mn_ob(itim,ipr)+emisadj_no2_mn_ob(itim,ipr))/3.;
         obs_so2(itim,ipr)=(control_so2_mn_ob(itim,ipr)+ ...   
         allchem_so2_mn_ob(itim,ipr)+emisadj_so2_mn_ob(itim,ipr))/3.;
         obs_pm10(itim,ipr)=(control_pm10_mn_ob(itim,ipr)+ ...   
         allchem_pm10_mn_ob(itim,ipr)+emisadj_pm10_mn_ob(itim,ipr))/3.;
         obs_pm25(itim,ipr)=(control_pm25_mn_ob(itim,ipr)+ ...   
         allchem_pm25_mn_ob(itim,ipr)+emisadj_pm25_mn_ob(itim,ipr))/3.;
      end
   end
%
% PLOT TIMESERIES OF PRIOR RMSE
% CO
%   control_co_mn_pr(1:nntim)
%   allchem_co_mn_pr(1:nntim)
%   emisadj_co_mn_pr(1:nntim)
%
   iplt=1;
   if(iplt==1)
      ymn1=min(min(obs_co(1:nntim),control_co_mn_pr(1:nntim)));
      ymx1=max(max(obs_co(1:nntim),control_co_mn_pr(1:nntim)));
      ymn2=min(min(allchem_co_mn_pr(1:nntim),emisadj_co_mn_pr(1:nntim)));
      ymx2=max(max(allchem_co_mn_pr(1:nntim),emisadj_co_mn_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_4('Prior CO MEAN (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ','AIRNOW', ...
      'FRAPPE_PRIOR_MEAN_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_co_mn_pr(1:nntim),control_co_sd_pr(1:nntim), ...
      allchem_co_mn_pr(1:nntim),allchem_co_sd_pr(1:nntim), ...
      emisadj_co_mn_pr(1:nntim),emisadj_co_sd_pr(1:nntim), ...
      obs_co(1:nntim),errors);
%
      ymn1=min(control_co_rmse_pr(1:nntim));
      ymx1=max(control_co_rmse_pr(1:nntim));
      ymn2=min(min(allchem_co_rmse_pr(1:nntim),emisadj_co_rmse_pr(1:nntim)));
      ymx2=max(max(allchem_co_rmse_pr(1:nntim),emisadj_co_rmse_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior CO RMSE (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_RMSE_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_co_rmse_pr(1:nntim),allchem_co_rmse_pr(1:nntim),emisadj_co_rmse_pr(1:nntim));
%     
      ymn1=min(control_co_bias_pr(1:nntim));
      ymx1=max(control_co_bias_pr(1:nntim));
      ymn2=min(min(allchem_co_bias_pr(1:nntim),emisadj_co_bias_pr(1:nntim)));
      ymx2=max(max(allchem_co_bias_pr(1:nntim),emisadj_co_bias_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior CO BIAS (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_BIAS_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_co_bias_pr(1:nntim),allchem_co_bias_pr(1:nntim),emisadj_co_bias_pr(1:nntim));
   end
%
% O3
%   control_o3_mn_pr(1:nntim)
%   allchem_o3_mn_pr(1:nntim)
%   emisadj_o3_mn_pr(1:nntim)
%
   iplt=0;
   if(iplt==1)
      ymn1=min(min(obs_o3(1:nntim),control_o3_mn_pr(1:nntim)));
      ymx1=max(max(obs_o3(1:nntim),control_o3_mn_pr(1:nntim)));
      ymn2=min(min(allchem_o3_mn_pr(1:nntim),emisadj_o3_mn_pr(1:nntim)));
      ymx2=max(max(allchem_o3_mn_pr(1:nntim),emisadj_o3_mn_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_4('Prior O3 MEAN (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ','AIRNOW', ...
      'FRAPPE_PRIOR_MEAN_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_o3_mn_pr(1:nntim),control_o3_sd_pr(1:nntim), ...
      allchem_o3_mn_pr(1:nntim),allchem_o3_sd_pr(1:nntim), ...
      emisadj_o3_mn_pr(1:nntim),emisadj_o3_sd_pr(1:nntim), ...
      obs_o3(1:nntim),errors);
%
      ymn1=min(control_o3_rmse_pr(1:nntim));
      ymx1=max(control_o3_rmse_pr(1:nntim));
      ymn2=min(min(allchem_o3_rmse_pr(1:nntim),emisadj_o3_rmse_pr(1:nntim)));
      ymx2=max(max(allchem_o3_rmse_pr(1:nntim),emisadj_o3_rmse_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior O3 RMSE (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_RMSE_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_o3_rmse_pr(1:nntim),allchem_o3_rmse_pr(1:nntim),emisadj_o3_rmse_pr(1:nntim));
%     
      ymn1=min(control_o3_bias_pr(1:nntim));
      ymx1=max(control_o3_bias_pr(1:nntim));
      ymn2=min(min(allchem_o3_bias_pr(1:nntim),emisadj_o3_bias_pr(1:nntim)));
      ymx2=max(max(allchem_o3_bias_pr(1:nntim),emisadj_o3_bias_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior O3 BIAS (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_BIAS_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_o3_bias_pr(1:nntim),allchem_o3_bias_pr(1:nntim),emisadj_o3_bias_pr(1:nntim));
   end
%
% NO2
%   obs_no2(1:nntim)
%   control_no2_mn_pr(1:nntim)
%   allchem_no2_mn_pr(1:nntim)
%   emisadj_no2_mn_pr(1:nntim)
%
   iplt=1;
   if(iplt==1)
      ymn1=min(min(obs_no2(1:nntim),control_no2_mn_pr(1:nntim)));
      ymx1=max(max(obs_no2(1:nntim),control_no2_mn_pr(1:nntim)));
      ymn2=min(min(allchem_no2_mn_pr(1:nntim),emisadj_no2_mn_pr(1:nntim)));
      ymx2=max(max(allchem_no2_mn_pr(1:nntim),emisadj_no2_mn_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_4('Prior NO2 MEAN (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ','AIRNOW', ...
      'FRAPPE_PRIOR_MEAN_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_no2_mn_pr(1:nntim),control_no2_sd_pr(1:nntim), ...
      allchem_no2_mn_pr(1:nntim),allchem_no2_sd_pr(1:nntim), ...
      emisadj_no2_mn_pr(1:nntim),emisadj_no2_sd_pr(1:nntim), ...
      obs_no2(1:nntim),errors);
%
      ymn1=min(control_no2_rmse_pr(1:nntim));
      ymx1=max(control_no2_rmse_pr(1:nntim));
      ymn2=min(min(allchem_no2_rmse_pr(1:nntim),emisadj_no2_rmse_pr(1:nntim)));
      ymx2=max(max(allchem_no2_rmse_pr(1:nntim),emisadj_no2_rmse_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior NO2 RMSE (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_RMSE_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_no2_rmse_pr(1:nntim),allchem_no2_rmse_pr(1:nntim),emisadj_no2_rmse_pr(1:nntim));
%     
      ymn1=min(control_no2_bias_pr(1:nntim));
      ymx1=max(control_no2_bias_pr(1:nntim));
      ymn2=min(min(allchem_no2_bias_pr(1:nntim),emisadj_no2_bias_pr(1:nntim)));
      ymx2=max(max(allchem_no2_bias_pr(1:nntim),emisadj_no2_bias_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior NO2 BIAS (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_BIAS_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_no2_bias_pr(1:nntim),allchem_no2_bias_pr(1:nntim),emisadj_no2_bias_pr(1:nntim));
   end
%
% SO2
%   control_so2_mn_pr(1:nntim)
%   allchem_so2_mn_pr(1:nntim)
%   emisadj_so2_mn_pr(1:nntim)
%
    iplt=1;
    if(iplt==1)
      ymn1=min(min(obs_so2(1:nntim),control_so2_mn_pr(1:nntim)));
      ymx1=max(max(obs_so2(1:nntim),control_so2_mn_pr(1:nntim)));
      ymn2=min(min(allchem_so2_mn_pr(1:nntim),emisadj_so2_mn_pr(1:nntim)));
      ymx2=max(max(allchem_so2_mn_pr(1:nntim),emisadj_so2_mn_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_4('Prior SO2 MEAN (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ','AIRNOW', ...
      'FRAPPE_PRIOR_MEAN_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_so2_mn_pr(1:nntim),control_so2_sd_pr(1:nntim), ...
      allchem_so2_mn_pr(1:nntim),allchem_so2_sd_pr(1:nntim), ...
      emisadj_so2_mn_pr(1:nntim),emisadj_so2_sd_pr(1:nntim), ...
      obs_so2(1:nntim),errors);
%
      ymn1=min(control_so2_rmse_pr(1:nntim));
      ymx1=max(control_so2_rmse_pr(1:nntim));
      ymn2=min(min(allchem_so2_rmse_pr(1:nntim),emisadj_so2_rmse_pr(1:nntim)));
      ymx2=max(max(allchem_so2_rmse_pr(1:nntim),emisadj_so2_rmse_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior SO2 RMSE (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_RMSE_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_so2_rmse_pr(1:nntim),allchem_so2_rmse_pr(1:nntim),emisadj_so2_rmse_pr(1:nntim));
%     
      ymn1=min(control_so2_bias_pr(1:nntim));
      ymx1=max(control_so2_bias_pr(1:nntim));
      ymn2=min(min(allchem_so2_bias_pr(1:nntim),emisadj_so2_bias_pr(1:nntim)));
      ymx2=max(max(allchem_so2_bias_pr(1:nntim),emisadj_so2_bias_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior SO2 BIAS (AIRNOW) Time Series','Date','Mixing Ratio (ppb)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_BIAS_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_so2_bias_pr(1:nntim),allchem_so2_bias_pr(1:nntim),emisadj_so2_bias_pr(1:nntim));
   end
%
% PM10
%   control_pm10_mn_pr(1:nntim)
%   allchem_pm10_mn_pr(1:nntim)
%   emisadj_pm10_mn_pr(1:nntim)
%
   iplt=1;
   if(iplt==1)
      ymn1=min(min(obs_pm10(1:nntim),control_pm10_mn_pr(1:nntim)));
      ymx1=max(max(obs_pm10(1:nntim),control_pm10_mn_pr(1:nntim)));
      ymn2=min(min(allchem_pm10_mn_pr(1:nntim),emisadj_pm10_mn_pr(1:nntim)));
      ymx2=max(max(allchem_pm10_mn_pr(1:nntim),emisadj_pm10_mn_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_4('Prior PM10 MEAN (AIRNOW) Time Series','Date','Concentration (ug/m^3)', ...
      'CONTROL','ALLCHEM','EMISADJ','AIRNOW', ...
      'FRAPPE_PRIOR_MEAN_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_pm10_mn_pr(1:nntim),control_pm10_sd_pr(1:nntim), ...
      allchem_pm10_mn_pr(1:nntim),allchem_pm10_sd_pr(1:nntim), ...
      emisadj_pm10_mn_pr(1:nntim),emisadj_pm10_sd_pr(1:nntim), ...
      obs_pm10(1:nntim),errors);
%
      ymn1=min(control_pm10_rmse_pr(1:nntim));
      ymx1=max(control_pm10_rmse_pr(1:nntim));
      ymn2=min(min(allchem_pm10_rmse_pr(1:nntim),emisadj_pm10_rmse_pr(1:nntim)));
      ymx2=max(max(allchem_pm10_rmse_pr(1:nntim),emisadj_pm10_rmse_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior PM10 RMSE (AIRNOW) Time Series','Date','Concentration (ug/m^3)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_RMSE_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_pm10_rmse_pr(1:nntim),allchem_pm10_rmse_pr(1:nntim),emisadj_pm10_rmse_pr(1:nntim));
%     
      ymn1=min(control_pm10_bias_pr(1:nntim));
      ymx1=max(control_pm10_bias_pr(1:nntim));
      ymn2=min(min(allchem_pm10_bias_pr(1:nntim),emisadj_pm10_bias_pr(1:nntim)));
      ymx2=max(max(allchem_pm10_bias_pr(1:nntim),emisadj_pm10_bias_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior PM10 BIAS (AIRNOW) Time Series','Date','Concentration (ug/m^3)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_BIAS_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_pm10_bias_pr(1:nntim),allchem_pm10_bias_pr(1:nntim),emisadj_pm10_bias_pr(1:nntim));
   end
%
% PM25
%   control_pm25_mn_pr(1:nntim)
%   allchem_pm25_mn_pr(1:nntim)
%   emisadj_pm25_mn_pr(1:nntim)
%
   iplt=1;
   if(iplt==1)
      ymn1=min(min(obs_pm25(1:nntim),control_pm25_mn_pr(1:nntim)));
      ymx1=max(max(obs_pm25(1:nntim),control_pm25_mn_pr(1:nntim)));
      ymn2=min(min(allchem_pm25_mn_pr(1:nntim),emisadj_pm25_mn_pr(1:nntim)));
      ymx2=max(max(allchem_pm25_mn_pr(1:nntim),emisadj_pm25_mn_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_4('Prior PM25 MEAN (AIRNOW) Time Series','Date','Concentration (ug/m^3)', ...
      'CONTROL','ALLCHEM','EMISADJ','AIRNOW', ...
      'FRAPPE_PRIOR_MEAN_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_pm25_mn_pr(1:nntim),control_pm25_sd_pr(1:nntim), ...
      allchem_pm25_mn_pr(1:nntim),allchem_pm25_sd_pr(1:nntim), ...
      emisadj_pm25_mn_pr(1:nntim),emisadj_pm25_sd_pr(1:nntim), ...
      obs_pm25(1:nntim),errors);
%
      ymn1=min(control_pm25_rmse_pr(1:nntim));
      ymx1=max(control_pm25_rmse_pr(1:nntim));
      ymn2=min(min(allchem_pm25_rmse_pr(1:nntim),emisadj_pm25_rmse_pr(1:nntim)));
      ymx2=max(max(allchem_pm25_rmse_pr(1:nntim),emisadj_pm25_rmse_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior PM25 RMSE (AIRNOW) Time Series','Date','Concentration (ug/m^3)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_RMSE_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_pm25_rmse_pr(1:nntim),allchem_pm25_rmse_pr(1:nntim),emisadj_pm25_rmse_pr(1:nntim));
%     
      ymn1=min(control_pm25_bias_pr(1:nntim));
      ymx1=max(control_pm25_bias_pr(1:nntim));
      ymn2=min(min(allchem_pm25_bias_pr(1:nntim),emisadj_pm25_bias_pr(1:nntim)));
      ymx2=max(max(allchem_pm25_bias_pr(1:nntim),emisadj_pm25_bias_pr(1:nntim)));
      ymn=min(ymn1,ymn2);
      ymx=max(ymx1,ymx2);
      errors=0;
      rs = plot_series_3('Prior PM25 BIAS (AIRNOW) Time Series','Date','Concentration (ug/m^3)', ...
      'CONTROL','ALLCHEM','EMISADJ', ...
      'FRAPPE_PRIOR_BIAS_AIRNOW_TIMESERIES_NASA.eps',nntim,ymx,ymn, ...
      control_pm25_bias_pr(1:nntim),allchem_pm25_bias_pr(1:nntim),emisadj_pm25_bias_pr(1:nntim));
   end
end
%
function [fld_mn_ob,fld_mn_pr,fld_sd_pr,fld_mn_po,fld_sd_po, ...
fld_bias_pr,fld_bias_po,fld_rmse_pr,fld_rmse_po] = skill_metrics(nobs,obs_val, ...
obs_prior_mean,obs_prior_sprd,obs_post_mean,obs_post_sprd)
%
   cnt=0;
   if(nobs==0)
      fld_mn_ob=NaN;
      fld_mn_pr=NaN;
      fld_sd_pr=NaN;
      fld_mn_po=NaN;
      fld_sd_po=NaN;
      fld_bias_pr=NaN;
      fld_rmse_pr=NaN;
      fld_bias_po=NaN;
      fld_rmse_po=NaN;
   else
      fld_mn_ob=0.;
      fld_mn_pr=0.;
      fld_sd_pr=0.;
      fld_mn_po=0.;
      fld_sd_po=0.;
      fld_bias_pr=0.;
      fld_rmse_pr=0.;
      fld_bias_po=0.;
      fld_rmse_po=0.;
      for iobs=1:nobs
	 cnt=cnt+1;
%         fprintf('obs %d obs_pr %d obs_po %d \n',obs_val(iobs), ...
%	 obs_prior_mean(iobs),obs_post_mean(iobs))
%         fprintf('obs_sum %d obs_pr_sum %d obs_po_sum %d \n', ...
%	 fld_mn_ob,fld_mn_pr,fld_mn_po)
         fld_mn_ob=fld_mn_ob+obs_val(iobs);
         fld_mn_pr=fld_mn_pr+obs_prior_mean(iobs);
         fld_mn_po=fld_mn_po+obs_post_mean(iobs);
         fld_sd_pr=fld_sd_pr+obs_prior_sprd(iobs);
         fld_sd_po=fld_sd_po+obs_post_sprd(iobs);
         fld_bias_pr=fld_bias_pr+ ...
         (obs_prior_mean(iobs)-obs_val(iobs));
         fld_rmse_pr=fld_rmse_pr+ ...
         ((obs_prior_mean(iobs)-obs_val(iobs))^2.);
         fld_bias_po=fld_bias_po+ ...
         (obs_post_mean(iobs)-obs_val(iobs));
         fld_rmse_po=fld_rmse_po+ ...
         ((obs_post_mean(iobs)-obs_val(iobs))^2.);
      end
   end
   if(cnt~=0)
      fld_mn_ob=fld_mn_ob/cnt; 
      fld_mn_pr=fld_mn_pr/cnt;       
      fld_sd_pr=fld_sd_pr/cnt;       
      fld_mn_po=fld_mn_po/cnt;       
      fld_sd_po=fld_sd_po/cnt;       
      fld_bias_pr=fld_bias_pr/cnt;       
      fld_bias_po=fld_bias_po/cnt;       
      fld_rmse_pr=sqrt(fld_rmse_pr/cnt);
      fld_rmse_po=sqrt(fld_rmse_po/cnt);
   end
%   fprintf('fld_mn_ob %d cnt %d \n',ipr,fld_mn_ob,cnt)
%   fprintf('fld_mn_pr %d cnt %d \n',ipr,fld_mn_pr,cnt)
%   fprintf('fld_sd_pr %d cnt %d \n',ipr,fld_sd_pr,cnt)
%   fprintf('fld_mn_po %d cnt %d \n',ipr,fld_mn_po,cnt)
%   fprintf('fld_sd_po %d cnt %d \n',ipr,fld_sd_po,cnt)
%   fprintf('fld_bias_pr %d cnt %d \n',ipr,fld_bias_pr,cnt)
%   fprintf('fld_bias_po %d cnt %d \n',ipr,fld_bias_po,cnt)
%   fprintf('fld_rmse_pr %d cnt %d \n',ipr,fld_rmse_pr,cnt)
%   fprintf('fld_rmse_po %d cnt %d \n',ipr,fld_rmse_po,cnt)
end
%
function [rs] = plot_series_3(ptitle,xtitle,ytitle,leg1,leg2,leg3, ...
file_save,ntim,ymx,ymn,fld_1,fld_2,fld_3)
%
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',15, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','bold','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',2);
   box(axes1,'on');
   hold(axes1,'all');
   set(gca,'XTick',[0,4,8,12,16,20,24,28]);
   set(gca,'XTickLabel',{'7/14','7/15','7/16','7/17','7/18','7/19','7/20','7/21'});
%
   cr1=reshape(fld_1,1,ntim);
   cr2=reshape(fld_2,1,ntim);
   cr3=reshape(fld_3,1,ntim);
   h(1)=plot(index,cr1,'b--o');
   h(2)=plot(index,cr2,'r--o');
   h(3)=plot(index,cr3,'g--o');
%
   set(h(1),'LineWidth',2.3);
   set(h(2),'LineWidth',2.3);
   set(h(3),'LineWidth',2.3);
%
   scatter(index,cr1,siz,'o','fill','MarkerFaceColor','b');
   scatter(index,cr2,siz,'o','fill','MarkerFaceColor','r');
   scatter(index,cr3,siz,'o','fill','MarkerFaceColor','g');
%
   title(ptitle,'Fontsize',18,'FontWeight','bold');
   xlabel(xtitle,'FontSize',16);
   ylabel(ytitle,'FontSize',16);
   hleg=legend(leg1,leg2,leg3);
   set(hleg,'Location','NorthWest','FontSize',10,'FontWeight','bold');
%   saveas(figure1,file_save,'psc2');
   print(gcf,'-dpsc','-append',file_save);
   rs=0;
end
%
function [rs] = plot_series_4(ptitle,xtitle,ytitle,leg1,leg2,leg3,leg4, ...
file_save,ntim,ymx,ymn,fld_1,fld_1err,fld_2,fld_2err,fld_3,fld_3err,fld_4,errors)
%
   siz=50;
   nend=ntim-1;
   index=0:1:ntim-1;
   figure1=figure;
   axes1 = axes('Parent',figure1,'XMinorTick','on','YMinorTick','off','Fontsize',15, ...
   'PlotBoxAspectRatio',[1.618 1. 1.],'FontWeight','bold','XLim',[0. nend], ...
   'YLim',[ymn ymx],'LineWidth',2);
   box(axes1,'on');
   hold(axes1,'all');
   set(gca,'XTick',[0,4,8,12,16,20,24,28]);
   set(gca,'XTickLabel',{'7/14','7/15','7/16','7/17','7/18','7/19','7/20','7/21'});
%
   cr1=reshape(fld_1,1,ntim);
   cr2=reshape(fld_2,1,ntim);
   cr3=reshape(fld_3,1,ntim);
   cr4=reshape(fld_4,1,ntim);
   cr1_err=reshape(fld_1err,1,ntim);
   cr2_err=reshape(fld_2err,1,ntim);
   cr3_err=reshape(fld_3err,1,ntim);
   if(errors==0)
      h(1)=plot(index,cr1,'b--o');
      h(2)=plot(index,cr2,'r--o');
      h(3)=plot(index,cr3,'g--o');
      h(4)=plot(index,cr4,'k--o');
   elseif(errors==1)
      h(1)=errorbar(index,cr1,cr1_err,'vertical','b--o');
      h(2)=errorbar(index,cr2,cr2_err,'vertical','r--o');
      h(3)=errorbar(index,cr3,cr3_err,'vertical','g--o');
      h(4)=plot(index,cr4,'k--o');
   end	     
%
   set(h(1),'LineWidth',2.3);
   set(h(2),'LineWidth',2.3);
   set(h(3),'LineWidth',2.3);
   set(h(4),'LineWidth',2.3);
%
   scatter(index,cr1,siz,'o','fill','MarkerFaceColor','b');
   scatter(index,cr2,siz,'o','fill','MarkerFaceColor','r');
   scatter(index,cr3,siz,'o','fill','MarkerFaceColor','g');
   scatter(index,cr4,siz,'o','fill','MarkerFaceColor','k');
%
   title(ptitle,'Fontsize',18,'FontWeight','bold');
   xlabel(xtitle,'FontSize',16);
   ylabel(ytitle,'FontSize',16);
   hleg=legend(leg1,leg2,leg3,leg4);
   set(hleg,'Location','NorthWest','FontSize',10,'FontWeight','bold');
%   saveas(figure1,file_save,'psc2');
   print(gcf,'-dpsc','-append',file_save);
   rs=0;
end
%
function [obs_co_val,obs_co_prior_mean,obs_co_post_mean,obs_co_prior_sprd,obs_co_post_sprd, ...
   obs_o3_val,obs_o3_prior_mean,obs_o3_post_mean,obs_o3_prior_sprd,obs_o3_post_sprd, ...   
   obs_no2_val,obs_no2_prior_mean,obs_no2_post_mean,obs_no2_prior_sprd,obs_no2_post_sprd, ...   
   obs_so2_val,obs_so2_prior_mean,obs_so2_post_mean,obs_so2_prior_sprd,obs_so2_post_sprd, ...   
   obs_pm10_val,obs_pm10_prior_mean,obs_pm10_post_mean,obs_pm10_prior_sprd,obs_pm10_post_sprd, ...   
   obs_pm25_val,obs_pm25_prior_mean,obs_pm25_post_mean,obs_pm25_prior_sprd,obs_pm25_post_sprd, ...   
   nobs_co,nobs_o3,nobs_no2,nobs_so2,nobs_pm10,nobs_pm25]=read_obs_seq(fid,obs_name,num_mem);
%
% initialize variables
   missing=-888888;
   frewind(fid);
   icnt=0;
   icnt_co=0;
   icnt_o3=0;
   icnt_no2=0;
   icnt_so2=0;
   icnt_pm10=0;
   icnt_pm25=0;
   mopitt_dim=10;
   mopitt_prs_adj=zeros(mopitt_dim);
%
% clear obs variables
   clear obs_val;
   clear obs_prior_mean;
   clear obs_post_mean;
   clear obs_prior_sprd;
   clear obs_post_sprd;
   clear obs_x;
   clear obs_y;
   clear obs_z;
   clear obs_qc;
   clear obs_npr;
   clear obs_npr_mdl;
   clear obs_psfc;
   clear obs_prior;
   clear obs_avk;
   clear obs_swt;
   clear obs_prs;
   clear obs_hgt;
%
   clear obs_co_val;
   clear obs_co_prior_mean;
   clear obs_co_post_mean;
   clear obs_co_prior_sprd;
   clear obs_co_post_sprd;
%
   clear obs_o3_val;
   clear obs_o3_prior_mean;
   clear obs_o3_post_mean;
   clear obs_o3_prior_sprd;
   clear obs_o3_post_sprd;
%
   clear obs_no2_val;
   clear obs_no2_prior_mean;
   clear obs_no2_post_mean;
   clear obs_no2_prior_sprd;
   clear obs_no2_post_sprd;
%
   clear obs_so2_val;
   clear obs_so2_prior_mean;
   clear obs_so2_post_mean;
   clear obs_so2_prior_sprd;
   clear obs_so2_post_sprd;
%
   clear obs_pm10_val;
   clear obs_pm10_prior_mean;
   clear obs_pm10_post_mean;
   clear obs_pm10_prior_sprd;
   clear obs_pm10_post_sprd;
%
   clear obs_pm25_val;
   clear obs_pm25_prior_mean;
   clear obs_pm25_post_mean;
   clear obs_pm25_prior_sprd;
   clear obs_pm25_post_sprd;

% read file_type
   [file_type]=string(textscan(fid,'%s',1));
%
% read obs_kind definition
   [obs_kind_defn]=string(textscan(fid,'%s',1));
%
% read number of obs_kinds
   [nobs_kind]=cell2mat(textscan(fid,'%d',1));
%
% read the obs_kinds and the obs_kind_ids
   for irec=1:nobs_kind
      clear temp;
      [temp]=textscan(fid,'%d %s',1);
      obs_kind(irec)=temp{1};
      obs_kind_id(irec)=string(temp{2});
   end
%
% read num_copies and num_qc
   clear temp;
   [temp]=textscan(fid,'%s %d %s %d',1);
   chr_num_copies=string(temp{1});
   num_copies=temp{2};
   chr_num_qc=string(temp{3});
   num_qc=temp{4};
%
% read num_obs and max_num_obs
   clear temp;
   [temp]=textscan(fid,'%s %d %s %d',1);
   chr_num_obs=string(temp{1});
   num_obs=temp{2};
   chr_max_num_obs=string(temp{3});
   max_num_obs=temp{4};
%
% read num_copies meta data
   for irec=1:num_copies
      clear temp;
      [temp]=textscan(fid,'%s %s %s %d',1);
   end
   for irec=1:num_qc
      clear temp;
      [temp]=textscan(fid,'%s %s %s',1);
   end
%
% read first and last
   clear temp;
   [temp]=textscan(fid,'%s %d %s %d',1);
   chr_first_obs=string(temp{1});
   first_obs=temp{2};
   chr_last_obs=string(temp{3});
   last_obs=temp{4};
%   fprintf('first_obs %d last_obs %d \n',first_obs,last_obs)
%
% loop through obs and read data
   if (num_obs>max_num_obs) 
      fprintf('ERROR: max_num_obs not large enough %d %d \n',max_num_obs,num_obs)
      return
   end
%
   for irec=1:num_obs
      clear temp;
      [temp]=textscan(fid,'%s %d',1);
      chr_obs=string(temp{1});
      cnt_obs=temp{2};
%
% read data
      clear temp;
      [temp]=textscan(fid,'%f',1);
      obs_value=temp{1};
      [temp]=textscan(fid,'%f',1);
      prior_mean=temp{1};  
      [temp]=textscan(fid,'%f',1);
      post_mean=temp{1};  
      [temp]=textscan(fid,'%f',1);
      prior_sprd=temp{1};  
      [temp]=textscan(fid,'%f',1);
      post_sprd=temp{1};  
      for imem=1:num_mem
	 clear temp;
         [temp]=textscan(fid,'%f',1);
         prior_exp_ob=temp{1};  
         [temp]=textscan(fid,'%f',1);
         post_exp_ob=temp{1};  
      end
      clear temp;
      [temp]=textscan(fid,'%d',1);
      ncep_qc=temp{1};  
      [temp]=textscan(fid,'%d',1);
      dart_qc=temp{1};
%
% skip record
      clear temp;
      [temp]=textscan(fid,'%d %d %d',1);
%
% read chr_obdef
      clear temp;
      [temp]=textscan(fid,'%s',1);
      clear temp;
      temp=textscan(fid,'%s',1);
      chr_locxd=string(temp{1});
%
% select dimensionality
      if strcmp(chr_locxd,'loc2d')
         clear temp;
         [temp]=textscan(fid,'%f %f',1);
         x=temp{1};
         y=temp{2};
         z=-9999;
      elseif strcmp(chr_locxd,'loc3d')
         clear temp
         [temp]=textscan(fid,'%f %f %f %d',1);
         x=temp{1};
         y=temp{2};
         z=temp{3};
      else
         fprintf('APM ERROR: obs dimensionality is unrealistic \n')
         return
      end
%
% read chr_kind
      clear temp;
      [temp]=textscan(fid,'%s',1);
      clear temp;
      [temp]=textscan(fid,'%d',1);
      kind_id=temp{1};
      for irecc=1:nobs_kind
         if(kind_id==obs_kind(irecc))
	   iirec=irecc;
         end
      end
%
% find obs_kind
      if (strcmp(obs_kind_id(iirec),'RADIOSONDE_U_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'RADIOSONDE_V_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'RADIOSONDE_TEMPERATURE') | ...
         strcmp(obs_kind_id(iirec),'RADIOSONDE_SPECIFIC_HUMIDITY') | ...
         strcmp(obs_kind_id(iirec),'AIRCRAFT_U_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'AIRCRAFT_V_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'AIRCRAFT_TEMPERATURE') | ...
         strcmp(obs_kind_id(iirec),'MARINE_SFC_U_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'MARINE_SFC_V_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'MARINE_SFC_TEMPERATURE') | ...
         strcmp(obs_kind_id(iirec),'MARINE_SFC_SPECIFIC_HUMIDITY') | ...
         strcmp(obs_kind_id(iirec),'LAND_SFC_U_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'LAND_SFC_V_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'LAND_SFC_TEMPERATURE') | ...
         strcmp(obs_kind_id(iirec),'LAND_SFC_SPECIFIC_HUMIDITY') | ...
         strcmp(obs_kind_id(iirec),'SAT_U_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'SAT_V_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'RADIOSONDE_SURFACE_ALTIMETER') | ...
         strcmp(obs_kind_id(iirec),'MARINE_SFC_ALTIMETER') | ...
         strcmp(obs_kind_id(iirec),'LAND_SFC_ALTIMETER') | ...
         strcmp(obs_kind_id(iirec),'ACARS_U_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'ACARS_V_WIND_COMPONENT') | ...
         strcmp(obs_kind_id(iirec),'ACARS_TEMPERATURE') | ...
         strcmp(obs_kind_id(iirec),'AIRNOW_CO') | ...
         strcmp(obs_kind_id(iirec),'AIRNOW_O3') | ...
         strcmp(obs_kind_id(iirec),'AIRNOW_NO2') | ...
         strcmp(obs_kind_id(iirec),'AIRNOW_SO2') | ...
         strcmp(obs_kind_id(iirec),'AIRNOW_PM10') | ...
         strcmp(obs_kind_id(iirec),'AIRNOW_PM25') | ...
         strcmp(obs_kind_id(iirec),'MODIS_AOD_RETRIEVAL'))
%
% read time data 
         clear temp;
         [temp]=textscan(fid,'%d %d',1);
         obs_sec=temp{1};
         obs_day=temp{2};
%
% read obervation error variance 
         clear temp;
         [temp]=textscan(fid,'%f',1);
         err_var=temp{1};
%
% check whether to save these data
         if strcmp(obs_kind_id(iirec),strcat(obs_name,'_CO'))
	    if(prior_mean~=missing & post_mean~=missing & ...
	    prior_sprd~=missing & post_sprd~=missing)
               icnt_co=icnt_co+1;
               obs_co_val(icnt_co)=obs_value;
               obs_co_prior_mean(icnt_co)=prior_mean;
               obs_co_post_mean(icnt_co)=post_mean;
               obs_co_prior_sprd(icnt_co)=prior_sprd;
               obs_co_post_sprd(icnt_co)=post_sprd;
               obs_x(icnt_co)=x;
               obs_y(icnt_co)=y;
               obs_z(icnt_co)=z;
               obs_qc(icnt_co)=dart_qc;
               obs_npr(icnt_co)=-9999;
               obs_npr_mdl(icnt_co)=-9999;
               obs_psfc(icnt_co)=-9999;
               obs_prior(icnt_co)=-9999;
               obs_avk(icnt_co)=-9999;
               obs_swt(icnt_co)=-9999;
               obs_prs(icnt_co)=-9999;
               obs_hgt(icnt_co)=-9999;
            end
         elseif strcmp(obs_kind_id(iirec),strcat(obs_name,'_O3'))
	    if(prior_mean~=missing & post_mean~=missing & ...
	    prior_sprd~=missing & post_sprd~=missing)
               icnt_o3=icnt_o3+1;
               obs_o3_val(icnt_o3)=obs_value;
               obs_o3_prior_mean(icnt_o3)=prior_mean;
               obs_o3_post_mean(icnt_o3)=post_mean;
               obs_o3_prior_sprd(icnt_o3)=prior_sprd;
               obs_o3_post_sprd(icnt_o3)=post_sprd;
               obs_x(icnt_o3)=x;
               obs_y(icnt_o3)=y;
               obs_z(icnt_o3)=z;
               obs_qc(icnt_o3)=dart_qc;
               obs_npr(icnt_o3)=-9999;
               obs_npr_mdl(icnt_o3)=-9999;
               obs_psfc(icnt_o3)=-9999;
               obs_prior(icnt_o3)=-9999;
               obs_avk(icnt_o3)=-9999;
               obs_swt(icnt_o3)=-9999;
               obs_prs(icnt_o3)=-9999;
               obs_hgt(icnt_o3)=-9999;
            end
         elseif strcmp(obs_kind_id(iirec),strcat(obs_name,'_NO2'))
	    if(prior_mean~=missing & post_mean~=missing & ...
	    prior_sprd~=missing & post_sprd~=missing)
               icnt_no2=icnt_no2+1;
               obs_no2_val(icnt_no2)=obs_value;
               obs_no2_prior_mean(icnt_no2)=prior_mean;
               obs_no2_post_mean(icnt_no2)=post_mean;
               obs_no2_prior_sprd(icnt_no2)=prior_sprd;
               obs_no2_post_sprd(icnt_no2)=post_sprd;
               obs_x(icnt_no2)=x;
               obs_y(icnt_no2)=y;
               obs_z(icnt_no2)=z;
               obs_qc(icnt_no2)=dart_qc;
               obs_npr(icnt_no2)=-9999;
               obs_npr_mdl(icnt_no2)=-9999;
               obs_psfc(icnt_no2)=-9999;
               obs_prior(icnt_no2)=-9999;
               obs_avk(icnt_no2)=-9999;
               obs_swt(icnt_no2)=-9999;
               obs_prs(icnt_no2)=-9999;
               obs_hgt(icnt_no2)=-9999;
            end
         elseif strcmp(obs_kind_id(iirec),strcat(obs_name,'_SO2'))
	    if(prior_mean~=missing & post_mean~=missing & ...
	    prior_sprd~=missing & post_sprd~=missing)
               icnt_so2=icnt_so2+1;
               obs_so2_val(icnt_so2)=obs_value;
               obs_so2_prior_mean(icnt_so2)=prior_mean;
               obs_so2_post_mean(icnt_so2)=post_mean;
               obs_so2_prior_sprd(icnt_so2)=prior_sprd;
               obs_so2_post_sprd(icnt_so2)=post_sprd;
               obs_x(icnt_so2)=x;
               obs_y(icnt_so2)=y;
               obs_z(icnt_so2)=z;
               obs_qc(icnt_so2)=dart_qc;
               obs_npr(icnt_so2)=-9999;
               obs_npr_mdl(icnt_so2)=-9999;
               obs_psfc(icnt_so2)=-9999;
               obs_prior(icnt_so2)=-9999;
               obs_avk(icnt_so2)=-9999;
               obs_swt(icnt_so2)=-9999;
               obs_prs(icnt_so2)=-9999;
               obs_hgt(icnt_so2)=-9999;
            end
         elseif strcmp(obs_kind_id(iirec),strcat(obs_name,'_PM10'))
	    if(prior_mean~=missing & post_mean~=missing & ...
	    prior_sprd~=missing & post_sprd~=missing)
               icnt_pm10=icnt_pm10+1;
               obs_pm10_val(icnt_pm10)=obs_value;
               obs_pm10_prior_mean(icnt_pm10)=prior_mean;
               obs_pm10_post_mean(icnt_pm10)=post_mean;
               obs_pm10_prior_sprd(icnt_pm10)=prior_sprd;
               obs_pm10_post_sprd(icnt_pm10)=post_sprd;
               obs_x(icnt_pm10)=x;
               obs_y(icnt_pm10)=y;
               obs_z(icnt_pm10)=z;
               obs_qc(icnt_pm10)=dart_qc;
               obs_npr(icnt_pm10)=-9999;
               obs_npr_mdl(icnt_pm10)=-9999;
               obs_psfc(icnt_pm10)=-9999;
               obs_prior(icnt_pm10)=-9999;
               obs_avk(icnt_pm10)=-9999;
               obs_swt(icnt_pm10)=-9999;
               obs_prs(icnt_pm10)=-9999;
               obs_hgt(icnt_pm10)=-9999;
            end
         elseif strcmp(obs_kind_id(iirec),strcat(obs_name,'_PM25'))
	    if(prior_mean~=missing & post_mean~=missing & ...
	    prior_sprd~=missing & post_sprd~=missing)
               icnt_pm25=icnt_pm25+1;
               obs_pm25_val(icnt_pm25)=obs_value;
               obs_pm25_prior_mean(icnt_pm25)=prior_mean;
               obs_pm25_post_mean(icnt_pm25)=post_mean;
               obs_pm25_prior_sprd(icnt_pm25)=prior_sprd;
               obs_pm25_post_sprd(icnt_pm25)=post_sprd;
               obs_x(icnt_pm25)=x;
               obs_y(icnt_pm25)=y;
               obs_z(icnt_pm25)=z;
               obs_qc(icnt_pm25)=dart_qc;
               obs_npr(icnt_pm25)=-9999;
               obs_npr_mdl(icnt_pm25)=-9999;
               obs_psfc(icnt_pm25)=-9999;
               obs_prior(icnt_pm25)=-9999;
               obs_avk(icnt_pm25)=-9999;
               obs_swt(icnt_pm25)=-9999;
               obs_prs(icnt_pm25)=-9999;
               obs_hgt(icnt_pm25)=-9999;
            end
         elseif strcmp(obs_kind_id(iirec),obs_name)
	    if(prior_mean~=missing & post_mean~=missing & ...
	    prior_sprd~=missing & post_sprd~=missing)
               icnt=icnt+1;
               obs_val(icnt)=obs_value;
               obs_prior_mean(icnt)=prior_mean;
               obs_post_mean(icnt)=post_mean;
               obs_prior_sprd(icnt)=prior_sprd;
               obs_post_sprd(icnt)=post_sprd;
               obs_x(icnt)=x;
               obs_y(icnt)=y;
               obs_z(icnt)=z;
               obs_qc(icnt)=dart_qc;
               obs_npr(icnt)=-9999;
               obs_npr_mdl(icnt)=-9999;
               obs_psfc(icnt)=-9999;
               obs_prior(icnt)=-9999;
               obs_avk(icnt)=-9999;
               obs_swt(icnt)=-9999;
               obs_prs(icnt)=-9999;
               obs_hgt(icnt)=-9999;
            end
         end
%
      elseif strcmp(obs_kind_id(iirec),'MOPITT_CO_RETRIEVAL')
%
% read number of MOPITT levels
         clear temp;
         [temp]=textscan(fid,'%f',1);
         mopitt_nprr=temp{1};
         mopitt_npr=fix(mopitt_nprr);
%
% read meta data
         clear temp;
         [temp]=textscan(fid,'%f',1);
         mopitt_prior=temp{1};
         [temp]=textscan(fid,'%f',1);
         mopitt_psfc=temp{1};
         clear temp;
         [temp]=textscan(fid,'%f',mopitt_npr);
         mopitt_avk(1:mopitt_npr)=temp{1:mopitt_npr};
%
% read mopitt record number
         clear temp;
         [temp]=textscan(fid,'%d',1);
%
% read time data
         clear temp;
         [temp]=textscan(fid,'%d %d',1);
         obs_sec=temp{1};
         obs_day=temp{2};
%
% read observation error variance
         clear temp;
         [temp]=textscan(fid,'%f',1);
         err_var=temp{1};
%
% check whether to save these data
         if strcmp(obs_kind_id(iirec),obs_name)
	    if(prior_mean~=missing & post_mean~=missing & ...
	    prior_sprd~=missing & post_sprd~=missing)
               icnt=icnt+1;
               mopitt_prs=[1000.,900.,800.,700.,600.,500., ...
               400.,300.,200.,100.];
               obs_val(icnt)=obs_value;
               obs_prior_mean(icnt)=prior_mean;
               obs_post_mean(icnt)=post_mean;
               obs_prior_sprd(icnt)=prior_sprd;
               obs_post_sprd(icnt)=post_sprd;
               obs_x(icnt)=x;
               obs_y(icnt)=y;
               obs_z(icnt)=z;
               obs_qc(icnt)=dart_qc;
               obs_npr(icnt)=mopitt_npr;
               obs_npr_mdl(icnt)=-9999;
               kstr=mopitt_dim-mopitt_npr+1;
	       mopitt_prs_adj(1)=mopitt_psfc;
               for k=kstr+1:mopitt_dim
	          indx=k-kstr+1;
                  mopitt_prs_adj(indx)=mopitt_prs(k);
               end
               obs_psfc(icnt)=mopitt_psfc;
               obs_prior(icnt)=mopitt_prior;
               obs_avk(icnt,1:mopitt_npr)=mopitt_avk(1:mopitt_npr);
               obs_swt(icnt)=-9999;
               obs_prs(icnt,1:mopitt_npr)=mopitt_prs_adj(1:mopitt_npr);
               obs_hgt(icnt)=-9999;
            end
	    clear mopitt_prs_adj
         end
%
      elseif strcmp(obs_kind_id(iirec),'IASI_CO_RETRIEVAL')
%
% read number of IASI CO levels
         clear temp;
         [temp]=textscan(fid,'%f',1);
         iasi_co_nprr=temp{1};
         iasi_co_npr=fix(iasi_co_nprr);
         iasi_co_nprp=iasi_co_npr+1;
         [temp]=textscan(fid,'%f',1);
         iasi_co_prior=temp{1};
         [temp]=textscan(fid,'%f',1);
         iasi_co_psfc=temp{1};
         clear temp;
         [temp]=textscan(fid,'%f',iasi_co_npr);
         iasi_co_avk(1:iasi_co_npr)=temp{1:iasi_co_npr};
         clear temp;
         [temp]=textscan(fid,'%f',iasi_co_nprp);
         iasi_co_prs(1:iasi_co_nprp)=temp{1:iasi_co_nprp};
%
% read record number
         clear temp;
         [temp]=textscan(fid,'%d',1);
%
% read time data
         clear temp;
         [temp]=textscan(fid,'%d %d',1);
         obs_sec=temp{1};
         obs_day=temp{2};
%
% read observation error variance
         clear temp;
         [temp]=textscan(fid,'%f',1);
         err_var=temp{1};
%
% check whether to save these data
         if strcmp(obs_kind_id(iirec),obs_name)
            icnt=icnt+1;
            obs_val(icnt)=obs_value;
            obs_prior_mean(icnt)=prior_mean;
            obs_post_mean(icnt)=post_mean;
            obs_prior_sprd(icnt)=prior_sprd;
            obs_post_sprd(icnt)=post_sprd;
            obs_x(icnt)=x;
            obs_y(icnt)=y;
            obs_z(icnt)=z;
            obs_qc(icnt)=dart_qc;
            obs_npr(icnt)=iasi_co_npr;
            obs_npr_mdl(icnt)=-9999;
            obs_psfc(icnt)=iasi_co_psfc;
            obs_prior(icnt)=iasi_co_prior;
            obs_avk(icnt,1:iasi_co_npr)=iasi_co_avk(1:iasi_co_npr);
            obs_swt(icnt)=-9999;
            obs_prs(icnt,1:iasi_co_nprp)=iasi_co_prs(1:iasi_co_nprp);
            obs_hgt(icnt)=-9999;
         end
      elseif strcmp(obs_kind_id(iirec),'IASI_O3_RETRIEVAL')
%
% read number of IASI O3 levels
         clear temp;
         [temp]=textscan(fid,'%f',1);
         iasi_o3_nprr=temp{1};
         iasi_o3_npr=fix(iasi_o3_nprr);
         iasi_o3_nprp=iasi_o3_npr+1;
         [temp]=textscan(fid,'%f',1);
         iasi_o3_prior=temp{1};
         clear temp;
         [temp]=textscan(fid,'%f',iasi_o3_nprp);
         iasi_o3_hgt(1:iasi_o3_npr)=temp{1:iasi_o3_npr};
         clear temp;
         [temp]=textscan(fid,'%f',iasi_o3_nprp);
         iasi_o3_prs(1:iasi_o3_npr)=temp{1:iasi_o3_npr};
         clear temp;
         [temp]=textscan(fid,'%f',iasi_o3_npr);
         iasi_o3_avk(1:iasi_o3_npr)=temp{1:iasi_o3_npr};
         clear temp;
         [temp]=textscan(fid,'%f',iasi_o3_npr);
         iasi_o3_col(1:iasi_o3_npr)=temp{1:iasi_o3_npr};
%
% read record number
         clear temp;
         [temp]=textscan(fid,'%d',1);
%
% read time data
         clear temp;
         [temp]=textscan(fid,'%d %d',1);
         obs_sec=temp{1};
         obs_day=temp{2};
%
% read observation error variance
         clear temp;
         [temp]=textscan(fid,'%f',1);
         err_var=temp{1};
%
% check whether to save these data
         if strcmp(obs_kind_id(iirec),obs_name)
            icnt=icnt+1;
            obs_val(icnt)=obs_value;
            obs_prior_mean(icnt)=prior_mean;
            obs_post_mean(icnt)=post_mean;
            obs_prior_sprd(icnt)=prior_sprd;
            obs_post_sprd(icnt)=post_sprd;
            obs_x(icnt)=x;
            obs_y(icnt)=y;
            obs_z(icnt)=z;
            obs_qc(icnt)=dart_qc;
            obs_npr(icnt)=iasi_o3_npr;
            obs_npr_mdl(icnt)=-9999;
            obs_psfc(icnt)=iasi_o3_psfc;
            obs_prior(icnt)=iasi_o3_prior;
            obs_avk(icnt,1:iasi_o3_npr)=iasi_o3_avk(1:iasi_o3_npr);
            obs_swt(icnt)=-9999;
            obs_prs(icnt,1:iasi_o3_nprp)=iasi_o3_prs(1:iasi_o3_nprp);
            obs_hgt(icnt,1:iasi_o3_nprp)=iasi_o3_hgt(1:iasi_o3_nprp);
         end
%
      elseif strcmp(obs_kind_id(iirec),'OMI_O3_COLUMN')
%
% read number of OMI O3 levels
         clear temp;
         [temp]=textscan(fid,'%f',1);
         omi_o3_npr=temp{1};
         omi_o3_nprp=omi_o3_npr+1;
         clear temp;
         [temp]=textscan(fid,'%f',1);
         omi_o3_npr_mdl=temp{1};
         clear temp;
         [temp]=textscan(fid,'%f',omi_o3_nprp);
         omi_o3_prs(1:omi_o3_nprp)=temp{1:omi_o3_nprp};
         clear temp;
         [temp]=textscan(fid,'%f',omi_o3_npr);
         omi_o3_avk(1:omi_o3_npr)=temp{1:omi_o3_npr};
         clear temp;
         [temp]=textscan(fid,'%f',omi_o3_npr);
         omi_o3_prior(1:omi_o3_npr)=temp{1:omi_o3_npr};
%
% read record number
         clear temp;
         [temp]=textscan(fid,'%d',1);
%
% read time data
         clear temp;
         [temp]=textscan(fid,'%d %d',1);
         obs_sec=temp{1};
         obs_day=temp{2};
%
% read observation error variance
         clear temp;
         [temp]=textscan(fid,'%f',1);
         err_var=temp{1};
%
% check whether to save these data
         if strcmp(obs_kind_id(iirec),obs_name)
            icnt=icnt+1;
            obs_val(icnt)=obs_value;
            obs_prior_mean(icnt)=prior_mean;
            obs_post_mean(icnt)=post_mean;
            obs_prior_sprd(icnt)=prior_sprd;
            obs_post_sprd(icnt)=post_sprd;
            obs_x(icnt)=x;
            obs_y(icnt)=y;
            obs_z(icnt)=z;
            obs_qc(icnt)=dart_qc;
            obs_npr(icnt)=omi_o3_npr;
            obs_npr_mdl(icnt)=omi_o3_npr_mdl;
            obs_psfc(icnt)=-9999;
            obs_prior(icnt,1:omi_o3_npr)=omi_o3_prior(1:omi_o3_npr);
            obs_avk(icnt,1:omi_o3_npr)=omi_o3_avk(1:omi_o3_npr);
            obs_swt(icnt)=-9999;
            obs_prs(icnt,1:omi_o3_nprp)=omi_o3_prs(1:omi_o3_nprp);
            obs_hgt(icnt)=-9999;
         end
%
      elseif strcmp(obs_kind_id(iirec),'OMI_NO2_COLUMN')
%
% read number of OMI NO2 levels
         clear temp;
         [temp]=textscan(fid,'%f',1);
         omi_no2_npr=temp{1};
         omi_no2_nprp=omi_no2_npr+1;
         clear temp;
         [temp]=textscan(fid,'%f',1);
         omi_no2_npr_mdl=temp{1};
         clear temp;
         [temp]=textscan(fid,'%f',1);
         omi_no2_prs_mdl=temp{1};
         clear temp;
         [temp]=textscan(fid,'%f',omi_no2_nprp);
         omi_no2_prs(1:omi_no2_nprp)=temp{1:omi_no2_nprp};
         clear temp;
         [temp]=textscan(fid,'%f',omi_no2_npr);
         omi_no2_swt(1:omi_no2_npr)=temp{1:omi_no2_npr};
%
% read record number
         clear temp;
         [temp]=textscan(fid,'%d',1);
%
% read time data
         clear temp;
         [temp]=textscan(fid,'%d %d',1);
         obs_sec=temp{1};
         obs_day=temp{2};
%
% read observation error variance
         clear temp;
         [temp]=textscan(fid,'%f',1);
         err_var=temp{1};
%
% check whether to save these data
         if strcmp(obs_kind_id(iirec),obs_name)
            icnt=icnt+1;
            obs_val(icnt)=obs_value;
            obs_prior_mean(icnt)=prior_mean;
            obs_post_mean(icnt)=post_mean;
            obs_prior_sprd(icnt)=prior_sprd;
            obs_post_sprd(icnt)=post_sprd;
            obs_x(icnt)=x;
            obs_y(icnt)=y;
            obs_z(icnt)=z;
            obs_qc(icnt)=dart_qc;
            obs_npr(icnt)=omi_no2_npr;
            obs_npr_mdl(icnt)=omi_no2_npr_mdl;
            obs_psfc(icnt)=-9999;
            obs_prior(icnt)=-9999;
            obs_avk(icnt)=-9999;
            obs_swt(icnt,1:omi_no2_npr)=omi_no2_swt(1:omi_no2_npr);
            obs_prs(icnt,1:omi_no2_nprp)=omi_no2_prs(1:omi_no2_nprp);
            obs_hgt(icnt)=-9999;
         end
%
      elseif strcmp(obs_kind_id(iirec),'OMI_SO2_COLUMN')
%
% read number of OMI SO2 levels
         clear temp;
         [temp]=textscan(fid,'%f',1);
         omi_so2_npr=temp{1};
         omi_so2_nprp=omi_so2_npr+1;
         clear temp;
         [temp]=textscan(fid,'%f',1);
         omi_so2_npr_mdl=temp{1};
         clear temp;
         [temp]=textscan(fid,'%f',omi_so2_nprp);
         omi_so2_prs(1:omi_so2_nprp)=temp{1:omi_so2_nprp};
         clear temp;
         [temp]=textscan(fid,'%f',omi_so2_npr);
         omi_so2_swt(1:omi_so2_npr)=temp{1:omi_so2_npr};
%
% read record number
         clear temp;
         [temp]=textscan(fid,'%d',1);
%
% read time data
         clear temp;
         [temp]=textscan(fid,'%d %d',1);
         obs_sec=temp{1};
         obs_day=temp{2};
%
% read observation error variance
         clear temp;
         [temp]=textscan(fid,'%f',1);
         err_var=temp{1};
%
% check whether to save these data
         if strcmp(obs_kind_id(iirec),obs_name)
            icnt=icnt+1;
            obs_val(icnt)=obs_value;
            obs_prior_mean(icnt)=prior_mean;
            obs_post_mean(icnt)=post_mean;
            obs_prior_sprd(icnt)=prior_sprd;
            obs_post_sprd(icnt)=post_sprd;
            obs_x(icnt)=x;
            obs_y(icnt)=y;
            obs_z(icnt)=z;
            obs_qc(icnt)=dart_qc;
            obs_npr(icnt)=omi_so2_npr;
            obs_npr_mdl(icnt)=omi_so2_npr_mdl;
            obs_psfc(icnt)=-9999;
            obs_prior(icnt)=-9999;
            obs_avk(icnt)=-9999;
            obs_swt(icnt,1:omi_so2_npr)=omi_so2_swt(1:omi_so2_npr);
            obs_prs(icnt,1:omi_so2_nprp)=omi_so2_prs(1:omi_so2_nprp);
            obs_hgt(icnt)=-9999;
         end
      else
         fprintf('APM ERROR: obs_kind not found \n')
         return
      end 
   end
   nobs=icnt;
   nobs_co=icnt_co;
   nobs_o3=icnt_o3;
   nobs_no2=icnt_no2;
   nobs_so2=icnt_so2;
   nobs_pm10=icnt_pm10;
   nobs_pm25=icnt_pm25;
   if(nobs==0)
      obs_val=-9999;
      obs_prior_mean=-9999;
      obs_post_mean=-9999;
      obs_prior_sprd=-9999;
      obs_post_sprd=-9999;
      obs_x=-9999;
      obs_y=-9999;
      obs_z=-9999;
      obs_qc=-9999;
      obs_npr=-9999;
      obs_npr_mdl=-9999;
      obs_psfc=-9999;
      obs_prior=-9999;
      obs_avk=-9999;
      obs_swt=-9999;
      obs_prs=-9999;
      obs_hgt=-9999;
   end
   if(nobs_co==0)
      obs_co_val=-9999;
      obs_co_prior_mean=-9999;
      obs_co_post_mean=-9999;
      obs_co_prior_sprd=-9999;
      obs_co_post_sprd=-9999;
      obs_x=-9999;
      obs_y=-9999;
      obs_z=-9999;
      obs_qc=-9999;
      obs_npr=-9999;
      obs_npr_mdl=-9999;
      obs_psfc=-9999;
      obs_prior=-9999;
      obs_avk=-9999;
      obs_swt=-9999;
      obs_prs=-9999;
      obs_hgt=-9999;
   end
   if(nobs_o3==0)
      obs_o3_val=-9999;
      obs_o3_prior_mean=-9999;
      obs_o3_post_mean=-9999;
      obs_o3_prior_sprd=-9999;
      obs_o3_post_sprd=-9999;
      obs_x=-9999;
      obs_y=-9999;
      obs_z=-9999;
      obs_qc=-9999;
      obs_npr=-9999;
      obs_npr_mdl=-9999;
      obs_psfc=-9999;
      obs_prior=-9999;
      obs_avk=-9999;
      obs_swt=-9999;
      obs_prs=-9999;
      obs_hgt=-9999;
   end
   if(nobs_no2==0)
      obs_no2_val=-9999;
      obs_no2_prior_mean=-9999;
      obs_no2_post_mean=-9999;
      obs_no2_prior_sprd=-9999;
      obs_no2_post_sprd=-9999;
      obs_x=-9999;
      obs_y=-9999;
      obs_z=-9999;
      obs_qc=-9999;
      obs_npr=-9999;
      obs_npr_mdl=-9999;
      obs_psfc=-9999;
      obs_prior=-9999;
      obs_avk=-9999;
      obs_swt=-9999;
      obs_prs=-9999;
      obs_hgt=-9999;
   end
   if(nobs_so2==0)
      obs_so2_val=-9999;
      obs_so2_prior_mean=-9999;
      obs_so2_post_mean=-9999;
      obs_so2_prior_sprd=-9999;
      obs_so2_post_sprd=-9999;
      obs_x=-9999;
      obs_y=-9999;
      obs_z=-9999;
      obs_qc=-9999;
      obs_npr=-9999;
      obs_npr_mdl=-9999;
      obs_psfc=-9999;
      obs_prior=-9999;
      obs_avk=-9999;
      obs_swt=-9999;
      obs_prs=-9999;
      obs_hgt=-9999;
   end
   if(nobs_pm10==0)
      obs_pm10_val=-9999;
      obs_pm10_prior_mean=-9999;
      obs_pm10_post_mean=-9999;
      obs_pm10_prior_sprd=-9999;
      obs_pm10_post_sprd=-9999;
      obs_x=-9999;
      obs_y=-9999;
      obs_z=-9999;
      obs_qc=-9999;
      obs_npr=-9999;
      obs_npr_mdl=-9999;
      obs_psfc=-9999;
      obs_prior=-9999;
      obs_avk=-9999;
      obs_swt=-9999;
      obs_prs=-9999;
      obs_hgt=-9999;
   end
   if(nobs_pm25==0)
      obs_pm25_val=-9999;
      obs_pm25_prior_mean=-9999;
      obs_pm25_post_mean=-9999;
      obs_pm25_prior_sprd=-9999;
      obs_pm25_post_sprd=-9999;
      obs_x=-9999;
      obs_y=-9999;
      obs_z=-9999;
      obs_qc=-9999;
      obs_npr=-9999;
      obs_npr_mdl=-9999;
      obs_psfc=-9999;
      obs_prior=-9999;
      obs_avk=-9999;
      obs_swt=-9999;
      obs_prs=-9999;
      obs_hgt=-9999;
   end
end
%
function [xi,xj]=w3fb13(alat,elon,alat1,elon1, ...
dx,elonv,alatan1,alatan2)
%
   rerth=6.3712e6;
   pi=3.14159;
%
   if(alatan1>0)
      h=1;
   else
      h=-1;
   end
%
   radpd=pi/180.;
   rebydx=rerth/dx;
   alatn1=alatan1*radpd;
   alatn2=alatan2*radpd;
   if(alatan1==alatan2)
      an=h*sin(alatn1);
   else
      an=log(cos(alatn1)/cos(alatn2))/ ...
      log(tan(((h*pi/2.)-alatn1)/2.)/tan(((h*pi/2.)-alatn2)/2.));
   end
   cosltn=cos(alatn2);
%
   elon1l=elon1;
   if(elon1-elonv>180)
      elon1l=elon1-360;
   end
   if(elon1-elonv<-180)
      elon1l=elon1+360;
   end
%
   elonl=elon;
   if(elon-elonv>180)
      elonl=elon-360;
   end
   if(elon-elonv<-180)
      elonl=elon+360;
   end
%
   elonvr=elonv*radpd;
%
   ala1=alat1*radpd;
   psi=(rebydx*cosltn)/(an*(tan((pi/4.)-(h*alatn2/2.))^an));
   rmll=psi*(tan((pi/4.)-(h*ala1/2.))^an);
%
   elo1=elon1l*radpd;
   arg=an*(elo1-elonvr);
   polei=1.-h*rmll*sin(arg);
   polej=1+rmll*cos(arg);
%
   ala=alat*radpd;
%
   rm=psi*(tan((pi/4.)-(h*ala/2.))^an);
   elo=elonl*radpd;
   arg=an*(elo-elonvr);
   xi=polei+h*rm*sin(arg);
   xj=polej-rm*cos(arg);
%
   if(round(xi)<1)
      xi=xi-1;
   end
   if(round(xj)<1)
      xj=xj-1;
   end
end
