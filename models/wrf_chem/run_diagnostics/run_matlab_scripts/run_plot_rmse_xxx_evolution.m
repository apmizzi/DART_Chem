%
path='/nobackupp11/amizzi/OUTPUT_DATA/DART_OBS_DIAG';
%
exp         = '/real_FRAPPE_CONTROL_NASA/obs_diag_output.nc';
exp         = '/real_FRAPPE_ALLCHEM_NASA/obs_diag_output.nc';
%exp         = '/real_FRAPPE_ALLCHEM_RELAX/obs_diag_output.nc';
%
fname=strcat(path,exp);
%
npar=1;
copystring    = {'totalspread'};
%copystring    = {'spread'};
nvar=1;
%obsname      = {'AIRNOW_CO'};
%obsname      = {'AIRNOW_O3'};
obsname      = {'IASI_CO_RETRIEVAL'};
%obsname      = {'MOPITT_CO_RETRIEVAL'};
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
