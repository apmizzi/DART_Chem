%
path='/nobackupp11/amizzi/OUTPUT_DATA/DART_OBS_DIAG';
%
%exp         = '/FRAPPE_CONTROL_CO_RETR/obs_diag_output_profile.nc';
%exp         = '/FRAPPE_ALLCHEM_CO_RETR/obs_diag_output_profile.nc';
exp         = '/FRAPPE_ALLCHEM_CO_CPSR/obs_diag_output_profile.nc';
%exp         = '/FRAPPE_EMISADJ_CO_RETR/obs_diag_output_profile.nc';
%exp         = '/FRAPPE_EMISADJ_CO_CPSR/obs_diag_output_profile.nc';
%
fname=strcat(path,exp);
copystring    = 'totalspread';
%copystring    = 'spread';
%
%obsname      = 'MOPITT_CO_PROFILE';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
obsname      = 'MOPITT_CO_CPSR';
plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'IASI_CO_PROFILE';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
obsname      = 'IASI_CO_CPSR';
plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TES_CO_PROFILE';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
obsname      = 'TES_CO_CPSR';
plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
obsname      = 'AIRNOW_CO';
plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname,'range',[lbnd,ubnd]);
