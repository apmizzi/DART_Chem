%
path='/nobackupp28/amizzi/OUTPUT_DATA/DART_OBS_DIAG';
exp= '/TRACER_I_ALLCHEM/obs_diag_output_profile.nc';
%
fname=strcat(path,exp);
%
%copystring    = 'ens_mean';
%copystring    = 'observation';
%copystring    = 'bias';
copystring     = 'rmse';
obsnamevar     = 'OMI_SO2_PBL_COL';
%
plot = plot_profile(fname,copystring,'obsname',obsnamevar);

