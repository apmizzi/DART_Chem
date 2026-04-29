function omi_o3_profile_extract (filein,fileout,file_pre,cwyr_mn,cwmn_mn,cwdy_mn,cwhh_mn,cwmm_mn,cwss_mn,cwyr_mx,cwmn_mx,cwdy_mx,cwhh_mx,cwmm_mx,cwss_mx,path_mdl,file_mdl,cnx_mdl,cny_mdl)
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
   command=strcat('rm'," ",'-rf'," ",fileout);
   [status]=system(command);
   fid=fopen(fileout,'w');
%
   command=strcat('/usr/bin/ls'," ",'-1'," ",filein,'*');
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
   cone_fac=.715567;   
%
% Convert DU to moles/m^2
   du2molpm2=4.4615e-4;
%
% Convert DU to molecules/m^2
   du2molcpm2=2.6867e20;
%
   day_secs_beg=whh_mn*60.*60. + wmm_mn*60. + wss_mn;
   day_secs_end=whh_mx*60.*60. + wmm_mx*60. + wss_mx;
%
% Print input data
%   fprintf('obs window str %d %d %d %d %d %d \n',wyr_mn,wmn_mn,wdy_mn,whh_mn,wmm_mn,wss_mn)
%   fprintf('obs window end %d %d %d %d %d %d \n',wyr_mx,wmn_mx,wdy_mx,whh_mx,wmm_mx,wss_mx)
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
      file_in=char(file_list(ifile))
      if(isempty(file_in))
         continue
      end
      indx=strfind(file_in,file_pre)-1;
      if(isempty(indx))
         continue
      end
%      
% date data
      field='/HDFEOS/ADDITIONAL/FILE_ATTRIBUTES/';
      day=h5readatt(file_in,field,'GranuleDay');
      month=h5readatt(file_in,field,'GranuleMonth');
      year=h5readatt(file_in,field,'GranuleYear');
      tai93At0z=h5readatt(file_in,field,'TAI93At0zOfGranule');
      field='/HDFEOS/SWATHS/O3Profile/';
      ntime=h5readatt(file_in,field,'NumTimes');
% time(ntim)
      field='/HDFEOS/SWATHS/O3Profile/Geolocation Fields/Time';
      time=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');
      offset=h5readatt(file_in,field,'Offset');
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      title=h5readatt(file_in,field,'Title');
      defn=h5readatt(file_in,field,'UniqueFieldDefinition');
      units=h5readatt(file_in,field,'Units');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Read OMI data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cov_prior_lay(ndim_cov,npixel,ntime) (no units) (465, 30, 329)
      field='/HDFEOS/SWATHS/O3Profile/Data Fields/APrioriCovarianceMatrix';
      cov_prior_lay_int=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');
      scalef=h5readatt(file_in,field,'ScaleFactor');
      title=h5readatt(file_in,field,'Title');
      defn=h5readatt(file_in,field,'UniqueFieldDefinition');
      units=h5readatt(file_in,field,'Units');
      fill=h5readatt(file_in,field,'_FillValue');
      tmp=size(cov_prior_lay_int);
      ndim_cov=tmp(1);
      npixel=tmp(2);
      ntime=tmp(3);
      for i=1:ndim_cov
         for j=1:npixel
            for k=1:ntime
	       if(cov_prior_lay_int(i,j,k)~=missing & ...
               cov_prior_lay_int(i,j,k)~=fill)
                  cov_prior_lay(i,j,k)=double(cov_prior_lay_int(i,j,k))*scalef;
               else		 
                  cov_prior_lay(i,j,k)=double(cov_prior_lay_int(i,j,k));
               end
            end
         end
      end
      clear cov_prior_lay_int tmp
%
% avgk_lay(layer,layer,npixel,ntime) (no units) (18, 18, 30, 329)
      field='/HDFEOS/SWATHS/O3Profile/Data Fields/AveragingKernel';
      avgk_lay_int=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');
      offset=h5readatt(file_in,field,'Offset');
      scalef=h5readatt(file_in,field,'ScaleFactor');
      title=h5readatt(file_in,field,'Title');
      defn=h5readatt(file_in,field,'UniqueFieldDefinition');
      units=h5readatt(file_in,field,'Units');
      fill=h5readatt(file_in,field,'_FillValue');
      tmp=size(avgk_lay_int);
      layer=tmp(1);
      level=layer+1;
      for i=1:layer
         for j=1:layer
            for k=1:npixel
               for l=1:ntime
	          if(avgk_lay_int(i,j,k,l)~=missing & ...
                  avgk_lay_int(i,j,k,l)~=fill)
                     avgk_lay(i,j,k,l)=double(avgk_lay_int(i,j,k,l))*scalef;
                  else
                     avgk_lay(i,j,k,l)=double(avgk_lay_int(i,j,k,l));
                  end
               end
            end
         end
      end 
      clear avgk_lay_lay_int tmp
%      
% cov_lay(ndim_cov,npixel,ntime) (no units)
      field='/HDFEOS/SWATHS/O3Profile/Data Fields/CovarianceMatrix';
      cov_lay_int=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');
      offset=h5readatt(file_in,field,'Offset');
      scalef=h5readatt(file_in,field,'ScaleFactor');   
      title=h5readatt(file_in,field,'Title');
      defn=h5readatt(file_in,field,'UniqueFieldDefinition');
      units=h5readatt(file_in,field,'Units');
      fill=h5readatt(file_in,field,'_FillValue');
      for i=1:ndim_cov
         for j=1:npixel
            for k=1:ntime
	       if(cov_lay_int(i,j,k)~=missing & ...
               cov_lay_int(i,j,k)~=fill)
                  cov_lay(i,j,k)=double(cov_lay_int(i,j,k))*scalef;
               else
                  cov_lay(i,j,k)=double(cov_lay_int(i,j,k));
               end
            end
         end
      end
      clear cov_prior_lay_int
%      
% dofs(npixel,ntime) (no units)
      field='/HDFEOS/SWATHS/O3Profile/Data Fields/DegreesOfFreedomForSignal';
      dofs_int=double(h5read(file_in,field));
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      fill=h5readatt(file_in,field,'_FillValue');
      for i=1:npixel
         for j=1:ntime
	    if(dofs_int(i,j)~=missing & dofs_int(i,j)~=fill)
               dofs(i,j)=double(dofs_int(i,j))*scalef;
            else
               dofs(i,j)=double(dofs_int(i,j));
            end
         end
      end
      clear dofs_int
%
% meas_qual_flg(ntime) (no units)
      field='/HDFEOS/SWATHS/O3Profile/Data Fields/MeasurementQualityFlags';
      meas_qual_flg=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      fill=h5readatt(file_in,field,'_FillValue');
%      
% o3_lay(layer,npixel,ntime) (DU)
      field='/HDFEOS/SWATHS/O3Profile/Data Fields/O3';
      o3_lay=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');
      offset=h5readatt(file_in,field,'Offset');
      scalef=h5readatt(file_in,field,'ScaleFactor');
      title=h5readatt(file_in,field,'Title');
      defn=h5readatt(file_in,field,'UniqueFieldDefinition');
      units=h5readatt(file_in,field,'Units');
      fill=h5readatt(file_in,field,'_FillValue');
      for i=1:layer
         for j=1:npixel
            for k=1:ntime
	       if(o3_lay(i,j,k)>0)
                  o3_lay(i,j,k)=double(o3_lay(i,j,k))*scalef*du2molpm2;
               end
            end
         end
      end
%      
% o3_prior_lay(layer,npixel,ntime) (DU)
      field='/HDFEOS/SWATHS/O3Profile/Data Fields/O3Apriori';
      o3_prior_lay_int=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');
      offset=h5readatt(file_in,field,'Offset');
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      title=h5readatt(file_in,field,'Title');
      defn=h5readatt(file_in,field,'UniqueFieldDefinition');
      fill=h5readatt(file_in,field,'_FillValue');
      for i=1:layer
         for j=1:npixel
            for k=1:ntime
	       if(o3_prior_lay_int(i,j,k)>0)
                  o3_prior_lay(i,j,k)=double(o3_prior_lay_int(i,j,k))*scalef*du2molpm2;
               else
                  o3_prior_lay(i,j,k)=double(o3_prior_lay_int(i,j,k));
               end
            end
         end
      end
      clear o3_prior_lay_int
%      
% o3_prior_err_lay(layer,npixel,ntime) (%)
      field='/HDFEOS/SWATHS/O3Profile/Data Fields/O3AprioriError';
      o3_prior_err_lay_int=double(h5read(file_in,field));
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      fill=h5readatt(file_in,field,'_FillValue');
      for i=1:layer
         for j=1:npixel
            for k=1:ntime
	       if(o3_prior_err_lay_int(i,j,k)>0)
                  o3_prior_err_lay(i,j,k)=double(o3_prior_err_lay_int(i,j,k))*scalef;
               else
                  o3_prior_err_lay(i,j,k)=double(o3_prior_err_lay_int(i,j,k));
               end
            end
         end
      end
      clear o3_prior_error_lay_int
%      
% proc_qual_flg(npixel,ntime) (no units)
      field='/HDFEOS/SWATHS/O3Profile/Data Fields/ProcessingQualityFlags';
      proc_qual_flg=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      fill=h5readatt(file_in,field,'_FillValue');  
%      
% lat(npixel,ntime) (deg)
      field='/HDFEOS/SWATHS/O3Profile/Geolocation Fields/Latitude';
      lat_int=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      fill=h5readatt(file_in,field,'_FillValue');  
      for i=1:npixel
         for j=1:ntime
            if(lat_int(i,j)>0)
               lat(i,j)=double(lat_int(i,j))*scalef;
            else
               lat(i,j)=double(lat_int(i,j));
            end
         end
      end
      clear lat_int
%      
% lon(npixel,ntime) (deg)
      field='/HDFEOS/SWATHS/O3Profile/Geolocation Fields/Longitude';
      lon_int=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      fill=h5readatt(file_in,field,'_FillValue');  
      for i=1:npixel
         for j=1:ntime
            if(lon_int(i,j)>-500.)
               lon(i,j)=double(lon_int(i,j))*scalef;
            else
               lon(i,j)=double(lon_int(i,j));
            end
         end
      end
      clear lon_int
      for i=1:npixel
         for j=1:ntime
            if(lon(i,j)>-500. & lon(i,j)<0.)
      	       lon(i,j)=lon(i,j)+360.;
            end
         end
      end
%      
% prs_lev(level,npixel,ntime) (hPa)
% vertical grid is top to bottom      
      field='/HDFEOS/SWATHS/O3Profile/Geolocation Fields/Pressure';
      prs_lev=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');
      offset=h5readatt(file_in,field,'Offset');
      scalef=h5readatt(file_in,field,'ScaleFactor');
      units=h5readatt(file_in,field,'Units');
      title=h5readatt(file_in,field,'Title');
      defn=h5readatt(file_in,field,'UniqueFieldDefinition');
      fill=h5readatt(file_in,field,'_FillValue');
%      
% zenang(npixel,ntime) (deg)
      field='/HDFEOS/SWATHS/O3Profile/Geolocation Fields/SolarZenithAngle';
      zenang=double(h5read(file_in,field));
      missing=h5readatt(file_in,field,'MissingValue');
      offset=h5readatt(file_in,field,'Offset');
      scalef=h5readatt(file_in,field,'ScaleFactor');
      units=h5readatt(file_in,field,'Units');
      fill=h5readatt(file_in,field,'_FillValue');
      for i=1:npixel
         for j=1:ntime
            if(zenang(i,j)>0)
               zenang(i,j)=double(zenang(i,j))*scalef;
            else
               zenang(i,j)=double(zenang(i,j));
            end
         end
      end
%
% RCF_qual(npixel,ntime) (no units) (should be less than 30)
      field='/HDFEOS/SWATHS/O3Profile/Data Fields/ReflectanceCostFunction';
      RCF_qual=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      fill=h5readatt(file_in,field,'_FillValue');
%
% Loop through OMI data
      clear temp
      [temp,rc]=time_tai93(wyr_mn,wmn_mn,wdy_mn,whh_mn,wmm_mn,wss_mn);
      windate_min=single(temp);
      clear temp
      [temp,rc]=time_tai93(wyr_mx,wmn_mx,wdy_mx,whh_mx,wmm_mx,wss_mx);
      windate_max=single(temp);
      year_omi=double(year);
      month_omi=double(month);
      day_omi=double(day);
      icnt=0;
      for ilin=1:ntime
         secs_day(ilin)=round(time(ilin))-tai93At0z;
         hour_omi=double(idivide(int32(secs_day(ilin)),3600));
         minute_omi=double(idivide(mod(int32(secs_day(ilin)),3600),60));
         second_omi=double(int32(secs_day(ilin))-int32(hour_omi*3600+minute_omi*60));
	 if(hour_omi>23)
	   [year_tmp,month_tmp,day_tmp,hour_tmp,minute_tmp,second_tmp]= ...
	   incr_time(year_omi,month_omi,day_omi,hour_omi,minute_omi,second_omi);
%	   fprintf('before %d %d %d %d %d %d \n',year_omi,month_omi,day_omi, ...
%           hour_omi,minute_omi,second_omi)
%	   fprintf('after %d %d %d %d %d %d \n',year_tmp,month_tmp,day_tmp, ...
%           hour_tmp,minute_tmp,second_tmp)
	   year_omi=year_tmp;
	   month_omi=month_tmp;
	   day_omi=day_tmp;
	   hour_omi=hour_tmp;
	   minute_omi=minute_tmp;
	   second_omi=second_tmp;
	 end
         clear temp
         [omidate,rc]=time_tai93(year_omi,month_omi,day_omi,hour_omi,minute_omi,second_omi);
         if(omidate<windate_min | omidate>windate_max)
            continue
         end
         for ipxl=1:npixel
%
% QA/AC
	    if(zenang(ipxl,ilin)>=75)
               continue
	    end
%
	    if(RCF_qual(ipxl,ilin)>=30)
               continue
	    end
%
	    if(isnan(o3_lay(:,ipxl,ilin)) | isnan(o3_prior_lay(:,ipxl,ilin)))
               continue
            end
%
% Check domain
% Input grid needs to be in degrees
% X coordinate is [0 to 360]
%		 
	    x_obser=lon(ipxl,ilin);
            y_obser=lat(ipxl,ilin);
            if(x_obser<0.)
	       x_obser=360.+x_obser;
            end
%
	    xmdl_sw=lon_mdl(1,1);
	    if(xmdl_sw<0.)
	       xmdl_sw=xmdl_sw+360.;
            end
%
% APM: Need to get this info from model
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
	       continue
	    end
	    if(i_min<1 | i_min>nx_mdl | j_min<1 | j_min>ny_mdl)
	       continue
	    end
%
% Save profile data to ascii file  
            icnt=icnt+1;
            fprintf(fid,'OMI_O3_Profile_Obs: %d %d %d \n',icnt,i_min,j_min);
            fprintf(fid,'%d %d %d %d %d %d \n',year_omi, ...
	    month_omi,day_omi,hour_omi,minute_omi,second_omi);
	    fprintf(fid,'%14.8f %14.8f \n',lat(ipxl,ilin),lon(ipxl,ilin));
            fprintf(fid,'%d %d %d \n',layer,level,ndim_cov);
	    fprintf(fid,'%14.8g \n ',dofs(ipxl,ilin));
 	    fprintf(fid,'%14.8g ',prs_lev(1:level,ipxl,ilin));
            fprintf(fid,'\n');
            fprintf(fid,'%14.8g ',o3_lay(1:layer,ipxl,ilin));
            fprintf(fid,'\n');
            fprintf(fid,'%14.8g ',o3_prior_lay(1:layer,ipxl,ilin));
            fprintf(fid,'\n');
            fprintf(fid,'%14.8g ',o3_prior_err_lay(1:layer,ipxl,ilin));
            fprintf(fid,'\n');
	    for j=1:layer	    
               fprintf(fid,'%14.8g ',avgk_lay(j,1:layer,ipxl,ilin));
               fprintf(fid,'\n');
	    end    
            fprintf(fid,'%14.8g ',cov_lay(1:ndim_cov,ipxl,ilin));
            fprintf(fid,'\n');
            fprintf(fid,'%14.8g ',cov_prior_lay(1:ndim_cov,ipxl,ilin));
            fprintf(fid,'\n');
         end
      end
      clear cov_prior_lay avgk_lay cov_lay dofs meas_qual_flg
      clear o3_lay o3_prior_lay o3_prior_err_lay proc_qual_flg
      clear lat lon prs_lev zenang time
   end
end
%
