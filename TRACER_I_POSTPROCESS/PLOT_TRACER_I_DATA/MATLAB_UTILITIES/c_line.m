 function h = c_line(x, y, z, mark)
% c_line plots a 2-D "line" with z-data as color
%
%       h = c_line(x, y, z, mark)
%
%  in:  x   x-data
%       y   y-data
%       z   3rd dimension for colouring
%     mark  marker or linestyle to use (like linestyle, default '*')
%
% out:  h   handle of the surface object

% (c) Pekka Kumpulainen
%     www.mit.tut.fi

if nargin<4; mark = '.'; end

h = surface(...
  'xdata',[x(:) x(:)], ...
  'ydata',[y(:) y(:)], ...
  'zdata',0*[z(:) z(:)], ...
  'cdata',[z(:) z(:)], ...
  'facecolor','flat', ...
  'edgecolor','none');

%switch mark
%case {'-','--',':','-.'}
%set(h,'LineStyle',mark)
%otherwise
%set(h,'LineStyle','none','Marker',mark,'Markersize',10); % may edit markersize
%set(h,'LineStyle','none','Marker','.','Markersize',14.4,'MarkerFaceColor','auto'); % may edit markersize
%set(h,'LineStyle','none','Marker','o','Markersize',10,'MarkerFaceColor','flat'); % may edit markersize
set(h,'LineStyle','none','Marker','o','Markersize',5,'MarkerFaceColor','flat'); % may edit markersize
%set(h,'MarkerEdgeColor','k','LineWidth',1.);
end
%%%%%%%%%%%%%%%%%%%%%%%%% 
