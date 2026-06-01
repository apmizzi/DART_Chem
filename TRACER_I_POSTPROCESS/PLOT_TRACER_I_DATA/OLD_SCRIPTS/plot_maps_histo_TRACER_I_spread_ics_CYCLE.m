function plot_maps_histo_TRACER_I_spread_ics_CYCLE
   clear all;
%
   DATE_STR_PR=["2011040200","2011040203","2011040206","2011040209","2011040212","2011040215"];
   DATE_STR_PO=["2011040203","2011040206","2011040209","2011040212","2011040215","2011040218"];
   DATE_STR_PR=["2011040215"];
   DATE_STR_PO=["2011040218"];
   DATE_STR_PR=["2005040200"];
   DATE_STR_PO=["2005040200"];
   ndates=1;
   wrf_vert=[10,14,18,21,23,25,27,29,31,34];
   levl=1;
   nx=440;
   ny=284;
   nz=50;
   num_mem=30;
   rc=system('rm -rf TRACER_I_SPREAD_IC_CYCLE.eps');
   save_file='TRACER_I_SPREAD_IC_CYCLE.eps';
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
      file_date_pr=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      date_chr=DATE_STR_PO(idate);
      file_date_po=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      exp_pr=strcat(path_data,'/',DATE_STR_PR(idate),'/wrfchem_chem_icbc/wrfinput_d01_',file_date_pr,'.e001');
%      if (idate==1)
%         exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_initial/run_e001/wrfout_d01_',file_date_pr));
%      end
%
% GRID DATA
% CHEM DA: WRF-Chem/DART data
      xlon=double(ncread(exp_pr,'XLONG'));
      xlat=double(ncread(exp_pr,'XLAT'));
%
      date_chr=DATE_STR_PR(idate);
      file_date_pr=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      date_chr=DATE_STR_PO(idate);
      file_date_po=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      co_exp_pr=zeros(nx,ny,num_mem);
      o3_exp_pr=zeros(nx,ny,num_mem);
      no2_exp_pr=zeros(nx,ny,num_mem);
      so2_exp_pr=zeros(nx,ny,num_mem);
      co_exp_po=zeros(nx,ny,num_mem);
      o3_exp_po=zeros(nx,ny,num_mem);
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
         path_data='/nobackupp28/amizzi/OUTPUT_DATA/INPUT_2005_NOAA_EMISADJ_30MEMS_TEST';
%         exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_cycle_cr/',run_dir,'/wrfout_d01_',file_date_pr));
         exp_pr=strcat(path_data,'/',DATE_STR_PR(idate),'/wrfchem_chem_icbc/wrfinput_d01_',file_date_pr,mem_chr);
%         if (idate==1)
%            exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_initial/',run_dir,'/wrfout_d01_',file_date_pr));
%         end
%         exp_po=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_cycle_cr/',run_dir,'/wrfout_d01_',file_date_po));
         exp_po=strcat(path_data,'/',DATE_STR_PR(idate),'/wrfchem_chem_icbc/wrfinput_d01_',file_date_pr,mem_chr)
%
% CO PRIOR and POST FIELDS
         fac=1.e3;
         state_var='co'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         co_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         co_exp_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
%
% O3 PRIOR and POST FIELDS
         fac=1.e3;
         state_var='o3'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         o3_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         o3_exp_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
%
% NO2 PRIOR and POST FIELDS
         fac=1.e3;
         state_var='no2'; 
         clear fld_full
         fld_full=double(ncread(exp_pr,state_var));
         no2_exp_pr(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
         clear fld_full
         fld_full=double(ncread(exp_po,state_var));
         no2_exp_po(:,:,imem)=squeeze(fld_full(:,:,wrf_vert(levl)))*fac;%ppbv
%
% SO2 PRIOR and POST FIELDS
         fac=1.e3;
         state_var='so2'; 
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
% O3 ENS MEAN and VARIANCE FIELDS
      o3_exp_pr_mean(:,:)=zeros(nx,ny);
      o3_exp_pr_vari(:,:)=zeros(nx,ny);
      o3_exp_po_mean(:,:)=zeros(nx,ny);
      o3_exp_po_vari(:,:)=zeros(nx,ny);
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
               o3_exp_pr_mean(i,j)=o3_exp_pr_mean(i,j)+o3_exp_pr(i,j,imem)/num_mem;
               no2_exp_pr_mean(i,j)=no2_exp_pr_mean(i,j)+no2_exp_pr(i,j,imem)/num_mem;
               so2_exp_pr_mean(i,j)=so2_exp_pr_mean(i,j)+so2_exp_pr(i,j,imem)/num_mem;
%
               co_exp_po_mean(i,j)=co_exp_po_mean(i,j)+co_exp_po(i,j,imem)/num_mem;
               o3_exp_po_mean(i,j)=o3_exp_po_mean(i,j)+o3_exp_po(i,j,imem)/num_mem;
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
               o3_exp_pr_vari(i,j)=o3_exp_pr_vari(i,j)+((o3_exp_pr(i,j,imem)- ...
               o3_exp_pr_mean(i,j))^2.)/(num_mem-1);
               no2_exp_pr_vari(i,j)=no2_exp_pr_vari(i,j)+((no2_exp_pr(i,j,imem)- ...
               no2_exp_pr_mean(i,j))^2.)/(num_mem-1);
               so2_exp_pr_vari(i,j)=so2_exp_pr_vari(i,j)+((so2_exp_pr(i,j,imem)- ...
               so2_exp_pr_mean(i,j))^2.)/(num_mem-1);
%
               co_exp_po_vari(i,j)=co_exp_po_vari(i,j)+((co_exp_po(i,j,imem)- ...
               co_exp_po_mean(i,j))^2.)/(num_mem-1);
               o3_exp_po_vari(i,j)=o3_exp_po_vari(i,j)+((o3_exp_po(i,j,imem)- ...
               o3_exp_po_mean(i,j))^2.)/(num_mem-1);
               no2_exp_po_vari(i,j)=no2_exp_po_vari(i,j)+((no2_exp_po(i,j,imem)- ...
               no2_exp_po_mean(i,j))^2.)/(num_mem-1);
               so2_exp_po_vari(i,j)=so2_exp_po_vari(i,j)+((so2_exp_po(i,j,imem)- ...
               so2_exp_po_mean(i,j))^2.)/(num_mem-1);
            end
            co_exp_pr_stdv(i,j)=sqrt(co_exp_pr_vari(i,j));
            o3_exp_pr_stdv(i,j)=sqrt(o3_exp_pr_vari(i,j));
            no2_exp_pr_stdv(i,j)=sqrt(no2_exp_pr_vari(i,j));
            so2_exp_pr_stdv(i,j)=sqrt(so2_exp_pr_vari(i,j));
%
            co_exp_po_stdv(i,j)=sqrt(co_exp_po_vari(i,j));
            o3_exp_po_stdv(i,j)=sqrt(o3_exp_po_vari(i,j));
            no2_exp_po_stdv(i,j)=sqrt(no2_exp_po_vari(i,j));
            so2_exp_po_stdv(i,j)=sqrt(so2_exp_po_vari(i,j));
         end
      end
      fprintf('APM: After calculation of ensemble metrics \n')
%
% LOOK AT RESULTS
      relative_sprd_co_pr=zeros(nx*ny,1);
      relative_sprd_o3_pr=zeros(nx*ny,1);
      relative_sprd_no2_pr=zeros(nx*ny,1);
      relative_sprd_so2_pr=zeros(nx*ny,1);
      relative_sprd_co_po=zeros(nx*ny,1);
      relative_sprd_o3_po=zeros(nx*ny,1);
      relative_sprd_no2_po=zeros(nx*ny,1);
      relative_sprd_so2_po=zeros(nx*ny,1);
      rel_sprd_co_pr_map=zeros(nx,ny);
      rel_sprd_o3_pr_map=zeros(nx,ny);
      rel_sprd_no2_pr_map=zeros(nx,ny);
      rel_sprd_so2_pr_map=zeros(nx,ny);
      rel_sprd_co_po_map=zeros(nx,ny);
      rel_sprd_o3_po_map=zeros(nx,ny);
      rel_sprd_no2_po_map=zeros(nx,ny);
      rel_sprd_so2_po_map=zeros(nx,ny);
%
      sum_pr=0.;
      sum_po=0.;
      for i=1:nx
         for j=1:ny
            if(co_exp_pr_mean(i,j)~=0)
              sum_pr=sum_pr+1;
              rel_sprd_co_pr_map(i,j)=co_exp_pr_stdv(i,j)/co_exp_pr_mean(i,j)*100.;
%              rel_sprd_co_pr_map(i,j)=co_exp_pr_stdv(i,j);
              relative_sprd_co_pr(sum_pr)=co_exp_pr_stdv(i,j)/co_exp_pr_mean(i,j)*100.;
            end
            if(co_exp_po_mean(i,j)~=0)
              sum_po=sum_po+1;
              rel_sprd_co_po_map(i,j)=co_exp_po_stdv(i,j)/co_exp_po_mean(i,j)*100.;
%              rel_sprd_co_po_map(i,j)=co_exp_po_stdv(i,j);
              relative_sprd_co_po(sum_po)=co_exp_po_stdv(i,j)/co_exp_po_mean(i,j)*100.;
            end
         end
      end
      sum_pr=0.;
      sum_po=0.;
      for i=1:nx
         for j=1:ny
            if(o3_exp_pr_mean(i,j)~=0)
              sum_pr=sum_pr+1;
              rel_sprd_o3_pr_map(i,j)=o3_exp_pr_stdv(i,j)/o3_exp_pr_mean(i,j)*100.;
%              rel_sprd_o3_pr_map(i,j)=o3_exp_pr_stdv(i,j);
              relative_sprd_o3_pr(sum_pr)=o3_exp_pr_stdv(i,j)/o3_exp_pr_mean(i,j)*100.;
            end
            if(o3_exp_po_mean(i,j)~=0)
              sum_po=sum_po+1;
              rel_sprd_o3_po_map(i,j)=o3_exp_po_stdv(i,j)/o3_exp_po_mean(i,j)*100.;
%              rel_sprd_o3_po_map(i,j)=o3_exp_po_stdv(i,j);
              relative_sprd_o3_po(sum_po)=o3_exp_po_stdv(i,j)/o3_exp_po_mean(i,j)*100.;
            end
         end
      end
      sum_pr=0.;
      sum_po=0.;
      for i=1:nx
         for j=1:ny
            if(no2_exp_pr_mean(i,j)~=0)
              sum_pr=sum_pr+1;
              rel_sprd_no2_pr_map(i,j)=no2_exp_pr_stdv(i,j)/no2_exp_pr_mean(i,j)*100.;
%              rel_sprd_no2_pr_map(i,j)=no2_exp_pr_stdv(i,j);
              relative_sprd_no2_pr(sum_pr)=no2_exp_pr_stdv(i,j)/no2_exp_pr_mean(i,j)*100.;
            end
            if(no2_exp_po_mean(i,j)~=0)
              sum_po=sum_po+1;
              rel_sprd_no2_po_map(i,j)=no2_exp_po_stdv(i,j)/no2_exp_po_mean(i,j)*100.;
%              rel_sprd_no2_po_map(i,j)=no2_exp_po_stdv(i,j);
              relative_sprd_no2_po(sum_po)=no2_exp_po_stdv(i,j)/no2_exp_po_mean(i,j)*100.;
            end
         end
      end
      sum_pr=0.;
      sum_po=0.;
      for i=1:nx
         for j=1:ny
            if(so2_exp_pr_mean(i,j)~=0)
              sum_pr=sum_pr+1;
              rel_sprd_so2_pr_map(i,j)=so2_exp_pr_stdv(i,j)/so2_exp_pr_mean(i,j)*100.;
%              rel_sprd_so2_pr_map(i,j)=so2_exp_pr_stdv(i,j);
              relative_sprd_so2_pr(sum_pr)=so2_exp_pr_stdv(i,j)/so2_exp_pr_mean(i,j)*100.;
            end
            if(so2_exp_po_mean(i,j)~=0)
              sum_po=sum_po+1;
              rel_sprd_so2_po_map(i,j)=so2_exp_po_stdv(i,j)/so2_exp_po_mean(i,j)*100.;
%              rel_sprd_so2_po_map(i,j)=so2_exp_po_stdv(i,j);
              relative_sprd_so2_po(sum_po)=so2_exp_po_stdv(i,j)/so2_exp_po_mean(i,j)*100.;
            end
         end
      end
      fprintf('APM: After definition of spread vectors \n')
%
%  PLOT CO FIELDS
      iplt=0;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         title(strcat('CO PR R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         histogram(relative_sprd_co_pr,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
%
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         title(strcat('CO PO R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         histogram(relative_sprd_co_po,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%
% O3   
      iplt=0;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         title(strcat('O3 PR R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         histogram(relative_sprd_o3_pr,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
%
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         title(strcat('O3 PO R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         histogram(relative_sprd_o3_po,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%
% NO2
      iplt=0;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         title(strcat('NO2 PR R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         histogram(relative_sprd_no2_pr,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
%
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         title(strcat('NO2 PO R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         histogram(relative_sprd_no2_po,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%
% SO2
      iplt=0;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         title(strcat('SO2 PR R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         histogram(relative_sprd_so2_pr,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
%
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         title(strcat('SO2 PO R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
         histogram(relative_sprd_so2_po,20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%      
% PLOT CO FIELD MAPS
     iplt=1;
     if (iplt==1)
        figure1=figure;
        cmin=0;
        cmax=.3;
        contourf(xlon,xlat,rel_sprd_co_pr_map);
        colorbar('eastoutside')
        xlabel('Longitude (deg)','FontSize',16);
        ylabel('Latitude','FontSize',16);
        title(strcat('CO PR R-Sprd Cycle ',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
        print(gcf,'-dpsc2','-append',save_file);
%
        figure1=figure;
        cmin=0;
        cmax=.3;
        contourf(xlon,xlat,rel_sprd_co_po_map);
        colorbar('eastoutside')
        xlabel('Longitude (deg)','FontSize',16);
        ylabel('Latitude','FontSize',16);
        title(strcat('CO PO R-Sprd Cycle ',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
        print(gcf,'-dpsc2','-append',save_file);
     end
%
% PLOT O3 FIELD MAPS
     iplt=1;
     if (iplt==1)
        figure1=figure;
        cmin=0;
        cmax=.3;
        contourf(xlon,xlat,rel_sprd_o3_pr_map);
        colorbar('eastoutside')
        xlabel('Longitude (deg)','FontSize',16);
        ylabel('Latitude','FontSize',16);
        title(strcat('O3 PR R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
        print(gcf,'-dpsc2','-append',save_file);
%
        figure1=figure;
        cmin=0;
        cmax=.3;
        contourf(xlon,xlat,rel_sprd_o3_po_map);
        colorbar('eastoutside')
        xlabel('Longitude (deg)','FontSize',16);
        ylabel('Latitude','FontSize',16);
        title(strcat('O3 PO R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
        print(gcf,'-dpsc2','-append',save_file);
     end
%
% PLOT NO2 FIELD MAPS
     iplt=1;
     if (iplt==1)
        figure1=figure;
        cmin=0;
        cmax=.3;
        contourf(xlon,xlat,rel_sprd_no2_pr_map);
        colorbar('eastoutside')
        xlabel('Longitude (deg)','FontSize',16);
        ylabel('Latitude','FontSize',16);
        title(strcat('NO2 PR R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
        print(gcf,'-dpsc2','-append',save_file);
%
        figure1=figure;
        cmin=0;
        cmax=.3;
        contourf(xlon,xlat,rel_sprd_no2_po_map);
        colorbar('eastoutside')
        xlabel('Longitude (deg)','FontSize',16);
        ylabel('Latitude','FontSize',16);
        title(strcat('NO2 PO R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
        print(gcf,'-dpsc2','-append',save_file);
     end
%
% PLOT SO2 FIELD MAPS
     iplt=1;
     if (iplt==1)
        figure1=figure;
        cmin=0;
        cmax=.3;
        contourf(xlon,xlat,rel_sprd_so2_pr_map);
        colorbar('eastoutside')
        xlabel('Longitude (deg)','FontSize',16);
        ylabel('Latitude','FontSize',16);
        title(strcat('SO2 PR R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
        print(gcf,'-dpsc2','-append',save_file);
%
        figure1=figure;
        cmin=0;
        cmax=.3;
        contourf(xlon,xlat,rel_sprd_so2_po_map);
        colorbar('eastoutside')
        xlabel('Longitude (deg)','FontSize',16);
        ylabel('Latitude','FontSize',16);
        title(strcat('SO2 PO R-Sprd Cycle',{' '},SPRD_FAC_LBL),'Fontsize',18,'FontWeight','bold');
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
