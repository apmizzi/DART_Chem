function plot_maps_histo_TRACER_I_spread_emis_CYCLE
   clear all;
%
   DATE_STR_PR=["2009040218","2009040203","2009040206","2009040209","2009040212","2009040215","2009040218"];
   DATE_STR_PR=["2009040306","2009040309","2009040312","2009040315","2009040318"];
   DATE_STR_PR=["2005040200"];
   DATE_STR_PO=["2005040200"];
   ndates=1;
   wrf_vert=[1,2,3,2];
   levl=1;
   nx=440;
   ny=284;
   nz=20;
   num_mem=30;
   rc=system('rm -rf TRACER_I_SPREAD_EMIS_CYCLE.eps');
   save_file='TRACER_I_SPREAD_EMIS_CYCLE.eps';
%
% set colormap
   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
   cmap=desired_colors;
%
   SPRD_FAC_TRM='';
   SPRD_FAC_TRM='_SCAL_1.0';
%
   SPRD_FAC_LBL='';
   SPRD_FAC_LBL='SCAL 1.0';
%
% CHEM DA
   path_data='/nobackupp28/amizzi/OUTPUT_DATA/INPUT_2005_NOAA_EMISADJ_30MEMS_TEST';
%
% Loop through dates
   for idate=1:ndates
      date_chr=DATE_STR_PR(idate);
      file_date=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_chem_icbc/wrfinput_d01_',file_date,'.e001'))
%
% GRID DATA
% CHEM DA: WRF-Chem/DART data
      xlon=double(ncread(exp_pr,'XLONG'));
      xlat=double(ncread(exp_pr,'XLAT'));
%
      date_chr=DATE_STR_PR(idate);
      file_date=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      file_date=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_03:00:00');
      co_exp_pr=zeros(nx,ny,num_mem);
      no2_exp_pr=zeros(nx,ny,num_mem);
      so2_exp_pr=zeros(nx,ny,num_mem);
      for imem=1:num_mem
         run_dir=strcat('.e',int2str(imem));
         if (imem>9 & imem<100)
            run_dir=strcat('.e0',int2str(imem));
         end
         if (imem<=9)
            run_dir=strcat('.e00',int2str(imem));
         end
         exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_chem_emiss/wrfchemi_d01_',file_date,run_dir))
%
% CO PRIOR FIELDS
         fac=1.e3;
         state_var='E_CO'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         co_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
%
% NO2 PRIOR FIELDS
         fac=1.e3;
         state_var='E_NO2'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         no2_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
%
% SO2 PRIOR FIELDS
         fac=1.e3;
         state_var='E_SO2'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         so2_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)));
      end
%
% CO ENS MEAN and VARIANCEc FIELDS
      co_exp_mean(:,:)=zeros(nx,ny);
      co_exp_vari(:,:)=zeros(nx,ny);
%
% NO2 ENS MEAN and VARIANCE FIELDS
      no2_exp_mean(:,:)=zeros(nx,ny);
      no2_exp_vari(:,:)=zeros(nx,ny);
%
% SO2 ENS MEAN and VARIANCEcFIELDS
      so2_exp_mean(:,:)=zeros(nx,ny);
      so2_exp_vari(:,:)=zeros(nx,ny);
%
% Calculate ensemble mean
      for i=1:nx
         for j=1:ny
            for imem=1:num_mem  
               co_exp_mean(i,j)=co_exp_mean(i,j)+co_exp_pr(i,j,imem)/num_mem;
               no2_exp_mean(i,j)=no2_exp_mean(i,j)+no2_exp_pr(i,j,imem)/num_mem;
               so2_exp_mean(i,j)=so2_exp_mean(i,j)+so2_exp_pr(i,j,imem)/num_mem;
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
               so2_exp_vari(i,j)=so2_exp_vari(i,j)+((so2_exp_pr(i,j,imem)- ...
               so2_exp_mean(i,j))^2.)/(num_mem-1);
            end
            co_exp_stdv(i,j)=sqrt(co_exp_vari(i,j));
            no2_exp_stdv(i,j)=sqrt(no2_exp_vari(i,j));
            so2_exp_stdv(i,j)=sqrt(so2_exp_vari(i,j));
         end
      end
      fprintf('APM: After calculation of ensemble metrics \n')
%
% LOOK AT RESULTS
      sum1=0.;
      relative_sprd_co=zeros(nx*ny,1);
      relative_sprd_no2=zeros(nx*ny,1);
      relative_sprd_so2=zeros(nx*ny,1);
      rel_sprd_co_map=zeros(nx,ny);
      rel_sprd_no2_map=zeros(nx,ny);
      rel_sprd_so2_map=zeros(nx,ny);
      for i=1:nx
         for j=1:ny
            if(co_exp_mean(i,j)~=0)
               sum1=sum1+1;
               rel_sprd_co_map(i,j)=co_exp_stdv(i,j)/co_exp_mean(i,j)*100.;
               relative_sprd_co(sum1)=co_exp_stdv(i,j)/co_exp_mean(i,j)*100.;
	       if(relative_sprd_co(sum1)>300.)
                  relative_sprd_co(sum1)=300.;
               end
	       if(relative_sprd_co(sum1)<-300.)
                  relative_sprd_co(sum1)=-300.;
               end
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
	       if(relative_sprd_no2(sum1)>300.)
                  relative_sprd_no2(sum1)=300.;
               end
	       if(relative_sprd_no2(sum1)<-300.)
                  relative_sprd_no2(sum1)=-300.;
               end
            end
         end
      end
      sum1=0.;
      for i=1:nx
         for j=1:ny
            if(so2_exp_mean(i,j)~=0)
               sum1=sum1+1;
               rel_sprd_so2_map(i,j)=so2_exp_stdv(i,j)/so2_exp_mean(i,j)*100.;
               relative_sprd_so2(sum1)=so2_exp_stdv(i,j)/so2_exp_mean(i,j)*100.;
	       if(relative_sprd_so2(sum1)>300.)
                  relative_sprd_so2(sum1)=300.;
               end
	       if(relative_sprd_so2(sum1)<-300.)
                  relative_sprd_so2(sum1)=-300.;
               end
            end
         end
      end
      fprintf('APM: After definition of spread vectors \n')
%
%  PLOT E-CO FIELDS
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('E-CO Relative Sprd',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(relative_sprd_co,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%
% E-NO2
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('E-NO2 Relative Sprd',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(relative_sprd_no2,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%
% E-SO2   
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('E-SO2 Relative Sprd',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(relative_sprd_so2,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%
% PLOT E-CO FIELDS
      iplt=1;
      if (iplt==1)
         figure1=figure;
         cmin=0;
         cmax=.3;
         contourf(xlon,xlat,rel_sprd_co_map);
         colorbar('eastoutside')
         title(strcat('E-CO Rel Sprd ',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         xlabel('Longitude (deg)','FontSize',16);
         ylabel('Latitude','FontSize',16);
         print(gcf,'-dpsc2','-append',save_file);
      end
%
% PLOT E-NO2 FIELDS
      iplt=1;
      if (iplt==1)
         figure1=figure;
         cmin=0;
         cmax=.3;
         contourf(xlon,xlat,rel_sprd_no2_map);
         colorbar('eastoutside')
         title(strcat('E-NO2 Rel Sprd',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         xlabel('Longitude (deg)','FontSize',16);
         ylabel('Latitude','FontSize',16);
         print(gcf,'-dpsc2','-append',save_file);
      end
%
% PLOT E-SO2 FIELDS
      iplt=1;
      if (iplt==1)
         figure1=figure;
         cmin=0;
         cmax=.3;
         contourf(xlon,xlat,rel_sprd_so2_map);
         colorbar('eastoutside')
         title(strcat('E-SO2 Rel Sprd',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         xlabel('Longitude (deg)','FontSize',16);
         ylabel('Latitude','FontSize',16);
         print(gcf,'-dpsc2','-append',save_file);
      end
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
