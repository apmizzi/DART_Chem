function status=plot_map_locations(ifig,lon,lat,var,cmin,cmax,diff_flg,titl,filenm,punits);
   status=0;
%------------------------------------------
% all about the coastline -- need usahi.mat
%------------------------------------------
   load usahi;
   [lats,lons]=extractm(stateline);
   coastlines2(:,2)=lons;
   coastlines2(:,1)=lats;
%
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
%
%------------------------------------------
% Plot the figure
%------------------------------------------
%
   h(ifig)=figure;
   clf(ifig);
   set(h(ifig),'Units','pixels','Position',[700 450 620 350]); 
%
%------------------------------------------
% Plot the continental outlines
%------------------------------------------
%
   h(ifig)=plot(coastlines(:,2), coastlines(:,1),'k.-','Linewidth',1.0);
   set(h,'MarkerSize',0.1);
   h(ifig)=plot(coastlin(:,2), coastlin(:,1),'k.-','Linewidth',1.0);
   set(h,'MarkerSize',0.1);
   hold on;
%
%------------------------------------------
% Plot the data
%------------------------------------------ 
% FRAPPE
   ylim([28 51]);
   xlim([-132 -93]);
   if(diff_flg==0)
      load 'MyColormap.mat';     % name: mymap
      colormap(mymap);
   else
      diff_matrix=load('Diff_map.mat');       % name: diff
      diff_map=diff_matrix.diff;
      colormap(diff_map);
   end
   caxis([cmin cmax]);
   hmap=pcolor(lon,lat,var);
   set(hmap,'edgecolor','none');
   hold on
%
%------------------------------------------
% Plot the continental outlines
%------------------------------------------
%
   h(ifig)=plot(coastlines(:,2), coastlines(:,1),'k.-','Linewidth',1.0);
   set(h,'MarkerSize',0.1);
   h(ifig)=plot(coastlin(:,2), coastlin(:,1),'k.-','Linewidth',1.0);
   set(h,'MarkerSize',0.1);
   hold on;
%
%------------------------------------------
% Plot the map labels and titles
%------------------------------------------ 
%   
   title(titl,'Fontsize',18,'FontWeight','bold');
   set(gca,'Xtick', [-130 -120 -110 -100],'FontWeight','bold','TickLength',[0.025 0.025]);
   set(gca,'XtickLabel',['130W'; '120W'; '110W'; '100W'],'Fontsize',14,'FontWeight','bold');
   set(gca,'Ytick',[32 36 40 44 48],'FontWeight','bold','TickLength',[0.025 0.025]);
   set(gca,'YtickLabel',['32N'; '36N'; '40N'; '44N'; '48N'],'Fontsize',14,'FontWeight','bold');
   set(gca,'Fontsize',14);
   ax=gca;
   hh=colorbar('eastoutside');
   axx=gca;
   set(hh,'Fontsize',16,'FontWeight','bold');
   set(get(hh,'XLabel'),'String',punits,'Fontsize',14,'FontWeight','bold');
   ylabel('Latitude','Fontsize',18,'FontWeight','bold');
   xlabel('Longitude','Fontsize',18,'FontWeight','bold');
   box on;
   set(gca,'LineWidth',2);
   status=1;
%
   fig=h(ifig);
   print(gcf,'-dpsc2','-append',filenm);
%   saveas(figure(ifig),filenm,'psc2')
end
