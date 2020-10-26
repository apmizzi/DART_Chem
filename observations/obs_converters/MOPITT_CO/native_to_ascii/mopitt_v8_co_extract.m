function main (filein,fileout,file_pre,cwyr_mn,cwmn_mn,cwdy_mn,cwhh_mn,cwmm_mn,cwss_mn,cwyr_mx,cwmn_mx,cwdy_mx,cwhh_mx,cwmm_mx,cwss_mx,clon_min,clon_max,clat_min,clat_max)
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
   lon_min=str2double(clon_min);
   lon_max=str2double(clon_max);
   lat_min=str2double(clat_min);
   lat_max=str2double(clat_max);
%
   command=strcat('rm'," ",'-rf'," ",fileout);
   [status]=system(command);
   fid=fopen(fileout,'w');
%
   command=strcat('ls'," ",'-1'," ",filein,'*');
   [status,file_list_a]=system(command);
   file_list_b=split(file_list_a);
   file_list=squeeze(file_list_b)   
   nfile=size(file_list);
%
% Constants
   Ru=8.316;
   Rd=286.9;
   eps=0.61;
   molec_wt_o3=.0480;
   molec_wt_no2=.0460;
   molec_wt_so2=.0641;
   AvogN=6.02214e23;
   msq2cmsq=1.e4;
   P_std=1013.25;
   grav=9.8;
%
% Convert DU to moles/m^2
   du2molpm2=4.4615e-4;
%
% Convert DU to molecules/m^2
%
   du2molcpm2=2.6867e20;
   day_secs_beg=whh_mn*60.*60. + wmm_mn*60. + wss_mn;
   day_secs_end=whh_mx*60.*60. + wmm_mx*60. + wss_mx;
%
% Print input data
   fprintf('obs window str %d %d %d %d %d %d \n',wyr_mn,wmn_mn,wdy_mn,whh_mn,wmm_mn,wss_mn)
   fprintf('obs window end %d %d %d %d %d %d \n',wyr_mx,wmn_mx,wdy_mx,whh_mx,wmm_mx,wss_mx)
   fprintf('domain bounds %d %d %d %d \n',lat_min,lat_max,lon_min,lon_max)
%
   for ifile=1:nfile
      file_in=char(file_list(ifile));
      indx=strfind(file_in,file_pre)-1;
      if(isempty(indx))
         continue
      end
      file_hh=00;
      file_mm=00;
      file_secs_str=file_hh*60.*60. + file_mm*60.;
      file_hh=23;
      file_mm=59;
      file_secs_end=file_hh*60.*60. + file_mm*60. + 59.;

      fprintf('%d %s \n',ifile,file_in);
      fprintf('%d %d %d \n',day_secs_beg,file_secs_str,day_secs_end);
      fprintf('%d %d %d \n',day_secs_beg,file_secs_end,day_secs_end);
%       
%      if((file_secs_str<day_secs_beg | file_secs>day_secs_end)
%         continue
%      end
%      fprintf('%d %s \n',ifile,file_in)
%      fprintf('%d %d %d \n',day_secs_beg,file_secs,day_secs_end)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Read MOPITT data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% For nid: 1 - value; 2 - uncertainty
% date data
      field='/HDFEOS/ADDITIONAL/FILE_ATTRIBUTES/';
      day=h5readatt(file_in,field,'Day');
      month=h5readatt(file_in,field,'Month');
      str_time=h5readatt(file_in,field,'StartDateTime');
      year=h5readatt(file_in,field,'Year');
% prior_prof_lay(nid,layer,numobs) (ppbv)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/APrioriCOMixingRatioProfile';
      prior_prof_lay=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
      tmp=size(prior_prof_lay);
      nid=tmp(1);
      layer=tmp(2);
      numobs=tmp(3);
      level=layer+1;
% prior_sfc(nid,numobs) (ppbv)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/APrioriCOSurfaceMixingRatio';
      prior_sfc=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% prior_col_amt(numobs) (ppbv) 
      field='/HDFEOS/SWATHS/MOP02/Data Fields/APrioriCOTotalColumn';
      prior_col_amt=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% avgk_row_sum_lev(level,numobs) (uses log10 VMR)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/AveragingKernelRowSums';
      avgk_row_sum_lev=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% dofs(numobs) (dimless)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/DegreesofFreedomforSignal';
      dofs=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% dry_col_amt(numobs) (molec/cm2)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/DryAirColumn';
      dry_col_amt=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% cov_m(level,level,numobs) 
      field='/HDFEOS/SWATHS/MOP02/Data Fields/MeasurementErrorCovarianceMatrix';
      cov_m=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% prs_grd(layer) (hPa)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/PressureGrid';
      prs_grd=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% avgk_lev(level,level,numobs) (uses log10 VMR)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/RetrievalAveragingKernelMatrix';
      avgk_lev=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% cov_r(level,level,numobs) 
      field='/HDFEOS/SWATHS/MOP02/Data Fields/RetrievalErrorCovarianceMatrix';
      cov_r=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% retr_prof_lay(nid,layer,numobs) (ppbv)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/RetrievedCOMixingRatioProfile';
      retr_prof_lay=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% retr_sfc(nid,numobs) (ppbv)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/RetrievedCOSurfaceMixingRatio';
      retr_sfc=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% retr_col_amt(nid,numobs) (molec/cm2)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/RetrievedCOTotalColumn';
      retr_col_amt=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% cov_s(level,level,numobs) 
      field='/HDFEOS/SWATHS/MOP02/Data Fields/SmoothingErrorCovarianceMatrix';
      cov_s=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% zen_ang(numobs) (deg)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/SolarZenithAngle';
      zen_ang=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% prs_sfc(numobs) (hPa)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/SurfacePressure';
      prs_sfc=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% avgk_dim_col_lev(level,numobs) (uses log10 VMR)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/TotalColumnAveragingKernel';
      avgk_dim_col_lev=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% avgk_ndim_col_lev(level,numobs) (uses partial columns)
      field='/HDFEOS/SWATHS/MOP02/Data Fields/TotalColumnAveragingKernelDimless';
      avgk_ndim_col_lev=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% lat(numobs) (degrees)
      field='/HDFEOS/SWATHS/MOP02/Geolocation Fields/Latitude';
      lat=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% lon(numobs) (degrees)
      field='/HDFEOS/SWATHS/MOP02/Geolocation Fields/Longitude';
      lon=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% prs_lay(layer) (hPa)
      field='/HDFEOS/SWATHS/MOP02/Geolocation Fields/Pressure';
      prs_lay=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% prs_lev(layer) (hPa)
      field='/HDFEOS/SWATHS/MOP02/Geolocation Fields/Pressure2';
      prs_lev=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% secs_day(numobs) 
      field='/HDFEOS/SWATHS/MOP02/Geolocation Fields/SecondsinDay';
      secs_day=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
% time(numobs) (TAI time)
      field='/HDFEOS/SWATHS/MOP02/Geolocation Fields/Time';
      time=h5read(file_in,field);
      units=h5readatt(file_in,field,'units');  
%
% Loop through MOPITT data
      windate_min=single(convert_time(wyr_mn,wmn_mn,wdy_mn,whh_mn,wmm_mn,wss_mn));
      windate_max=single(convert_time(wyr_mx,wmn_mx,wdy_mx,whh_mx,wmm_mx,wss_mx));
      icnt=0;
%
      yyyy_mop=double(year);
      mn_mop=double(month);
      dy_mop=double(day);
      for iobs=1:numobs
         hh_mop=double(idivide(int32(secs_day(iobs)),3600));
         mm_mop=double(idivide(mod(int32(secs_day(iobs)),3600),60));
         ss_mop=double(int32(secs_day(iobs))-int32(hh_mop*3600+mm_mop*60));
         if(int32(hh_mop)>23 | int32(mm_mop)>59 | int32(ss_mop)>59)
            [yyyy_mop,mn_mop,dy_mop,hh_mop,mm_mop,ss_mop]=incr_time(yyyy_mop, ...
      	    mn_mop,dy_mop,hh_mop,mm_mop,ss_mop);
         end
         mopdate=single(convert_time(yyyy_mop,mn_mop,dy_mop,hh_mop,mm_mop,ss_mop));
%
% Check time
         if(mopdate<windate_min | mopdate>windate_max)
            continue
         end
%
% QA/AC
         if(isnan(retr_col_amt(1,iobs)) | retr_col_amt(1,iobs)<=0)
            continue
         end
         if(isnan(prior_col_amt(iobs)) | prior_col_amt(iobs)<=0.)
            continue
         end
%
% Check domain
	 if(lat(iobs)<lat_min | lat(iobs)>lat_max | ...
	 lon(iobs)<lon_min | lon(iobs)>lon_max)
            continue
         end
%
% Save data to ascii file
         icnt=icnt+1;
         fprintf(fid,'MOPITT_CO_Obs: %d \n',icnt);
         fprintf(fid,'%d %d %d %d %d %d \n',yyyy_mop, ...
	 mn_mop,dy_mop,hh_mop,mm_mop,ss_mop);
	 fprintf(fid,'%14.8f %14.8f \n',lat(iobs),lon(iobs));
         fprintf(fid,'%d %d \n',layer,level);
 	 fprintf(fid,'%14.8g \n',dofs(iobs));
 	 fprintf(fid,'%14.8g \n',prs_sfc(iobs));
         fprintf(fid,'%14.8g ',prs_lay(1:layer));
         fprintf(fid,'\n');
         fprintf(fid,'%14.8g ',avgk_row_sum_lev(1:level,iobs));
         fprintf(fid,'\n');
	 for k=1:level
            fprintf(fid,'%14.8g ',avgk_lev(k,1:level,iobs));
            fprintf(fid,'\n');
	 end
	 fprintf(fid,'%14.8g \n',retr_sfc(1,iobs));
	 fprintf(fid,'%14.8g ',retr_prof_lay(1,1:layer,iobs));
         fprintf(fid,'\n');
	 fprintf(fid,'%14.8g \n',retr_sfc(2,iobs));
	 fprintf(fid,'%14.8g ',retr_prof_lay(2,1:layer,iobs));
         fprintf(fid,'\n');
         fprintf(fid,'%14.8g \n',prior_sfc(1,iobs));
         fprintf(fid,'%14.8g ',prior_prof_lay(1,1:layer,iobs));
         fprintf(fid,'\n');
         fprintf(fid,'%14.8g \n',prior_sfc(2,iobs));
	 fprintf(fid,'%14.8g ',prior_prof_lay(2,1:layer,iobs));
         fprintf(fid,'\n');
	 for k=1:level
	    fprintf(fid,'%14.8g ',cov_s(k,1:level,iobs));
            fprintf(fid,'\n');
         end
	 for k=1:level
            fprintf(fid,'%14.6g ',cov_r(k,1:level,iobs));
            fprintf(fid,'\n');
         end
	 for k=1:level
            fprintf(fid,'%14.6g ',cov_m(k,1:level,iobs));
            fprintf(fid,'\n');
         end
         fprintf(fid,'%14.8g ',avgk_dim_col_lev(1:level,iobs));
	 fprintf(fid,'\n');
         fprintf(fid,'%14.8g \n',retr_col_amt(1,iobs));
         fprintf(fid,'%14.8g \n',retr_col_amt(2,iobs));
         fprintf(fid,'%14.8g \n',prior_col_amt(iobs));
         fprintf(fid,'%14.8g \n',dry_col_amt(iobs));
      end
      clear prior_lay cld_prs col_amt rad_cld_frac avgk_lay 
      clear lat lon secs_day zen_ang time 
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
function [fld_interp]=prs_interp_col(fld,i_tmp,j_tmp,i_mdl,j_mdl, ...
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
      100)~=0) || (mod(int64(iyear),100)==0 && mod(int64(iyear),400)==0))
         jult=jult+secs_leap_year;
      else
         jult=jult+secs_year;
      end
   end
   for imon=1:month-1
      if(imon==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),100)==0 && mod(int64(year),400)==0)))
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
   ref_year=2010;
   ref_month=1;
   ref_day=1;
   ref_hour=0;
   ref_minute=0;
   ref_second=0;
   secs_year=365.*24.*60.*60.;
   secs_leap_year=366.*24.*60.*60.;
%
   if((mod(int64(ref_year),4)==0 & mod(int64(ref_year), ...
   100)~=0) || (mod(int64(ref_year),100)==0 && mod(int64(ref_year),400)==0))
      secs_gone=secs_leap_year;
   else
      secs_gone=secs_year;
   end
   year=ref_year;
   while (jult>secs_gone)
      jult=jult-secs_gone;
      year=year+1.;
      if((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),100)==0 && mod(int64(year),400)==0))
         secs_gone=secs_leap_year;
      else
         secs_gone=secs_year;
      end
   end
   for imon=1:12
      if(imon==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),100)==0 && mod(int64(year),400)==0)))
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
   day=floor(jult/24./60./60.)+1;
   jult=jult-(day-1)*24.*60.*60.;
   hour=floor(jult/60./60.);
   jult=jult-hour*60.*60.;
   minute=floor(jult/60.);
   second=jult-minute*60.;
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
      100)~=0) || (mod(int64(iyear),100)==0 && mod(int64(iyear),400)==0))
         jult=jult+secs_leap_year;
      else
         jult=jult+secs_year;
      end
   end
   for imon=1:month-1
      if(imon==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
      100)~=0) || (mod(int64(year),100)==0 && mod(int64(year),400)==0)))
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
      100)~=0) || (mod(int64(year),100)==0 && mod(int64(year),400)==0)))
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
         fprintf('APM: Error hourss too large %d \n',int64(hour))
         return
      end
      hour=hour-24;
      day=day+1;
   end
   days_mon=days_per_month(month);
   if(int64(month)==2 & ((mod(int64(year),4)==0 & mod(int64(year), ...
   100)~=0) || (mod(int64(year),100)==0 & mod(int64(year),400)==0)))
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
