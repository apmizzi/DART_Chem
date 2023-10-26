
fname         = '/nobackupp11/amizzi/OUTPUT_DATA/DART_OBS_DIAG/real_FRAPPE_ALLCHEM_NASA_v4/obs_diag_output_profile.nc'
region        = [0 360 -90 90 -Inf Inf];
%ObsTypeString = 'MOPITT_CO_PROFILE';
%ObsTypeString = 'IASI_CO_PROFILE';
%ObsTypeString = 'IASI_O3_PROFILE';
ObsTypeString = 'OMI_NO2_TROP_COL';
CopyString    = 'NCEP BUFR observation';
QCString      = 'DART quality control';
maxgoodQC     = 2;
verbose       = 1;
twoup         = 0;
plot          = plot_obs_netcdf(fname, ObsTypeString, region, CopyString, ...
                      QCString, maxgoodQC, verbose, twoup);
