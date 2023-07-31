function mopitt_v8_co_profile_extract (filein,fileout,file_pre,cwyr_mn,cwmn_mn,cwdy_mn,cwhh_mn,cwmm_mn,cwss_mn,cwyr_mx,cwmn_mx,cwdy_mx,cwhh_mx,cwmm_mx,cwss_mx,clon_min,clon_max,clat_min,clat_max)
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
   file_list=squeeze(file_list_b);
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
   prss=[900. 800. 700. 600. 500. 400. 300. 200. 100.];
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
%   fprintf('domain bounds %d %d %d %d \n',lat_min,lat_max,lon_min,lon_max)
%
   for ifile=1:nfile
      file_in=char(file_list(ifile));
      indx=strfind(file_in,file_pre)-1;
      if(isempty(indx))
         continue
      end
      file_hh=00;
      file_mm=00;
      file_str_secs=file_hh*60.*60. + file_mm*60.;
      file_hh=23;
      file_mm=59;
      file_end_secs=file_hh*60.*60. + file_mm*60. + 59.;

      fprintf('%d %s \n',ifile,file_in);
      fprintf('file str %d cycle end %d \n',file_str_secs,day_secs_end);
      fprintf('file_end %d cycle str %d \n',file_end_secs,day_secs_beg);
%       
      if(file_str_secs>day_secs_end | file_end_secs<day_secs_beg)
         continue
      end
      fprintf('READ MOPITT DATA \n')
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
%            fprintf('OUTSIDE DATE RANGE \n')
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
	 if(lon(iobs)<0)
	   lon(iobs)=lon(iobs)+360.;
	 end
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
