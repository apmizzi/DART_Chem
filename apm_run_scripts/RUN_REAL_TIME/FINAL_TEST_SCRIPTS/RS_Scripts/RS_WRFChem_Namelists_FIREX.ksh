#!/bin/ksh -aux
#
# LARGE SCALE FORECAST PARAMETERS:
   export FG_TYPE=NAM
   export GRIB_PART1=nam_218_
   export GRIB_PART2=.g2.tar
#
# WPS PARAMETERS:
   export SINGLE_FILE=false
   export HOR_SCALE=1500
   export VTABLE_TYPE=NAM
   export METGRID_TABLE_TYPE=ARW
#
# MOZBC PARAMETERS:
  export EXP_SPCS_MAP=FIREX
  export MOZBC_SUFFIX='' 
#
# WRF PREPROCESS PARAMETERS
# TARG_LAT=31.56 (33,15) for 072600
# TARG_LON=-120.14 = 239.85 (33,15)
#   export NL_MIN_LAT=27.5
#   export NL_MAX_LAT=38.5
#   export NL_MIN_LON=-125.5
#   export NL_MAX_LON=-115.5
#
# NL_MIN_LON, NL_MAX_LON = [-180.,190.]
# NL_MIN_LAT, NL_MAX_LAT = [-90.,90.]
# NNL_MIN_LON, NNL_MAX_LON = [0.,360.]
# NNL_MIN_LON, NNL_MAX_LON = [-90.,90.]
#
   export NL_MIN_LAT=35
   export NL_MAX_LAT=43
   export NL_MIN_LON=-111
   export NL_MAX_LON=-100
#
   export NNL_MIN_LON=${NL_MIN_LON}
   if [[ ${NL_MIN_LON} -lt 0 ]]; then
      (( NNL_MIN_LON=${NL_MIN_LON}+360 ))
   fi
   export NNL_MAX_LON=${NL_MAX_LON}
   if [[ ${NL_MAX_LON} -lt 0 ]]; then
      (( NNL_MAX_LON=${NL_MAX_LON}+360 ))
   fi
   export NNL_MIN_LAT=${NL_MIN_LAT}
   export NNL_MAX_LAT=${NL_MAX_LAT}
   export NL_OBS_PRESSURE_TOP=5000.
#
#########################################################################
#
#  NAMELIST PARAMETERS
#
#########################################################################
#
# WPS SHARE NAMELIST:
   export NL_WRF_CORE=\'ARW\'
   export NL_MAX_DOM=${MAX_DOMAINS}
   export NL_IO_FORM_GEOGRID=2
   export NL_OPT_OUTPUT_FROM_GEOGRID_PATH=\'${GEOGRID_DIR}\'
   export NL_ACTIVE_GRID=".true."
#
# WPS GEOGRID NAMELIST:
   export NL_S_WE=1
   export NL_E_WE=${NNXP_STAG_CR}
   export NL_S_SN=1
   export NL_E_SN=${NNYP_STAG_CR}
   export NL_S_VERT=1
   export NL_E_VERT=${NNZP_STAG_CR}
   export NL_PARENT_ID="0"
   export NL_PARENT_GRID_RATIO=1
   export NL_I_PARENT_START=${ISTR_CR}
   export NL_J_PARENT_START=${JSTR_CR}
   export NL_GEOG_DATA_RES=\'usgs_lakes+default\'
   export NL_DX=${DX_CR}
   export NL_DY=${DX_CR}
   export NL_MAP_PROJ=\'lambert\'
   export NL_REF_LAT=39.28873
   export NL_REF_LON=-105.8463
   export NL_STAND_LON=-97.0
   export NL_TRUELAT1=30.0
   export NL_TRUELAT2=60.0
   export NL_GEOG_DATA_PATH=\'${WPS_GEOG_DIR}\'
   export NL_OPT_GEOGRID_TBL_PATH=\'${WPS_DIR}/geogrid\'
#
# WPS UNGRIB NAMELIST:
   export NL_OUT_FORMAT=\'WPS\'
#
# WPS METGRID NAMELIST:
   export NL_IO_FORM_METGRID=2
#
# WRF NAMELIST:
# TIME CONTROL NAMELIST:
   export NL_RUN_DAYS=0
   export NL_RUN_HOURS=${FCST_PERIOD}
   export NL_RUN_MINUTES=0
   export NL_RUN_SECONDS=0
   export NL_START_YEAR=${START_YEAR}
   export NL_START_MONTH=${START_MONTH}
   export NL_START_DAY=${START_DAY}
   export NL_START_HOUR=${START_HOUR}
   export NL_START_MINUTE=00
   export NL_START_SECOND=00
   export NL_END_YEAR=${END_YEAR}
   export NL_END_MONTH=${END_MONTH}
   export NL_END_DAY=${END_DAY}
   export NL_END_HOUR=${END_HOUR}
   export NL_END_MINUTE=00
   export NL_END_SECOND=00
   export NL_INTERVAL_SECONDS=${INTERVAL_SECONDS}
   export NL_INPUT_FROM_FILE=".true."
   export NL_HISTORY_INTERVAL=${HISTORY_INTERVAL_MIN}
   export NL_FRAMES_PER_OUTFILE=1
   export NL_RESTART=".false."
   export NL_RESTART_INTERVAL=60
   export NL_IO_FORM_HISTORY=2
   export NL_IO_FORM_RESTART=2
   export NL_FINE_INPUT_STREAM=0
   export NL_IO_FORM_INPUT=2
   export NL_IO_FORM_BOUNDARY=2
   export NL_AUXINPUT2_INNAME=\'wrfinput_d\<domain\>\'
   export NL_AUXINPUT5_INNAME=\'wrfchemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT6_INNAME=\'wrfbiochemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT7_INNAME=\'wrffirechemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT12_INNAME=\'wrfinput_d\<domain\>\'
   export NL_AUXINPUT2_INTERVAL_M=60480
   export NL_AUXINPUT5_INTERVAL_M=60
   export NL_AUXINPUT6_INTERVAL_M=60480
   export NL_AUXINPUT7_INTERVAL_M=60
   export NL_AUXINPUT12_INTERVAL_M=60480
   export NL_FRAMES_PER_AUXINPUT2=1
   export NL_FRAMES_PER_AUXINPUT5=1
   export NL_FRAMES_PER_AUXINPUT6=1
   export NL_FRAMES_PER_AUXINPUT7=1
   export NL_FRAMES_PER_AUXINPUT12=1
   export NL_IO_FORM_AUXINPUT2=2
   export NL_IO_FORM_AUXINPUT5=2
   export NL_IO_FORM_AUXINPUT6=2
   export NL_IO_FORM_AUXINPUT7=2
   export NL_IO_FORM_AUXINPUT12=2
   export NL_IOFIELDS_FILENAME=\'hist_io_flds_v1\'
   export NL_WRITE_INPUT=".true."
   export NL_INPUTOUT_INTERVAL=360
   export NL_INPUT_OUTNAME=\'wrfapm_d\<domain\>_\<date\>\'
   export NL_FORCE_USE_OLD_DATA=".true."
#
# DOMAINS NAMELIST:
   export NL_TIME_STEP=15
   export NNL_TIME_STEP=${NL_TIME_STEP}
   export NL_TIME_STEP_FRACT_NUM=0
   export NL_TIME_STEP_FRACT_DEN=1
#
   export NL_USE_ADAPTIVE_TIME_STEP=".true."
   export NL_STEP_TO_OUTPUT_TIME=".true."
   export NL_TARGET_CFL=1.2
   export NL_TARGET_HCFL=.84
   export NL_MAX_STEP_INCREASE_PCT=5
   export NL_STARTING_TIME_STEP=15
   export NL_STARTING_TIME_STEP_DEN=1
   export NL_MAX_TIME_STEP=30
   export NL_MAX_TIME_STEP_DEN=1
   export NL_MIN_TIME_STEP=5
   export NL_MIN_TIME_STEP_DEN=1
#
   export NL_MAX_DOM=${MAX_DOMAINS}
   export NL_S_WE=1
   export NL_E_WE=${NNXP_STAG_CR}
   export NL_S_SN=1
   export NL_E_SN=${NNYP_STAG_CR}
   export NL_S_VERT=1
   export NL_E_VERT=${NNZP_STAG_CR}
   export NL_NUM_METGRID_LEVELS=40
   export NL_NUM_METGRID_SOIL_LEVELS=4
   export NL_DX=${DX_CR}
   export NL_DY=${DX_CR}
   export NL_GRID_ID=1
   export NL_PARENT_ID=0
   export NL_I_PARENT_START=${ISTR_CR}
   export NL_J_PARENT_START=${JSTR_CR}
   export NL_PARENT_GRID_RATIO=1
   export NL_PARENT_TIME_STEP_RATIO=1
   export NL_FEEDBACK=0
   export NL_SMOOTH_OPTION=0
   export NL_LAGRANGE_ORDER=1
   export NL_INTERP_TYPE=1
   export NL_EXTRAP_TYPE=1
   export NL_T_EXTRAP_TYPE=1
   export NL_USE_SURFACE=".true."
   export NL_USE_LEVELS_BELOW_GROUND=".true."
   export NL_LOWEST_LEV_FROM_SFC=".false."
   export NL_FORCE_SFC_IN_VINTERP=1
   export NL_ZAP_CLOSE_LEVELS=500
   export NL_INTERP_THETA=".false."
   export NL_HYPSOMETRIC_OPT=2
   export NL_P_TOP_REQUESTED=5000.
   export NL_ETA_LEVELS=1.0,0.999,0.996,0.992,0.985,0.975,0.963,0.949,\
0.932,0.913,0.891,0.864,0.843,0.824,0.808,0.793,0.783,0.773,0.758,\
0.739,0.711,0.666,0.599,0.530,0.465,0.406,0.354,0.322,0.297,0.278,0.262,\
0.249,0.238,0.228,0.216,0.2,0.178,0.152,0.121,0.09,0.059,0.028,0.0,
#
# PHYSICS NAMELIST:
   export NL_MP_PHYSICS=8
   export NL_RA_LW_PHYSICS=4
   export NL_RA_SW_PHYSICS=4
   export NL_RADT=12
   export NL_SF_SFCLAY_PHYSICS=1
   export NL_SF_SURFACE_PHYSICS=2
   export NL_BL_PBL_PHYSICS=1
   export NL_BLDT=0
   export NL_CU_PHYSICS=1
   export NL_CUDT=0
   export NL_CUGD_AVEDX=1
   export NL_CU_RAD_FEEDBACK=".true."
   export NL_CU_DIAG=0
   export NL_ISFFLX=1
   export NL_IFSNOW=1
   export NL_ICLOUD=1
   export NL_SURFACE_INPUT_SOURCE=1
   export NL_NUM_SOIL_LAYERS=2
   export NL_MP_ZERO_OUT=2
   export NL_NUM_LAND_CAT=28
   export NL_SF_URBAN_PHYSICS=0
   export NL_MAXIENS=1
   export NL_MAXENS=3
   export NL_MAXENS2=3
   export NL_MAXENS3=16
   export NL_ENSDIM=144
#
# DYNAMICS NAMELIST:
   export NL_ISO_TEMP=200.
   export NL_TRACER_OPT=0
   export NL_W_DAMPING=1
   export NL_DIFF_OPT=1
   export NL_DIFF_6TH_OPT=2
   export NL_DIFF_6TH_FACTOR=0.12
   export NL_KM_OPT=4
   export NL_DAMP_OPT=3
   export NL_ZDAMP=5000
   export NL_DAMPCOEF=0.2
   export NL_EPSSM=.2
   export NL_NON_HYDROSTATIC=".true."
   export NL_USE_BASEPARAM_FR_NML=".true."
   export NL_MOIST_ADV_OPT=2
   export NL_SCALAR_ADV_OPT=2
   export NL_CHEM_ADV_OPT=2
   export NL_TKE_ADV_OPT=2
   export NL_H_MOM_ADV_ORDER=5
   export NL_V_MOM_ADV_ORDER=3
   export NL_H_SCA_ADV_ORDER=5
   export NL_V_SCA_ADV_ORDER=3
   export NL_HYBRID_OPT=0
#
# BDY_CONTROL NAMELIST:
   export NL_SPEC_BDY_WIDTH=5
   export NL_SPEC_ZONE=1
   export NL_RELAX_ZONE=4
   export NL_SPECIFIED=".true."
   export NL_NESTED=".false."
#
# QUILT NAMELIST:
   export NL_NIO_TASKS_PER_GROUP=0
   export NL_NIO_GROUPS=0
#
# NAMELIST CHEM
   export NL_KEMIT=${NNZ_CHEM}
#
# APM NO_CHEM
#   export NL_CHEM_OPT=0
   export NL_CHEM_OPT=112
   export NL_BIOEMDT=60
   export NL_PHOTDT=60
   export NL_CHEMDT=0
   export NL_IO_STYLE_EMISSIONS=2
   export NL_EMISS_INPT_OPT=111
   export NL_EMISS_OPT=8
   export NL_EMISS_OPT_VOL=0
   export NL_CHEM_IN_OPT=0
   export NL_PHOT_OPT=3
   export NL_GAS_DRYDEP_OPT=1
   export NL_AER_DRYDEP_OPT=1
   export NL_BIO_EMISS_OPT=3
   export NL_NE_AREA=118
   export NL_GAS_BC_OPT=112
   export NL_GAS_IC_OPT=112
   export NL_GAS_BC_OPT=112
   export NL_AER_BC_OPT=112
   export NL_AER_IC_OPT=112
   export NL_GASCHEM_ONOFF=1
   export NL_AERCHEM_ONOFF=1
#
# APM NO_CHEM
#   export NL_WETSCAV_ONOFF=0
   export NL_WETSCAV_ONOFF=1
   export NL_CLDCHEM_ONOFF=0
   export NL_VERTMIX_ONOFF=1
   export NL_CHEM_CONV_TR=0
   export NL_CONV_TR_WETSCAV=1
   export NL_CONV_TR_AQCHEM=0
   export NL_SEAS_OPT=0
#
# APM NO_CHEM
#   export NL_DUST_OPT=0
   export NL_DUST_OPT=1
   export NL_DMSEMIS_OPT=1
   export NL_BIOMASS_BURN_OPT=2
   export NL_PLUMERISEFIRE_FRQ=60
   export NL_SCALE_FIRE_EMISS=".true."
   export NL_HAVE_BCS_CHEM=".true."
#
# APM NO_CHEM
#   export NL_AER_RA_FEEDBACK=0
   export NL_AER_RA_FEEDBACK=1
   export NL_CHEMDIAG=0
   export NL_AER_OP_OPT=1
   export NL_OPT_PARS_OUT=1
   export NL_HAVE_BCS_UPPER=".true."
   export NL_FIXED_UBC_PRESS=50.
   export NL_FIXED_UBC_INNAME=\'ubvals_b40.20th.track1_1996-2005.nc\'
#
# WRFDA NAMELIST PARAMETERS
# WRFVAR1 NAMELIST:
   export NL_PRINT_DETAIL_GRAD=false
   export NL_VAR4D=false
   export NL_MULTI_INC=0
#
# WRFVAR3 NAMELIST:
   export NL_OB_FORMAT=1
   export NL_NUM_FGAT_TIME=1
#
# WRFVAR4 NAMELIST:
   export NL_USE_SYNOPOBS=true
   export NL_USE_SHIPOBS=false
   export NL_USE_METAROBS=true
   export NL_USE_SOUNDOBS=true
   export NL_USE_MTGIRSOBS=false
   export NL_USE_PILOTOBS=true
   export NL_USE_AIREOBS=true
   export NL_USE_GEOAMVOBS=false
   export NL_USE_POLARAMVOBS=false
   export NL_USE_BOGUSOBS=false
   export NL_USE_BUOYOBS=false
   export NL_USE_PROFILEROBS=false
   export NL_USE_SATEMOBS=false
   export NL_USE_GPSPWOBS=false
   export NL_USE_GPSREFOBS=false
   export NL_USE_SSMIRETRIEVALOBS=false
   export NL_USE_QSCATOBS=false
   export NL_USE_AIRSRETOBS=false
#
# WRFVAR5 NAMELIST:
   export NL_CHECK_MAX_IV=true
   export NL_PUT_RAND_SEED=true
#
# WRFVAR6 NAMELIST:
   export NL_NTMAX=100
#
# WRFVAR7 NAMELIST:
   export NL_JE_FACTOR=1.0
   export NL_CV_OPTIONS=3
   export NL_AS1=0.25,2.0,1.0
   export NL_AS2=0.25,2.0,1.0
   export NL_AS3=0.25,2.0,1.0
   export NL_AS4=0.25,2.0,1.0
   export NL_AS5=0.25,2.0,1.0
#
# WRFVAR11 NAMELIST:
   export NL_CV_OPTIONS_HUM=1
   export NL_CHECK_RH=2
   export NL_SEED_ARRAY1=$(${BUILD_DIR}/da_advance_time.exe ${DATE} 0 -f hhddmmyycc)
   export NL_SEED_ARRAY2=`echo ${NUM_MEMBERS} \* 100000 | bc -l `
   export NL_CALCULATE_CG_COST_FN=true
   export NL_LAT_STATS_OPTION=false
#
# WRFVAR15 NAMELIST:
   export NL_NUM_PSEUDO=0
   export NL_PSEUDO_X=0
   export NL_PSEUDO_Y=0
   export NL_PSEUDO_Z=0
   export NL_PSEUDO_ERR=0.0
   export NL_PSEUDO_VAL=0.0
#
# WRFVAR16 NAMELIST:
   export NL_ALPHACV_METHOD=2
   export NL_ENSDIM_ALPHA=0
   export NL_ALPHA_CORR_TYPE=3
   export NL_ALPHA_CORR_SCALE=${HOR_SCALE}
   export NL_ALPHA_STD_DEV=1.0
   export NL_ALPHA_VERTLOC_OPT=0
#
# WRFVAR17 NAMELIST:
   export NL_ANALYSIS_TYPE=\'RANDOMCV\'
#
# WRFVAR18 NAMELIST:
   export ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} 0 -W 2>/dev/null)
#
# WRFVAR19 NAMELIST:
   export NL_PSEUDO_VAR=\'t\'
#
# WRFVAR21 NAMELIST:
   export NL_TIME_WINDOW_MIN=\'$(${BUILD_DIR}/da_advance_time.exe ${DATE} -${ASIM_WINDOW} -W 2>/dev/null)\'
#
# WRFVAR22 NAMELIST:
   export NL_TIME_WINDOW_MAX=\'$(${BUILD_DIR}/da_advance_time.exe ${DATE} +${ASIM_WINDOW} -W 2>/dev/null)\'
#
# WRFVAR23 NAMELIST:
   export NL_JCDFI_USE=false
   export NL_JCDFI_IO=false
