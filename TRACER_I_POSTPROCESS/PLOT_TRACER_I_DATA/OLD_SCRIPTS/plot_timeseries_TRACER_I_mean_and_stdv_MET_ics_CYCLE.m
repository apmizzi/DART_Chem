function plot_timeseries_TRACER_I_mean_and_stdv_MET_ics_CYCLE
   clear all;
%
   DATE_STR_PR=["2005040200","2005040203","2005040206","2005040209","2005040212","2005040215","2005040218","2005040221","2005040300","2005040303","2005040306","2005040309","2005040312","2005040315","2005040318","2005040321","2005040400"];
   DATE_STR_PO=["2005040203","2005040206","2005040209","2005040212","2005040215","2005040218","2005040221","2005040300","2005040303","2005040306","2005040309","2005040312","2005040315","2005040318","2005040321","2005040400","2005040403"];
%
   ndates=17;
   ndates=9;
   kappa=0.286;
   wrf_vert=[10,14,18,21,23,25,27,29,31,34];
   levl=1;
   nx=440;
   nxs=441;
   ny=284;
   nys=285;
   nz=50;
   num_mem=30;
   rc=system('rm -rf TRACER_I_MEAN_and_STDV_MET_IC_CYCLE_timeseries.eps');
   save_file='TRACER_I_MEAN_and_STDV_MET_IC_CYCLE_timeseries.eps';
%
% set colormap
   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
   cmap=desired_colors;
%
% CHEM DA
   path_data='/nobackupp28/amizzi/OUTPUT_DATA/OUTPUT_2005_NOAA_EMISADJ_30MEMS_TEST';
%
% GRID DATA
% CHEM DA: WRF-Chem/DART data
   idate=1;
   date_chr=DATE_STR_PR(idate);
   file_date_pr=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
   date_chr=DATE_STR_PO(idate);
   file_date_po=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
   exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_cycle_cr/run_e001/wrfout_d01_',file_date_pr));
   if (idate==1)
      exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_initial/run_e001/wrfout_d01_',file_date_pr));
   end
   xlon=double(ncread(exp_pr,'XLONG'));
   xlat=double(ncread(exp_pr,'XLAT'));
%
% Loop through dates
   for idate=1:ndates
      fprintf('APM: Process date %s \n',DATE_STR_PR(idate))
      date_chr=DATE_STR_PR(idate);
      file_date_pr=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      date_chr=DATE_STR_PO(idate);
      file_date_po=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      t_pert_pr=zeros(nx,ny,num_mem);
      t_exp_pr=zeros(nx,ny,num_mem);
      p_pert_pr=zeros(nx,ny,num_mem);
      p_zero_pr=zeros(nx,ny,num_mem);
      u_exp_pr=zeros(nxs,ny,num_mem);
      v_exp_pr=zeros(nx,nys,num_mem);
      q_exp_pr=zeros(nx,ny,num_mem);
      t_pert_po=zeros(nx,ny,num_mem);
      t_exp_po=zeros(nx,ny,num_mem);
      p_pert_po=zeros(nx,ny,num_mem);
      p_zero_po=zeros(nx,ny,num_mem);
      u_exp_po=zeros(nxs,ny,num_mem);
      v_exp_po=zeros(nx,nys,num_mem);
      q_exp_po=zeros(nx,ny,num_mem);
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
         exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_cycle_cr/',run_dir,'/wrfout_d01_',file_date_pr));
         exp_po=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_cycle_cr/',run_dir,'/wrfout_d01_',file_date_po));
         if (idate==1)
            exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_initial/',run_dir,'/wrfout_d01_',file_date_pr));
            exp_po=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_initial/',run_dir,'/wrfout_d01_',file_date_po));
         end
%
% T PRIOR and POST FIELDS
         state_var='T'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         t_pert_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         t_pert_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
%
         state_var='P'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         p_pert_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         p_pert_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
%
         state_var='T00'; 
         t_zero_pr=double(ncread(exp_pr,state_var));
         t_zero_po=double(ncread(exp_po,state_var));
%
         state_var='PB'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         p_zero_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         p_zero_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
%
% Convert potential temperature (K)
         for i=1:nx
            for j=1:ny
               t_exp_pr(i,j,imem)=(t_pert_pr(i,j,imem)+t_zero_pr)* ...
	       (((p_pert_pr(i,j,imem)+p_zero_pr(i,j,imem))/100000.)^kappa);
               t_exp_po(i,j,imem)=(t_pert_po(i,j,imem)+t_zero_po)* ...
	       (((p_pert_po(i,j,imem)+p_zero_po(i,j,imem))/100000.)^kappa);
            end
         end
%
% U PRIOR and POST FIELDS (m/s)
         state_var='U'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         u_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         u_exp_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
%
% V PRIOR and POST FIELDS (m/s)
         state_var='V'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         v_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         v_exp_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
%
% Q PRIOR and POST FIELDS (mixing ratio)
         state_var='QVAPOR'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         q_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         q_exp_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
      end
%
% T ENS MEAN and VARIANCE FIELDS
      t_exp_pr_mean(:,:)=zeros(nx,ny);
      t_exp_pr_vari(:,:)=zeros(nx,ny);
      t_exp_po_mean(:,:)=zeros(nx,ny);
      t_exp_po_vari(:,:)=zeros(nx,ny);
%
% U ENS MEAN and VARIANCE FIELDS
      u_exp_pr_mean(:,:)=zeros(nx,ny);
      u_exp_pr_vari(:,:)=zeros(nx,ny);
      u_exp_po_mean(:,:)=zeros(nx,ny);
      u_exp_po_vari(:,:)=zeros(nx,ny);
%
% V ENS MEAN and VARIACNE FIELDS
      v_exp_pr_mean(:,:)=zeros(nx,ny);
      v_exp_pr_vari(:,:)=zeros(nx,ny);
      v_exp_po_mean(:,:)=zeros(nx,ny);
      v_exp_po_vari(:,:)=zeros(nx,ny);
%
% Q ENS MEAN and VARIACNE FIELDS
      q_exp_pr_mean(:,:)=zeros(nx,ny);
      q_exp_pr_vari(:,:)=zeros(nx,ny);
      q_exp_po_mean(:,:)=zeros(nx,ny);
      q_exp_po_vari(:,:)=zeros(nx,ny);
%
% Calculate ensemble mean
      for i=1:nx
         for j=1:ny
            for imem=1:num_mem  
               t_exp_pr_mean(i,j)=t_exp_pr_mean(i,j)+t_exp_pr(i,j,imem)/num_mem;
               u_exp_pr_mean(i,j)=u_exp_pr_mean(i,j)+(u_exp_pr(i,j,imem)+ ...
               u_exp_pr(i+1,j,imem))/2./num_mem;
               v_exp_pr_mean(i,j)=v_exp_pr_mean(i,j)+(v_exp_pr(i,j,imem)+ ...
               v_exp_pr(i,j+1,imem))/2./num_mem;
               q_exp_pr_mean(i,j)=q_exp_pr_mean(i,j)+q_exp_pr(i,j,imem)/num_mem;
%
               t_exp_po_mean(i,j)=t_exp_po_mean(i,j)+t_exp_po(i,j,imem)/num_mem;
               u_exp_po_mean(i,j)=u_exp_po_mean(i,j)+u_exp_po(i,j,imem)/num_mem;
               v_exp_po_mean(i,j)=v_exp_po_mean(i,j)+v_exp_po(i,j,imem)/num_mem;
               q_exp_po_mean(i,j)=q_exp_po_mean(i,j)+q_exp_po(i,j,imem)/num_mem;
            end
         end
      end 
%
% Calculate ensemble variance
      for i=1:nx
         for j=1:ny
            for imem=1:num_mem
               t_exp_pr_vari(i,j)=t_exp_pr_vari(i,j)+((t_exp_pr(i,j,imem)- ...
               t_exp_pr_mean(i,j))^2.)/(num_mem-1);
               u_exp_pr_vari(i,j)=u_exp_pr_vari(i,j)+(((u_exp_pr(i,j,imem)+ ...
               u_exp_pr(i+1,j,imem))/2.-u_exp_pr_mean(i,j))^2.)/(num_mem-1);
               v_exp_pr_vari(i,j)=v_exp_pr_vari(i,j)+(((v_exp_pr(i,j,imem)+ ...
               v_exp_pr(i,j+1,imem))/2.-v_exp_pr_mean(i,j))^2.)/(num_mem-1);
               q_exp_pr_vari(i,j)=q_exp_pr_vari(i,j)+((q_exp_pr(i,j,imem)- ...
               q_exp_pr_mean(i,j))^2.)/(num_mem-1);
%
               t_exp_po_vari(i,j)=t_exp_po_vari(i,j)+((t_exp_po(i,j,imem)- ...
               t_exp_po_mean(i,j))^2.)/(num_mem-1);
               u_exp_po_vari(i,j)=u_exp_po_vari(i,j)+(((u_exp_po(i,j,imem)+ ...
               u_exp_po(i+1,j,imem))/2.-u_exp_po_mean(i,j))^2.)/(num_mem-1);
               v_exp_po_vari(i,j)=v_exp_po_vari(i,j)+(((v_exp_po(i,j,imem)+ ...
               v_exp_po(i,j+1,imem))/2.-v_exp_po_mean(i,j))^2.)/(num_mem-1);
               q_exp_po_vari(i,j)=q_exp_po_vari(i,j)+((q_exp_po(i,j,imem)- ...
               q_exp_po_mean(i,j))^2.)/(num_mem-1);
            end
         end
      end
%
% Domain mean of ensemble mean and variance
      t_exp_pr_gr_mean(idate)=0.;
      u_exp_pr_gr_mean(idate)=0.;
      v_exp_pr_gr_mean(idate)=0.;
      q_exp_pr_gr_mean(idate)=0.;
      t_exp_po_gr_mean(idate)=0.;
      u_exp_po_gr_mean(idate)=0.;
      v_exp_po_gr_mean(idate)=0.;
      q_exp_po_gr_mean(idate)=0.;
%
      t_exp_pr_gr_vari(idate)=0.;
      u_exp_pr_gr_vari(idate)=0.;
      v_exp_pr_gr_vari(idate)=0.;
      q_exp_pr_gr_vari(idate)=0.;
      t_exp_po_gr_vari(idate)=0.;
      u_exp_po_gr_vari(idate)=0.;
      v_exp_po_gr_vari(idate)=0.;
      q_exp_po_gr_vari(idate)=0.;
%
      for i=1:nx
         for j=1:ny
            t_exp_pr_gr_mean(idate)=t_exp_pr_gr_mean(idate)+t_exp_pr_mean(i,j)/(nx*ny);
            u_exp_pr_gr_mean(idate)=u_exp_pr_gr_mean(idate)+u_exp_pr_mean(i,j)/(nx*ny);
            v_exp_pr_gr_mean(idate)=v_exp_pr_gr_mean(idate)+v_exp_pr_mean(i,j)/(nx*ny);
            q_exp_pr_gr_mean(idate)=q_exp_pr_gr_mean(idate)+q_exp_pr_mean(i,j)/(nx*ny);
            t_exp_po_gr_mean(idate)=t_exp_po_gr_mean(idate)+t_exp_po_mean(i,j)/(nx*ny);
            u_exp_po_gr_mean(idate)=u_exp_po_gr_mean(idate)+u_exp_po_mean(i,j)/(nx*ny);
            v_exp_po_gr_mean(idate)=v_exp_po_gr_mean(idate)+v_exp_po_mean(i,j)/(nx*ny);
            q_exp_po_gr_mean(idate)=q_exp_po_gr_mean(idate)+q_exp_po_mean(i,j)/(nx*ny);
%
	    t_exp_pr_gr_vari(idate)=t_exp_pr_gr_vari(idate)+t_exp_pr_vari(i,j)/(nx*ny);
            u_exp_pr_gr_vari(idate)=u_exp_pr_gr_vari(idate)+u_exp_pr_vari(i,j)/(nx*ny);
            v_exp_pr_gr_vari(idate)=v_exp_pr_gr_vari(idate)+v_exp_pr_vari(i,j)/(nx*ny);
            q_exp_pr_gr_vari(idate)=q_exp_pr_gr_vari(idate)+q_exp_pr_vari(i,j)/(nx*ny);
            t_exp_po_gr_vari(idate)=t_exp_po_gr_vari(idate)+t_exp_po_vari(i,j)/(nx*ny);
            u_exp_po_gr_vari(idate)=u_exp_po_gr_vari(idate)+u_exp_po_vari(i,j)/(nx*ny);
            v_exp_po_gr_vari(idate)=v_exp_po_gr_vari(idate)+v_exp_po_vari(i,j)/(nx*ny);
            q_exp_po_gr_vari(idate)=q_exp_po_gr_vari(idate)+q_exp_po_vari(i,j)/(nx*ny);
         end
      end 
%
      t_exp_pr_gr_stdv(idate)=sqrt(t_exp_pr_gr_vari(idate));
      u_exp_pr_gr_stdv(idate)=sqrt(u_exp_pr_gr_vari(idate));
      v_exp_pr_gr_stdv(idate)=sqrt(v_exp_pr_gr_vari(idate));
      q_exp_pr_gr_stdv(idate)=sqrt(q_exp_pr_gr_vari(idate));
      t_exp_po_gr_stdv(idate)=sqrt(t_exp_po_gr_vari(idate));
      u_exp_po_gr_stdv(idate)=sqrt(u_exp_po_gr_vari(idate));
      v_exp_po_gr_stdv(idate)=sqrt(v_exp_po_gr_vari(idate));
      q_exp_po_gr_stdv(idate)=sqrt(q_exp_po_gr_vari(idate));
   end
%
% PLOT TIMESERIES OF SPATIAL MEAN PRIOR ENSEMBLE MEAN
% T
   ymn=min(min(t_exp_pr_gr_mean,t_exp_po_gr_mean));
   ymx=max(max(t_exp_pr_gr_mean,t_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean T Time Series','Date','Temperature (K)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,t_exp_pr_gr_mean,t_exp_po_gr_mean);
% U
   ymn=min(min(u_exp_pr_gr_mean,u_exp_po_gr_mean));
   ymx=max(max(u_exp_pr_gr_mean,u_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean U Time Series','Date','Wind Speed (m/s)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,u_exp_pr_gr_mean,u_exp_po_gr_mean);
% V
   ymn=min(min(v_exp_pr_gr_mean,v_exp_po_gr_mean));
   ymx=max(max(v_exp_pr_gr_mean,v_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean V Time Series','Date','Wind Speed (m/s)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,v_exp_pr_gr_mean,v_exp_po_gr_mean);
% Q
   ymn=min(min(q_exp_pr_gr_mean,q_exp_po_gr_mean));
   ymx=max(max(q_exp_pr_gr_mean,q_exp_po_gr_mean));   
   rs = plot_series_2('Ens Mean Q Time Series','Date','Mixing Ratio ( )', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,q_exp_pr_gr_mean,q_exp_po_gr_mean);
%
% PLOT TIMESERIES OF SPATIAL SPREAD PRIOR ENSEMBLE MEAN
% T
   ymn=min(min(t_exp_pr_gr_stdv,t_exp_po_gr_stdv));
   ymx=max(max(t_exp_pr_gr_stdv,t_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv T Time Series','Date','Temperature (K)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,t_exp_pr_gr_stdv,t_exp_po_gr_stdv);
% U
   ymn=min(min(u_exp_pr_gr_stdv,u_exp_po_gr_stdv));
   ymx=max(max(u_exp_pr_gr_stdv,u_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv U Time Series','Date','Wind Speed (m/s)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,u_exp_pr_gr_stdv,u_exp_po_gr_stdv);
% V
   ymn=min(min(v_exp_pr_gr_stdv,v_exp_po_gr_stdv));
   ymx=max(max(v_exp_pr_gr_stdv,v_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv V Time Series','Date','Wind Speed (m/s)', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,v_exp_pr_gr_stdv,v_exp_po_gr_stdv);
% Q
   ymn=min(min(q_exp_pr_gr_stdv,q_exp_po_gr_stdv));
   ymx=max(max(q_exp_pr_gr_stdv,q_exp_po_gr_stdv));   
   rs = plot_series_2('Ens Stdv Q Time Series','Date','Mixing Ratio ( )', ...
   '0 hr FCST','3 hr FCST',save_file,ndates,ymx,ymn,q_exp_pr_gr_stdv,q_exp_po_gr_stdv);
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
