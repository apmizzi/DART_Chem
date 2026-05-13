function plot_maps_histo_TRACER_I_spread_bcs_CYCLE
   clear all;
%
   DATE_STR_PR=["2011040200"];
   DATE_STR_PO=["2011040200"];
   DATE_STR_PR=["2005040200"];
   DATE_STR_PO=["2005040200"];
   ndates=1;
   wrf_vert=[10,14,18,21,23,25,27,29,31,34];
   bdy_exts=["_BXS","_BXE","_BYS","_BYE","_BTXS","_BTXE","_BTYS","_BTYE"];
   levl=1;
   nx=440;
   ny=284;
   nz=50;
   nbdy=8;
   nhalo=5;
   nt=2;
   bdy_dims=[ny,ny,nx,nx,ny,ny,nx,nx];
   zscal_crit=400.;
   zscal_bdy=20.;
   num_mem=30;
   rc=system('rm -rf TRACER-I_SPREAD_BC_CYCLE.eps');
   save_file='TRACER_I_SPREAD_BC_CYCLE.eps';
%
% set colormap
   red     =   ([ 228, 161,   0,   0,   0, 144, 255, 255, 255, 255, 255, 255]);
   green   =   ([ 239, 179, 104, 204, 255, 255, 255, 191, 102,   0,   0, 103]);
   blue    =   ([ 255, 223, 255, 255,   0, 130,   0,   0,   0,   0, 255, 255]);
   desired_colors = ([red',green',blue'] ) / 256;
   cmap=desired_colors;
%
   SPRD_FAC_TRM='';
   SPRD_FAC_TRM='_SCL_1.0';
%
   SPRD_FAC_LBL='';
   SPRD_FAC_LBL='SCL 1.0';
%
% CHEM DA
   path_data='/nobackupp28/amizzi/OUTPUT_DATA/INPUT_2005_NOAA_EMISADJ_30MEMS_TEST';
%
% Loop through dates
   for idate=1:ndates
      date_chr=DATE_STR_PR(idate);
      file_date=strcat(date_chr{1}(1:4),'-',date_chr{1}(5:6),'-',date_chr{1}(7:8),'_',date_chr{1}(9:10),':00:00');
      exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_chem_icbc/wrfinput_d01_',file_date,'.e001'));
%       exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_chem_icbc/wrfinput_d01','.e001'));
%
% GRID DATA
% CHEM DA: WRF-Chem/DART data
      xlon=double(ncread(exp_pr,'XLONG'));
      xlat=double(ncread(exp_pr,'XLAT'));
%
      co_bdy_pr=zeros(nbdy,nx,nhalo,nt,num_mem);
      o3_bdy_pr=zeros(nbdy,nx,nhalo,nt,num_mem);
      no2_bdy_pr=zeros(nbdy,nx,nhalo,nt,num_mem);
      so2_bdy_pr=zeros(nbdy,nx,nhalo,nt,num_mem);
      for imem=1:num_mem
         run_dir=strcat('.e',int2str(imem));
         if (imem>9 & imem<100)
            run_dir=strcat('.e0',int2str(imem));
         end
         if (imem<=9)
            run_dir=strcat('.e00',int2str(imem));
         end
         exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_chem_icbc/wrfbdy_d01_',file_date,run_dir))
%           exp_pr=strcat(path_data,strcat('/',DATE_STR_PR(idate),'/wrfchem_chem_icbc/wrfbdy_d01',run_dir))
%
% CO PRIOR BCs
         fac=1.e3;
         for ibdy=1:nbdy
            state_var=strcat('co',bdy_exts(ibdy)); 
            clear fld_full
            fld_full=double(ncread(exp_pr,state_var));
            for ij=1:bdy_dims(ibdy)
               for h=1:nhalo
                  for l=1:nt
                     co_bdy_pr(ibdy,ij,h,l,imem)=fld_full(ij,wrf_vert(levl),h,l)*fac;%ppbv;
                  end
               end
            end
%
% O3 PRIOR BCs
            state_var=strcat('o3',bdy_exts(ibdy)); 
            clear fld_full
            fld_full=double(ncread(exp_pr,state_var));
            for ij=1:bdy_dims(ibdy)
               for h=1:nhalo
                  for l=1:nt
                     o3_bdy_pr(ibdy,ij,h,l,imem)=fld_full(ij,wrf_vert(levl),h,l)*fac;%ppbv
                  end
               end
            end
%
% NO2 PRIOR BCs
            state_var=strcat('no2',bdy_exts(ibdy)); 
            clear fld_full
            fld_full=double(ncread(exp_pr,state_var));
            for ij=1:bdy_dims(ibdy)
               for h=1:nhalo
                  for l=1:nt
                     no2_bdy_pr(ibdy,ij,h,l,imem)=fld_full(ij,wrf_vert(levl),h,l)*fac;%ppbv
                  end
               end
            end
%
% SO2 PRIOR BCs
            state_var=strcat('so2',bdy_exts(ibdy)); 
            clear fld_full
            fld_full=double(ncread(exp_pr,state_var));
            for ij=1:bdy_dims(ibdy)
               for h=1:nhalo
                  for l=1:nt
                     so2_bdy_pr(ibdy,ij,h,l,imem)=fld_full(ij,wrf_vert(levl),h,l)*fac;%ppbv
                  end
               end
           end
         end
      end
%
% CO ENS MEAN and VARIANCE FIELDS
      co_bdy_mean=zeros(nbdy,nx,nhalo,nt);
      co_bdy_vari=zeros(nbdy,nx,nhalo,nt);
%
% O3 ENS MEAN and VARIANCE FIELDS
      o3_bdy_mean=zeros(nbdy,nx,nhalo,nt);
      o3_bdy_vari=zeros(nbdy,nx,nhalo,nt);
%
% NO2 ENS MEAN and VARIANCE FIELDS
      no2_bdy_mean=zeros(nbdy,nx,nhalo,nt);
      no2_bdy_vari=zeros(nbdy,nx,nhalo,nt);
%
% SO2 ENS MEAN and VARIANCE FIELDS
      so2_bdy_mean=zeros(nbdy,nx,nhalo,nt);
      so2_bdy_vari=zeros(nbdy,nx,nhalo,nt);
%
% Calculate ensemble mean
      for ibdy=1:nbdy
         for ij=1:bdy_dims(ibdy)       
            for h=1:nhalo
      	    for l=1:nt
                 for imem=1:num_mem
                     co_bdy_mean(ibdy,ij,h,l)=co_bdy_mean(ibdy,ij,h,l)+co_bdy_pr(ibdy,ij,h,l,imem)/num_mem;
                     o3_bdy_mean(ibdy,ij,h,l)=o3_bdy_mean(ibdy,ij,h,l)+o3_bdy_pr(ibdy,ij,h,l,imem)/num_mem;
                     no2_bdy_mean(ibdy,ij,h,l)=no2_bdy_mean(ibdy,ij,h,l)+no2_bdy_pr(ibdy,ij,h,l,imem)/num_mem;
                     so2_bdy_mean(ibdy,ij,h,l)=so2_bdy_mean(ibdy,ij,h,l)+so2_bdy_pr(ibdy,ij,h,l,imem)/num_mem;
                  end
               end
            end
         end
      end
%
% Calculate ensemble variance
      for ibdy=1:nbdy
         for ij=1:bdy_dims(ibdy)
            for h=1:nhalo
      	    for l=1:nt 
                  for imem=1:num_mem 
                     co_bdy_vari(ibdy,ij,h,l)=co_bdy_vari(ibdy,ij,h,l)+((co_bdy_pr(ibdy,ij,h,l,imem)- ...
                     co_bdy_mean(ibdy,ij,h,l))^2.)/(num_mem-1);
                     o3_bdy_vari(ibdy,ij,h,l)=o3_bdy_vari(ibdy,ij,h,l)+((o3_bdy_pr(ibdy,ij,h,l,imem)- ...
                     o3_bdy_mean(ibdy,ij,h,l))^2.)/(num_mem-1);
                     no2_bdy_vari(ibdy,ij,h,l)=no2_bdy_vari(ibdy,ij,h,l)+((no2_bdy_pr(ibdy,ij,h,l,imem)- ...
                     no2_bdy_mean(ibdy,ij,h,l))^2.)/(num_mem-1);
                     so2_bdy_vari(ibdy,ij,h,l)=so2_bdy_vari(ibdy,ij,h,l)+((so2_bdy_pr(ibdy,ij,h,l,imem)- ...
                     so2_bdy_mean(ibdy,ij,h,l))^2.)/(num_mem-1);
                  end
                  co_bdy_stdv(ibdy,ij,h,l)=sqrt(co_bdy_vari(ibdy,ij,h,l));
                  o3_bdy_stdv(ibdy,ij,h,l)=sqrt(o3_bdy_vari(ibdy,ij,h,l));
                  no2_bdy_stdv(ibdy,ij,h,l)=sqrt(no2_bdy_vari(ibdy,ij,h,l));
                  so2_bdy_stdv(ibdy,ij,h,l)=sqrt(so2_bdy_vari(ibdy,ij,h,l));
               end
            end
         end
      end
      cnt_co=zeros(nbdy);
      cnt_o3=zeros(nbdy);
      cnt_no2=zeros(nbdy);
      cnt_so2=zeros(nbdy);
      co_bdy_rel_sprd=zeros(nbdy,nx*nhalo);
      o3_bdy_rel_sprd=zeros(nbdy,nx*nhalo);
      no2_bdy_rel_sprd=zeros(nbdy,nx*nhalo);
      so2_bdy_rel_sprd=zeros(nbdy,nx*nhalo);
      fprintf('APM: After ensemble statics calculations \n')
%
% CO
      for ij=1:bdy_dims(1)
         for h=1:nhalo
            if(co_bdy_mean(1,ij,h,1)~=0.) 
               cnt_co(1)=cnt_co(1)+1;
               co_bdy_rel_sprd(1,cnt_co(1))=co_bdy_stdv(1,ij,h,1)/co_bdy_mean(1,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(2)
         for h=1:nhalo
            if(co_bdy_mean(2,ij,h,1)~=0.) 
               cnt_co(2)=cnt_co(2)+1;
               co_bdy_rel_sprd(2,cnt_co(2))=co_bdy_stdv(2,ij,h,1)/co_bdy_mean(2,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(3)
         for h=1:nhalo
            if(co_bdy_mean(3,ij,h,1)~=0.) 
               cnt_co(3)=cnt_co(3)+1;
               co_bdy_rel_sprd(3,cnt_co(3))=co_bdy_stdv(3,ij,h,1)/co_bdy_mean(3,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(4)
         for h=1:nhalo
            if(co_bdy_mean(4,ij,h,1)~=0.) 
               cnt_co(4)=cnt_co(4)+1;
               co_bdy_rel_sprd(4,cnt_co(4))=co_bdy_stdv(4,ij,h,1)/co_bdy_mean(4,ij,h,1)*100.;
            end
         end
      end
%
% O3
      for ij=1:bdy_dims(1)
         for h=1:nhalo
            if(o3_bdy_mean(1,ij,h,1)~=0.) 
               cnt_o3(1)=cnt_o3(1)+1;
               o3_bdy_rel_sprd(1,cnt_o3(1))=o3_bdy_stdv(1,ij,h,1)/o3_bdy_mean(1,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(2)
         for h=1:nhalo
            if(o3_bdy_mean(2,ij,h,1)~=0.) 
               cnt_o3(2)=cnt_o3(2)+1;
               o3_bdy_rel_sprd(2,cnt_o3(2))=o3_bdy_stdv(2,ij,h,1)/o3_bdy_mean(2,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(3)
         for h=1:nhalo
            if(o3_bdy_mean(3,ij,h,1)~=0.) 
               cnt_o3(3)=cnt_o3(3)+1;
               o3_bdy_rel_sprd(3,cnt_o3(3))=o3_bdy_stdv(3,ij,h,1)/o3_bdy_mean(3,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(4)
         for h=1:nhalo
            if(o3_bdy_mean(4,ij,h,1)~=0.) 
               cnt_o3(4)=cnt_o3(4)+1;
               o3_bdy_rel_sprd(4,cnt_o3(4))=o3_bdy_stdv(4,ij,h,1)/o3_bdy_mean(4,ij,h,1)*100.;
            end
         end
      end
%
% NO2	 
      for ij=1:bdy_dims(1)
         for h=1:nhalo
            if(no2_bdy_mean(1,ij,h,1)~=0.) 
               cnt_no2(1)=cnt_no2(1)+1;
               no2_bdy_rel_sprd(1,cnt_no2(1))=no2_bdy_stdv(1,ij,h,1)/no2_bdy_mean(1,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(2)
         for h=1:nhalo
            if(no2_bdy_mean(2,ij,h,1)~=0.) 
               cnt_no2(2)=cnt_no2(2)+1;
               no2_bdy_rel_sprd(2,cnt_no2(2))=no2_bdy_stdv(2,ij,h,1)/no2_bdy_mean(2,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(3)
         for h=1:nhalo
            if(no2_bdy_mean(3,ij,h,1)~=0.) 
               cnt_no2(3)=cnt_no2(3)+1;
               no2_bdy_rel_sprd(3,cnt_no2(3))=no2_bdy_stdv(3,ij,h,1)/no2_bdy_mean(3,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(4)
         for h=1:nhalo
            if(no2_bdy_mean(4,ij,h,1)~=0.) 
               cnt_no2(4)=cnt_no2(4)+1;
               no2_bdy_rel_sprd(4,cnt_no2(4))=no2_bdy_stdv(4,ij,h,1)/no2_bdy_mean(4,ij,h,1)*100.;
            end
         end
      end
%
% SO2	 
      for ij=1:bdy_dims(1)
         for h=1:nhalo
            if(so2_bdy_mean(1,ij,h,1)~=0.) 
               cnt_so2(1)=cnt_so2(1)+1;
               so2_bdy_rel_sprd(1,cnt_so2(1))=so2_bdy_stdv(1,ij,h,1)/so2_bdy_mean(1,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(2)
         for h=1:nhalo
            if(so2_bdy_mean(2,ij,h,1)~=0.) 
               cnt_so2(2)=cnt_so2(2)+1;
               so2_bdy_rel_sprd(2,cnt_so2(2))=so2_bdy_stdv(2,ij,h,1)/so2_bdy_mean(2,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(3)
         for h=1:nhalo
            if(so2_bdy_mean(3,ij,h,1)~=0.) 
               cnt_so2(3)=cnt_so2(3)+1;
               so2_bdy_rel_sprd(3,cnt_so2(3))=so2_bdy_stdv(3,ij,h,1)/so2_bdy_mean(3,ij,h,1)*100.;
            end
         end
      end
%
      for ij=1:bdy_dims(4)
         for h=1:nhalo
            if(so2_bdy_mean(4,ij,h,1)~=0.) 
               cnt_so2(4)=cnt_so2(4)+1;
               so2_bdy_rel_sprd(4,cnt_so2(4))=so2_bdy_stdv(4,ij,h,1)/so2_bdy_mean(4,ij,h,1)*100.;
            end
         end
      end
%
      fprintf('APM: After calculation of ensemble metrics \n')
%
%  PLOT CO FIELDS
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('CO BXS Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(co_bdy_rel_sprd(1,1:cnt_co(1)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('CO BXE Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(co_bdy_rel_sprd(2,1:cnt_co(2)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%   
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('CO BYS Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(co_bdy_rel_sprd(3,1:cnt_co(3)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end	 
%
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('CO BYE Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(co_bdy_rel_sprd(4,1:cnt_co(4)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%
%  PLOT O3 FIELDS
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('O3 BXS Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(o3_bdy_rel_sprd(1,1:cnt_o3(1)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end	 
%
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('O3 BXE Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(o3_bdy_rel_sprd(2,1:cnt_o3(2)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('O3 BYS Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(o3_bdy_rel_sprd(3,1:cnt_o3(3)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end	 
%
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('O3 BYE Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(o3_bdy_rel_sprd(4,1:cnt_o3(4)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end

%
%  PLOT NO2 FIELDS
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('NO2 BXS Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(no2_bdy_rel_sprd(1,1:cnt_no2(1)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end	 
%     
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('NO2 BXE Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(no2_bdy_rel_sprd(2,1:cnt_no2(2)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('NO2 BYS Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(no2_bdy_rel_sprd(3,1:cnt_no2(3)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end	 
%     
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('NO2 BYE Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(no2_bdy_rel_sprd(4,1:cnt_no2(4)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end 
%
%  PLOT SO2 FIELDS
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('SO2 BXS Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(so2_bdy_rel_sprd(1,1:cnt_so2(1)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end	 
%     
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('SO2 BXE Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(so2_bdy_rel_sprd(2,1:cnt_so2(2)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end
%
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('SO2 BYS Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(so2_bdy_rel_sprd(3,1:cnt_so2(3)),20,'Normalization','probability')
         print(gcf,'-dpsc2','-append',save_file);
      end	 
%     
      iplt=1;
      if(iplt==1)
         figure1=figure;
         axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
         box(axes1,'on');
         hold(axes1,'all');
         title(strcat('SO2 BYE Sprd',{' '},SPRD_FAC_LBL,{' '},DATE_STR_PR(idate)),'Fontsize',18,'FontWeight','bold');
         xlabel('Rel Sprd (%)','FontSize',16);
         xtickformat('%5.2f')
         ylabel('Probability','FontSize',16);
         ytickformat('%5.2f')
         histogram(so2_bdy_rel_sprd(4,1:cnt_so2(4)),20,'Normalization','probability')
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
