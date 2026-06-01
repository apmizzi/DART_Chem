function plot_rank_histo_TRACER_I_ics_DART
   clear all;
%
   DATE_STR_PR=["2011040215"];
   DATE_STR_PO=["2011040218"];
   ndates=1;
   wrf_vert=[10,14,18,21,23,25,27,29,31,34];
   levl=1;
   nx=440;
   ny=284;
   nz=50;
   num_mem=30;
   nobs_max=100000;
   rc=system('rm -rf TRACER_I_RANK_HISTO_ICS_DART.eps');
   save_file='TRACER_I_RANK_HISTO_ICS_DART.eps';
%
% set colormap
   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
   cmap=desired_colors;
%
   path_data='/nobackupp28/amizzi/OUTPUT_DATA/OUTPUT_2011_NOAA_EMISADJ_30MEMS';
%
% Loop through dates
   for idate=1:ndates
      date_chr=DATE_STR_PO(idate);
      file_date=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      file_obsseq=strcat(path_data,'/',date_chr,'/dart_filter/obs_seq.final')
      file_fid=fopen(file_obsseq);
%
% AIRNOW CO
      iplt_co=1;
      if (iplt_co==1)
         [obs_val_airn_co,obs_prior_mean_airn_co,obs_post_mean_airn_co, ...
         obs_prior_sprd_airn_co,obs_post_sprd_airn_co,obs_prior_mem_airn_co,obs_post_mem_airn_co, ...
         obs_npr_airn_co,obs_prs_airn_co,obs_hgt_airn_co,nobs_airn_co]= ...
	 read_obs_seq(file_fid,'AIRNOW_CO',num_mem);
      end
%
% AIRNOW O3
      iplt_o3=0;
      if (iplt_o3==1)
         [obs_val_airn_o3,obs_prior_mean_airn_o3,obs_post_mean_airn_o3, ...
         obs_prior_sprd_airn_o3,obs_post_sprd_airn_o3,obs_prior_mem_airn_o3,obs_post_mem_airn_o3, ...
         obs_npr_airn_o3,obs_psfc_airn_o3,obs_prs_airn_o3,obs_hgt_airn_o3,nobs_airn_o3]= ...
	 read_obs_seq(file_fid,'AIRNOW_O3',num_mem);
      end
%
% AIRNOW NO2
      iplt_no2=0;
      if (iplt_no2==1)
         [obs_val_airn_no2,obs_prior_mean_airn_no2,obs_post_mean_airn_no2, ...
         obs_prior_sprd_airn_no2,obs_post_sprd_airn_no2,obs_prior_mem_airn_no2,obs_post_mem_airn_no2, ...
         obs_npr_airn_no2,obs_psfc_airn_no2,obs_prs_airn_no2,obs_hgt_airn_no2,nobs_airn_no2]= ...
	 read_obs_seq(file_fid,'AIRNOW_NO2',num_mem);
      end
%
% AIRNOW SO2
      iplt_so2=0;
      if (iplt_so2==1)
         [obs_val_airn_so2,obs_prior_mean_airn_so2,obs_post_mean_airn_so2, ...
         obs_prior_sprd_airn_so2,obs_post_sprd_airn_so2,obs_prior_mem_airn_so2,obs_post_mem_airn_so2, ...
         obs_npr_airn_so2,obs_psfc_airn_so2,obs_prs_airn_so2,obs_hgt_airn_so2,nobs_airn_so2]= ...
	 read_obs_seq(file_fid,'AIRNOW_SO2',num_mem);
      end
%
% MOPITT CO PROFILE
      iplt_co=0;
      if (iplt_co==1)
         [obs_val_mop_co,obs_prior_mean_mop_co,obs_post_mean_mop_co, ...
         obs_prior_sprd_mop_co,obs_post_sprd_mop_co,obs_prior_mem_mop_co,obs_post_mem_mop_co, ...
         obs_npr_mop_co,obs_psfc_mop_co,obs_prs_mop_co,obs_hgt_mop_co,nobs_mop_co]= ...
	 read_obs_seq(file_fid,'MOPITT_CO_PROFILE',num_mem);
      end
%
% OMI O3 PROFILE
      iplt_o3=0;
      if (iplt_o3==1)
         [obs_val_omi_o3,obs_prior_mean_omi_o3,obs_post_mean_omi_o3, ...
         obs_prior_sprd_omi_o3,obs_post_sprd_omi_o3,obs_prior_mem_omi_o3,obs_post_mem_omi_o3, ...
         obs_npr_omi_o3,obs_psfc_omi_o3,obs_prs_omi_o3,obs_hgt_omi_o3,nobs_omi_o3]= ...
	 read_obs_seq(file_fid,'OMI_O3_PROFILE',num_mem);
      end
%
% OMI NO2 DOMINO TROP COL
      iplt_no2=0;
      if (iplt_no2==1)
         [obs_val_omi_dom_no2,obs_prior_mean_omi_dom_no2,obs_post_mean_omi_dom_no2, ...
         obs_prior_sprd_omi_dom_no2,obs_post_sprd_omi_dom_no2,obs_prior_mem_omi_dom_no2,obs_post_mem_omi_dom_no2, ...
         obs_npr_omi_dom_no2,obs_psfc_omi_dom_no2,obs_prs_omi_dom_no2,obs_hgt_omi_dom_no2,nobs_omi_dom_no2]= ...
	 read_obs_seq(file_fid,'OMI_NO2_DOMINO_TROP_COL',num_mem);
      end
%
% OMI SO2 PBL COL
      iplt_so2=0;
      if (iplt_so2==1)
         [obs_val_omi_so2,obs_prior_mean_omi_so2,obs_post_mean_omi_so2, ...
         obs_prior_sprd_omi_so2,obs_post_sprd_omi_so2,obs_prior_mem_omi_so2,obs_post_mem_omi_so2, ...
         obs_npr_omi_so2,obs_psfc_omi_so2,obs_prs_omi_so2,obs_hgt_omi_so2,nobs_omi_so2]= ...
	 read_obs_seq(file_fid,'OMI_SO2_PBL_COL',num_mem);
      end
%
% GOME2A NO2 TROP COL
      iplt_no2=0;
      if (iplt_no2==1)
         [obs_val_gome_no2,obs_prior_mean_gome_no2,obs_post_mean_gome_no2, ...
         obs_prior_sprd_gome_no2,obs_post_sprd_gome_no2,obs_prior_mem_gome_no2,obs_post_mem_gome_no2, ...
         obs_npr_gome_no2,obs_psfc_gome_no2,obs_prs_gome_no2,obs_hgt_gome_no2,nobs_gome_no2]= ...
	 read_obs_seq(file_fid,'GOME2A_NO2_TROL_COL',num_mem);
      end
%
% MLS O3 PROFILE
      iplt_o3=0;
      if (iplt_o3==1)
         [obs_val_mls_o3,obs_prior_mean_mls_o3,obs_post_mean_mls_o3, ...
         obs_prior_sprd_mls_o3,obs_post_sprd_mls_o3,obs_prior_mem_mls_o3,obs_post_mem_mls_o3, ...
         obs_npr_mls_o3,obs_psfc_mls_o3,obs_prs_mls_o3,obs_hgt_mls_o3,nobs_mls_o3]= ...
	 read_obs_seq(file_fid,'MLS_O3_PROFILE',num_mem);
      end
%
% MLS HNO3 PROFILE
      iplt_hno3=0;
      if (iplt_hno3==1)
         [obs_val_mls_hno3,obs_prior_mean_mls_hno3,obs_post_mean_mls_hno3, ...
         obs_prior_sprd_mls_hno3,obs_post_sprd_mls_hno3,obs_prior_mem_mls_hno3,obs_post_mem_mls_hno3, ...
         obs_npr_mls_hno3,obs_psfc_mls_hno3,obs_prs_mls_hno3,obs_hgt_mls_hno3,nobs_mls_hno3]= ...
	 read_obs_seq(file_fid,'MLS_HNO3_PROFILE',num_mem);
      end
%
% TES CO PROFILE
      iplt_co=0;
      if (iplt_co==1)
         [obs_val_tes_co,obs_prior_mean_tes_co,obs_post_mean_tes_co, ...
         obs_prior_sprd_tes_co,obs_post_sprd_tes_co,obs_prior_mem_tes_co,obs_post_mem_tes_co, ...
         obs_npr_tes_co,obs_psfc_tes_co,obs_prs_tes_co,obs_hgt_tes_co,nobs_tes_co]= ...
	 read_obs_seq(file_fid,'TES_CO_PROFILE',num_mem);
      end
%
% TES O3 PROFILE
      iplt_o3=0;
      if (iplt_o3==1)
         [obs_val_tes_o3,obs_prior_mean_tes_o3,obs_post_mean_tes_o3, ...
         obs_prior_sprd_tes_o3,obs_post_sprd_tes_o3,obs_prior_mem_tes_o3,obs_post_mem_tes_o3, ...
         obs_npr_tes_o3,obs_psfc_tes_o3,obs_prs_tes_o3,obs_hgt_tes_o3,nobs_tes_o3]= ...
	 read_obs_seq(file_fid,'TES_O3_PROFILE',num_mem);
      end
%
% SCIA NO2 TROP COL
      iplt_no2=0;
      if (iplt_no2==1)
         [obs_val_scia_no2,obs_prior_mean_scia_no2,obs_post_mean_scia_no2, ...
         obs_prior_sprd_scia_no2,obs_post_sprd_scia_no2,obs_prior_mem_scia_no2,obs_post_mem_scia_no2, ...
         obs_npr_scia_no2,obs_psfc_scia_no2,obs_prs_scia_no2,obs_hgt_scia_no2,nobs_scia_no2]= ...
	 read_obs_seq(file_fid,'SCIA_NO2_TROP_COL',num_mem);
      end
   end
end
%
function [obs_val,obs_prior_mean,obs_post_mean, ...
obs_prior_sprd,obs_post_sprd,obs_prior_mem,obs_post_mem, ...
obs_npr,obs_psfc,obs_prs,obs_hgt,nobs]= ...
read_obs_seq(fid,obs_name_save,num_mem);
%
% initialize variables
   frewind(fid);
%
% clear obs variables
   clear obs_val;
   clear obs_prior_mean;
   clear obs_post_mean;
   clear obs_prior_sprd;
   clear obs_post_sprd;
   clear obs_prior_mem;
   clear obs_post_mem;
   clear obs_npr;
   clear obs_psfc;
   clear obs_prs;
   clear obs_hgt;
   clear nobs;
   nobs=0;
%
% read obs_seq file_type
   clear file_type;
   [file_type]=string(textscan(fid,'%s',1));
%
% read obs_kind definition
   clear obs_kind_def;
   [obs_kind_defn]=string(textscan(fid,'%s',1));
%
% read number of obs_kinds
   clear nobs_kind;
   [nobs_kind]=cell2mat(textscan(fid,'%d',1));
%
% read the obs_kinds and the obs_kind_ids
   clear obs_kind;
   clear obs_kind_id;
   for irec=1:nobs_kind
      clear temp;
      [temp]=textscan(fid,'%d %s',1);
      obs_kind(irec)=temp{1};
      obs_kind(irec);
      obs_kind_id(irec)=string(temp{2});
      obs_kind_id(irec);
   end
%
% read num_copies and num_qc
   clear temp;
   clear chr_num_copies;
   clear num_copies;
   clear chr_num_qc;
   clear num_qc;
   [temp]=textscan(fid,'%s %d %s %d',1);
   chr_num_copies=string(temp{1});
   num_copies=temp{2};
   chr_num_qc=string(temp{3});
   num_qc=temp{4};
%
% read num_obs and max_num_obs
   clear temp;
   clear chr_num_obs;
   clear num_obs;
   clear chr_max_num_obs;
   clear max_num_obs;
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
   clear chr_first_obs;
   clear first_obs;
   clear chr_last_obs;
   clear last_obs;
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
      clear cnt_obs;
      [temp]=textscan(fid,'%s %d',1);
      chr_obs=string(temp{1});
      cnt_obs=temp{2};
%
% read data
      clear temp;
      clear obs_value;
      [temp]=textscan(fid,'%f',1);
      obs_value=temp{1};
      clear temp;
      clear prior_mean;
      [temp]=textscan(fid,'%f',1);
      prior_mean=temp{1};
      clear temp;
      clear post_mean;
      [temp]=textscan(fid,'%f',1);
      post_mean=temp{1};
      clear temp;
      clear prior_sprd;
      [temp]=textscan(fid,'%f',1);
      prior_sprd=temp{1};
      clear temp;
      clear post_sprd;
      [temp]=textscan(fid,'%f',1);
      post_sprd=temp{1};
      clear prior_mem;
      clear post_mem;
      prior_mem=zeros(num_mem);
      post_mem=zeros(num_mem);
      for imem=1:num_mem
	 clear temp;
         [temp]=textscan(fid,'%f',1);
         prior_mem(imem)=temp{1};
	 prior_mem(imem);
         [temp]=textscan(fid,'%f',1);
         post_mem(imem)=temp{1};
         post_mem(imem);
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
      clear chr_locxd;
      temp=textscan(fid,'%s',1);
      chr_locxd=string(temp{1});
%
% select dimensionality
      if strcmp(chr_locxd,'loc2d')
         clear temp;
	 clear x y z;
         [temp]=textscan(fid,'%f %f',1);
         x=temp{1};
         y=temp{2};
         z=-9999;
      elseif strcmp(chr_locxd,'loc3d')
         clear temp
	 clear x y z;
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
      clear kind_id;
      clear iirec;
      [temp]=textscan(fid,'%d',1);
      kind_id=temp{1};
      for irecc=1:nobs_kind
         if(kind_id==obs_kind(irecc))
	   iirec=irecc;
         end
      end
      if (strcmp(obs_kind_id(iirec),'AIRNOW_CO'))
         fprintf('APM: Read data for obs type %s obs number %d \n',obs_kind_id(iirec),irec)
      end
%
% CONVENTIONAL MET AND CHEM OBS
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
         strcmp(obs_kind_id(iirec),'MODIS_AOD_TOTAL_COL'))
%
% Read time data 
         clear temp;
         clear obs_sec;
         clear obs_day;
         [temp]=textscan(fid,'%d %d',1);
         obs_sec=temp{1};
         obs_day=temp{2};
%
% read obervation error variance 
         clear temp;
	 clear err_var;
         [temp]=textscan(fid,'%f',1);
         err_var=temp{1};
	 if strcmp(obs_kind_id(iirec),obs_name_save)
            if(dart_qc==0)
               nobs=nobs+1;
               obs_val(nobs)=obs_value;
               obs_prior_mean(nobs)=prior_mean;
               obs_post_mean(nobs)=post_mean;
               obs_prior_sprd(nobs)=prior_sprd;
               obs_post_sprd(nobs)=post_sprd;
               obs_prior_mem(nobs,1:num_mem)=prior_mem(1:num_mem);
               obs_post_mem(nobs,1:num_mem)=post_mem(1:num_mem);
               obs_npr=1;
               obs_psfc=-9999;
               obs_prs(1:obs_npr)=-9999;
               obs_hgt(1:obs_npr)=-9999;
            end
         end
%
% MOPITT CO
      elseif strcmp(obs_kind_id(iirec),'MOPITT_CO_PROFILE')
%
% read number of MOPITT levels
         clear temp;
         [temp]=textscan(fid,'%f',1);
         mopitt_nprr=temp{1};
         mopitt_npr=fix(mopitt_nprr)
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
      elseif strcmp(obs_kind_id(iirec),'OMI_O3_PROFILE')
%
% read number of OMI O3 levels
         clear temp;
         [temp]=textscan(fid,'%f',1);
         omi_o3_npr=temp{1};
         omi_o3_nprp=omi_o3_npr+1;
         clear temp;
         [temp]=textscan(fid,'%f',1);
         omi_o3_lvl=temp{1};
         clear temp;
         [temp]=textscan(fid,'%f',1);
         omi_o3_end=temp{1};
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
      elseif strcmp(obs_kind_id(iirec),'OMI_NO2_DOMINO_TROP_COL')
%
% read number of OMI NO2 levels
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
      elseif strcmp(obs_kind_id(iirec),'OMI_SO2_PBL_COL')
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
      elseif strcmp(obs_kind_id(iirec),'GOME2A_NO2_TROP_COL')
%
% read number of GOME2A NO2 levels
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
      elseif strcmp(obs_kind_id(iirec),'MLS_O3_PROFILE')
%
% read number of MLS O3 levels
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
      elseif strcmp(obs_kind_id(iirec),'MLS_HNO3_PROFILE')
%
% read number of MLS HNO3 levels
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
      elseif strcmp(obs_kind_id(iirec),'TES_CO_PROFILE')
%
% read number of TES CO levels
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
      elseif strcmp(obs_kind_id(iirec),'TES_O3_PROFILE')
%
% read number of TES O3 levels
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
      else
         fprintf('APM ERROR: obs_kind not found \n')
         return
      end 
   end
   if(nobs==0)
      obs_val=-9999;
      obs_prior_mean=-9999;
      obs_post_mean=-9999;
      obs_prior_sprd=-9999;
      obs_post_sprd=-9999;
      obs_prior_mem=-9999;
      obs_post_mem=-9999;
      obs_npr=-9999;
      obs_psfc=-9999;
      obs_prs=-9999;
      obs_hgt=-9999;
   end
end
%
