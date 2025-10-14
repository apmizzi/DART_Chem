%
path='/nobackupp28/amizzi/OUTPUT_DATA/DART_OBS_DIAG';
exp         = '/TRACER-I/obs_diag_output_profile.nc';
%
fname=strcat(path,exp)
copystring    = 'totalspread';
%copystring    = 'spread';
%
%obsname      = 'MOPITT_V8_CO_PROFILE';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'MOPITT_CO_CPSR';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'IASI_CO_PROFILE';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'IASI_CO_CPSR';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'MODIS_AOD_TOTAL_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
obsname      = 'OMI_O3_PROFILE';
plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'OMI_O3_CPSR';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'OMI_NO2_TROP_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'OMI_NO2_DOMINO_TROP_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'OMI_SO2_PBL_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'SCIAM_NO2_TROP_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'OMI_HCHO_TOTAL_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TES_CO_PROFILE';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TES_CO_CPSR';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
obsname      = 'TES_O3_PROFILE';
plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TES_O3_CPSR';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'GOME2A_NO2_TROP_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
obsname      = 'MLS_O3_PROFILE';
plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'MLS_O3_CPSR';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
obsname      = 'MLS_HNO3_PROFILE';
plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'MLS_HNO3_CPSR';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TROPOMI_CO_TOTAL_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TROPOMI_NO2_TROP_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TROPOMI_SO2_PBL_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TROPOMI_HCHO_TROP_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TEMPO_O3_PROFILE';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TEMPO_O3_CPSR';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'TEMPO_NO2_TROP_COL';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
%
%obsname      = 'AIRNOW_CO';
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname);
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
%plot = plot_rmse_xxx_evolution(fname,copystring,'obsname',obsname,'range',[lbnd,ubnd]);
return
