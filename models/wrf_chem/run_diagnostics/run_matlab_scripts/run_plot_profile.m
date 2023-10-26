%
path='/nobackupp11/amizzi/OUTPUT_DATA/DART_OBS_DIAG';
exp         = '/real_FRAPPE_ALLCHEM_NASA_v4/obs_diag_output_profile.nc';
%
fname=strcat(path,exp);
%
%copystring    = 'ens_mean';
%copystring    = 'observation';
%copystring    = 'bias';
copystring     = 'rmse';
%obsnamevar    = 'MOPITT_CO_PROFILE';
%obsnamevar    = 'IASI_CO_PROFILE';
obsnamevar    = 'OMI_NO2_TROP_COL';
%
  plot = plot_profile(fname,copystring,'obsname',obsnamevar);

