%
path='/nobackupp11/amizzi/OUTPUT_DATA/DART_OBS_DIAG';
%
exp         = '/real_FIREX_CONTROL_NASA_v4/obs_diag_output_profile.nc';
exp         = '/real_FIREX_ALLCHEM_NASA_v4/obs_diag_output_profile.nc';
exp         = '/real_FIREX_EMISADJ_NASA_v4/obs_diag_output_profile.nc';
exp         = '/real_FIREX_AIRNOW_O3_v4/obs_diag_output_profile.nc';
exp         = '/real_FIREX_TROPOMI_CO_v4/obs_diag_output_profile.nc';
exp         = '/real_FIREX_MOPITT_CO_v4/obs_diag_output_profile.nc';
%exp         = '/real_FIREX_TROPOMI_NO2_v4/obs_diag_output_profile.nc';
%
%exp         = '/real_FRAPPE_CONTROL_NASA_v4/obs_diag_output_profile.nc';
%exp         = '/real_FRAPPE_ALLCHEM_NASA_v4/obs_diag_output_profile.nc';
%exp         = '/real_FRAPPE_EMISADJ_NASA_v4/obs_diag_output_profile.nc';
%
%
fname=strcat(path,exp);
copystring    = 'totalspread';
%copystring    = 'spread';
%
obsname      = 'MOPITT_CO_RETRIEVAL';
plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'IASI_CO_RETRIEVAL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
obsname      = 'AIRNOW_CO';
plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'AIRNOW_O3';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'AIRNOW_NO2';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'AIRNOW_SO2';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'AIRNOW_PM10';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'AIRNOW_PM25';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'MODIS_AOD_RETRIEVAL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'OMI_NO2_COLUMN';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
obsname      = 'TROPOMI_CO_COLUMN';
plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TROPOMI_NO2_COLUMN';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TEMPO_NO2_COLUMN';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname,'range',[lbnd,ubnd]);
