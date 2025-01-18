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
force_use_old_data                  = ${NL_FORCE_USE_OLD_DATA:-.true.},
history_interval                    = ${NL_HISTORY_INTERVAL},
history_begin_h                     = 00, 00,
frames_per_outfile                  = ${NL_FRAMES_PER_OUTFILE},

interval_seconds                    = ${NL_INTERVAL_SECONDS},
input_from_file                     = ${NL_INPUT_FROM_FILE},
fine_input_stream                   = ${NL_FINE_INPUT_STREAM},

cycling                             = ${NL_CYCLING:-.true.}
restart                             = ${NL_RESTART},
restart_interval                    = ${NL_RESTART_INTERVAL},

auxinput1_inname                    = ${NL_AUXINPUT1_INNAME},

auxinput4_inname                    = ${NL_AUXINPUT4_INNAME},
auxinput4_interval_m                = ${NL_AUXINPUT4_INTERVAL_M},
io_form_auxinput4                   = ${NL_IO_FORM_AUXINPUT4},

auxinput5_inname                    = ${NL_AUXINPUT5_INNAME},
auxinput5_interval_m                = ${NL_AUXINPUT5_INTERVAL_M},
frames_per_auxinput5                = ${NL_FRAMES_PER_AUXINPUT5},
io_form_auxinput5                   = ${NL_IO_FORM_AUXINPUT5},

auxinput6_inname                    = ${NL_AUXINPUT6_INNAME},
io_form_auxinput6                   = ${NL_IO_FORM_AUXINPUT6},

auxinput7_inname                    = ${NL_AUXINPUT7_INNAME},
auxinput7_interval_m                = ${NL_AUXINPUT7_INTERVAL_M},
frames_per_auxinput7                = ${NL_FRAMES_PER_AUXINPUT7},
io_form_auxinput7                   = ${NL_IO_FORM_AUXINPUT7},

auxinput12_inname                   = ${NL_AUXINPUT12_INNAME},
io_form_auxinput12                  = ${NL_IO_FORM_AUXINPUT12},
debug_level                         = ${NL_DEBUG_LEVEL},
/
&domains
time_step                           = ${NL_TIME_STEP},
time_step_fract_num                 = ${NL_TIME_STEP_FRACT_NUM},
time_step_fract_den                 = ${NL_TIME_STEP_FRACT_DEN:-1},
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
eta_levels                          = ${NL_ETA_LEVELS:-1},

interp_type                         = ${NL_INTERP_TYPE}, 
extrap_type                         = ${NL_EXTRAP_TYPE},
t_extrap_type                       = ${NL_T_EXTRAP_TYPE},
lagrange_order                      = ${NL_LAGRANGE_ORDER},

lowest_lev_from_sfc                 = ${NL_LOWEST_LEV_FROM_SFC},
force_sfc_in_vinterp                = ${NL_FORCE_SFC_IN_VINTERP:-1},
zap_close_levels                    = ${NL_ZAP_CLOSE_LEVELS},
sfcp_to_sfcp                        = ${NL_SFCP_TO_SFCP:-.false.}
adjust_heights                      = ${NL_ADJUST_HEIGHTS:-.false.}

use_levels_below_ground             = ${NL_USE_LEVELS_BELOW_GROUND},
use_surface                         = ${NL_USE_SURFACE}, 

dx                                  = ${NL_DX},
dy                                  = ${NL_DY},

grid_id                             = ${NL_GRID_ID},
parent_id                           = ${NL_PARENT_ID},
i_parent_start                      = ${NL_I_PARENT_START},
j_parent_start                      = ${NL_J_PARENT_START},
parent_grid_ratio                   = ${NL_PARENT_GRID_RATIO},
parent_time_step_ratio              = ${NL_PARENT_TIME_STEP_RATIO},

vert_refine_method                  = ${NL_VERT_REFINE_METHOD:-0}
vert_refine_fact                    = ${NL_VERT_REFINE_FACT:-1}

feedback                            = ${NL_FEEDBACK},
smooth_option                       = ${NL_SMOOTH_OPTION},
smooth_cg_topo                      = ${NL_SMOOTH_CG_TOPO:-.true.}
num_traj                            = ${NL_NUM_TRAJ:-1}
/
&physics
mp_physics                          = ${NL_MP_PHYSICS},
mp_zero_out                         = ${NL_MP_ZERO_OUT},

ra_lw_physics                       = ${NL_RA_LW_PHYSICS},
ra_sw_physics                       = ${NL_RA_SW_PHYSICS},
radt                                = ${NL_RADT},
swint_opt                           = ${NL_SWINT_OPT:-1},
aer_opt                             = ${NL_AER_OPT:-0},

slope_rad                           = ${NL_SLOPE_RAD:-0},
topo_shading                        = ${NL_TOPO_SHADING:-1},
shadlen                             = ${NL_SHADLEN:-25000},

surface_input_source                = ${NL_SURFACE_INPUT_SOURCE},
sf_surface_physics                  = ${NL_SF_SURFACE_PHYSICS},
sf_urban_physics                    = ${NL_SF_URBAN_PHYSICS},
sf_lake_physics                     = ${NL_SF_LAKE_PHYSICS:-0},

sst_update                          = ${NL_SST_UPDATE:-1},
num_soil_layers                     = ${NL_NUM_SOIL_LAYERS},
num_land_cat                        = ${NL_NUM_LAND_CAT},
usemonalb                           = ${NL_USEMONALB:-.true.},
rdlai2d                             = ${NL_RDLAIALB:-.true.},

sf_sfclay_physics                   = ${NL_SF_SFCLAY_PHYSICS},
bl_pbl_physics                      = ${NL_BL_PBL_PHYSICS},
bl_mynn_tkeadvect                   = ${NL_BL_MYNN_TKEADVECT:-.false.},
bl_mynn_tkebudget                   = ${NL_BL_MYNN_TKEBUDGET:-0},
bl_mynn_cloudpdf                    = ${NL_BL_MYNN_CLOUDPDF:-2},
bl_mynn_edmf                        = ${NL_BL_MYNN_EDMF:-0},
bl_mynn_edmf_mom                    = ${NL_BL_MYNN_EDMF_MOM:-0},
bl_mynn_edmf_tke                    = ${NL_BL_MYNN_EDMF_TKE:-0},
bl_mynn_mixlength                   = ${NL_BL_MYNN_MIXLENGTH:-0},
bl_mynn_mixqt                       = ${NL_BL_MYNN_MIXQT:-0},

grav_settling                       = ${NL_GRAV_SETTLING:-2},
iz0tlnd                             = ${NL_IZ0TLND:-1},
bldt                                = ${NL_BLDT:-0},

cu_physics                          = ${NL_CU_PHYSICS},
cudt                                = ${NL_CUDT},
cu_rad_feedback                     = ${NL_CU_RAD_FEEDBACK},
cu_diag                             = ${NL_CU_DIAG},
ishallow                            = ${NL_ISHALLOW:-1},
prec_acc_dt                         = ${NL_PREC_ACC_DT:-60},

shcu_physics                        = ${NL_SHCU_PHYSICS:-0},

isfflx                              = ${NL_ISFFLX},
ifsnow                              = ${NL_IFSNOW},
icloud                              = ${NL_ICLOUD},
icloud_bl                           = ${NL_ICLOUD_BL:-1},
traj_opt                            = ${NL_TRAJ_OPT:-0},
dm_has_traj                         = ${NL_DM_HAS_TRAJ:-.true.},
/
&dfi_control
dfi_opt                             = 0,
/
&tc
/
&scm
/
&dynamics
hybrid_opt                          = ${NL_HYBRID_OPT:-0},
km_opt                              = ${NL_KM_OPT},
km_opt_dfi                          = ${NL_KM_OPT_DFI:-1},
diff_opt                            = ${NL_DIFF_OPT},

c_s                                 = ${NL_C_S:-0.25},

mix_full_fields                     = ${NL_MIX_FULL_FIELDS:-.false.},

damp_opt                            = ${NL_DAMP_OPT},
zdamp                               = ${NL_ZDAMP},
dampcoef                            = ${NL_DAMPCOEF},
w_damping                           = ${NL_W_DAMPING},

diff_6th_opt                        = ${NL_DIFF_6TH_OPT},
diff_6th_factor                     = ${NL_DIFF_6TH_FACTOR},
gwd_opt                             = ${NL_GWD_OPT:-0},

base_temp                           = ${NL_BASE_TEMP:-290},
iso_temp                            = ${NL_ISO_TEMP:-200},

khdif                               = ${NL_KHDIF:-0},
kvdif                               = ${NL_KVDIF:-0},
smdiv                               = ${NL_SMDIV:-0.1},
emdiv                               = ${NL_EMDIV:-0.01},
epssm                               = ${NL_EPSSM:-0.1},
time_step_sound                     = ${NL_TIME_STEP_SOUND:-4},

h_mom_adv_order                     = ${NL_H_MOM_ADV_ORDER},
v_mom_adv_order                     = ${NL_V_MOM_ADV_ORDER},
h_sca_adv_order                     = ${NL_H_SCA_ADV_ORDER},
v_sca_adv_order                     = ${NL_V_SCA_ADV_ORDER},
non_hydrostatic                     = ${NL_NON_HYDROSTATIC},

use_input_w                         = ${NL_USE_INPUT_W:-.false.},

moist_adv_opt                       = ${NL_MOIST_ADV_OPT},
momentum_adv_opt                    = ${NL_MOMENTUM_ADV_OPT:-1},
scalar_adv_opt                      = ${NL_SCALAR_ADV_OPT},
tke_adv_opt                         = ${NL_TKE_ADV_OPT},
chem_adv_opt                        = ${NL_CHEM_ADV_OPT},

do_avgflx_em                        = ${NL_DO_AVGFLX_EM:-1},
do_avgflx_cugd                      = ${NL_DO_AVGFLX_CUGD:-1},
/
&bdy_control
spec_bdy_width                      = ${NL_SPEC_BDY_WIDTH},
spec_zone                           = ${NL_SPEC_ZONE},
relax_zone                          = ${NL_RELAX_ZONE},
specified                           = ${NL_SPECIFIED},
nested                              = ${NL_NESTED:-.false.},
spec_exp                            = ${NL_SPEC_EXP:-0},
constant_bc                         = ${NL_CONSTANT_BC:-.false.},
/
&grib2
/
&namelist_quilt
nio_tasks_per_group                 = ${NL_NIO_TASKS_PER_GROUP},
nio_groups                          = ${NL_NIO_GROUPS},
/
&chem
chem_opt                           = ${NL_CHEM_OPT},
gaschem_onoff                      = ${NL_GASCHEM_ONOFF},
aerchem_onoff                      = ${NL_AERCHEM_ONOFF},
do_pvozone                         = ${NL_DO_PVOZONE:-.false.},
phot_blcld                         = ${NL_PHOT_BLCLD:-.true.},
chemdt                             = ${NL_CHEMDT},
bioemdt                            = ${NL_BIOEMDT},

lnox_opt                           = ${NL_LNOX_OPT:-1}, 
N_IC                               = ${NL_N_IC:-125.}, 
N_CG                               = ${NL_N_CG:-125.},

lightning_option                   = ${NL_LIGHTNING_OPTION:-11}, 
iccg_prescribed_num                = ${NL_ICCG_PRESCRIBED_NUM:-2}, 
iccg_prescribed_den                = ${NL_ICCG_PRESCRIBED_DEN:-1}, 
lightning_dt                       = ${NL_LIGHTNING_DT:-60}, 
cellcount_method                   = ${NL_CELLCOUNT_METHOD:-0}, 
lightning_start_seconds            = ${NL_LIGHTNING_START_SECONDS:-600}, 
cldtop_adjustment                  = ${NL_CLDTOP_ADJUSTMENT:-0}, 

iccg_method                        = ${NL_ICCG_METHOD:-2}, 
flashrate_factor                   = ${NL_FLASHRATE_FACTOR:-1}, 

vertmix_onoff                      = ${NL_VERTMIX_ONOFF},
chem_conv_tr                       = ${NL_CHEM_CONV_TR},
mynn_chem_vertmx                   = .true.,
enh_vermix                         = .false.,
have_bcs_upper                     = .false.,

gas_drydep_opt                     = ${NL_GAS_DRYDEP_OPT},
aer_drydep_opt                     = ${NL_AER_DRYDEP_OPT},

emiss_inpt_opt                     = ${NL_EMISS_INPT_OPT},
emiss_opt                          = ${NL_EMISS_OPT},
kemit                              = ${NL_KEMIT},
io_style_emissions                 = ${NL_IO_STYLE_EMISSIONS},
aircraft_emiss_opt                 = ${NL_AIRCRAFT_EMISS_OPT:-0}, 
bio_emiss_opt                      = ${NL_BIO_EMISS_OPT},
ne_area                            = ${NL_NE_AREA}, 
phot_opt                           = ${NL_PHOT_OPT},
photdt                             = ${NL_PHOTDT},
is_full_tuv                        = .true.,
has_o3_exo_coldens                 = .false.,
scale_o3_to_grnd_exo_coldens       = .false.,
scale_o3_to_du_at_grnd             = .false.,
scale_o3_to_gfs_tot                = .true.,
pht_cldfrc_opt                     = 2,
cld_od_opt                         = 1,

conv_tr_aqchem                     = ${NL_CONV_TR_AQCHEM},
conv_tr_wetscav                    = ${NL_CONV_TR_WETSCAV},
cldchem_onoff                      = ${NL_CLDCHEM_ONOFF},
wetscav_onoff                      = ${NL_WETSCAV_ONOFF},

seas_opt                           = ${NL_SEAS_OPT}, 
dust_opt                           = ${NL_DUST_OPT}, 
dmsemis_opt                        = ${NL_DMSEMIS_OPT}, 
biomass_burn_opt                   = ${NL_BIOMASS_BURN_OPT},

gas_bc_opt                         = ${NL_GAS_BC_OPT},
gas_ic_opt                         = ${NL_GAS_IC_OPT},
aer_bc_opt                         = ${NL_AER_BC_OPT},
aer_ic_opt                         = ${NL_AER_IC_OPT},

aer_ra_feedback                    = ${NL_AER_RA_FEEDBACK},
aer_op_opt                         = ${NL_AER_OP_OPT:-1}, 
opt_pars_out                       = ${NL_OPT_PARS_OUT:-1}, 

diagnostic_chem                    = ${NL_DIAGNOSTIC_CHEM:-2}, 

chem_in_opt                        = ${NL_CHEM_IN_OPT},
have_bcs_chem                      = .true.,
have_ics_ch4                       = ${NL_HAVE_ICS_CH4:-.true.},
/
EOF
