
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
