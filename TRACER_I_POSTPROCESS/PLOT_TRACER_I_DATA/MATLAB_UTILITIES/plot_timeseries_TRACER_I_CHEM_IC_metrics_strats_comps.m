function plot_timeseries_TRACER_I_CHEM_IC_metrics_strats_comps
   clear all;
%
   DATE_STR=2012040200;
   DATE_END=2012040200;
   wrf_vert=[10,14,18,21,23,25,27,29,31,34];
   incr=3;
   levl=1;
   fac=1000.;
   nx=440;
   ny=284;
   nz=50;
   rc=system('rm -rf TRACER_I_CHEM_IC_metrics_strats_comps.eps');
   save_file='TRACER_I_CHEM_IC_metrics_strats_comps.eps';
%
% set colormap
   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
   cmap=desired_colors;
%
   idate=DATE_STR;
   icnt=0;
   while (idate<=DATE_END);
      icnt=icnt+1;
%
% CHEM DA
      YYYY=floor(idate/1000000);
      MM=floor((idate-YYYY*1000000)/10000);
      DD=floor((idate-YYYY*1000000-MM*10000)/100);
      HH=floor(idate-YYYY*1000000-MM*10000-DD*100);
      MM_str=string(MM);
      if(MM<10)
	 MM_str=strcat('0',string(MM));
      end
      DD_str=string(DD);
      if(DD<10)
	 DD_str=strcat('0',string(DD));
      end
      HH_str=string(HH);
      if(HH<10)
	 HH_str=strcat('0',string(HH));
      end
      data_path=strcat('/nobackupp28/amizzi/OUTPUT_DATA/OUTPUT_',string(YYYY),'_NOAA_EMISADJ_30MEMS');
      data_dir=strcat('/ensemble_stats/',string(idate),'/ens_stats_d01_',string(YYYY),'-',MM_str, ...
      '-',DD_str,'_',HH_str,':00:00');
      data_file=strcat(data_path,data_dir);
%
% Read data for plotting
      state_var='TRACER_I_CO_CONUS_MN'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_traceri_conus_mn(icnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
      co_traceri_conus_mn(1)
%
      state_var='TRACER_I_CO_CONUS_SD'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_traceri_conus_sd(icnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
      co_traceri_conus_sd(1)
%
      state_var='TCR2_CO_CONUS_MN'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_tcr2_conus_mn(icnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
      co_tcr2_conus_mn(1)
%
%      state_var='WRFCMAQ_CO_CONUS_MN'; 
%      clear fld_full
%      fld_full=double(ncread(data_file,state_var));
%      co_wrfcmaq_conus_mn(icnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%      co_wrfcmaq_conus_mn(1)
%
      state_var='CAMCHEM_CO_CONUS_MN'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_camchem_conus_mn(icnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
      co_camchem_conus_mn(1)

return

      
%
      state_var='TRACER_I_CO_URBAN_MN'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_traceri_urban_mn(icnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%
      state_var='TRACER_I_CO_URBAN_SD'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_traceri_urban_sd(icnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%
      state_var='TCR2_CO_URBAN_MN'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_tcr2_urban_mn(icnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%
      state_var='WRFCMAQ_CO_URBAN_MN'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_wrfcmaq_urban_mn(icnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%
      state_var='CAMCHEM_CO_URBAN_MN'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_camchem_urban_mn(icnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%
      state_var='TRACER_I_CO_RURAL_MN'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_traceri_rural_mn(icnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%
      state_var='TRACER_I_CO_RURAL_SD'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_traceri_rural_sd(icnt)=fld_full(wrf_vert(levl))*fac;        %ppbv
%
      state_var='TCR2_CO_RURAL_MN'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_tcr2_rural_mn(icnt)=fld_full(wrf_vert(levl))*fac;            %ppbv
%
      state_var='WRFCMAQ_CO_RURAL_MN'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_wrfcmaq_rural_mn(icnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%
      state_var='CAMCHEM_CO_RURAL_MN'; 
      clear fld_full
      fld_full=double(ncread(data_file,state_var));
      co_camchem_rural_mn(icnt)=fld_full(wrf_vert(levl))*fac;         %ppbv
%
      HH = HH + incr;
      if(HH>=24)
         HH=0;
	 DD=DD+1;
	 if(MM==4 & DD>30)
            DD=1;
	    MM=MM+1
	 elseif(MM==5 & DD>31)
            DD=1;
            MM=MM+1
	 elseif(MM==6 & DD>30)
            DD=1;
            MM=MM+1
	 elseif(MM==7 & DD>31)
            DD=1;
            MM=MM+1
	 elseif(MM==8 & DD>31)
            DD=1;
            MM=MM+1
	 elseif(MM==9 & DD>30)
            DD=1;
            MM=MM+1
	 elseif(MM==10 & DD>31)
            DD=1;
            MM=MM+1
         end	   
      end
      idate=YYYY*1000000 + MM*10000 + DD*100 + HH;
   end

return
   
%
% PLOT TIMESERIES OF SPATIAL MEAN PRIOR ENSEMBLE MEAN
% CO
   ymn=min(min(co_exp_pr_gr_mean,co_exp_po_gr_mean));
   ymx=max(max(co_exp_pr_gr_mean,co_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean CO Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,co_exp_pr_gr_mean,co_exp_po_gr_mean);
% O3
   ymn=min(min(o3_exp_pr_gr_mean,o3_exp_po_gr_mean));
   ymx=max(max(o3_exp_pr_gr_mean,o3_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean O3 Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,o3_exp_pr_gr_mean,o3_exp_po_gr_mean);
% NO2
   ymn=min(min(no2_exp_pr_gr_mean,no2_exp_po_gr_mean));
   ymx=max(max(no2_exp_pr_gr_mean,no2_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean NO2 Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,no2_exp_pr_gr_mean,no2_exp_po_gr_mean);
% SO2
   ymn=min(min(so2_exp_pr_gr_mean,so2_exp_po_gr_mean));
   ymx=max(max(so2_exp_pr_gr_mean,so2_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean SO2 Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,so2_exp_pr_gr_mean,so2_exp_po_gr_mean);
% HCHO
   ymn=min(min(hcho_exp_pr_gr_mean,hcho_exp_po_gr_mean));
   ymx=max(max(hcho_exp_pr_gr_mean,hcho_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean HCHO Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,hcho_exp_pr_gr_mean,hcho_exp_po_gr_mean);
% HNO3
   ymn=min(min(hno3_exp_pr_gr_mean,hno3_exp_po_gr_mean));
   ymx=max(max(hno3_exp_pr_gr_mean,hno3_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean HNO3 Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,hno3_exp_pr_gr_mean,hno3_exp_po_gr_mean);
%
% PLOT TIMESERIES OF SPATIAL SPREAD PRIOR ENSEMBLE MEAN
% CO
   ymn=min(min(co_exp_pr_gr_stdv,co_exp_po_gr_stdv));
   ymx=max(max(co_exp_pr_gr_stdv,co_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv CO Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,co_exp_pr_gr_stdv,co_exp_po_gr_stdv);
% O3
   ymn=min(min(o3_exp_pr_gr_stdv,o3_exp_po_gr_stdv));
   ymx=max(max(o3_exp_pr_gr_stdv,o3_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv O3 Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,o3_exp_pr_gr_stdv,o3_exp_po_gr_stdv);
% NO2
   ymn=min(min(no2_exp_pr_gr_stdv,no2_exp_po_gr_stdv));
   ymx=max(max(no2_exp_pr_gr_stdv,no2_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv NO2 Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,no2_exp_pr_gr_stdv,no2_exp_po_gr_stdv);
% SO2
   ymn=min(min(so2_exp_pr_gr_stdv,so2_exp_po_gr_stdv));
   ymx=max(max(so2_exp_pr_gr_stdv,so2_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv SO2 Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,so2_exp_pr_gr_stdv,so2_exp_po_gr_stdv);
% HCHO
   ymn=min(min(hcho_exp_pr_gr_stdv,hcho_exp_po_gr_stdv));
   ymx=max(max(hcho_exp_pr_gr_stdv,hcho_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv HCHO Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,hcho_exp_pr_gr_stdv,hcho_exp_po_gr_stdv);
% HNO3
   ymn=min(min(hno3_exp_pr_gr_stdv,hno3_exp_po_gr_stdv));
   ymx=max(max(hno3_exp_pr_gr_stdv,hno3_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv HNO3 Time Series','Date','Mixing Ratio (ppb)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,hno3_exp_pr_gr_stdv,hno3_exp_po_gr_stdv);
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
