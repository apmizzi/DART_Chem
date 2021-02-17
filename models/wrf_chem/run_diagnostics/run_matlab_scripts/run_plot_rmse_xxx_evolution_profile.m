%
path='/nobackupp11/amizzi/OUTPUT_DATA/DART_OBS_DIAG';
%
exp         = '/real_FRAPPE_CONTROL_NASA/obs_diag_output_profile.nc';
exp         = '/real_FRAPPE_ALLCHEM_NASA/obs_diag_output_profile.nc';
exp         = '/real_FRAPPE_ALLCHEM_RELAX_NASA/obs_diag_output_profile.nc';
exp         = '/real_COLO_ALLCHEM_RELAX_NASA/obs_diag_output_profile.nc';
exp         = '/real_FRAPPE_ALLCHEM_EMISS_ADJ_NASA/obs_diag_output_profile.nc';
%
fname=strcat(path,exp);
%
npar=1;
copystring    = {'totalspread'};
%copystring    = {'spread'};
nvar=1;
%obsname      = {'MOPITT_CO_RETRIEVAL'};
%obsname      = {'IASI_CO_RETRIEVAL'};
%obsname      = {'AIRNOW_CO'};
obsname      = {'AIRNOW_O3'};
%obsname      = {'AIRNOW_NO2'};
%obsname      = {'MODIS_AOD_RETRIEVAL'};
%obsname      = {'AIRNOW_PM10'};
%obsname      = {'OMI_O3_COLUMN'};
%obsname      = {'OMI_NO2_COLUMN'};
%obsname      = {'OMI_SO2_COLUMN'};
lbnd=0.;
ubnd=0.4;
%ubnd=0.3;
%ubnd=1.5;
%%ubnd=3.0;
%
for ipar=1:npar
for ivar=1:nvar
plot = plot_rmse_xxx_evolution(fname,copystring{ipar},'obsname',obsname{ivar});
%plot = plot_rmse_xxx_evolution(fname,copystring{ipar},'obsname',obsname{ivar},'range',[lbnd,ubnd]);
end
end
