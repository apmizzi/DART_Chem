%
path    =  '/nobackupp28/amizzi/OUTPUT_DATA/DART_OBS_DIAG';
exp     =  '/TRACER-I/obs_diag_output_profile_2005.nc';
exp     =  '/TRACER-I/obs_diag_output_profile_2006.nc';
exp     =  '/TRACER-I/obs_diag_output_profile_2007.nc';
exp     =  '/TRACER-I/obs_diag_output_profile_2008.nc';
exp     =  '/TRACER-I/obs_diag_output_profile_2009.nc';
%exp     =  '/TRACER-I/obs_diag_output_profile_2010.nc';
fname   =  strcat(path,exp);
%
% Possible variables to plot
varname   = 'observation'
varname   = 'ens_mean'
varname   = 'spread'
%
% Plot data  
varname   = 'ens_mean'
obsname   = 'RADIOSONDE_TEMPERATURE'
plot = plot_evolution(fname,varname,'obsname',obsname);
%
varname   = 'spread'
obsname   = 'RADIOSONDE_TEMPERATURE'
plot = plot_evolution(fname,varname,'obsname',obsname);
%
varname   = 'ens_mean'
obsname   = 'RADIOSONDE_U_WIND_COMPONENT'
plot = plot_evolution(fname,varname,'obsname',obsname);
%
varname   = 'spread'
obsname   = 'RADIOSONDE_U_WIND_COMPONENT'
plot = plot_evolution(fname,varname,'obsname',obsname);
%
varname   = 'ens_mean'
obsname   = 'RADIOSONDE_V_WIND_COMPONENT'
plot = plot_evolution(fname,varname,'obsname',obsname);
%
varname   = 'spread'
obsname   = 'RADIOSONDE_V_WIND_COMPONENT'
plot = plot_evolution(fname,varname,'obsname',obsname);
%
varname   = 'ens_mean'
obsname   = 'RADIOSONDE_SPECIFIC_HUMIDITY'
plot = plot_evolution(fname,varname,'obsname',obsname);
%
varname   = 'spread'
obsname   = 'RADIOSONDE_SPECIFIC_HUMIDITY'
plot = plot_evolution(fname,varname,'obsname',obsname);
