function tes_nh3_cpsr_extract (filein,fileout,file_pre,cwyr_mn,cwmn_mn,cwdy_mn,cwhh_mn,cwmm_mn,cwss_mn,cwyr_mx,cwmn_mx,cwdy_mx,cwhh_mx,cwmm_mx,cwss_mx,path_mdl,file_mdl,cnx_mdl,cny_mdl)
  
%
% Get file list and number of files
   wyr_mn=str2double(cwyr_mn);
   wmn_mn=str2double(cwmn_mn);
   wdy_mn=str2double(cwdy_mn);
   whh_mn=str2double(cwhh_mn);
   wmm_mn=str2double(cwmm_mn);
   wss_mn=str2double(cwss_mn);
   wyr_mx=str2double(cwyr_mx);
   wmn_mx=str2double(cwmn_mx);
   wdy_mx=str2double(cwdy_mx);
   whh_mx=str2double(cwhh_mx);
   wmm_mx=str2double(cwmm_mx);
   wss_mx=str2double(cwss_mx);
   nx_mdl=str2double(cnx_mdl);
   ny_mdl=str2double(cny_mdl);

%
% Get file list and number of files
   command=strcat('rm'," ",'-rf'," ",fileout);
   [status]=system(command);
   fid=fopen(fileout,'w');
%
   command=strcat('ls'," ",'-1'," ",filein,'*')
   [status,file_list_a]=system(command)
   
   file_list_b=split(file_list_a);
   file_list=squeeze(file_list_b);
   nfile=size(file_list);
%
% Constants
   Ru=8.316;
   Rd=286.9;
   eps=0.61;
   molec_wt_co=.0480;
   molec_wt_no2=.0460;
   molec_wt_so2=.0641;
   AvogN=6.02214e23;
   msq2cmsq=1.e4;
   P_std=1013.25;
   grav=9.8;
   cone_fac=.715567;
%
% Convert DU to moles/m^2
   du2molpm2=4.4615e-4;
%
% Convert DU to molecules/m^2
   du2molcpm2=2.6867e20;
   day_secs_beg=whh_mn*60.*60. + wmm_mn*60. + wss_mn;
   day_secs_end=whh_mx*60.*60. + wmm_mx*60. + wss_mx;
%
% Print input data
   fprintf('obs window str %d %d %d %d %d %d \n',wyr_mn,wmn_mn,wdy_mn,whh_mn,wmm_mn,wss_mn)
   fprintf('obs window end %d %d %d %d %d %d \n',wyr_mx,wmn_mx,wdy_mx,whh_mx,wmm_mx,wss_mx)
%
% Read model grid
   lon_mdl=ncread(strcat(path_mdl,'/',file_mdl),'XLONG');
   lat_mdl=ncread(strcat(path_mdl,'/',file_mdl),'XLAT');
   delx=ncreadatt(strcat(path_mdl,'/',file_mdl),'/','DX');  
   cen_lat=ncreadatt(strcat(path_mdl,'/',file_mdl),'/','CEN_LAT');  
   cen_lon=ncreadatt(strcat(path_mdl,'/',file_mdl),'/','CEN_LON');  
   if(cen_lon<0)
      cen_lon=cen_lon+360.;
   end
   truelat1=ncreadatt(strcat(path_mdl,'/',file_mdl),'/','TRUELAT1');  
   truelat2=ncreadatt(strcat(path_mdl,'/',file_mdl),'/','TRUELAT2');  
   moad_cen_lat=ncreadatt(strcat(path_mdl,'/',file_mdl),'/','MOAD_CEN_LAT');  
   stand_lon=ncreadatt(strcat(path_mdl,'/',file_mdl),'/','STAND_LON');  
   pole_lat=ncreadatt(strcat(path_mdl,'/',file_mdl),'/','POLE_LAT');  
   pole_lon=ncreadatt(strcat(path_mdl,'/',file_mdl),'/','POLE_LON');
%
% Process satellite data
   for ifile=1:nfile
      clear time_start time_end
      clear nstep ntrk crnr layer level
      clear lat lon zenang time_utc
      clear nh3_lay vert_col_total vert_col_trop
      clear prior_lay prior_err_lay prs_lev
      clear trop_indx avgk_lay avgk_diag_lay noise_corr info_content
      file_in=char(file_list(ifile));
      if(isempty(file_in))
         continue
      end
      indx=strfind(file_in,file_pre)-1;
      if(isempty(indx))
         continue
      end
      field='/HDFEOS/ADDITIONAL/FILE_ATTRIBUTES';
      day=h5readatt(file_in,field,'GranuleDay');
      month=h5readatt(file_in,field,'GranuleMonth');
      year=h5readatt(file_in,field,'GranuleYear');
      field='/HDFEOS/SWATHS/NH3NadirSwath';
      zgrid=h5readatt(file_in,field,'VerticalCoordinate');
%
% Read Time
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/UTCTime';
      utc_time=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');
      title=h5readatt(file_in,field,'Title');
      defn=h5readatt(file_in,field,'UniqueFieldDefinition');
      units=h5readatt(file_in,field,'Units');
      nobs=size(utc_time);  % 14
      time_start=cell2mat(utc_time(1));
      time_end=cell2mat(utc_time(nobs(1)));

      file_str_yy=str2double(time_start(1:4));
      file_str_mm=str2double(time_start(6:7));
      file_str_dd=str2double(time_start(9:10));
      file_str_hh=str2double(time_start(12:13));
      file_str_mn=str2double(time_start(15:16));
      file_str_ss=round(str2double(time_start(18:23)));
      file_end_yy=str2double(time_end(1:4));
      file_end_mm=str2double(time_end(6:7));
      file_end_dd=str2double(time_end(9:10));
      file_end_hh=str2double(time_end(12:13));
      file_end_mn=str2double(time_end(15:16));
      file_end_ss=round(str2double(time_end(18:23)));
      
      file_str_secs=file_str_hh*3600 + file_str_mn*60 + file_str_ss;
      file_end_secs=file_end_hh*3600 + file_end_mn*60 + file_end_ss;
%      fprintf('%d %s \n',ifile,file_in);
%      fprintf('If file_str_secs %d <= day_secs_end %d, and \n',file_str_secs,day_secs_end);
%      fprintf('If file_end_secs %d >= day_secs_beg %d, then process data \n',file_end_secs,day_secs_beg);
      if(file_str_secs>day_secs_end | file_end_secs<day_secs_beg)
         continue
      end
      fprintf('READ TES DATA \n')
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Read TES data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% get dimensions
%      wfid=netcdf.open(file_in,'NC_NOWRITE');
%      [name,nstep]=netcdf.inqDim(wfid,0);
%      [name,ntrk]=netcdf.inqDim(wfid,1);
%      [name,crnr]=netcdf.inqDim(wfid,2);
%      [name,layer]=netcdf.inqDim(wfid,3);
%      [name,level]=netcdf.inqDim(wfid,4);
%      netcdf.close(wfid);
%
% averaging kernel (layer,layer,nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/AveragingKernel';
      avgk_lay=h5read(file_in,field);
      dims=size(avgk_lay);
      layer=dims(1);
      level=layer+1;
      nobs=dims(3);
      units=h5readatt(file_in,field,'Units');
%
% averaging kernel diagonal (layer,nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/AveragingKernelDiagonal';
      avgk_diag_lay=h5read(file_in,field);
%
% dofs(nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/DegreesOfFreedomForSignal';
      dofs=h5read(file_in,field);
%
% err_cov_mea(layer,layer,nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/MeasurementErrorCovariance';
      err_cov_mea=h5read(file_in,field);
%
% nh3_lay (layer,nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/NH3';
      nh3_lay=h5read(file_in,field);
      units=h5readatt(file_in,field,'Units');
%
% nh3_lay_prior (layer,nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/Initial';
      nh3_lay_prior=h5read(file_in,field);
      units=h5readatt(file_in,field,'Units');
%
% nh3_lay_err (layer,nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/NH3Precision';
      nh3_lay_err=h5read(file_in,field);
      units=h5readatt(file_in,field,'Units');
%
% nh3_trop col (nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/NH3TroposphericColumn';
      nh3_trop_col=h5read(file_in,field);
%
% nh3_trop_col_err (nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/NH3TroposphericColumnError';
      nh3_trop_col_err=h5read(file_in,field);
%
% nh3_trop_col_prior (nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/NH3TroposphericColumnInitial';
      nh3_trop_col_prior=h5read(file_in,field);
%
% nh3_total_col (nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/TotalColumnDensity';
      nh3_total_col=h5read(file_in,field);
%
% nh3_total_col_err (nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/TotalColumnDensityError';
      nh3_total_col_err=h5read(file_in,field);
%
% nh3_total_col_prior (nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/TotalColumnDensityInitial';
      nh3_total_col_prior=h5read(file_in,field);
%      
% err_cov_obs(layer,layer,nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/ObservationErrorCovariance';
      err_cov_obs=h5read(file_in,field);
%
% prs_lay (layer,nobs) Pressure is bottom to top (hPa)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/Pressure';
      prs_lay=h5read(file_in,field);
      units=h5readatt(file_in,field,'Units');
%
% total_err (layer,nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/TotalError';
      total_err=h5read(file_in,field);
%
% err_cov_total(layer,layer,nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/TotalErrorCovariance';
      err_cov_total=h5read(file_in,field);
%
% tropopause pressure(nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Data Fields/TropopausePressure';
      trop_pressure=h5read(file_in,field);
%
% lat (nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Geolocation Fields/Latitude';
      lat=h5read(file_in,field);
%
% lon (nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Geolocation Fields/Longitude';
      lon=h5read(file_in,field);
%
% zenang (nobs)
      field='/HDFEOS/SWATHS/NH3NadirSwath/Geolocation Fields/SolarZenithAngle';
      zenang=h5read(file_in,field);
%
% Loop through TES data
      windate_min=single(convert_time(wyr_mn,wmn_mn,wdy_mn,whh_mn,wmm_mn,wss_mn));
      windate_max=single(convert_time(wyr_mx,wmn_mx,wdy_mx,whh_mx,wmm_mx,wss_mx));
      icnt=0;
      for iobs=1:nobs
         utcc_time=cell2mat(utc_time(iobs));
         yyyy_tes=str2double(utcc_time(1:4));
         mn_tes=str2double(utcc_time(6:7));
         dy_tes=str2double(utcc_time(9:10));
         hh_tes=str2double(utcc_time(12:13));
         mm_tes=str2double(utcc_time(15:16));
         ss_tes=round(str2double(utcc_time(18:23)));
         tesdate=single(convert_time(yyyy_tes,mn_tes, ...
         dy_tes,hh_tes,mm_tes,ss_tes));

%
% Check time
%         fprintf('min_date %d, tes_date %d, max_date %d \n',windate_min,tesdate,windate_max)
         if(tesdate<windate_min | tesdate>windate_max)
            continue
         end
%
% QA/QC
%
         if(zenang(iobs)>=80.0)
            fprintf('APM: zenang %6.2f \n',zenang(iobs))
            continue
         end
         for ilay=1:layer
            if(isnan(nh3_lay(ilay,iobs)))
               fprintf('APM: nh3_lay has NaNs \n')
               continue
            end
         end
         if(isnan(nh3_trop_col(iobs)))
            fprintf('APM: nh3_trop_col is a NaN \n')
            continue
         end
         if(isnan(nh3_total_col(iobs)))
            fprintf('APM: nh3_total_col is a NaN \n')
            continue
         end
%
% Check domain
% Input grid needs to be in degrees
% X coordinate is [0 to 360]
         x_obser=lon(iobs);
         y_obser=lat(iobs);
         if(x_obser<0.)
            x_obser=360.+x_obser;
         end
%
         xmdl_sw=lon_mdl(1,1);
         if(xmdl_sw<0.)
            xmdl_sw=xmdl_sw+360.;
         end
         xmdl_mx=lon_mdl(nx_mdl,ny_mdl);
         if(xmdl_mx<0.)
            xmdl_mx=xmdl_mx+360.;
         end
%
         [xi,xj]=w3fb13(y_obser,x_obser,lat_mdl(1,1), ...
	 xmdl_sw,delx,cen_lon,truelat1,truelat2);
         i_min = round(xi);
         j_min = round(xj);
         reject = 0;
%
% Check lower bounds
         if(i_min<1 & round(xi)==0)
            i_min=1;
         elseif(i_min<1 & fix(xi)<0)
            i_min=-9999;
            j_min=-9999;
            reject=1;
         end
         if(j_min<1 & round(xj)==0)
            j_min=1;
         elseif (j_min<1 & fix(xj)<0)
            i_min=-9999;
            j_min=-9999;
            reject=1;
         end
%
% Check upper bounds
         if(i_min>nx_mdl & fix(xi)==nx_mdl)
            i_min=nx_mdl;
         elseif (i_min>nx_mdl & fix(xi)>nx_mdl)
            i_min=-9999;
            j_min=-9999;
            reject=1;
         end
         if(j_min>ny_mdl & fix(xj)==ny_mdl)
            j_min=ny_mdl;
         elseif (j_min>ny_mdl & fix(xj)>ny_mdl)
            i_min=-9999;
            j_min=-9999;
            reject=1;
         end
         if(reject==1)
            fprintf('x_mdl_min, x_obs, x_mdl_max: %6.2f %6.2f %6.2f \n',xmdl_sw, ...
            x_obser,xmdl_mx)
            fprintf('y_mdl_min, y_obs, y_mdl_max: %6.2f %6.2f %6.2f \n',lat_mdl(1,1), ...
            y_obser,lat_mdl(nx_mdl,ny_mdl))
            fprintf('i_min %d j_min %d \n',i_min,j_min)
            continue
         end
         if(i_min<1 | i_min>nx_mdl | j_min<1 | j_min>ny_mdl)
            fprintf('NO REJECT: i_min %d j_min %d \n',i_min,j_min)
            continue
         end
%
% Save data to ascii file
         icnt=icnt+1;
         fprintf(fid,'TES_NH3_Obs: %d %d %d \n',icnt,i_min,j_min);
         fprintf(fid,'%d %d %d %d %d %d \n',yyyy_tes, ...
         mn_tes,dy_tes,hh_tes,mm_tes,ss_tes);
         fprintf(fid,'%14.8f %14.8f \n',lat(iobs),lon(iobs));
         fprintf(fid,'%d %d \n',layer,level);
         fprintf(fid,'%14.8g ',prs_lay(1:layer,iobs));
         fprintf(fid,'\n');
         fprintf(fid,'%14.8g ',trop_pressure(iobs));
         fprintf(fid,'\n');
         fprintf(fid,'%14.8g ',nh3_lay(1:layer,iobs));
         fprintf(fid,'\n');
         fprintf(fid,'%14.8g ',nh3_lay_prior(1:layer,iobs));
         fprintf(fid,'\n');
         fprintf(fid,'%14.8g ',nh3_lay_err(1:layer,iobs));
         fprintf(fid,'\n');
         fprintf(fid,'%14.8g ',dofs(iobs));
         fprintf(fid,'\n');
         for k=1:layer
            fprintf(fid,'%14.8g ',avgk_lay(k,1:layer,iobs));
            fprintf(fid,'\n');
	 end
         fprintf(fid,'%14.8g ',avgk_diag_lay(1:layer,iobs));
         fprintf(fid,'\n');
         for k=1:layer
            fprintf(fid,'%14.8g ',err_cov_obs(k,1:layer,iobs));
            fprintf(fid,'\n');
	 end
         for k=1:layer
            fprintf(fid,'%14.8g ',err_cov_total(k,1:layer,iobs));
            fprintf(fid,'\n');
	 end
         fprintf(fid,'%14.8g \n',nh3_trop_col(iobs));
         fprintf(fid,'%14.8g \n',nh3_trop_col_prior(iobs));
         fprintf(fid,'%14.8g \n',nh3_trop_col_err(iobs));
         fprintf(fid,'%14.8g \n',nh3_total_col(iobs));
         fprintf(fid,'%14.8g \n',nh3_total_col_prior(iobs));
         fprintf(fid,'%14.8g \n',nh3_total_col_err(iobs));
      end
   end  
end
function [fld_interp]=prs_interp(fld,i_tmp,j_tmp,i_mdl,j_mdl, ...
   x_tmp,y_tmp,p_tmp,nz_tmp,x_mdl,y_mdl,p_mdl,nz_mdl)
%
% Interpolation weights
   x_wt_m=x_mdl(i_mdl+1)-x_tmp(i_tmp,j_tmp);
   x_wt_p=x_tmp(i_tmp,j_tmp)-x_mdl(i_mdl);
   y_wt_m=y_mdl(j_mdl+1)-y_tmp(i_tmp,j_tmp);
   y_wt_p=y_tmp(i_tmp,j_tmp)-y_mdl(j_mdl);
%
   k_mdl_ll=0;
   for k_tmp=1:nz_tmp
      fld_interp(k_tmp,i_tmp,j_tmp)=0.;
%
% LL corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl,j_mdl,1)>=p_tmp(k_tmp))
	    k_mdl_ll=1;
            break
         end
	    if(k_mdl==nz_mdl-1 & p_mdl(i_mdl,j_mdl,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_ll=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl,j_mdl,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl,j_mdl,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_ll=k_mdl;
            break
         end
      end
%
% LR corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl+1,j_mdl,1)>=p_tmp(k_tmp))
	    k_mdl_lr=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl+1,j_mdl,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_lr=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl+1,j_mdl,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl+1,j_mdl,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_lr=k_mdl;
            break
         end
      end
%
% UL corner
      for k_mdl=1:nz_mdl-1
         if(k_mdl==1 & p_mdl(i_mdl,j_mdl+1,1)>=p_tmp(k_tmp))
	    k_mdl_ul=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl,j_mdl+1,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_ul=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl,j_mdl+1,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl,j_mdl+1,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_ul=k_mdl;
            break
         end
      end
%
% UR corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl+1,j_mdl+1,1)>=p_tmp(k_tmp))
	    k_mdl_ur=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl+1,j_mdl+1,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_ur=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl+1,j_mdl+1,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl+1,j_mdl+1,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_ur=k_mdl;
            break
         end
      end
%
      fld_y_m_z_m=(fld(i_mdl,j_mdl,k_mdl_ll)*x_wt_m + fld(i_mdl+1,j_mdl,k_mdl_lr)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_p_z_m=(fld(i_mdl,j_mdl+1,k_mdl_ul)*x_wt_m + fld(i_mdl+1,j_mdl+1,k_mdl_ur)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_m_z_p=(fld(i_mdl,j_mdl,k_mdl_ll+1)*x_wt_m + fld(i_mdl+1,j_mdl,k_mdl_lr+1)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_p_z_p=(fld(i_mdl,j_mdl+1,k_mdl_ul+1)*x_wt_m + fld(i_mdl+1,j_mdl+1,k_mdl_ur+1)*x_wt_p)/(x_wt_m+x_wt_p);
%
      prs_y_m_z_m=(p_mdl(i_mdl,j_mdl,k_mdl_ll)*x_wt_m + p_mdl(i_mdl+1,j_mdl,k_mdl_lr)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_p_z_m=(p_mdl(i_mdl,j_mdl+1,k_mdl_ul)*x_wt_m + p_mdl(i_mdl+1,j_mdl+1,k_mdl_ur)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_m_z_p=(p_mdl(i_mdl,j_mdl,k_mdl_ll+1)*x_wt_m + p_mdl(i_mdl+1,j_mdl,k_mdl_lr+1)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_p_z_p=(p_mdl(i_mdl,j_mdl+1,k_mdl_ul+1)*x_wt_m + p_mdl(i_mdl+1,j_mdl+1,k_mdl_ur+1)*x_wt_p) /(x_wt_m+x_wt_p);
%
      fld_z_m=(fld_y_m_z_m*y_wt_m + fld_y_p_z_m*y_wt_p)/(y_wt_m+y_wt_p);
      fld_z_p=(fld_y_m_z_p*y_wt_m + fld_y_p_z_p*y_wt_p)/(y_wt_m+y_wt_p);
%
      prs_z_m=(prs_y_m_z_m*y_wt_m + prs_y_p_z_m*y_wt_p)/(y_wt_m+y_wt_p);
      prs_z_p=(prs_y_m_z_p*y_wt_m + prs_y_p_z_p*y_wt_p)/(y_wt_m+y_wt_p);
%
      z_wt_m=prs_z_p-p_tmp(k_tmp);
      z_wt_p=p_tmp(k_tmp)-prs_z_m;
%
      if(prs_z_m>=p_tmp(k_tmp))
	fld_interp(k_tmp)=fld_z_m;
      end
      if(prs_z_p<=p_tmp(k_tmp))
	fld_interp(k_tmp)=fld_z_p;
      end
      if(prs_z_m<p_tmp(k_tmp) & ...
      prs_z_p>p_tmp(k_tmp))
	fld_interp(k_tmp)=(fld_z_m*z_wt_m + fld_z_p*z_wt_p)/(z_wt_m+z_wt_p);
      end
   end
end
%
function [fld_interp]=prs_interp_top_to_bot(fld,i_tmp,j_tmp,i_mdl,j_mdl, ...
   x_tmp,y_tmp,p_tmp,nz_tmp,x_mdl,y_mdl,p_mdl,nz_mdl)
%
% Model runs top to bottom (nz_mdl)
% Observation runs top to bottom (nz_tmp)
%
% Interpolation weights
   x_wt_m=x_mdl(i_mdl+1)-x_tmp(i_tmp,j_tmp);
   x_wt_p=x_tmp(i_tmp,j_tmp)-x_mdl(i_mdl);
   y_wt_m=y_mdl(j_mdl+1)-y_tmp(i_tmp,j_tmp);
   y_wt_p=y_tmp(i_tmp,j_tmp)-y_mdl(j_mdl);
%
   k_mdl_ll=0;
   for k_tmp=1:nz_tmp
      fld_interp(k_tmp,i_tmp,j_tmp)=0.;
%
% LL corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl,j_mdl,1)>=p_tmp(k_tmp))
	    k_mdl_ll=1;
            break
         end
	 if(k_mdl==nz_mdl-1 & p_mdl(i_mdl,j_mdl,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_ll=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl,j_mdl,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl,j_mdl,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_ll=k_mdl;
            break
         end
      end
%
% LR corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl+1,j_mdl,1)>=p_tmp(k_tmp))
	    k_mdl_lr=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl+1,j_mdl,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_lr=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl+1,j_mdl,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl+1,j_mdl,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_lr=k_mdl;
            break
         end
      end
%
% UL corner
      for k_mdl=1:nz_mdl-1
         if(k_mdl==1 & p_mdl(i_mdl,j_mdl+1,1)>=p_tmp(k_tmp))
	    k_mdl_ul=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl,j_mdl+1,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_ul=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl,j_mdl+1,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl,j_mdl+1,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_ul=k_mdl;
            break
         end
      end
%
% UR corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl+1,j_mdl+1,1)>=p_tmp(k_tmp))
	    k_mdl_ur=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl+1,j_mdl+1,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_ur=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl+1,j_mdl+1,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl+1,j_mdl+1,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_ur=k_mdl;
            break
         end
      end
%
      fld_y_m_z_m=(fld(i_mdl,j_mdl,k_mdl_ll)*x_wt_m + fld(i_mdl+1,j_mdl,k_mdl_lr)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_p_z_m=(fld(i_mdl,j_mdl+1,k_mdl_ul)*x_wt_m + fld(i_mdl+1,j_mdl+1,k_mdl_ur)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_m_z_p=(fld(i_mdl,j_mdl,k_mdl_ll+1)*x_wt_m + fld(i_mdl+1,j_mdl,k_mdl_lr+1)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_p_z_p=(fld(i_mdl,j_mdl+1,k_mdl_ul+1)*x_wt_m + fld(i_mdl+1,j_mdl+1,k_mdl_ur+1)*x_wt_p)/(x_wt_m+x_wt_p);
%
      prs_y_m_z_m=(p_mdl(i_mdl,j_mdl,k_mdl_ll)*x_wt_m + p_mdl(i_mdl+1,j_mdl,k_mdl_lr)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_p_z_m=(p_mdl(i_mdl,j_mdl+1,k_mdl_ul)*x_wt_m + p_mdl(i_mdl+1,j_mdl+1,k_mdl_ur)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_m_z_p=(p_mdl(i_mdl,j_mdl,k_mdl_ll+1)*x_wt_m + p_mdl(i_mdl+1,j_mdl,k_mdl_lr+1)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_p_z_p=(p_mdl(i_mdl,j_mdl+1,k_mdl_ul+1)*x_wt_m + p_mdl(i_mdl+1,j_mdl+1,k_mdl_ur+1)*x_wt_p) /(x_wt_m+x_wt_p);
%
      fld_z_m=(fld_y_m_z_m*y_wt_m + fld_y_p_z_m*y_wt_p)/(y_wt_m+y_wt_p);
      fld_z_p=(fld_y_m_z_p*y_wt_m + fld_y_p_z_p*y_wt_p)/(y_wt_m+y_wt_p);
%
      prs_z_m=(prs_y_m_z_m*y_wt_m + prs_y_p_z_m*y_wt_p)/(y_wt_m+y_wt_p);
      prs_z_p=(prs_y_m_z_p*y_wt_m + prs_y_p_z_p*y_wt_p)/(y_wt_m+y_wt_p);
%
      z_wt_m=prs_z_p-p_tmp(k_tmp);
      z_wt_p=p_tmp(k_tmp)-prs_z_m;
%
      if(prs_z_m>=p_tmp(k_tmp))
	fld_interp(k_tmp)=fld_z_m;
      end
      if(prs_z_p<=p_tmp(k_tmp))
	fld_interp(k_tmp)=fld_z_p;
      end
      if(prs_z_m<p_tmp(k_tmp) & ...
      prs_z_p>p_tmp(k_tmp))
	fld_interp(k_tmp)=(fld_z_m*z_wt_m + fld_z_p*z_wt_p)/(z_wt_m+z_wt_p);
      end
   end
end
%
function [fld_interp]=prs_interp_bot_to_top(fld,i_tmp,j_tmp,i_mdl,j_mdl, ...
   x_tmp,y_tmp,p_tmp,nz_tmp,x_mdl,y_mdl,p_mdl,nz_mdl)
%
% Model runs top to bottom (nz_mdl)
% Observation runs bottom to top (nz_tmp)
% Reverse the observation profile (top to bottom), interpolate model to the observation grid,
% and then reverse interpolated model field so it runs bottom to top.
%
  for k_tmp=1:nz_tmp
     kk_tmp=nz_tmp-k_tmp+1;
     p_tmp_rev(k_tmp)=p_tmp(kk_tmp);
  end
%
% Interpolation weights
   x_wt_m=x_mdl(i_mdl+1)-x_tmp(i_tmp,j_tmp);
   x_wt_p=x_tmp(i_tmp,j_tmp)-x_mdl(i_mdl);
   y_wt_m=y_mdl(j_mdl+1)-y_tmp(i_tmp,j_tmp);
   y_wt_p=y_tmp(i_tmp,j_tmp)-y_mdl(j_mdl);
%
   k_mdl_ll=0;
   for k_tmp=1:nz_tmp
      fld_interp(k_tmp,i_tmp,j_tmp)=0.;
%
% LL corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl,j_mdl,1)>=p_tmp_rev(k_tmp))
	    k_mdl_ll=1;
            break
         end
	 if(k_mdl==nz_mdl-1 & p_mdl(i_mdl,j_mdl,nz_mdl)<=p_tmp_rev(k_tmp))
	    k_mdl_ll=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl,j_mdl,k_mdl)<p_tmp_rev(k_tmp) & ...
	 p_mdl(i_mdl,j_mdl,k_mdl+1)>=p_tmp_rev(k_tmp))
            k_mdl_ll=k_mdl;
            break
         end
      end
%
% LR corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl+1,j_mdl,1)>=p_tmp_rev(k_tmp))
	    k_mdl_lr=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl+1,j_mdl,nz_mdl)<=p_tmp_rev(k_tmp))
	    k_mdl_lr=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl+1,j_mdl,k_mdl)<p_tmp_rev(k_tmp) & ...
	 p_mdl(i_mdl+1,j_mdl,k_mdl+1)>=p_tmp_rev(k_tmp))
            k_mdl_lr=k_mdl;
            break
         end
      end
%
% UL corner
      for k_mdl=1:nz_mdl-1
         if(k_mdl==1 & p_mdl(i_mdl,j_mdl+1,1)>=p_tmp_rev(k_tmp))
	    k_mdl_ul=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl,j_mdl+1,nz_mdl)<=p_tmp_rev(k_tmp))
	    k_mdl_ul=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl,j_mdl+1,k_mdl)<p_tmp_rev(k_tmp) & ...
	 p_mdl(i_mdl,j_mdl+1,k_mdl+1)>=p_tmp_rev(k_tmp))
            k_mdl_ul=k_mdl;
            break
         end
      end
%
% UR corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl+1,j_mdl+1,1)>=p_tmp_rev(k_tmp))
	    k_mdl_ur=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl+1,j_mdl+1,nz_mdl)<=p_tmp_rev(k_tmp))
	    k_mdl_ur=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl+1,j_mdl+1,k_mdl)<p_tmp_rev(k_tmp) & ...
	 p_mdl(i_mdl+1,j_mdl+1,k_mdl+1)>=p_tmp_rev(k_tmp))
            k_mdl_ur=k_mdl;
            break
         end
      end
%
      fld_y_m_z_m=(fld(i_mdl,j_mdl,k_mdl_ll)*x_wt_m + fld(i_mdl+1,j_mdl,k_mdl_lr)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_p_z_m=(fld(i_mdl,j_mdl+1,k_mdl_ul)*x_wt_m + fld(i_mdl+1,j_mdl+1,k_mdl_ur)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_m_z_p=(fld(i_mdl,j_mdl,k_mdl_ll+1)*x_wt_m + fld(i_mdl+1,j_mdl,k_mdl_lr+1)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_p_z_p=(fld(i_mdl,j_mdl+1,k_mdl_ul+1)*x_wt_m + fld(i_mdl+1,j_mdl+1,k_mdl_ur+1)*x_wt_p)/(x_wt_m+x_wt_p);
%
      prs_y_m_z_m=(p_mdl(i_mdl,j_mdl,k_mdl_ll)*x_wt_m + p_mdl(i_mdl+1,j_mdl,k_mdl_lr)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_p_z_m=(p_mdl(i_mdl,j_mdl+1,k_mdl_ul)*x_wt_m + p_mdl(i_mdl+1,j_mdl+1,k_mdl_ur)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_m_z_p=(p_mdl(i_mdl,j_mdl,k_mdl_ll+1)*x_wt_m + p_mdl(i_mdl+1,j_mdl,k_mdl_lr+1)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_p_z_p=(p_mdl(i_mdl,j_mdl+1,k_mdl_ul+1)*x_wt_m + p_mdl(i_mdl+1,j_mdl+1,k_mdl_ur+1)*x_wt_p) /(x_wt_m+x_wt_p);
%
      fld_z_m=(fld_y_m_z_m*y_wt_m + fld_y_p_z_m*y_wt_p)/(y_wt_m+y_wt_p);
      fld_z_p=(fld_y_m_z_p*y_wt_m + fld_y_p_z_p*y_wt_p)/(y_wt_m+y_wt_p);
%
      prs_z_m=(prs_y_m_z_m*y_wt_m + prs_y_p_z_m*y_wt_p)/(y_wt_m+y_wt_p);
      prs_z_p=(prs_y_m_z_p*y_wt_m + prs_y_p_z_p*y_wt_p)/(y_wt_m+y_wt_p);
%
      z_wt_m=prs_z_p-p_tmp_rev(k_tmp);
      z_wt_p=p_tmp_rev(k_tmp)-prs_z_m;
%
      if(prs_z_m>=p_tmp_rev(k_tmp))
	fld_interp(k_tmp)=fld_z_m;
      end
      if(prs_z_p<=p_tmp_rev(k_tmp))
	fld_interp(k_tmp)=fld_z_p;
      end
      if(prs_z_m<p_tmp_rev(k_tmp) & ...
      prs_z_p>p_tmp_rev(k_tmp))
	fld_interp(k_tmp)=(fld_z_m*z_wt_m + fld_z_p*z_wt_p)/(z_wt_m+z_wt_p);
      end
   end
%
% Reverse the interpolated model field
  for k_tmp=1:nz_tmp
     p_tmp_rev(k_tmp)=fld_interp(k_tmp);
  end
  for k_tmp=1:nz_tmp
     kk_tmp=nz_tmp-k_tmp+1;
     fld_interp(k_tmp)=p_tmp_rev(kk_tmp);
  end
end
%
function [fld_interp]=prs_interp_nh3l(fld,i_tmp,j_tmp,i_mdl,j_mdl, ...
   x_tmp,y_tmp,p_tmp,nz_tmp,x_mdl,y_mdl,p_mdl,nz_mdl)
%
% Interpolation weights
   x_wt_m=x_mdl(i_mdl+1)-x_tmp(i_tmp,j_tmp);
   x_wt_p=x_tmp(i_tmp,j_tmp)-x_mdl(i_mdl);
   y_wt_m=y_mdl(j_mdl+1)-y_tmp(i_tmp,j_tmp);
   y_wt_p=y_tmp(i_tmp,j_tmp)-y_mdl(j_mdl);
%
   k_mdl_ll=0;
   for k_tmp=1:nz_tmp
%
% LL corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl,j_mdl,1)>=p_tmp(k_tmp))
	    k_mdl_ll=1;
            break
         end
	    if(k_mdl==nz_mdl-1 & p_mdl(i_mdl,j_mdl,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_ll=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl,j_mdl,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl,j_mdl,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_ll=k_mdl;
            break
         end
      end
%
% LR corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl+1,j_mdl,1)>=p_tmp(k_tmp))
	    k_mdl_lr=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl+1,j_mdl,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_lr=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl+1,j_mdl,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl+1,j_mdl,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_lr=k_mdl;
            break
         end
      end
%
% UL corner
      for k_mdl=1:nz_mdl-1
         if(k_mdl==1 & p_mdl(i_mdl,j_mdl+1,1)>=p_tmp(k_tmp))
	    k_mdl_ul=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl,j_mdl+1,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_ul=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl,j_mdl+1,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl,j_mdl+1,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_ul=k_mdl;
            break
         end
      end
%
% UR corner
      for k_mdl=1:nz_mdl-1
	 if(k_mdl==1 & p_mdl(i_mdl+1,j_mdl+1,1)>=p_tmp(k_tmp))
	    k_mdl_ur=1;
            break
         end
         if(k_mdl==nz_mdl-1 & p_mdl(i_mdl+1,j_mdl+1,nz_mdl)<=p_tmp(k_tmp))
	    k_mdl_ur=nz_mdl-1;
            break
         end
	 if(p_mdl(i_mdl+1,j_mdl+1,k_mdl)<p_tmp(k_tmp) & ...
	 p_mdl(i_mdl+1,j_mdl+1,k_mdl+1)>=p_tmp(k_tmp))
            k_mdl_ur=k_mdl;
            break
         end
      end
%
      fld_y_m_z_m=(fld(i_mdl,j_mdl,k_mdl_ll)*x_wt_m + fld(i_mdl+1,j_mdl,k_mdl_lr)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_p_z_m=(fld(i_mdl,j_mdl+1,k_mdl_ul)*x_wt_m + fld(i_mdl+1,j_mdl+1,k_mdl_ur)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_m_z_p=(fld(i_mdl,j_mdl,k_mdl_ll+1)*x_wt_m + fld(i_mdl+1,j_mdl,k_mdl_lr+1)*x_wt_p)/(x_wt_m+x_wt_p);
      fld_y_p_z_p=(fld(i_mdl,j_mdl+1,k_mdl_ul+1)*x_wt_m + fld(i_mdl+1,j_mdl+1,k_mdl_ur+1)*x_wt_p)/(x_wt_m+x_wt_p);
%
      prs_y_m_z_m=(p_mdl(i_mdl,j_mdl,k_mdl_ll)*x_wt_m + p_mdl(i_mdl+1,j_mdl,k_mdl_lr)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_p_z_m=(p_mdl(i_mdl,j_mdl+1,k_mdl_ul)*x_wt_m + p_mdl(i_mdl+1,j_mdl+1,k_mdl_ur)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_m_z_p=(p_mdl(i_mdl,j_mdl,k_mdl_ll+1)*x_wt_m + p_mdl(i_mdl+1,j_mdl,k_mdl_lr+1)*x_wt_p)/(x_wt_m+x_wt_p);
      prs_y_p_z_p=(p_mdl(i_mdl,j_mdl+1,k_mdl_ul+1)*x_wt_m + p_mdl(i_mdl+1,j_mdl+1,k_mdl_ur+1)*x_wt_p) /(x_wt_m+x_wt_p);
%
      fld_z_m=(fld_y_m_z_m*y_wt_m + fld_y_p_z_m*y_wt_p)/(y_wt_m+y_wt_p);
      fld_z_p=(fld_y_m_z_p*y_wt_m + fld_y_p_z_p*y_wt_p)/(y_wt_m+y_wt_p);
%
      prs_z_m=(prs_y_m_z_m*y_wt_m + prs_y_p_z_m*y_wt_p)/(y_wt_m+y_wt_p);
      prs_z_p=(prs_y_m_z_p*y_wt_m + prs_y_p_z_p*y_wt_p)/(y_wt_m+y_wt_p);
%
      z_wt_m=prs_z_p-p_tmp(k_tmp);
      z_wt_p=p_tmp(k_tmp)-prs_z_m;
%
      if(prs_z_m>=p_tmp(k_tmp))
	fld_interp(k_tmp)=fld_z_m;
      end
      if(prs_z_p<=p_tmp(k_tmp))
	fld_interp(k_tmp)=fld_z_p;
      end
      if(prs_z_m<p_tmp(k_tmp) & ...
      prs_z_p>p_tmp(k_tmp))
	fld_interp(k_tmp)=(fld_z_m*z_wt_m + fld_z_p*z_wt_p)/(z_wt_m+z_wt_p);
      end
   end
end
%
function [jult]=convert_time(year,month,day,hour,minute,second)
   days_per_mon=[31 28 31 30 31 30 31 31 30 31 30 31]; 
   ref_year=2010;
   ref_month=1;
   ref_day=1;
   ref_hour=0;
   ref_minute=0;
   ref_second=0;
   secs_year=365.*24.*60.*60.;
   secs_leap_year=366.*24.*60.*60.;
   jult=0;
%
% NOTE: hours run 0 - 23
   if(hour>23)
      'APM: ERROR - hour must be less than or equal to 23'
      return
   end
   if(ref_year>year)
      'APM: ERROR - year must greater than or equal to 2010'
      return
   end
%
   for iyear=ref_year:year-1
      if((mod(int64(iyear),4)==0 & mod(int64(iyear), ...
      100)~=0) || (mod(int64(iyear),400)==0))
         jult=jult+secs_leap_year;
      else
         jult=jult+secs_year;
      end
   end
   for imon=1:month-1
      if(imon==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),400)==0)))
         jult=jult+(days_per_mon(imon)+1)*24.*60.*60.;
      else
         jult=jult+days_per_mon(imon)*24.*60.*60.;
      end
   end
   jult=jult+(day-1)*24.*60.*60.;
   jult=jult+hour*60.*60.+minute*60.+second;
end
%
function [year,month,day,hour,minute,second]=invert_time(jult)
   days_mon=[31 28 31 30 31 30 31 31 30 31 30 31]; 
   ref_year=2000;
   ref_month=1;
   ref_day=1;
   ref_hour=0;
   ref_minute=0;
   ref_second=0;
   secs_year=365.*24.*60.*60.;
   secs_leap_year=366.*24.*60.*60.;
%
   if((mod(int64(ref_year),4)==0 & mod(int64(ref_year), ...
   100)~=0) || (mod(int64(ref_year),400)==0))
      secs_gone=secs_leap_year;
   else
      secs_gone=secs_year;
   end
   year=ref_year;
   while (jult>secs_gone)
      jult=jult-secs_gone;
      year=year+1.;
      if((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),400)==0))
         secs_gone=secs_leap_year;
      else
         secs_gone=secs_year;
      end
   end
   yeart=year;
   for imon=1:12
      if(imon==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),400)==0)))
         secs_gone=(days_mon(imon)+1)*24.*60.*60.;
      else
         secs_gone=days_mon(imon)*24.*60.*60.;
      end
      if(jult>=secs_gone) 
	 jult=jult-secs_gone;
      else
	 month=imon;
         break
      end
   end
   montht=month;
   day=floor(jult/24./60./60.)+1;
   dayt=day;
   jult=jult-(day-1)*24.*60.*60.;
   hour=floor(jult/60./60.);
   hourt=hour;
   jult=jult-hour*60.*60.;
   minute=floor(jult/60.);
   minutet=minute;
   second=jult-minute*60.;
   secondt=second;
   hourt=hourt+12;
   [year,month,day,hour,minute,second]=incr_time(yeart, ...
   montht,dayt,hourt,minutet,secondt);
end
%
function [secs_tai93,rc]=time_tai93(year,month,day,hour,minute,second)
   days_per_mon=[31 28 31 30 31 30 31 31 30 31 30 31]; 
   ref_year=1993;
   ref_month=1;
   ref_day=1;
   ref_hour=0;
   ref_minute=0;
   ref_second=0;
   secs_year=365.*24.*60.*60.;
   secs_leap_year=366.*24.*60.*60.;
   jult=0;
%
% NOTE: hours run 0 - 23
   if(hour>23)
      'APM: ERROR - hour must be less than or equal to 23'
      return
   end
   if(ref_year>year)
      'APM: ERROR - year must greater than or equal to 2010'
      return
   end
%
   for iyear=ref_year:year-1
      if((mod(int64(iyear),4)==0 & mod(int64(iyear), ...
      100)~=0) || (mod(int64(iyear),400)==0))
         jult=jult+secs_leap_year;
      else
         jult=jult+secs_year;
      end
   end
   for imon=1:month-1
      if(imon==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),400)==0)))
         jult=jult+(days_per_mon(imon)+1)*24.*60.*60.;
      else
         jult=jult+days_per_mon(imon)*24.*60.*60.;
      end
   end
   jult=jult+(day-1)*24.*60.*60.;
   jult=jult+hour*60.*60.+minute*60.+second;
%
   rc=0;
   secs_tai93=jult;
end
%
function [yyyy,mn,dy,hh,mm,ss]=incr_time(year, ...
month,day,hour,minute,second);
   days_per_month=[31,28,31,30,31,30,31,31,30,31,30,31];
%
% Check for negative time / date
   if(second<0)
      minute=minute-1;
      second=60+second;
   end
   if(minute<0)
      hour=hour-1;
      minute=60-minute;
   end
   if(hour<0)
      day=day-1;
      hour=60-hour;
   end
   if(day<=0)
      if(imon==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),400)==0)))
         days_mon=days_per_month(month)+1;
      else
         days_mon=days_per_month(month);
      end
      month=month-1;
      day=day_mon-day;
   end
   if(month<=0)
     month=12;
     year=year-1;
   end
%
% Check if time / date too large

   if(second>59) 
      if(second>119)
         fprintf('APM: Error seconds too large %d \n',int64(second))
         return
      end
      second=second-60;
      minute=minute+1;
   end
   if(minute>59)
     if(minute>119)
         fprintf('APM: Error minutes too large %d \n',int64(minute))
         return
      end
      minute=minute-60;
      hour=hour+1;
   end
   if(hour>23)
      if(hour>47)
         fprintf('APM: Error hours too large %d \n',int64(hour))
         return
      end
      hour=hour-24;
      day=day+1;
   end
   days_mon=days_per_month(month);
   if(int64(month)==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
   100)~=0) || (mod(int64(year),400)==0)))
      days_mon=days_mon+1;
   end
   if(day>days_mon)
     if(day>(days_mon+days+mon))
         fprintf('APM: Error days too large %d \n',day)
         return
      end
      day=day-days_mon;
      month=month+1;
   end
   if(month>12)
      if(month>24)
         fprintf('APM: Error month too large %d \n',month)
         return
      end
     month=month-12;
     year=year+1;
   end
   yyyy=year;
   mn=month;
   dy=day;
   hh=hour;
   mm=minute;
   ss=second;
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
