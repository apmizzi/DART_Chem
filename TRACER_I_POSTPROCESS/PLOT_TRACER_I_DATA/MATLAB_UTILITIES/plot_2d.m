function status=plot_2d(ifig,lon,lat,var,cmin,cmax,cmap,titl,filenm);
status=0;
%------------------------------------------
% all about the coastline -- need usahi.mat
%------------------------------------------
nx=100;
ny=40;
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
%------------------------------------------
% now plot
%------------------------------------------
h(ifig)=figure;
clf(ifig);
caxis([cmin cmax]);
% position the figure
set(h(ifig),'Units','pixels','Position',[700 450 620 350]); 
contourf(lon,lat,var);
caxis([cmin cmax]);
line(lon(1:nx,1),lat(1:nx,1),'Linewidth',1,'Color',[0,0,0]);
line(lon(1,1:ny),lat(1,1:ny),'Linewidth',1,'Color',[0,0,0]);
line(lon(1:nx,ny),lat(1:nx,ny),'Linewidth',1,'Color',[0,0,0]);
line(lon(nx,1:ny),lat(nx,1:ny),'Linewidth',1,'Color',[0,0,0]);
hold on;
h(ifig)=plot(coastlines(:,2), coastlines(:,1),'k.-','Linewidth',1.0);
set(h,'Markersize',0.1);
h(ifig)=plot(coastlin(:,2), coastlin(:,1),'k.-','Linewidth',1.0);
set(h,'Markersize',0.1);
%------------------------------------------
% all aesthetics
%------------------------------------------
% 
% 2008 CASE
ylim([5 55]);
xlim([-180 -50]);
% 
% FRAPPE
% full grid
%ylim([28 51]);
%xlim([-132 -93]);
% truncated grid
%ylim([31 46]);
%xlim([-124 -97]);
title(titl,'Fontsize',18,'FontWeight','bold');
set(gca,'Xtick', [-180 -140 -100 -60],'FontWeight','bold','TickLength',[0.025 0.025]);
set(gca,'XtickLabel',['180W';'140W';'100W';' 60W'],'Fontsize',14,'FontWeight','bold');
set(gca,'Ytick',[10 20 30 40 50],'FontWeight','bold','TickLength',[0.025 0.025]);
set(gca,'YtickLabel',['10N';'20N';'30N'; '40N'; '50N'],'Fontsize',14,'FontWeight','bold');
set(gca,'Fontsize',14);
ax=gca;

% colorbar
hh=colorbar('north');
axx=gca;
%set(hh,'Position',[0.835,0.232,0.024,0.4028]);
%set(hh,'Position',[0.912,0.318,0.01,0.403]);
set(hh,'Position',[0.4,0.24,0.25,0.02]); % may need to edit
set(hh,'Fontsize',16,'FontWeight','bold');
set(get(hh,'XLabel'),'String','ppbv','Fontsize',14,'FontWeight','bold');
ylabel('Latitude (deg)','Fontsize',18,'FontWeight','bold');
xlabel('Longitude (deg)','Fontsize',18,'FontWeight','bold');
box on;
set(gca,'LineWidth',2);
colormap(cmap);
status=1;
fig=h(ifig);
print(gcf,'-dpsc','-append',filenm);
%saveas(h(ifig),filenm,'psc2');
end
