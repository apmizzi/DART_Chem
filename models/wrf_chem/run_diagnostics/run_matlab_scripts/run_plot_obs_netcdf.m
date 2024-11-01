
fname         = '/nobackupp28/amizzi/OUTPUT_DATA/DART_OBS_DIAG/TRACER_I_ALLCHEM/obs_diag_output_profile.nc'
region        = [0 360 -90 90 -Inf Inf];
ObsTypeString = 'OMI_SO2_PBL_COL';
CopyString    = 'NCEP BUFR observation';
QCString      = 'DART quality control';
maxgoodQC     = 2;
verbose       = 1;
twoup         = 0;
plot          = plot_obs_netcdf(fname, ObsTypeString, region, CopyString, ...
                QCString, maxgoodQC, verbose, twoup);
