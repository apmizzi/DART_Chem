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
%   fprintf('domain bounds %d %d %d %d \n',lat_min,lat_max,lon_min,lon_max)
%
   for ifile=1:nfile
      file_in=char(file_list(ifile));
      indx=strfind(file_in,file_pre)-1;
      if(isempty(indx))
         continue
      end
      file_mm=str2double(file_in(indx+29:indx+32));
      file_secs=file_mm*60.;
%       
%      if(file_secs<day_secs_beg | file_secs>day_secs_end)
%         continue
%      end
      fprintf('%d %s \n',ifile,file_in)
%      fprintf('%d %d %d \n',day_secs_beg,file_secs,day_secs_end)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Read OMI data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% date data
      field='/HDFEOS/ADDITIONAL/FILE_ATTRIBUTES/';
      day=h5readatt(file_in,field,'GranuleDay');
      month=h5readatt(file_in,field,'GranuleMonth');
      year=h5readatt(file_in,field,'GranuleYear');
      field='/HDFEOS/SWATHS/ColumnAmountNO2/';
      zgrid=h5readatt(file_in,field,'VerticalCoordinate');
% amfstrat(pixel,scanline)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/AmfStrat';
      amfstrat=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');   
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      amfstrat(:,:)=amfstrat(:,:)*scalef;
% amfstrat_clr(pixel,scanline)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/AmfStratClear';
      amfstrat_clr=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');   
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      amfstrat_clr(:,:)=amfstrat_clr(:,:)*scalef;
% amfstrat_cld(pixel,scanline)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/AmfStratCloudy';
      amfstrat_cld=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');   
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      amfstrat_cld(:,:)=amfstrat_cld(:,:)*scalef;
% amftrop(pixel,scanline) (none)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/AmfTrop';
      amftrop=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');   
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      amftrop(:,:)=amftrop(:,:)*scalef;
% amftrop_clr(pixel,scanline) (none)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/AmfTropClear';
      amftrop_clr=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');   
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      amftrop_clr(:,:)=amftrop_clr(:,:)*scalef;
% amftrop_cld(pixel,scanline) (none)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/AmfTropCloudy';
      amftrop_cld=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');   
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      amftrop_cld(:,:)=amftrop_cld(:,:)*scalef;
% cld_frac(pixel,scanline)
      clear temp
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/CloudFraction';
      temp=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');   
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      cld_frac(:,:)=double(temp(:,:))*scalef;
% cld_prs(pixel,scanline)
      clear temp
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/CloudPressure';
      temp=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');   
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      cld_prs(:,:)=double(temp(:,:))*scalef;
% cld_rad_frac(pixel,scanline) (scalef=.001)
      clear temp
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/CloudRadianceFraction';
      temp=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');   
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      cld_rad_frac(:,:)=double(temp(:,:))*scalef;
% col_amt(pixel,scanline) (molec/cm^2)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/ColumnAmountNO2';
      col_amt=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      col_amt(:,:)=col_amt(:,:)*scalef;
% col_amt_std(pixel,scanline) (molec/cm^2)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/ColumnAmountNO2Std';
      col_amt_std=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      col_amt_std(:,:)=col_amt_std(:,:)*scalef;
% col_amt_trop(pixel,scanline) (molec/cm^2)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/ColumnAmountNO2Trop';
      col_amt_trop=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      col_amt_trop(:,:)=col_amt_trop(:,:)*scalef;
% col_amt_trop_std(pixel,scanline) (molec/cm^2)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/ColumnAmountNO2TropStd';
      col_amt_trop_std=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      col_amt_trop_std(:,:)=col_amt_trop_std(:,:)*scalef;
% scat_wt(layer,pixel,scanline) (none)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/ScatteringWeight';
      scat_wt=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      scat_wt(:,:,:)=scat_wt(:,:,:)*scalef;
      tmp=size(scat_wt);
      layer=tmp(1);
      pixel=tmp(2);
      scanline=tmp(3);
      level=layer+1;
% scat_wt_prs(layer,pixel,scanline) (hPa) (bottom to top)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/ScatteringWtPressure';
      scat_wt_prs=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      scat_wt_prs(:,:,:)=scat_wt_prs(:,:,:)*scalef;
% bottom to top
      prs_lev(level)=scat_wt_prs(layer) - (scat_wt_prs(layer-1) ...
      -scat_wt_prs(layer))/2.;
      for ilv=1:layer-1
         ilvv=layer-ilv+1;
         prs_lev(ilvv)=(scat_wt_prs(ilvv)+scat_wt_prs(ilvv-1))/2.;
      end
      prs_lev(1)=scat_wt_prs(1) + (scat_wt_prs(1)-scat_wt_prs(2))/2.;
      prs_lay(1:layer)=scat_wt_prs(1:layer);      
% slnt_col_amt(pixel,scanline) (molec/cm^2)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/SlantColumnAmountNO2';
      slnt_col_amt=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      slnt_col_amt(:,:)=slnt_col_amt(:,:)*scalef;
% slnt_col_amt_std(pixel,scanline) (molec/cm^2)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/SlantColumnAmountNO2Std';
      slnt_col_amt_std=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      slnt_col_amt_std(:,:)=slnt_col_amt_std(:,:)*scalef;
% prs_trop(pixel,scanline)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/TropopausePressure';
      prs_trop=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      prs_trop(:,:)=prs_trop(:,:)*scalef;;  
% vcd_flg(pixel,scanline) (none)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/VcdQualityFlags';
      vcd_flg=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      vcd_flg(:,:)=vcd_flg(:,:)*scalef;
% terr_refl(pixel,scanline) (none)
      clear temp
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/TerrainReflectivity';
      temp=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      terr_refl(:,:)=double(temp(:,:))*scalef;
% xtrk_flg(pixel,scanline) (none)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Data Fields/XTrackQualityFlags';
      xtrk_flg=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');
      xtrk_flg(:,:)=xtrk_flg(:,:)*scalef;;  
% lat(pixel,scanline)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Geolocation Fields/Latitude';
      lat=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      lat(:,:)=lat(:,:)*scalef;;  
% lon(pixel,scanline)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Geolocation Fields/Longitude';
      lon=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      lon(:,:)=lon(:,:)*scalef;;  
      for i=1:pixel
         for j=1:scanline
            if(lon(i,j)<0.)
      	       lon(i,j)=lon(i,j)+360.;
            end
         end
      end
% zenang(pixel,scanline) (deg)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Geolocation Fields/SolarZenithAngle';
      zenang=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');  
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      units=h5readatt(file_in,field,'Units');  
      zenang(:,:)=zenang(:,:)*scalef;;  
% time(scanline) TAI-93 time (secs)
      field='/HDFEOS/SWATHS/ColumnAmountNO2/Geolocation Fields/Time';
      time=h5read(file_in,field);
      missing=h5readatt(file_in,field,'MissingValue');   
      offset=h5readatt(file_in,field,'Offset');  
      scalef=h5readatt(file_in,field,'ScaleFactor');  
      title=h5readatt(file_in,field,'Title');
      units=h5readatt(file_in,field,'Units');
      time(:)=time(:)*scalef;
      time(:)=time(:)-37;
%
% Loop through OMI data
      clear temp
      [temp,rc]=time_tai93(wyr_mn,wmn_mn,wdy_mn,whh_mn,wmm_mn,wss_mn);
      windate_min=single(temp);
      clear temp
      [temp,rc]=time_tai93(wyr_mx,wmn_mx,wdy_mx,whh_mx,wmm_mx,wss_mx);
      windate_max=single(temp);
      clear temp
      [temp,rc]=time_tai93(year,month,day,0,0,0);
      base_omi=single(temp);
%      fprintf('%d \n',single(time(1)))
%      fprintf('%d %d %d \n',windate_min,base_omi,windate_max)
%   
      yyyy_omi=double(year);
      mn_omi=double(month);
      dy_omi=double(day);
      ocnt=0;
      icnt=0;
      for ilin=1:scanline
         secs_day(ilin)=time(ilin)-base_omi;
         hh_omi=double(idivide(int32(secs_day(ilin)),3600));
         mm_omi=double(idivide(mod(int32(secs_day(ilin)),3600),60));
         ss_omi=double(int32(secs_day(ilin))-int32(hh_omi*3600+mm_omi*60));
         omidate=single(time(ilin));
         if(int32(hh_omi)>23 | int32(mm_omi)>59 | int32(ss_omi)>59)
%            fprintf('yr %d mn %d dy %d hh %d mm %d ss %d \n', ...
%	    year,month,day,int32(hh_omi),int32(mm_omi),int32(ss_omi))
            [yr_nw,mn_nw,dy_nw,hh_nw,mm_nw,ss_nw,rc]=incr_time(year, ...
            month,day,int32(hh_omi),int32(mm_omi),int32(ss_omi));
            year=yr_nw;
            month=mn_nw;
            day=dy_nw;
            hh_omi=hh_nw;
            mm_omi=mm_nw;
            ss_omi=ss_nw;
%            fprintf('yr %d mn %d dy %d hh %d mm %d ss %d \n \n', ...
%   	    year,month,day,hh_omi,mm_omi,ss_omi)
	 end 
%
% Check time
         if(omidate<windate_min | omidate>windate_max)
            continue
         end
%         fprintf('%d %d %d \n',windate_min,omidate,windate_max)
         for ipxl=1:pixel
%
% QA/AC
	    if(bitand(vcd_flg(ipxl,ilin),1)~=0 | xtrk_flg(ipxl,ilin)~=0 | ...
	    zenang(ipxl,ilin)>=85.)
               continue
	    end
%
	    if(cld_rad_frac(ipxl,ilin)>=0.5 | terr_refl(ipxl,ilin)>=0.3)
               continue
	    end
%
	    if(isnan(slnt_col_amt(ipxl,ilin)) | slnt_col_amt(ipxl,ilin)<=0)
               continue
            end
%
% Check domain
	    ocnt=ocnt+1;
%            fprintf('obs count %d \n',ocnt)
%            fprintf('lat %d %d %d \n',lat_min,lat(ipxl,ilin),lat_max)
%            fprintf('lon %d %d %d \n',lon_min,lon(ipxl,ilin),lon_max)
	    if(lat(ipxl,ilin)<lat_min | lat(ipxl,ilin)>lat_max | ...
	    lon(ipxl,ilin)<lon_min | lon(ipxl,ilin)>lon_max)
               continue
            end
%
% Save data to ascii file
            icnt=icnt+1;
            fprintf(fid,'OMI_NO2_Obs: %d \n',icnt);
            fprintf(fid,'%d %d %d %d %d %d \n',yyyy_omi, ...
	    mn_omi,dy_omi,hh_omi,mm_omi,ss_omi);
	    fprintf(fid,'%14.8f %14.8f \n',lat(ipxl,ilin),lon(ipxl,ilin));
            fprintf(fid,'%d %d \n',layer,level);
            fprintf(fid,'%14.8g %14.8g %14.8g \n',amfstrat(ipxl,ilin), ...
            amfstrat_clr(ipxl,ilin),amfstrat_cld(ipxl,ilin));
            fprintf(fid,'%14.8g %14.8g %14.8g \n',amftrop(ipxl,ilin), ...
            amftrop_clr(ipxl,ilin),amftrop_cld(ipxl,ilin));
            fprintf(fid,'%14.8g %14.8g %14.8g \n',cld_frac(ipxl,ilin), ...
            cld_prs(ipxl,ilin),cld_rad_frac(ipxl,ilin));
            fprintf(fid,'%14.8g %14.8g \n',col_amt(ipxl,ilin), ...
	    col_amt_std(ipxl,ilin));
            fprintf(fid,'%14.8g %14.8g \n',col_amt_trop(ipxl,ilin), ...
	    col_amt_trop_std(ipxl,ilin));
            fprintf(fid,'%14.8g %14.8g \n',slnt_col_amt(ipxl,ilin), ...
	    slnt_col_amt_std(ipxl,ilin));
            fprintf(fid,'%14.8g %14.8g \n',prs_trop(ipxl,ilin), ...
	    zenang(ipxl,ilin));
            fprintf(fid,'%14.8g ',scat_wt(1:layer,ipxl,ilin));
            fprintf(fid,'\n');
 	    fprintf(fid,'%14.8g ',prs_lev(1:level));
            fprintf(fid,'\n');
         end
      end
      clear amfstrat amfstrat_clr amfstrat_cld amftrop amftrop_clr 
      clear cld_frac cld_prs cld_rad_frac col_amt col_amt_std 
      clear col_amt_trop col_amt_trop_std scat_wt scat_wt_prs 
      clear slnt_col_amt slnt_col_amt_std prs_trop vcd_flg 
      clear xtrk_flg lat lon zenang time terr_refl
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
function [yyyy,mn,dy,hh,mm,ss,rc]=incr_time(year, ...
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
     if(day>(days_mon+days_mon))
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
   rc=0;
end
%
