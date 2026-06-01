function plot_timeseries_TRACER_I_mean_and_stdv_emis_CYCLE
   clear all;
%
%   DATE_STR_PR=["2005040200","2005040203","2005040206","2005040209","2005040212","2005040215","2005040218","2005040221","2005040300","2005040303","2005040306","2005040309","2005040312","2005040315","2005040318","2005040321","2005040400"];
   DATE_STR_PR=["2005040209","2005040212","2005040215","2005040218","2005040221","2005040300","2005040303","2005040306","2005040309","2005040312","2005040315","2005040318","2005040321","2005040400"];
   DATE_STR_PO=["2005040203","2005040206","2005040209","2005040212","2005040215","2005040218","2005040221","2005040300","2005040303","2005040306","2005040309","2005040312","2005040315","2005040318","2005040321","2005040400","2005040403"];
%
   ndates=17;
   ndates=6;
   wrf_vert=[1,14,18,21,23,25,27,29,31,34];
   levl=1;
   nx=440;
   ny=284;
   nz=50;
   num_mem=30;
   rc=system('rm -rf TRACER_I_MEAN_and_STDV_EMIS_CYCLE_timeseries.eps');
   save_file='TRACER_I_MEAN_and_STDV_EMIS_CYCLE_timeseries.eps';
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
%   if (idate==1)
%      exp_pr=strcat(path_data_out,strcat('/',DATE_STR_PR(idate),'/wrfchem_initial/run_e001/wrfout_d01_',file_date_pr));
%   end
%   xlon=double(ncread(exp_pr,'XLONG'));
%   xlat=double(ncread(exp_pr,'XLAT'));
%
% Loop through dates
   for idate=1:ndates
      fprintf('APM: Process date %s \n',DATE_STR_PR(idate))
      date_chr=DATE_STR_PR(idate);
      file_date_pr=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      date_chr=DATE_STR_PO(idate);
      file_date_po=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      co_exp_pr=zeros(nx,ny,num_mem);
      no2_exp_pr=zeros(nx,ny,num_mem);
      so2_exp_pr=zeros(nx,ny,num_mem);
      co_exp_po=zeros(nx,ny,num_mem);
      no2_exp_po=zeros(nx,ny,num_mem);
      so2_exp_po=zeros(nx,ny,num_mem);
      for imem=1:num_mem
         run_dir=strcat('run_e',int2str(imem));
         mem_chr=strcat('.e',int2str(imem));
         if (imem>9 & imem<100)
            run_dir=strcat('run_e0',int2str(imem));
            mem_chr=strcat('.e0',int2str(imem));
         end
         if (imem<=9)
            run_dir=strcat('run_e00',int2str(imem));
            mem_chr=strcat('.e00',int2str(imem));
         end
%         if (idate==1)
%           exp_pr=strcat(path_data_inp,'/',DATE_STR_PR(idate), ...
%            '/wrfchem_chem_emiss/wrfchemi_d01_',file_date_pr,mem_chr);
%            exp_po=strcat(path_data_out,'/',DATE_STR_PR(idate), ...
%            '/wrfchem_initial/',run_dir,'/wrfchemi_d01_',file_date_pr);
%         elseif (idate==2)
%            exp_pr=strcat(path_data_inp,'/',DATE_STR_PR(idate), ...
%            '/wrfchem_chem_emiss/wrfchemi_d01_',file_date_pr,mem_chr);
%            exp_po=strcat(path_data_out,'/',DATE_STR_PR(idate), ...
%            '/wrfchem_cycle_cr/',run_dir,'/wrfchemi_d01_',file_date_pr);
%            exp_po=strcat(path_data_out,'/',DATE_STR_PR(idate), ...
%            '/dart_filter/wrfchemi_d01_',file_date_pr,'_filt',mem_chr);
%	 else
%            exp_pr=strcat(path_data_out,'/',DATE_STR_PR(idate), ...
%             '/dart_filter/emissions_scaling/wrfchemi_d01_',file_date_pr,mem_chr,'_new');
%            exp_po=strcat(path_data_out,'/',DATE_STR_PR(idate), ...
%             '/wrfchem_cycle_cr/',run_dir,'/wrfchemi_d01_',file_date_pr);
            exp_pr=strcat(path_data_inp,'/',DATE_STR_PR(idate), ...
            '/wrfchem_chem_emiss/wrfchemi_d01_',file_date_pr,mem_chr);
%            exp_po=strcat(path_data_out,'/',DATE_STR_PR(idate), ...
%            '/dart_filter/emissions_scaling/wrfchemi_d01_',file_date_pr,mem_chr,'_new');
            exp_po=strcat(path_data_out,'/',DATE_STR_PR(idate), ...
            '/dart_filter/wrfchemi_d01_',file_date_pr,'_filt',mem_chr);
%         end
%
% CO PRIOR and POST FIELDS
         fac=1.;
         state_var='E_CO'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         co_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         co_exp_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
%
% NO2 PRIOR and POST FIELDS
         fac=1.;
         state_var='E_NO2'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         no2_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         no2_exp_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
%
% SO2 PRIOR and POST FIELDS
         fac=1.;
         state_var='E_SO2'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         so2_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         so2_exp_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
      end
%
% CO ENS MEAN and VARIANCE FIELDS
      co_exp_pr_mean(:,:)=zeros(nx,ny);
      co_exp_pr_vari(:,:)=zeros(nx,ny);
      co_exp_po_mean(:,:)=zeros(nx,ny);
      co_exp_po_vari(:,:)=zeros(nx,ny);
%
% NO2 ENS MEAN and VARIACNE FIELDS
      no2_exp_pr_mean(:,:)=zeros(nx,ny);
      no2_exp_pr_vari(:,:)=zeros(nx,ny);
      no2_exp_po_mean(:,:)=zeros(nx,ny);
      no2_exp_po_vari(:,:)=zeros(nx,ny);
%
% SO2 ENS MEAN and VARIACNE FIELDS
      so2_exp_pr_mean(:,:)=zeros(nx,ny);
      so2_exp_pr_vari(:,:)=zeros(nx,ny);
      so2_exp_po_mean(:,:)=zeros(nx,ny);
      so2_exp_po_vari(:,:)=zeros(nx,ny);
%
% Calculate ensemble mean
      for i=1:nx
         for j=1:ny
            for imem=1:num_mem  
               co_exp_pr_mean(i,j)=co_exp_pr_mean(i,j)+co_exp_pr(i,j,imem)/num_mem;
               no2_exp_pr_mean(i,j)=no2_exp_pr_mean(i,j)+no2_exp_pr(i,j,imem)/num_mem;
               so2_exp_pr_mean(i,j)=so2_exp_pr_mean(i,j)+so2_exp_pr(i,j,imem)/num_mem;
%
               co_exp_po_mean(i,j)=co_exp_po_mean(i,j)+co_exp_po(i,j,imem)/num_mem;
               no2_exp_po_mean(i,j)=no2_exp_po_mean(i,j)+no2_exp_po(i,j,imem)/num_mem;
               so2_exp_po_mean(i,j)=so2_exp_po_mean(i,j)+so2_exp_po(i,j,imem)/num_mem;
            end
         end
      end 
%
% Calculate ensemble variance
      for i=1:nx
         for j=1:ny
            for imem=1:num_mem
               co_exp_pr_vari(i,j)=co_exp_pr_vari(i,j)+((co_exp_pr(i,j,imem)- ...
               co_exp_pr_mean(i,j))^2.)/(num_mem-1);
               no2_exp_pr_vari(i,j)=no2_exp_pr_vari(i,j)+((no2_exp_pr(i,j,imem)- ...
               no2_exp_pr_mean(i,j))^2.)/(num_mem-1);
               so2_exp_pr_vari(i,j)=so2_exp_pr_vari(i,j)+((so2_exp_pr(i,j,imem)- ...
               so2_exp_pr_mean(i,j))^2.)/(num_mem-1);
%
               co_exp_po_vari(i,j)=co_exp_po_vari(i,j)+((co_exp_po(i,j,imem)- ...
               co_exp_po_mean(i,j))^2.)/(num_mem-1);
               no2_exp_po_vari(i,j)=no2_exp_po_vari(i,j)+((no2_exp_po(i,j,imem)- ...
               no2_exp_po_mean(i,j))^2.)/(num_mem-1);
               so2_exp_po_vari(i,j)=so2_exp_po_vari(i,j)+((so2_exp_po(i,j,imem)- ...
               so2_exp_po_mean(i,j))^2.)/(num_mem-1);
            end
         end
      end
%
% Domain mean of ensemble mean and variance
      co_exp_pr_gr_mean(idate)=0.;
      no2_exp_pr_gr_mean(idate)=0.;
      so2_exp_pr_gr_mean(idate)=0.;
      co_exp_po_gr_mean(idate)=0.;
      no2_exp_po_gr_mean(idate)=0.;
      so2_exp_po_gr_mean(idate)=0.;
%
      co_exp_pr_gr_vari(idate)=0.;
      no2_exp_pr_gr_vari(idate)=0.;
      so2_exp_pr_gr_vari(idate)=0.;
      co_exp_po_gr_vari(idate)=0.;
      no2_exp_po_gr_vari(idate)=0.;
      so2_exp_po_gr_vari(idate)=0.;
%
      for i=1:nx
         for j=1:ny
            co_exp_pr_gr_mean(idate)=co_exp_pr_gr_mean(idate)+co_exp_pr_mean(i,j)/(nx*ny);
            no2_exp_pr_gr_mean(idate)=no2_exp_pr_gr_mean(idate)+no2_exp_pr_mean(i,j)/(nx*ny);
            so2_exp_pr_gr_mean(idate)=so2_exp_pr_gr_mean(idate)+so2_exp_pr_mean(i,j)/(nx*ny);
            co_exp_po_gr_mean(idate)=co_exp_po_gr_mean(idate)+co_exp_po_mean(i,j)/(nx*ny);
            no2_exp_po_gr_mean(idate)=no2_exp_po_gr_mean(idate)+no2_exp_po_mean(i,j)/(nx*ny);
            so2_exp_po_gr_mean(idate)=so2_exp_po_gr_mean(idate)+so2_exp_po_mean(i,j)/(nx*ny);
%
	    co_exp_pr_gr_vari(idate)=co_exp_pr_gr_vari(idate)+co_exp_pr_vari(i,j)/(nx*ny);
            no2_exp_pr_gr_vari(idate)=no2_exp_pr_gr_vari(idate)+no2_exp_pr_vari(i,j)/(nx*ny);
            so2_exp_pr_gr_vari(idate)=so2_exp_pr_gr_vari(idate)+so2_exp_pr_vari(i,j)/(nx*ny);
            co_exp_po_gr_vari(idate)=co_exp_po_gr_vari(idate)+co_exp_po_vari(i,j)/(nx*ny);
            no2_exp_po_gr_vari(idate)=no2_exp_po_gr_vari(idate)+no2_exp_po_vari(i,j)/(nx*ny);
            so2_exp_po_gr_vari(idate)=so2_exp_po_gr_vari(idate)+so2_exp_po_vari(i,j)/(nx*ny);
         end
      end 
%
      co_exp_pr_gr_stdv(idate)=sqrt(co_exp_pr_gr_vari(idate));
      no2_exp_pr_gr_stdv(idate)=sqrt(no2_exp_pr_gr_vari(idate));
      so2_exp_pr_gr_stdv(idate)=sqrt(so2_exp_pr_gr_vari(idate));
      co_exp_po_gr_stdv(idate)=sqrt(co_exp_po_gr_vari(idate));
      no2_exp_po_gr_stdv(idate)=sqrt(no2_exp_po_gr_vari(idate));
      so2_exp_po_gr_stdv(idate)=sqrt(so2_exp_po_gr_vari(idate));
   end
%
% PLOT TIMESERIES OF SPATIAL MEAN PRIOR ENSEMBLE MEAN
% CO
   ymn=min(min(co_exp_pr_gr_mean,co_exp_po_gr_mean));
   ymx=max(max(co_exp_pr_gr_mean,co_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean E-CO Time Series','Date','Flux', ...
   'PRIOR','POST',save_file,ndates,ymx,ymn,co_exp_pr_gr_mean,co_exp_po_gr_mean);
%
% NO2
   ymn=min(min(no2_exp_pr_gr_mean,no2_exp_po_gr_mean));
   ymx=max(max(no2_exp_pr_gr_mean,no2_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean E-NO2 Time Series','Date','Flux', ...
   'PRIOR','POST',save_file,ndates,ymx,ymn,no2_exp_pr_gr_mean,no2_exp_po_gr_mean);
% SO2
   ymn=min(min(so2_exp_pr_gr_mean,so2_exp_po_gr_mean));
   ymx=max(max(so2_exp_pr_gr_mean,so2_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean E-SO2 Time Series','Date','Flux', ...
   'PRIOR','POST',save_file,ndates,ymx,ymn,so2_exp_pr_gr_mean,so2_exp_po_gr_mean);
%
% PLOT TIMESERIES OF SPATIAL SPREAD PRIOR ENSEMBLE MEAN
% CO
   ymn=min(min(co_exp_pr_gr_stdv,co_exp_po_gr_stdv));
   ymx=max(max(co_exp_pr_gr_stdv,co_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv E-CO Time Series','Date','Flux', ...
   'PRIOR','POST',save_file,ndates,ymx,ymn,co_exp_pr_gr_stdv,co_exp_po_gr_stdv);
% NO2
   ymn=min(min(no2_exp_pr_gr_stdv,no2_exp_po_gr_stdv));
   ymx=max(max(no2_exp_pr_gr_stdv,no2_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv E-NO2 Time Series','Date','Flux', ...
   'PRIOR','POST',save_file,ndates,ymx,ymn,no2_exp_pr_gr_stdv,no2_exp_po_gr_stdv);
% SO2
   ymn=min(min(so2_exp_pr_gr_stdv,so2_exp_po_gr_stdv));
   ymx=max(max(so2_exp_pr_gr_stdv,so2_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv E-SO2 Time Series','Date','Flux', ...
   'PRIOR','POST',save_file,ndates,ymx,ymn,so2_exp_pr_gr_stdv,so2_exp_po_gr_stdv);
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
