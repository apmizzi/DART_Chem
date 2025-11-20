#!/bin/ksh -aux
#
# LARGE SCALE FORECAST PARAMETERS:
   export FG_TYPE=NAM
   #export GRIB_PART1=gfs_4_
   #export GRIB_PART2=.g2.tar
    export GRIB_PART1=nam_218_
    
# WPS PARAMETERS:
   export SINGLE_FILE=false
   export HOR_SCALE=1500
   export VTABLE_TYPE=NAM
   export METGRID_TABLE_TYPE=ARW
#
# MOZBC PARAMETERS:
  export EXP_SPCS_MAP=TRACER1
  export MOZBC_SUFFIX=_VMR_inst 
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
   export NL_MIN_LAT=20
   export NL_MAX_LAT=70
   export NL_MIN_LON=-140
   export NL_MAX_LON=-50
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
   export NL_OBS_PRESSURE_TOP=1000.
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
   export NL_ACTIVE_GRID=".true.",".true."
#
# WPS GEOGRID NAMELIST:
   export NL_S_WE=1,1
   export NL_E_WE=${NNXP_STAG_CR},${NNXP_STAG_FR}
   export NL_S_SN=1,1
   export NL_E_SN=${NNYP_STAG_CR},${NNYP_STAG_FR}
   export NL_S_VERT=1,1
   export NL_E_VERT=${NNZP_STAG_CR},${NNZP_STAG_FR}
   export NL_PARENT_ID="0,1"
   export NL_PARENT_GRID_RATIO=1,3
   export NL_I_PARENT_START=${ISTR_CR},${ISTR_FR}
   export NL_J_PARENT_START=${JSTR_CR},${JSTR_FR}
   export NL_GEOG_DATA_RES=\'modis_30s_lake+modis_lai+modis_fpar+30s\',\'modis_30s_lake+modis_lai+modis_fpar+30s\'
   export NL_DX=${DX_CR}
   export NL_DY=${DX_CR}
   export NL_MAP_PROJ=\'lambert\'
   export NL_REF_LAT=39.67239
   export NL_REF_LON=-97.704979
   export NL_STAND_LON=-97.0
   export NL_TRUELAT1=33.0
   export NL_TRUELAT2=45.0
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
   export NL_START_YEAR=${START_YEAR},${START_YEAR}
   export NL_START_MONTH=${START_MONTH},${START_MONTH}
   export NL_START_DAY=${START_DAY},${START_DAY}
   export NL_START_HOUR=${START_HOUR},${START_HOUR}
   export NL_START_MINUTE=00,00
   export NL_START_SECOND=00,00
   export NL_END_YEAR=${END_YEAR},${END_YEAR}
   export NL_END_MONTH=${END_MONTH},${END_MONTH}
   export NL_END_DAY=${END_DAY},${END_DAY}
   export NL_END_HOUR=${END_HOUR},${END_HOUR}
   export NL_END_MINUTE=00,00
   export NL_END_SECOND=00,00
   export NL_INTERVAL_SECONDS=${INTERVAL_SECONDS}
   export NL_INPUT_FROM_FILE=".true.",".true."
   export NL_HISTORY_INTERVAL=${HISTORY_INTERVAL_MIN},60
   export NL_FRAMES_PER_OUTFILE=1,1
   export NL_RESTART=".false."
   export NL_RESTART_INTERVAL=1440
   export NL_IO_FORM_HISTORY=2
   export NL_IO_FORM_RESTART=2
   export NL_FINE_INPUT_STREAM=0,2
   export NL_IO_FORM_INPUT=2
   export NL_IO_FORM_BOUNDARY=2
   export NL_AUXINPUT1_INNAME=\'met_em.d\<domain\>.\<date\>\'
   export NL_AUXINPUT2_INNAME=\'wrfinput_d\<domain\>\'
   export NL_AUXINPUT4_INNAME=\'wrflowinp_d\<domain\>\'
   export NL_AUXINPUT5_INNAME=\'wrfchemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT6_INNAME=\'wrfbiochemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT7_INNAME=\'wrffirechemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT12_INNAME=\'wrfinput_d\<domain\>\'
   export NL_AUXINPUT2_INTERVAL_M=60480,60480
   export NL_AUXINPUT4_INTERVAL_M=360,360
   export NL_AUXINPUT5_INTERVAL_M=60,60
   export NL_AUXINPUT6_INTERVAL_M=60480,60480
   export NL_AUXINPUT7_INTERVAL_M=60,60
   export NL_AUXINPUT12_INTERVAL_M=60480,60480
   export NL_FRAMES_PER_AUXINPUT2=1,1
   export NL_FRAMES_PER_AUXINPUT4=1,1
   export NL_FRAMES_PER_AUXINPUT5=1,1
   export NL_FRAMES_PER_AUXINPUT6=1,1
   export NL_FRAMES_PER_AUXINPUT7=1,1
   export NL_FRAMES_PER_AUXINPUT12=1,1
   export NL_IO_FORM_AUXINPUT2=2
   export NL_IO_FORM_AUXINPUT4=2
   export NL_IO_FORM_AUXINPUT5=2
   export NL_IO_FORM_AUXINPUT6=2
   export NL_IO_FORM_AUXINPUT7=2
   export NL_IO_FORM_AUXINPUT12=2
   export NL_IOFIELDS_FILENAME=\'hist_io_flds_v1\',\'hist_io_flds_v2\'
   export NL_WRITE_INPUT=".true."
   export NL_INPUTOUT_INTERVAL=360
   export NL_INPUT_OUTNAME=\'wrfapm_d\<domain\>_\<date\>\'
   export NL_FORCE_USE_OLD_DATA=".true."
   export NL_CYCLING=".true."
#
# DOMAINS NAMELIST:
   export NL_TIME_STEP=72
   export NNL_TIME_STEP=${NL_TIME_STEP}
   export NL_TIME_STEP_FRACT_NUM=0
   export NL_TIME_STEP_FRACT_DEN=1
   export NL_MAX_DOM=${MAX_DOMAINS}
   export NL_S_WE=1,1
   export NL_E_WE=${NNXP_STAG_CR},${NNXP_STAG_FR}
   export NL_S_SN=1,1
   export NL_E_SN=${NNYP_STAG_CR},${NNYP_STAG_FR}
   export NL_S_VERT=1,1
   export NL_E_VERT=${NNZP_STAG_CR},${NNZP_STAG_FR}
   export NL_NUM_METGRID_LEVELS=40
   export NL_NUM_METGRID_SOIL_LEVELS=4
   export NL_DX=${DX_CR},${DX_FR}
   export NL_DY=${DX_CR},${DX_FR}
   export NL_GRID_ID=1,2
   export NL_PARENT_ID=0,1
   export NL_I_PARENT_START=${ISTR_CR},${ISTR_FR}
   export NL_J_PARENT_START=${JSTR_CR},${JSTR_FR}
   export NL_PARENT_GRID_RATIO=1,3
   export NL_PARENT_TIME_STEP_RATIO=1,2
   export NL_FEEDBACK=0
   export NL_SMOOTH_OPTION=0
   export NL_LAGRANGE_ORDER=2
   export NL_INTERP_TYPE=2
   export NL_EXTRAP_TYPE=2
   export NL_T_EXTRAP_TYPE=2
   export NL_USE_SURFACE=".true."
   export NL_USE_LEVELS_BELOW_GROUND=".true."
   export NL_LOWEST_LEV_FROM_SFC=".false."
   export NL_FORCE_SFC_IN_VINTERP=1
   export NL_ZAP_CLOSE_LEVELS=500
   export NL_INTERP_THETA=".false."
   export NL_HYPSOMETRIC_OPT=2
   export NL_P_TOP_REQUESTED=5000.
   export NL_SFCP_TO_SFCP=".false."
   export NL_ADJUST_HEIGHTS=".false."
   export NL_VERT_REFINE_METHOD=0
   export NL_VERT_REFINE_FACT=1
   export NL_SMOOTH_CG_TOPO=".true."
   export NL_NUM_TRAJ=0
   export NL_ETA_LEVELS=1.0000,0.9973,0.9944,0.9912,0.9877,\
0.9838,0.9794,0.9745,0.9690,0.9629,\
0.9559,0.9480,0.9392,0.9291,0.9178,\
0.9050,0.8907,0.8747,0.8569,0.8372,\
0.8155,0.7919,0.7662,0.7386,0.7093,\
0.6782,0.6458,0.6121,0.5776,0.5424,\
0.5069,0.4713,0.4361,0.4013,0.3673,\
0.3342,0.3022,0.2714,0.2420,0.2140,\
0.1874,0.1623,0.1386,0.1138,0.0931,\
0.0740,0.0565,0.0405,0.0258,0.0123,\
0.0000
#
# PHYSICS NAMELIST:
   export NL_MP_PHYSICS=10,10
   export NL_RA_LW_PHYSICS=4,4
   export NL_RA_SW_PHYSICS=4,4
   export NL_RADT=12,3
   export NL_SF_SFCLAY_PHYSICS=5,5
   export NL_SF_SURFACE_PHYSICS=2,2
   export NL_BL_PBL_PHYSICS=5,5
   export NL_BLDT=0,0
   export NL_CU_PHYSICS=3,0
   export NL_CUDT=0,0
   export NL_CUGD_AVEDX=1
   export NL_CU_RAD_FEEDBACK=".true.",".true."
   export NL_CU_DIAG=1,
   export NL_ISFFLX=1
   export NL_IFSNOW=1
   export NL_ICLOUD=1
   export NL_SURFACE_INPUT_SOURCE=1
   export NL_NUM_SOIL_LAYERS=4
   export NL_MP_ZERO_OUT=0
   export NL_NUM_LAND_CAT=21
   export NL_SF_URBAN_PHYSICS=0,0
   export NL_MAXIENS=1
   export NL_MAXENS=3
   export NL_MAXENS2=3
   export NL_MAXENS3=16
   export NL_ENSDIM=144
#
   export NL_SWINT_OPT=1
   export NL_AER_OPT=1
   export NL_SLOPE_RAD=0
   export NL_TOPO_SHADING=1
   export NL_SHADLEN=25000.
   export NL_SF_LAKE_PHYSICS=0
   export NL_SST_UPDATE=1
   export NL_USEMONALB=".true."
   export NL_RDLAI2D=".true."
   export NL_BL_MYNN_TKEADVECT=".false."
   export NL_BL_MYNN_TKEBUDGET=0
   export NL_BL_MYNN_CLOUDPDF=2
   export NL_BL_MYNN_EDMF=1
   export NL_BL_MYNN_EDMF_MOM=1
   export NL_BL_MYNN_EDMF_TKE=0
   export NL_BL_MYNN_MIXLENGTH=2
   export NL_BL_MYNN_MIXQT=0
   export NL_GRAV_SETTLING=2
   export NL_IZ0TLND=1
   export NL_BLDT=0
   export NL_ISHALLOW=0
   export NL_PREC_ACC_DT=60.
   export NL_SHCU_PHYSICS=0.
   export NL_ICLOUD_BL=1
   export NL_TRAJ_OPT=0
   export NL_DM_HAS_TRAJ=".true."
#
# DYNAMICS NAMELIST:
   export NL_HYBRID_OPT=2
   export NL_ISO_TEMP=200.
   export NL_TRACER_OPT=0,0
   export NL_W_DAMPING=1
   export NL_DIFF_OPT=2
   export NL_DIFF_6TH_OPT=2,2
   export NL_DIFF_6TH_FACTOR=0.12,0.12
   export NL_KM_OPT=4
   export NL_DAMP_OPT=3
   export NL_W_CRIT_CFL=1.0,1.0
   export NL_ZDAMP=5000.,5000.,
   export NL_DAMPCOEF=0.2,0.2
   export NL_NON_HYDROSTATIC=".true.",".true."
   export NL_USE_BASEPARAM_FR_NML=".true."
   export NL_MOIST_ADV_OPT=2,2
   export NL_SCALAR_ADV_OPT=2,2
   export NL_CHEM_ADV_OPT=2,2
   export NL_TKE_ADV_OPT=2,2
   export NL_H_MOM_ADV_ORDER=5,5
   export NL_V_MOM_ADV_ORDER=3,3
   export NL_H_SCA_ADV_ORDER=5,5
   export NL_V_SCA_ADV_ORDER=3,3
#
   export NL_KM_OPT_DFI=1
   export NL_C_S=0.25
   export NL_MIX_FULL_FIELDS=".false."
   export NL_GWD_OPT=0
   export NL_BASE_TEMP=290.
   export NL_ISO_TEMP=200.
   export NL_KHDIF=0
   export NL_KVDIF=0
   export NL_SMDIV=0.1
   export NL_EMDIV=0.01
   export NL_EPSSM=0.1
   export NL_TIME_STEP_SOUND=4
   export NL_USE_INPUT_W=".false."
   export NL_MOMENTUM_ADV_OPT=1
   export NL_DO_AVGFLX_EM=1
   export NL_DO_AVGFLX_CUGD=1
#
# BDY_CONTROL NAMELIST:
   export NL_SPEC_BDY_WIDTH=5
   export NL_SPEC_ZONE=1
   export NL_RELAX_ZONE=4
   export NL_SPECIFIED=".true.",".false."
   export NL_NESTED=".false.",".true."
#
   export NL_SPEC_EXP=0.
   export NL_CONSTANT_BC=".false."
#
# QUILT NAMELIST:
   export NL_NIO_TASKS_PER_GROUP=0
   export NL_NIO_GROUPS=1
#
# NAMELIST CHEM
   export NL_KEMIT=${NNZ_CHEM}
#
# APM NO_CHEM
#   export NL_CHEM_OPT=0,0
   export NL_CHEM_OPT=108,108
   export NL_BIOEMDT=30,30
   export NL_PHOTDT=30,30
   export NL_CHEMDT=0,0
   export NL_IO_STYLE_EMISSIONS=2
   export NL_EMISS_INPT_OPT=1,1
   export NL_EMISS_OPT=3,3
   export NL_EMISS_OPT_VOL=0,0
   export NL_CHEM_IN_OPT=1,1
   export NL_PHOT_OPT=4,4
   export NL_GAS_DRYDEP_OPT=1,1
   export NL_AER_DRYDEP_OPT=1,1
   export NL_BIO_EMISS_OPT=3,3
   export NL_NE_AREA=117
   export NL_GAS_BC_OPT=1,112
   export NL_GAS_IC_OPT=1,112
   export NL_AER_BC_OPT=1,112
   export NL_AER_IC_OPT=1,112
   export NL_GASCHEM_ONOFF=1,1
   export NL_AERCHEM_ONOFF=1,1
#
# APM NO_CHEM
#   export NL_WETSCAV_ONOFF=0,0
   export NL_WETSCAV_ONOFF=0,0
   export NL_CLDCHEM_ONOFF=0,0
   export NL_VERTMIX_ONOFF=1,1
   export NL_CHEM_CONV_TR=1,0
   export NL_CONV_TR_WETSCAV=1,1
   export NL_CONV_TR_AQCHEM=1,0
   export NL_SEAS_OPT=1
#
# APM NO_CHEM
   export NL_DUST_OPT=5
   export NL_DMSEMIS_OPT=0
   export NL_BIOMASS_BURN_OPT=1,1
   export NL_PLUMERISEFIRE_FRQ=15,15
   export NL_SCALE_FIRE_EMISS=".true.",".true."
   export NL_HAVE_BCS_CHEM=".true.",".true."
#
# APM NO_CHEM
   export NL_AER_RA_FEEDBACK=0,0
#   export NL_AER_RA_FEEDBACK=1,1
   export NL_CHEMDIAG=0,1
   export NL_OPT_PARS_OUT=1
   export NL_HAVE_BCS_UPPER=".false.",".false."
   export NL_FIXED_UBC_PRESS=50.,50.
   export NL_FIXED_UBC_INNAME=\'ubvals_b40.20th.track1_1996-2005.nc\'
#
   export NL_DO_PVOZONE=".false."
   export NL_PHOT_BLCLD=".true."
   export NL_LNOX_OPT=1
   export NL_N_IC=125.
   export NL_N_CG=125.
   export NL_LIGHTNING_OPTION=11
   export NL_ICCG_PRESCRIBED_NUM=2.
   export NL_ICCG_PRESCRIBED_DEN=1.
   export NL_LIGHTNING_DT=${NL_TIME_STEP}
   export NL_CELLCOUNT_METHOD=0
   export NL_LIGHTNING_START_SECONDS=600.
   export NL_CLDTOP_ADJUSTMENT=0.
   export NL_ICCG_METHOD=2
   export NL_FLASHRATE_FACTOR=1.
   export NL_AIRCRAFT_EMISS_OPT=0   
   export NL_AER_OP_OPT=1   
   export NL_OPT_PARS_OUT=1   
   export NL_DIAGNOSTIC_CHEM=2   
   export NL_HAVE_ICS_CH4=".true."   
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
   export NL_ALPHA_VERTLOC=false
   export NL_ALPHA_TRUNCATION=1

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
