function plot_maps_NOAA_spread_ics_NASA
   clear all;
%
   DATE_STR_PR=["2009040218","2009040203","2009040206","2009040209","2009040212","2009040215","2009040218"];
   DATE_STR_PR=["2009040306","2009040309","2009040312","2009040315","2009040318"];
   DATE_STR_PR=["2011040306"];
   DATE_STR_PO= '2011040306';
   ndates=1;
   wrf_vert=[10,14,18,21,23,25,27,29,31,34];
   levl=1;
   nx=440;
   ny=284;
   nz=50;
   num_mem=30;
   rc=system('rm -rf NOAA_PRIOR_SPREAD_ICBCs.eps');
   save_file='NOAA_PRIOR_SPREAD_ICBC.eps';
%
% set colormap
   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
   cmap=desired_colors;
%
   SPRD_FAC_TRM='';
   SPRD_FAC_TRM='_SCAL_16.0';
%
   SPRD_FAC_LBL='';
   SPRD_FAC_LBL='SCAL 16.0';
%
   WRFCHEM_CHEM_ICBC_DIR=strcat('wrfchem_chem_icbc');
%
% CHEM DA
   path_data='/nobackupp28/amizzi/OUTPUT_DATA/OUTPUT_2005_NOAA_EMISADJ_10MEMS';
   path_data='/nobackupp28/amizzi/OUTPUT_DATA/INPUT_2005_NOAA_EMISADJ_10MEMS';
   path_data='/nobackupp28/amizzi/OUTPUT_DATA/INPUT_2009_NOAA_EMISADJ_10MEMS';
   path_data='/nobackupp28/amizzi/OUTPUT_DATA/INPUT_2009_NOAA_EMISADJ_30MEMS';
   path_data='/nobackupp28/amizzi/OUTPUT_DATA/INPUT_2011_NOAA_EMISADJ_30MEMS';
%
% Loop through dates
   for idate=1:ndates
      date_chr=DATE_STR_PR(idate);
      file_date=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
%
      exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/',WRFCHEM_CHEM_ICBC_DIR,'/wrfinput_d01_',file_date,'.e001'));
%      exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/',WRFCHEM_CHEM_ICBC_DIR,'/wrfinput_d01','.e001'));
%
% GRID DATA
% CHEM DA: WRF-Chem/DART data
      xlon=double(ncread(exp_pr,'XLONG'));
      xlat=double(ncread(exp_pr,'XLAT'));
%
      date_chr=DATE_STR_PR(idate);
      file_date=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      co_exp_pr=zeros(nx,ny,num_mem);
      o3_exp_pr=zeros(nx,ny,num_mem);
      no2_exp_pr=zeros(nx,ny,num_mem);
      for imem=1:num_mem
         run_dir=strcat('.e',int2str(imem));
         if (imem>9 & imem<100)
            run_dir=strcat('.e0',int2str(imem));
         end
         if (imem<=9)
            run_dir=strcat('.e00',int2str(imem));
         end
         exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/',WRFCHEM_CHEM_ICBC_DIR,'/wrfinput_d01_',file_date,run_dir))
%         exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/',WRFCHEM_CHEM_ICBC_DIR,'/wrfinput_d01',run_dir))
%
% CO PRIOR FIELDS
         fac=1.e3;
         state_var='co'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         co_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
%
% NO2 PRIOR FIELDS
         fac=1.e3;
         state_var='no2'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         no2_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
%
% O3 PRIOR FIELDS
         fac=1.e3;
         state_var='o3'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         o3_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
      end
%
% CO ENS MEAN FIELDS
      co_exp_mean(:,:)=zeros(nx,ny);
%
% CO ENS VARIANCE FIELDS
      co_exp_vari(:,:)=zeros(nx,ny);
%
% NO2 ENS MEAN FIELDS
      no2_exp_mean(:,:)=zeros(nx,ny);
%
% NO2 ENS VARIANCE FIELDS
      no2_exp_vari(:,:)=zeros(nx,ny);
%
% O3 ENS MEAN FIELDS
      o3_exp_mean(:,:)=zeros(nx,ny);
%
% O3 ENS VARIANCE FIELDS
      o3_exp_vari(:,:)=zeros(nx,ny);
%
% Calculate ensemble mean
      for i=1:nx
         for j=1:ny
            for imem=1:num_mem  
               co_exp_mean(i,j)=co_exp_mean(i,j)+co_exp_pr(i,j,imem)/num_mem;
               no2_exp_mean(i,j)=no2_exp_mean(i,j)+no2_exp_pr(i,j,imem)/num_mem;
               o3_exp_mean(i,j)=o3_exp_mean(i,j)+o3_exp_pr(i,j,imem)/num_mem;
            end
         end
      end 
%
% Calculate ensemble variance
      for i=1:nx
         for j=1:ny
            for imem=1:num_mem
               co_exp_vari(i,j)=co_exp_vari(i,j)+((co_exp_pr(i,j,imem)- ...
               co_exp_mean(i,j))^2.)/(num_mem-1);
               no2_exp_vari(i,j)=no2_exp_vari(i,j)+((no2_exp_pr(i,j,imem)- ...
               no2_exp_mean(i,j))^2.)/(num_mem-1);
               o3_exp_vari(i,j)=o3_exp_vari(i,j)+((o3_exp_pr(i,j,imem)- ...
               o3_exp_mean(i,j))^2.)/(num_mem-1);
            end
            co_exp_stdv(i,j)=sqrt(co_exp_vari(i,j));
            no2_exp_stdv(i,j)=sqrt(no2_exp_vari(i,j));
            o3_exp_stdv(i,j)=sqrt(o3_exp_vari(i,j));
         end
      end
      fprintf('APM: After calculation of ensemble metrics \n')
%
% LOOK AT RESULTS
      sum1=0.;
      relative_sprd_co=zeros(nx*ny,1);
      relative_sprd_o3=zeros(nx*ny,1);
      relative_sprd_no2=zeros(nx*ny,1);
      rel_sprd_co_map=zeros(nx,ny);
      rel_sprd_o3_map=zeros(nx,ny);
      rel_sprd_no2_map=zeros(nx,ny);
      for i=1:nx
         for j=1:ny
            if(co_exp_mean(i,j)~=0)
              sum1=sum1+1;
              rel_sprd_co_map(i,j)=co_exp_stdv(i,j)/co_exp_mean(i,j)*100.;
              relative_sprd_co(sum1)=co_exp_stdv(i,j)/co_exp_mean(i,j)*100.;
            end
         end
      end
      sum1=0.;
      for i=1:nx
         for j=1:ny
            if(o3_exp_mean(i,j)~=0)
              sum1=sum1+1;
              rel_sprd_o3_map(i,j)=o3_exp_stdv(i,j)/o3_exp_mean(i,j)*100.;
              relative_sprd_o3(sum1)=o3_exp_stdv(i,j)/o3_exp_mean(i,j)*100.;
            end
         end
      end
      sum1=0.;
      for i=1:nx
         for j=1:ny
            if(no2_exp_mean(i,j)~=0)
              sum1=sum1+1;
              rel_sprd_no2_map(i,j)=no2_exp_stdv(i,j)/no2_exp_mean(i,j)*100.;
              relative_sprd_no2(sum1)=no2_exp_stdv(i,j)/no2_exp_mean(i,j)*100.;
            end
         end
      end
      fprintf('APM: After definition of spread vectors \n')
%
%  PLOT CO FIELDS
      iplt=1;
      if(iplt==1)
         figure1=figure;
%         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14,'XLim',[xmn,xmx]);
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('CO Relative Sprd',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(relative_sprd_co,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
%         print(gcf,'-dpsc2','-append',save_file);
      end
%
% O3   
      if(iplt==1)
         figure1=figure;
%         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14,'XLim',[xmn,xmx]);
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('O3 Relative Sprd',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(relative_sprd_o3,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
%         print(gcf,'-dpsc2','-append',save_file);
      end
%
% NO2
      if(iplt==1)
         figure1=figure;
%         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14,'XLim',[xmn,xmx]);
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('NO2 Relative Sprd',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(relative_sprd_no2,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
%         print(gcf,'-dpsc2','-append',save_file);
      end
%                                                                                                             % PLOT CO FIELDS
     iplt=1;
     if (iplt==1)
        figure1=figure;
        cmin=0;
        cmax=.3;
        contourf(xlon,xlat,rel_sprd_co_map);
        colorbar('eastoutside')
        title(strcat('CO Rel Sprd ',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
        xlabel('Longitude (deg)','FontSize',16);
        ylabel('Latitude','FontSize',16);
        print(gcf,'-dpsc2','-append',save_file);
     end
%                                                                                                               % PLOT O3 FIELDS
     iplt=1;
     if (iplt==1)
        figure1=figure;
        cmin=0;
        cmax=.3;
        contourf(xlon,xlat,rel_sprd_o3_map);
        colorbar('eastoutside')
        title(strcat('O3 Rel Sprd',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
        xlabel('Longitude (deg)','FontSize',16);
        ylabel('Latitude','FontSize',16);
        print(gcf,'-dpsc2','-append',save_file);
     end
%                                                                                                               % PLOT NO2 FIELDS
     iplt=1;
     if (iplt==1)
        figure1=figure;
        cmin=0;
        cmax=.3;
        contourf(xlon,xlat,rel_sprd_no2_map);
        colorbar('eastoutside')
        title(strcat('NO2 Rel Sprd',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
        xlabel('Longitude (deg)','FontSize',16);
        ylabel('Latitude','FontSize',16);
        print(gcf,'-dpsc2','-append',save_file);
     end
  end
  return

%
% PLOT CO FIELDS  
   iplt_co=0;
   if (iplt_co==1)
%
% EMISADJ EXP
      cmin=0;
      cmax=230;
      punits='ppbv';
      cmap=desired_colors;
      status=plot_2d_frappee_noloc(1,xlon,xlat,co_exp_mean,cmin,cmax,cmap, ...
      'Prior CO EMISADJ MEAN',save_file,punits);
      cmin=0;
      cmax=50;
      punits='ppbv';
      cmap=desired_colors;
      status=plot_2d_frappee_noloc(1,xlon,xlat,co_exp_stdv,cmin,cmax,cmap, ...
      'Posterior CO EMISADJ SPREAD',save_file,punits);
   end
%
% PLOT O3 FIELDS  
   iplt_o3=0;
   if (iplt_o3==1)
%
% ALLCHEM EXP
      cmin=0;
      cmax=80;
      punits='ppbv';
      cmap=desired_colors;
      status=plot_2d_frappee_noloc(1,xlon,xlat,o3_exp_pr,cmin,cmax,cmap, ...
      'Prior O3 EMISADJ',save_file,punits);
      cmin=0;
      cmax=80;
      punits='ppbv';
      cmap=desired_colors;
      status=plot_2d_frappee_noloc(1,xlon,xlat,o3_exp_po,cmin,cmax,cmap, ...
      'Posterior O3 EMISADJ',save_file,punits);
      cmin=-10.;
      cmax=10.;
      punits='ppbv';
      cmap=desired_colors;
      status=plot_2d_frappee_noloc(1,xlon,xlat,o3_exp_incr,cmin,cmax,cmap, ...
      'Increment O3 EMISADJ',save_file,punits);
      cmin=-10.;
      cmax=10.;
      punits='ppbv';
      cmap=desired_colors;
      status=plot_2d_frappee_noloc(1,xlon,xlat,o3_allchem_diff,cmin,cmax,cmap, ...
      'Difference O3 EMISADJ',save_file,punits);
   end
%
% PLOT NO2 FIELDS  
   iplt_no2=0;
   if (iplt_no2==1)
%
% EMISADH EXP
      cmin=0;
      cmax=4;
      punits='ppbv';
      cmap=desired_colors;
      status=plot_2d_frappee_noloc(1,xlon,xlat,no2_exp_pr,cmin,cmax,cmap, ...
      'Prior NO2 EMISADJ',save_file,punits);
      cmin=0;
      cmax=4;
      punits='ppbv';
      cmap=desired_colors;
      status=plot_2d_frappee_noloc(1,xlon,xlat,no2_exp_po,cmin,cmax,cmap, ...
      'Posterior NO2 EMISADJ',save_file,punits);
      cmin=-1.;
      cmax=1.;
      punits='ppbv';
      cmap=desired_colors;
      status=plot_2d_frappee_noloc(1,xlon,xlat,no2_exp_incr,cmin,cmax,cmap, ...
      'Increment NO2 EMISADJ',save_file,punits);
      cmin=-1.;
      cmax=1.;
      punits='ppbv';
      cmap=desired_colors;
      status=plot_2d_frappee_noloc(1,xlon,xlat,no2_exp_diff,cmin,cmax,cmap, ...
      'Difference NO2 EMISADJ',save_file,punits);
   end
end
%
function status=plot_2d_frappee_noloc(ifig,lon,lat,var,cmin,cmax,cmap,titl,filenm,punits);
   status=0;
%------------------------------------------
% all about the coastline -- need usahi.mat
%------------------------------------------
   load usahi;
   [lats,lons]=extractm(stateline);
   coastlines2(:,2)=lons;
   coastlines2(:,1)=lats;

% in global models, sometimes i need to flip longitudes
   flip=0;
   if (flip==1)
      coastlines=coastlines2;
      for i=1:size(coastlines,1)
         if (coastlines2(i,2)<=0)
            coastlines(i,2)=coastlines2(i,2)+180;
         else
            coastlines(i,2)=coastlines2(i,2)-180;
         end
      end
   else
      coastlines=coastlines2;    
   end
   row_c=find(coastlines(:,2)<-178.5 & coastlines(:,2)>=-180 );
   coastlines(row_c,2)=NaN;

   coastlines0=coast;
   flip=0;
   if (flip==1)
      coastlin=coastlines0;
      for i=1:size(coastlin,1)
         if (coastlines0(i,2)<=0)
            coastlin(i,2)=coastlines0(i,2)+180;
         else
            coastlin(i,2)=coastlines0(i,2)-180;
         end
      end
   else
      coastlin=coastlines0;    
   end
   row_c=find(coastlin(:,2)<-178.5 & coastlin(:,2)>=-180 );
   coastlin(row_c,2)=NaN;
%------------------------------------------
% now plot
%------------------------------------------
   h(ifig)=figure;
   clf(ifig);
%
% position the figure
   set(h(ifig),'Units','pixels','Position',[700 450 620 350]); 
   contourf(lon,lat,var,12,'LineStyle','none');
   caxis([cmin cmax]);
   hold on;
   h(ifig)=plot(coastlines(:,2), coastlines(:,1),'k.-','Linewidth',1.0);
   set(h,'MarkerSize',0.1);
   h(ifig)=plot(coastlin(:,2), coastlin(:,1),'k.-','Linewidth',1.0);
   set(h,'MarkerSize',0.1);
%
%------------------------------------------
% all aesthetics
%------------------------------------------
% 
% FRAPPE
% full grid
   ylim([28 51]);
   xlim([-132 -93]);
% truncated grid
%   ylim([31 46]);
%   xlim([-124 -97]);
% plot correlation point
%   hold on
%   plot(xloc,yloc,'k+','LineWidth',5,'MarkerSize',15)

   title(titl,'Fontsize',18,'FontWeight','bold');
   set(gca,'Xtick', [-130 -120 -110 -100],'FontWeight','bold','TickLength',[0.025 0.025]); 
   set(gca,'XtickLabel',['130W';'120W';'110W';'100W'],'Fontsize',14,'FontWeight','bold');
   set(gca,'Ytick',[32 36 40 44 48],'FontWeight','bold','TickLength',[0.025 0.025]);
   set(gca,'YtickLabel',['32N'; '36N'; '40N'; '44N'; '48N'],'Fontsize',14,'FontWeight','bold');
   set(gca,'Fontsize',14);
   ax=gca;
% colorbar
   hh=colorbar('eastoutside');
   axx=gca;
%   set(hh,'Position',[0.835,0.232,0.024,0.4028]);
%   set(hh,'Position',[0.912,0.318,0.01,0.403]);
%   set(hh,'Position',[0.4,0.24,0.25,0.02]); % may need to edit
   set(hh,'Fontsize',16,'FontWeight','bold');
   set(get(hh,'XLabel'),'String',punits,'Fontsize',14,'FontWeight','bold');
   ylabel('Latitude','Fontsize',18,'FontWeight','bold');
   xlabel('Longitude','Fontsize',18,'FontWeight','bold');
   box on;
   set(gca,'LineWidth',2);
   colormap(cmap);
   status=1;
%
   fig=h(ifig);
%   saveas(figure(ifig),filenm,'psc2')
   print(gcf,'-dpsc2','-append',filenm);
end
%
function ll = coast
%COAST coastline data
%  
%  ll = COAST returns the world vector shoreline in the coast MAT-file as a 
%  two-column vector of latitudes and longitudes in degrees.
%  
%  See also COAST.MAT, WORLDLO, USALO, USAHI

% Copyright 1996-2000 Systems Planning and Analysis, Inc. and The MathWorks, Inc.
% $Revision: 1.4 $  $Date: 2000/01/18 02:02:49 $

%
% For MATLAB R2017b  
   load coast
   ll = [lat,long];
%
% For MATLAB 2022b
%load coastlines
%ll = [coastlat,coastlon];
end
