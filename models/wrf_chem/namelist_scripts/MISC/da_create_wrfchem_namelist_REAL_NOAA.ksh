#!/bin/ksh -x
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download

#########################################################################
#
# Purpose: Script to create WRF Namelist 

#########################################################################
#
# CREATE WRF NAMELIST FILE
rm -f namelist.input
touch namelist.input
cat > namelist.input << EOF
&time_control
run_days                            = ${NL_RUN_DAYS},
run_hours                           = ${NL_RUN_HOURS},
run_minutes                         = ${NL_RUN_MINUTES},
run_seconds                         = ${NL_RUN_SECONDS},
start_year                          = ${NL_START_YEAR},
start_month                         = ${NL_START_MONTH},
start_day                           = ${NL_START_DAY},
start_hour                          = ${NL_START_HOUR},
start_minute                        = ${NL_START_MINUTE},
start_second                        = ${NL_START_SECOND},
end_year                            = ${NL_END_YEAR},
end_month                           = ${NL_END_MONTH},
end_day                             = ${NL_END_DAY},
end_hour                            = ${NL_END_HOUR},
end_minute                          = ${NL_END_MINUTE},
end_second                          = ${NL_END_SECOND},
force_use_old_data                  = .true.,
history_interval                    = ${NL_HISTORY_INTERVAL},
history_begin_h                     = 00,   00,   00,
frames_per_outfile                  = ${NL_FRAMES_PER_OUTFILE},

interval_seconds                    = ${NL_INTERVAL_SECONDS},
input_from_file                     = ${NL_INPUT_FROM_FILE},             ! whether the nested run will have input files for domains other than 1
fine_input_stream                   = ${NL_FINE_INPUT_STREAM},                    ! 0- all fields from nest input are used
                                                                        ! 2- only nest input specified from input stream 2 (defined in the Registry) are used
cycling                             = .false.                           ! true for cycling (using wrfout file as input data)
restart                             = ${NL_RESTART},
restart_interval                    = ${NL_RESTART_INTERVAL},

auxinput1_inname                    = "met_em.d<domain>.<date>",

auxinput4_inname                    = "wrflowinp_d<domain>",            ! SST data input
auxinput4_interval                  = 360,  360,
io_form_auxinput4                   = 2,

auxinput5_inname                    = ${NL_AUXINPUT5_INNAME},
frames_per_auxinput5                = ${NL_FRAMES_PER_AUXINPUT5},
auxinput5_interval_m                = ${NL_AUXINPUT5_INTERVAL_M},                           ! Anthropogenic emissions input
io_form_auxinput5                   = ${NL_IO_FORM_AUXINPUT5},

auxinput6_inname                    = ${NL_AUXINPUT6_INNAME},          ! Biogenic emissions input
io_form_auxinput6                   = ${NL_IO_FORM_AUXINPUT6},

auxinput12_inname                   = "wrf_chem_input",                 ! Reading WRF-Chem output from a previous run
io_form_auxinput12                  = 2,
debug_level                         = 0,
/

&domains
time_step                           = ${NL_TIME_STEP},
time_step_fract_num                 = ${NL_TIME_STEP_FRACT_NUM},
time_step_fract_den                 = ${NL_TIME_STEP_FRACT_DEN},
max_dom                             = ${NL_MAX_DOM},
s_we                                = ${NL_S_WE},
e_we                                = ${NL_E_WE},
s_sn                                = ${NL_S_SN},
e_sn                                = ${NL_E_SN},

num_metgrid_levels                  = ${NL_NUM_METGRID_LEVELS},
num_metgrid_soil_levels             = ${NL_NUM_METGRID_SOIL_LEVELS},
p_top_requested                     = ${NL_P_TOP_REQUESTED},
s_vert                              = ${NL_S_VERT},
e_vert                              = ${NL_E_VERT},
eta_levels                          = ${NL_ETA_LEVELS:--1},

interp_type                         = 2                                 ! (default) vertical interpolation that is linear in log(pressure)
extrap_type                         = 2                                 ! (default) vertical extrapolation of non-temperature variables, using the lowest level as constant below ground
t_extrap_type                       = 2                                 ! vertical extrapolation for potential temp: (default) -6.5 K/km lapse rate for temperature
lagrange_order                      = 2                                 ! (default) quadratic vertical interpolation order

lowest_lev_from_sfc                 = .false.                           ! (default) use traditional interpolation
force_sfc_in_vinterp                = 1                                 ! (default) use the surface level as the lower boundary when interpolating through this many eta levels
zap_close_levels                    = 500                               ! allow surface data to be used if it is close to a constant pressure level
sfcp_to_sfcp                        = .false.                           ! optional method to compute model's surface pressure when incoming data only has surface pressure and terrain, but not sealevel pressure (default is .false.)
adjust_heights                      = .false.                           !

lowest_lev_from_sfc                 = .false.                           ! (default) use traditional interpolation
use_levels_below_ground             = .true.                            ! in vertical interpolation, whether to use levels below input surface level; (default) use input isobaric levels below input surface
use_surface                         = .true.                            ! (default) uses input surface level

dx                                  = ${NL_DX},
dy                                  = ${NL_DY},

grid_id                             = 1,
parent_id                           = 0,
i_parent_start                      = 1,
j_parent_start                      = 1,
parent_grid_ratio                   = 1,
parent_time_step_ratio              = 1,

vert_refine_method                  = 0,
vert_refine_fact                    = 1,

feedback                            = 0,
smooth_option                       = 0,
smooth_cg_topo                      = .true.,                           ! smooth topography on the outer rows and columns in domain 1
num_traj                            = 0,
!use_adaptive_time_step              = .true.,
!step_to_output_time                 = .true.,
!target_cfl                          = 1.75,
!max_step_increase_pct               = 5,51
!starting_time_step                  = 72,72,
!max_time_step                       = 96,96
!min_time_step                       = 32,48
/

&physics
mp_physics                          = ${NL_MP_PHYSICS},                                ! WRF Single-Moment 5-class scheme: A slightly more sophisticated version of (3) that allows for mixed-phase processes and super-cooled water
mp_zero_out                         = ${NL_MP_ZERO_OUT},                                ! for non-zero mp_physics options, this keeps moisture variables above a threshold value .0. An alternative (and better) way to keep moisture variables positive is to use the moist_adv_opt

ra_lw_physics                       = ${NL_RA_LW_PHYSICS},                                ! RRTMG scheme
ra_sw_physics                       = ${NL_RA_SW_PHYSICS},                                ! RRTMG scheme
radt                                = ${NL_RADT},
swint_opt                           = 0,                                ! Interpolation of shortwave radiation based on the updated solar zenith angle between radiation calls
aer_opt                             = 2,                                ! aerosol input option (RRTMG only); 1-using Tegen climatology; 2 - J. A. Ruiz-Arias method (see other aer* options)

slope_rad                           = 0,                                ! use slope-dependent radiation
topo_shading                        = 1,                                ! applies neighboring-point shadow effects for ra_sw_physics
shadlen                             = 25000.,                           ! maximum length of orographic shadow (in meters); use with topo_shading=1

surface_input_source                = 1,                                ! where landuse and soil category data come from 1 (default) WPS/geogrid, but with dominant categories recomputed in real
sf_surface_physics                  = ${NL_SF_SURFACE_PHYSICS},                                ! Land Surface; Noah Land Surface Model: Unified NCEP/NCAR/AFWA scheme with soil temperature and moisture in four layers, fractional snow cover and frozen soil physics
sf_urban_physics                    = 0,                                ! Urban canopy model (1): 3-category UCM option with surface effects for roofs, walls, and streets.
sf_lake_physics                     = 0,                                ! lake model on (default is 0 = off)

sf_surface_mosaic                   = 1,                                ! use mosaic landuse categories
mosaic_cat                          = 3,                                ! (default) number of mosaic landuse categories in a grid cell
mosaic_lu                           = 0,                                ! For RUC LSM only
mosaic_soil                         = 0,                                ! For RUC LSM only

sst_update                          = 1,                                ! option to use time-varying SST, seaice, vegetation fraction, and albedo during a model simulation (set before running real.exe)
num_soil_layers                     = ${NL_NUM_SOIL_LAYERS},                                ! number of soil layers in land surface model (set before running real.exe)
num_land_cat                        = ${NL_NUM_LAND_CAT},                               ! In future use MODIS with lake category
usemonalb                           = .true.                            ! When set to .true., it uses monthly albedo fields from geogrid, instead of table values
rdlai2d                             = .true.                            ! When set to .true., it uses monthly LAI data from geogrid (new in V3.6) and the field will also go to wrflowinp file if sst_update is 1.

sf_sfclay_physics                   = ${NL_SF_SFCLAY_PHYSICS},                                ! surface layer option
bl_pbl_physics                      = ${NL_BL_PBL_PHYSICS},                                ! boundary layer option, MYNN 2.5 level TKE
bl_mynn_tkeadvect                   = .false.,                          ! (default) off; does not advect tke in MYNN scheme (default)
bl_mynn_tkebudget                   = 0,                                ! 1- adds MYNN tke budget terms to output
bl_mynn_cloudpdf                    = 2,
bl_mynn_edmf                        = 0,
bl_mynn_edmf_mom                    = 0,
bl_mynn_edmf_tke                    = 0,
bl_mynn_mixlength                   = 2,
bl_mynn_mixqt                       = 0,

grav_settling                       = 2,                                ! Fogdes (vegetation and wind speed dependent; Katata et al. 2008) at surface, and Dyunkerke in the atmosphere
iz0tlnd                             = 1,                                ! Chen-Zhang thermal roughness length over land, which depends on vegetation height
bldt                                = 0,

cu_physics                          = ${NL_CU_PHYSICS},                                ! Grell-Freitas ensemble scheme
cudt                                = ${NL_CUDT},
cu_rad_feedback                     = .true.,                           ! sub-grid cloud effect to the optical depth in radiation currently it works only for GF, G3, GD, and KF schemes; also need to set cu_diag = 1 for GF, G3, and GD schemes (default is .false. =off)
cu_diag                             = 1,                                ! Additional time-averaged diagnostics from cu_physics (use only with cu_physics=3,5,and 93)
ishallow                            = 1,                                ! shallow convection used with cu_physics=3 or 5 (default is 0 = off)
prec_acc_dt                         = 60.,                              ! bucket reset time interval between outputs for cumulus or grid-scale precipitation (in minutes)

shcu_physics                        = 0,                                ! independent shallow cumulus option (not tied to deep convection);
                                                                        ! 2- CAM UW shallow convection, 3- GRIMS scheme

isfflx                              = 1,                                ! heat and moisture fluxes from the surface for real-data cases and when a PBL is used (only works with sf_sfclay_physics=1, 5, 7, or 11) 1 = fluxes are on, 0 = fluxes are off
ifsnow                              = 1,                                ! snow-cover effects (only works for sf_surface_physics=1)
icloud                              = 1,                                ! (default) cloud effect to the optical depth in radiation (only works with ra_sw_physics=1,4 and ra_lw_physics=1,4). with cloud effect, and use cloud fraction option 1 (Xu-Randall mehod)
icloud_bl                           = 1,
traj_opt                            = 0,
dm_has_traj                         = .true.,
/

&dynamics
hybrid_opt                          = ${NL_HYBRID_OPT},                 ! WRF V3.9 vert coord opt (0= no hybrid TF, 2= hybrid HYB)
km_opt                              = 4,                                ! horizontal Smagorinsky first order closure (recommended for realdata case)
km_opt_dfi                          = 1,
diff_opt                            = 2,                                ! 1 - (default) evaluates 2nd order diffusion term on coordinate surfaces, uses kvdif for vertical diffusion unless PBL option is used, may be used with km_opt = 1 (recommended for real-data case) and 4
                                                                        ! 2 - evaluates mixing tems in physical space (stress form) (x,y,z); turbulence parameterization is chosen by specifying km_opt

c_s                                 = 0.25,                             ! Smagorinsky coeff

mix_full_fields                     = .false.,                          ! used with diff_opt = 2; value of .true. is recommended, except for highly idealized numerical tests; damp_opt must not be =1 if .true. is chosen; .false. means subtract 1D base-state profile before mixing (only for idealized)

damp_opt                            = 3,                                ! with Rayleigh damping (dampcoef inverse time scale [1/s], e.g. 0.2; for real-data cases)
zdamp                               = 5000.,                            ! damping depth (m) from model top
dampcoef                            = 0.2,                              ! damping coefficient
w_damping                           = 1,                                ! vertical velocity damping flag (for operational use)

diff_6th_opt                        = 2,                                ! 6th-order numerical diffusion nondimensional rate (max value 1.0 corresponds to complete removal of 2dx wave in one timestep)
diff_6th_factor                     = 0.12,                             ! 0.12 is the default number
gwd_opt                             = 0,                                ! gravity wave drag option; use when grid size > 10 km (default is 0=off)

base_temp                           = 290.,                             ! base state temperature (K); real only
iso_temp                            = 200.,                             ! isothermal temperature in statosphere; enables model to be extended to 5 mb; real only. Default value changed to 200 since V3.5

khdif                               = 0,                                ! horizontal diffusion constant (m2/s)
kvdif                               = 0,                                ! vertical diffusion constant (m2/s)
smdiv                               = 0.1,                              ! divergence damping (0.1 is typical)
emdiv                               = 0.01,                             ! external-mode filter coef for mass coordinate model (0.01 is typical for real-data cases)
epssm                               = 0.1,                              ! time off-centering for vertical sound waves
time_step_sound                     = 4,                                ! number of sound steps per timestep (if using a time_step much larger than 6*DX (in km), increase number of sound steps (default is 0)

h_mom_adv_order                     = 5,                                ! horizontal momentum advection order
v_mom_adv_order                     = 3,                                ! vertical momentum advection order
h_sca_adv_order                     = 5,                                ! horizontal scalar advection order
v_sca_adv_order                     = 3,                                ! vertical scalar advection order
non_hydrostatic                     = .true.,

use_input_w                         = .false.,                          ! whether to use vertical velocity from input file

moist_adv_opt                       = 2,                                ! (default) positive-definite
momentum_adv_opt                    = 1,
scalar_adv_opt                      = 2,                                ! monotonic
tke_adv_opt                         = 2,
chem_adv_opt                        = 2,

do_avgflx_em                        = 1,
do_avgflx_cugd                      = 1,
/

&dfi_control
dfi_opt                             = 0
/

&bdy_control
spec_bdy_width                      = 5,
spec_zone                           = 1,
relax_zone                          = 4,
specified                           = .true.,
nested                              = .false.,
spec_exp                            = 0.                                ! exponential multiplier for relaxation zone ramp for specified = .true.; default is 0. = linear ramp; 0.33 = ~3*DX exp decay factor (real only)
constant_bc                         = .false.,                           ! constant boundary condition used with DFI (default is .false.)
/

&grib2
/
&namelist_quilt
nio_tasks_per_group                 = ${NL_NIO_TASKS_PER_GROUP},
nio_groups                          = ${NL_NIO_GROUPS},
/

&chem
!chem_opt                            = 108,      108,            
bio_emiss_opt                       = 2,        0, 
/
EOF

