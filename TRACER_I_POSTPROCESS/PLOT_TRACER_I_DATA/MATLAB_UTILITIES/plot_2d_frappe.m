function status=plot_2d(ifig,lon,lat,var,cmin,cmax,cmap,titl,filenm,latr,lonr,retr,icnt);
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
caxis([cmin cmax]);
% position the figure
set(h(ifig),'Units','pixels','Position',[700 450 620 350]); 
contourf(lon,lat,var,12,'LineStyle','none');
hold on;
%h(ifig)=surface('xdata',[lonr(:) lonr(:)],'ydata',[latr(:) latr(:)], ...
%   'zdata',0*[retr(:) retr(:)],'cdata',[retr(:) retr(:)], ...
%   'facecolor','flat','edgecolor','none','LineStyle','none','Marker','o', ...
%   'MarkerSize',10,'MarkerFaceColor','flat','LineStyle','none');
%
caxis([cmin cmax]);
for idx=1:icnt
   scatter(lonr(idx),latr(idx),110,retr(idx),'o','filled','MarkerEdgeColor','k','LineWidth',1.0);
end
%for idx=1:icnt
%   sprintf('%d %d %d',lonr(idx),latr(idx),retr(idx))
%end
h(ifig)=plot(coastlines(:,2), coastlines(:,1),'k.-','Linewidth',1.0);
set(h,'MarkerSize',0.1);
h(ifig)=plot(coastlin(:,2), coastlin(:,1),'k.-','Linewidth',1.0);
set(h,'MarkerSize',0.1);
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
ylim([28 51]);
xlim([-132 -93]);
% truncated grid
ylim([31 46]);
xlim([-124 -97]);
title(titl,'Fontsize',18,'FontWeight','bold');
set(gca,'Xtick', [-120 -115 -110 -105 -100],'FontWeight','bold','TickLength',[0.025 0.025]);
set(gca,'XtickLabel',['120W';'115W';'110W';'105W';'100W'],'Fontsize',14,'FontWeight','bold');
set(gca,'Ytick',[32 36 40 44],'FontWeight','bold','TickLength',[0.025 0.025]);
set(gca,'YtickLabel',['32N'; '36N'; '40N'; '44N'],'Fontsize',14,'FontWeight','bold');
set(gca,'Fontsize',14);
ax=gca;

% colorbar
hh=colorbar('eastoutside');
axx=gca;
%set(hh,'Position',[0.835,0.232,0.024,0.4028]);
%set(hh,'Position',[0.912,0.318,0.01,0.403]);
%set(hh,'Position',[0.4,0.24,0.25,0.02]); % may need to edit
set(hh,'Fontsize',16,'FontWeight','bold');
set(get(hh,'XLabel'),'String','ppbv','Fontsize',14,'FontWeight','bold');
ylabel('Latitude','Fontsize',18,'FontWeight','bold');
xlabel('Longitude','Fontsize',18,'FontWeight','bold');
box on;
set(gca,'LineWidth',2);
colormap(cmap);
status=1;
fig=h(ifig);
print(gcf,'-dpsc','-append',filenm);
%saveas(figure(ifig),filenm,'psc2')
end
