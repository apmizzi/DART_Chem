#!/bin/ksh -x
###############################################################################
#
#  Script to run dart perfect model for wrf_chem 
#  (Calls: create_obs_sequence.o, create_fixed_network_seq.o, preprocess.o, 
#   and perfect_model_obs.o)
#
############################################################################### 
#
# Define experiment parameters
# Start date is 2008061012 to account for full assimilation window
export START_DATE=2008061012
export END_DATE=2008061312
export INITIAL_DATE=2008061012
export INITIAL_FILE_DATE=2008-06-10_12:00:00
export FIRST_FILTER_DATE=${INITIAL_DATE}
export COLD_START_LIMIT=2
export DOMAIN=01
export NUM_MEMBERS=20
export CYCLE_PERIOD=6
export DBL_CYCLE_PERIOD=12
export FCST_PERIOD=6
export ASIM_PERIOD=3
export HIST_PERIOD=6
export RESTART_PERIOD=6
export INPUTOUT_PERIOD=6
export LBC_FREQ=3
(( INTERVAL_SEC=${LBC_FREQ}*60*60 ))
(( HISTORY_INTERVAL_MIN=${HIST_PERIOD}*60 ))
(( RESTART_INTERVAL_MIN=${RESTART_PERIOD}*60 ))
(( INPUTOUT_INTERVAL_MIN=${INPUTOUT_PERIOD}*60 ))
(( CYCLE_PERIOD_SEC=${CYCLE_PERIOD}*60*60 ))
#
# Define run options
export RUN_PERFECT_MODEL=true
export RUN_INITIAL_WRFCHEM=true
export RUN_FILTER=true
export RUN_WRFCHEM=true
export RUN_ARCHIVE=true
#
# Define warm start run options
export RUN_WARM=false
export WARM_PERFECT_MODEL=false
export WARM_INITIAL_WRFCHEM=false
export WARM_FILTER=false
export WARM_WRFCHEM=false
export WARM_ARCHIVE=false
#
#if [[ ${RUN_WARM} == true && ! ${RUN_FILTER} == true ]]; then 
#   echo ERROR: RUN_WARM and RUN_FILTER options inconsistent
#   exit
#elif [[ ${RUN_WARM} == true && ! ${RUN_WRFCHEM} == true ]]; then 
#   echo ERROR: RUN_WARM and RUN_WRFCHEM options inconsistent
#   exit
#elif [[ ${WARM_ARCHIVE} == true && ! ${RUN_ARCHIVE} == true ]]; then 
#   echo ERROR: WARM_ARCHIVE and RUN_ARCHIVE options inconsistent
#   exit
#fi
if [[ ! ${RUN_WARM} == true ]]; then
   export RUN_WARM=true
   export WARM_PERFECT_MODEL=${RUN_PERFECT_MODEL}
   export WARM_INITIAL_WRFCHEM=${RUN_INITIAL_WRFCHEM}
   export WARM_FILTER=${RUN_FILTER}
   export WARM_WRFCHEM=${RUN_WRFCHEM}
   export WARM_ARCHIVE=${RUN_ARCHIVE}
fi
#
# Define use options
export USE_HSI=false
export USE_DART_INFL=true
#
# Define special directory names
export EMISSIONS_DIR=chem_static_100km_p30
export WPB_RC_DIR=wpb_rc_chem_100km_p10
export OBS_SEQ_DIR=obs
export OBS_SEQ_DIR=obs_MOPCOMB_Mig_DA_filt
export OBS_SEQ_FLNAME=obs_seq_comb_
export OBS_SEQ_FLNAME=obs_seq_comb_filtered_
export OBS_SEQ_OUT_NAME=obs_seq_perf_
#
# Define code versions
export DART_VER=DART_CHEM
export WRFCHEM_VER=WRFCHEMv3.4_dmpar
export WRF_VER=WRFv3.4_dmpar
export WRFDA_VER=WRFDAv3.4_dmpar
#
# Set job submission parameters
export PROJ_NUMBER=P19010000
export PROJ_NUMBER=NNES0003
export PROJ_NUMBER=NACD0002
export TIME_LIMIT_FILTER=1:40
export TIME_LIMIT_PERFM=1:40
export TIME_LIMIT_WRF=1:40
export NUM_TASKS=32
export TASKS_PER_NODE=16
export JOB_CLASS_FILTER=regular
export JOB_CLASS_PERFM=regular
export JOB_CLASS_WRF=regular
#
# Define independent directory paths
export TRUNK_DIR=/glade/p/work/mizzi/TRUNK
export DATA_DIR=/glade/p/acd/mizzi/AVE_TEST_DATA
export HSI_DATA_DIR=/MIZZI/AVE_TEST_DATA
export RC_DIR=rc_chem_100km_p10
export RUN_DIR=/glade/scratch/mizzi/PERFECT_MODEL
export HSI_RUN_DIR=/MIZZI/PERFECT_MODEL
#
mkdir -p ${RUN_DIR}
hsi "mkdir -p ${HSI_RUN_DIR}"
cd ${RUN_DIR}
#
# Dependent path settings
export DART_DIR=${TRUNK_DIR}/${DART_VER}
export WRF_DIR=${TRUNK_DIR}/${WRF_VER}
export WRFCHEM_DIR=${TRUNK_DIR}/${WRFCHEM_VER}
export WRFDA_DIR=${TRUNK_DIR}/${WRFDA_VER}/var
export DART_WRF_CHEM=${DART_DIR}/models/wrf_chem/work
#
# Cycle through the obs_seq file central date/times
cp ${DART_WRF_CHEM}/advance_time ./.
cp ${DART_WRF_CHEM}/input.nml ./.
export L_DATE=${START_DATE}
rm advance_time
rm input.nml
rm dart_log.out
while [[ ${L_DATE} -lt ${END_DATE} ]]; do
   if [[ ! -d ${RUN_DIR}/${L_DATE} ]]; then
      mkdir ${RUN_DIR}/${L_DATE}
      cd ${RUN_DIR}/${L_DATE}
   else
      cd ${RUN_DIR}/${L_DATE}
   fi
#
# Set time information
   cp ${DART_WRF_CHEM}/advance_time ./.
   cp ${DART_WRF_CHEM}/input.nml ./.
   export L_YY=`echo $L_DATE | cut -c1-4`
   export L_MM=`echo $L_DATE | cut -c5-6`
   export L_DD=`echo $L_DATE | cut -c7-8`
   export L_HH=`echo $L_DATE | cut -c9-10`
   export L_MN=00
   export L_SS=00
   export L_FILE_DATE=${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
#
   export PAST_DATE=`echo $L_DATE -${CYCLE_PERIOD}h | ./advance_time`
   export PAST_YY=`echo $PAST_DATE | cut -c1-4`
   export PAST_MM=`echo $PAST_DATE | cut -c5-6`
   export PAST_DD=`echo $PAST_DATE | cut -c7-8`
   export PAST_HH=`echo $PAST_DATE | cut -c9-10`
   export PAST_MN=00
   export PAST_SS=00
   export PAST_FILE_DATE=${PAST_YY}-${PAST_MM}-${PAST_DD}_${PAST_HH}:00:00
#
   export NEXT_DATE=`echo ${L_DATE} +${CYCLE_PERIOD}h | ./advance_time` 
   export NEXT_YY=`echo $NEXT_DATE | cut -c1-4`
   export NEXT_MM=`echo $NEXT_DATE | cut -c5-6`
   export NEXT_DD=`echo $NEXT_DATE | cut -c7-8`
   export NEXT_HH=`echo $NEXT_DATE | cut -c9-10`
   export NEXT_MN=00
   export NEXT_SS=00
   export NEXT_FILE_DATE=${NEXT_YY}-${NEXT_MM}-${NEXT_DD}_${NEXT_HH}:00:00
#
   export ASIM_MIN_DATE=`echo ${L_DATE} -${ASIM_PERIOD}h | ./advance_time` 
   export ASIM_MIN_YY=`echo $ASIM_MIN_DATE | cut -c1-4`
   export ASIM_MIN_MM=`echo $ASIM_MIN_DATE | cut -c5-6`
   export ASIM_MIN_DD=`echo $ASIM_MIN_DATE | cut -c7-8`
   export ASIM_MIN_HH=`echo $ASIM_MIN_DATE | cut -c9-10`
#
   export ASIM_MAX_DATE=`echo ${L_DATE} +${ASIM_PERIOD}h | ./advance_time` 
   export ASIM_MAX_YY=`echo $ASIM_MAX_DATE | cut -c1-4`
   export ASIM_MAX_MM=`echo $ASIM_MAX_DATE | cut -c5-6`
   export ASIM_MAX_DD=`echo $ASIM_MAX_DATE | cut -c7-8`
   export ASIM_MAX_HH=`echo $ASIM_MAX_DATE | cut -c9-10`
#
   set -A GREG_DATE `echo $L_DATE 0 -g | ./advance_time`
   export DAY_GREG=${GREG_DATE[0]}
   export SEC_GREG=${GREG_DATE[1]}
#
   set -A GREG_DATE `echo $PAST_DATE 0 -g | ./advance_time`
   export PAST_DAY_GREG=${GREG_DATE[0]}
   export PAST_SEC_GREG=${GREG_DATE[1]}
#
   set -A GREG_DATE `echo $NEXT_DATE 0 -g | ./advance_time`
   export NEXT_DAY_GREG=${GREG_DATE[0]}
   export NEXT_SEC_GREG=${GREG_DATE[1]}
#
   set -A GREG_DATE `echo $ASIM_MIN_DATE 0 -g | ./advance_time`
   export ASIM_MIN_DAY_GREG=${GREG_DATE[0]}
   export ASIM_MIN_SEC_GREG=${GREG_DATE[1]}
#
   set -A GREG_DATE `echo $ASIM_MAX_DATE 0 -g | ./advance_time`
   export ASIM_MAX_DAY_GREG=${GREG_DATE[0]}
   export ASIM_MAX_SEC_GREG=${GREG_DATE[1]}
#
# Setup namelist information
# DART input.nml parameters
# assim_tools_nml
   export NL_CUTOFF=0.1
   export NL_SPECIAL_LOCALIZATION_OBS_TYPES="'IASI_O3_RETRIEVAL','MOPITT_CO_RETRIEVAL'"
   export NL_SAMPLING_ERROR_CORRECTION=.true.
   export NL_SPECIAL_LOCALIZATION_CUTOFFS=0.1,0.1
   export NL_ADAPTIVE_LOCALIZATION_THRESHOLD=2000
#    
# ensemble_manager_nml
   export NL_SINGLE_RESTART_FILE_IN=.false.       
   export NL_SINGLE_RESTART_FILE_OUT=.false.       
#    
# assim_model_nml
   export NL_WRITE_BINARY_RESTART_FILE=.true.
   export NL_ALLOW_OBS_BELOW_VOL=.true.
#    
# model_nml
   export NL_DEFAULT_STATE_VARIABLES=.false.
   export NL_WRF_STATE_VARIABLES="'U',     'KIND_U_WIND_COMPONENT',     'TYPE_U',  'UPDATE','999',
                               'V',     'KIND_V_WIND_COMPONENT',     'TYPE_V',  'UPDATE','999',
                               'W',     'KIND_VERTICAL_VELOCITY',    'TYPE_W',  'UPDATE','999',
                               'PH',    'KIND_GEOPOTENTIAL_HEIGHT',  'TYPE_GZ', 'UPDATE','999',
                               'T',     'KIND_POTENTIAL_TEMPERATURE','TYPE_T',  'UPDATE','999',
                               'MU',    'KIND_PRESSURE',             'TYPE_MU', 'UPDATE','999',
                               'QVAPOR','KIND_VAPOR_MIXING_RATIO',   'TYPE_QV', 'UPDATE','999',
                               'QRAIN', 'KIND_RAINWATER_MIXING_RATIO','TYPE_QRAIN', 'UPDATE','999',
                               'QCLOUD','KIND_CLOUD_LIQUID_WATER',   'TYPE_QCLOUD', 'UPDATE','999',
                               'QSNOW', 'KIND_SNOW_MIXING_RATIO',    'TYPE_QSNOW', 'UPDATE','999',
                               'QICE',  'KIND_CLOUD_ICE',            'TYPE_QICE', 'UPDATE','999',
                               'U10',   'KIND_U_WIND_COMPONENT',     'TYPE_U10','UPDATE','999',
                               'V10',   'KIND_V_WIND_COMPONENT',     'TYPE_V10','UPDATE','999',
                               'T2',    'KIND_TEMPERATURE',          'TYPE_T2', 'UPDATE','999',
                               'TH2',   'KIND_POTENTIAL_TEMPERATURE','TYPE_TH2','UPDATE','999',
                               'Q2',    'KIND_SPECIFIC_HUMIDITY',    'TYPE_Q2', 'UPDATE','999',
                               'PSFC',  'KIND_PRESSURE',             'TYPE_PS', 'UPDATE','999',
                               'o3',    'KIND_O3',                   'TYPE_O3', 'UPDATE','999',
                               'co',    'KIND_CO',                   'TYPE_CO', 'UPDATE','999',
                               'no',    'KIND_NO',                   'TYPE_NO', 'UPDATE','999',
                               'no2',   'KIND_NO2',                  'TYPE_NO2', 'UPDATE','999',
                               'hno3',  'KIND_HNO3',                 'TYPE_HNO3', 'UPDATE','999',
                               'hno4',  'KIND_HNO4',                 'TYPE_HNO4', 'UPDATE','999',
                               'n2o5',  'KIND_N2O5',                 'TYPE_N2O5', 'UPDATE','999',
                               'pan',   'KIND_PAN',                  'TYPE_PAN', 'UPDATE','999',
                               'mek',   'KIND_MEK',                  'TYPE_MEK', 'UPDATE','999',
                               'ald',   'KIND_ALD',                  'TYPE_ALD', 'UPDATE','999',
                               'ch3o2', 'KIND_CH3O2',                'TYPE_CH3O2', 'UPDATE','999',
                               'c3h8',  'KIND_C3H8',                 'TYPE_C3H8', 'UPDATE','999',
                               'c2h6',  'KIND_C2H6',                 'TYPE_C2H6', 'UPDATE','999',
                               'acet',  'KIND_ACET',                 'TYPE_ACET', 'UPDATE','999',
                               'hcho',  'KIND_HCHO',                 'TYPE_HCHO', 'UPDATE','999',
                               'c2h4',  'KIND_C2H4',                 'TYPE_C2H4', 'UPDATE','999',
                               'c3h6',  'KIND_C3H6',                 'TYPE_C3H6', 'UPDATE','999',
                               'tol',   'KIND_TOL',                  'TYPE_TOL', 'UPDATE','999',
                               'mvk',   'KIND_MVK',                  'TYPE_MVK', 'UPDATE','999',
                               'bigalk','KIND_BIGALK',               'TYPE_BIGALK', 'UPDATE','999',
                               'isopr', 'KIND_ISOPR',                'TYPE_ISOPR', 'UPDATE','999',
                               'macr',  'KIND_MACR',                 'TYPE_MACR', 'UPDATE','999',
                               'glyald','KIND_GLYALD',               'TYPE_GLYALD', 'UPDATE','999',
                               'c10h16','KIND_C10H16',               'TYPE_C10H16', 'UPDATE','999'"
   export NL_WRF_STATE_BOUNDS="'QVAPOR','0.0','NULL','CLAMP',
                            'QRAIN', '0.0','NULL','CLAMP',
                            'QCLOUD','0.0','NULL','CLAMP',
                            'QSNOW', '0.0','NULL','CLAMP',
                            'QICE',  '0.0','NULL','CLAMP',
                            'o3',    '0.0','NULL','CLAMP',
                            'co',    '1.e-4','NULL','CLAMP',
                            'no',    '0.0','NULL','CLAMP',
                            'no2',   '0.0','NULL','CLAMP',
                            'hno3',  '0.0','NULL','CLAMP',
                            'hno4',  '0.0','NULL','CLAMP',
                            'n2o5',  '0.0','NULL','CLAMP',
                            'pan',   '0.0','NULL','CLAMP',
                            'mek',   '0.0','NULL','CLAMP',
                            'ald',   '0.0','NULL','CLAMP',
                            'ch3o2', '0.0','NULL','CLAMP',
                            'c3h8',  '0.0','NULL','CLAMP',
                            'c2h6',  '0.0','NULL','CLAMP',
                            'acet'   '0.0','NULL','CLAMP',
                            'hcho'   '0.0','NULL','CLAMP',
                            'c2h4',  '0.0','NULL','CLAMP',
                            'c3h6',  '0.0','NULL','CLAMP',
                            'tol',   '0.0','NULL','CLAMP',
                            'mvk',   '0.0','NULL','CLAMP',
                            'bigalk','0.0','NULL','CLAMP',
                            'isopr', '0.0','NULL','CLAMP',
                            'macr',  '0.0','NULL','CLAMP',
                            'glyald','0.0','NULL','CLAMP',
                            'c10h16','0.0','NULL','CLAMP'"
   export NL_OUTPUT_STATE_VECTOR=.false.
   export NL_NUM_DOMAINS=${DOMAIN}
   export NL_CALENDAR_TYPE=3
   export NL_ASSIMILATION_PERIOD_SECONDS=${CYCLE_PERIOD_SEC}
   export NL_VERT_LOCALIZATION_COORD=3
   export NL_CENTER_SEARCH_HALF_LENGTH=500000.
   export NL_CENTER_SPLINE_GRID_SCALE=10
   export NL_SFC_ELEV_MAX_DIFF=100.0
   export NL_CIRCULATION_PRES_LEVEL=80000.0
   export NL_CIRCULATION_RADIUS=108000.0
#
# &obs_diag_nml
   export DT_YYYY=${YY}
   export DT_MM=${MM} 
   export DT_DD=${DD} 
   export DT_HH=${HH} 
   (( DT_MM = ${DT_MM} + 0 ))
   (( DT_DD = ${DT_DD} + 0 ))
   (( DT_HH = ${DT_HH} + 0 ))     
   export NL_FIRST_BIN_CENTER_YY=${DT_YYYY}
   export NL_FIRST_BIN_CENTER_MM=${DT_MM}
   export NL_FIRST_BIN_CENTER_DD=${DT_DD}
   export NL_FIRST_BIN_CENTER_HH=${DT_HH}
   export NL_LAST_BIN_CENTER_YY=${DT_YYYY}
   export NL_LAST_BIN_CENTER_MM=${DT_MM}
   export NL_LAST_BIN_CENTER_DD=${DT_DD}
   export NL_LAST_BIN_CENTER_HH=${DT_HH}
   export NL_BIN_SEPERATION_YY=0
   export NL_BIN_SEPERATION_MM=0
   export NL_BIN_SEPERATION_DD=0
   export NL_BIN_SEPERATION_HH=0
   export NL_BIN_WIDTH_YY=0
   export NL_BIN_WIDTH_MM=0
   export NL_BIN_WIDTH_DD=0
   export NL_BIN_WIDTH_HH=0
#
# &restart_file_utility_nml
   export NL_SINGLE_RESTART_FILE_IN=.false.       
   export NL_SINGLE_RESTART_FILE_OUT=.false.       
#
# &dart_to_wrf_nml
   export NL_MODEL_ADVANCE_FILE=.false.
   export NL_ADV_MOD_COMMAND="'mpirun -np 64 ./wrf.exe'"
   export NL_DART_RESTART_NAME="'dart_wrf_vector'"
#
# &preprocess_nml
   export NL_INPUT_OBS_KIND_MOD_FILE="'"${DART_DIR}/obs_kind/DEFAULT_obs_kind_mod.F90"'"
   export NL_OUTPUT_OBS_KIND_MOD_FILE="'"${DART_DIR}/obs_kind/obs_kind_mod.f90"'"
   export NL_INPUT_OBS_DEF_MOD_FILE="'"${DART_DIR}/obs_kind/DEFAULT_obs_def_mod.F90"'"
   export NL_OUTPUT_OBS_DEF_MOD_FILE="'"${DART_DIR}/obs_kind/obs_def_mod.f90"'"
   export NL_INPUT_FILES="'${DART_DIR}/obs_def/obs_def_reanalysis_bufr_mod.f90',
                       '${DART_DIR}/obs_def/obs_def_radar_mod.f90',
                       '${DART_DIR}/obs_def/obs_def_metar_mod.f90',
                       '${DART_DIR}/obs_def/obs_def_dew_point_mod.f90',
                       '${DART_DIR}/obs_def/obs_def_altimeter_mod.f90',
                       '${DART_DIR}/obs_def/obs_def_gps_mod.f90',
                       '${DART_DIR}/obs_def/obs_def_gts_mod.f90',
                       '${DART_DIR}/obs_def/obs_def_vortex_mod.f90',
                       '${DART_DIR}/obs_def/obs_def_IASI_O3_mod.f90',
                       '${DART_DIR}/obs_def/obs_def_MOPITT_CO_mod.f90',
                       '${DART_DIR}/obs_def/obs_def_MODIS_AOD_mod.f90'"
#
# &obs_kind_nml
   export NL_EVALUATE_THESE_OBS_TYPES="'RADIOSONDE_TEMPERATURE',
                                      'RADIOSONDE_U_WIND_COMPONENT',
                                      'RADIOSONDE_V_WIND_COMPONENT',
                                      'ACARS_U_WIND_COMPONENT',
                                      'ACARS_V_WIND_COMPONENT',
                                      'ACARS_TEMPERATURE',
                                      'AIRCRAFT_U_WIND_COMPONENT',
                                      'AIRCRAFT_V_WIND_COMPONENT',
                                      'AIRCRAFT_TEMPERATURE',
                                      'SAT_U_WIND_COMPONENT',
                                      'SAT_V_WIND_COMPONENT'"
   export NL_ASSIMILATE_THESE_OBS_TYPES="'MOPITT_CO_RETRIEVAL'"
#
# &replace_wrf_fields_nml
   export NL_FIELDNAMES="'SNOWC',
                      'ALBBCK',
                      'TMN',
                      'TSK',
                      'SH2O',
                      'SMOIS',
                      'SEAICE',
                      'HGT_d01',
                      'TSLB',
                      'SST',
                      'SNOWH',
                      'SNOW'"
   export NL_FIELDLIST_FILE="' '"
#
# &location_nml
   export NL_HORIZ_DIST_ONLY=.true.
   export NL_VERTICAL_NORMALIZATION_HEIGHT=8000.0
#
# WRFCHEM namelist.input parameters
# TIME CONTROL
   export NL_RUN_DAYS=0
   export NL_RUN_HOURS=${CYCLE_PERIOD}
   export NL_RUN_MINUTES=0
   export NL_RUN_SECONDS=0
   export NL_START_YEAR=${START_YY}
   export NL_START_MONTH=${START_MM}
   export NL_START_DAY=${START_DD}
   export NL_START_HOUR=${START_HH}
   export NL_START_MINUTE=0
   export NL_START_SECOND=0
   export NL_END_YEAR=${NEXT_YY}
   export NL_END_MONTH=${NEXT_MM}
   export NL_END_DAY=${NEXT_DD}
   export NL_END_HOUR=${NEXT_HH}
   export NL_END_MINUTE=0
   export NL_END_SECOND=0
   export NL_INTERVAL_SECONDS=${INTERVAL_SEC}
   export NL_INPUT_FROM_FILE=.true.
   export NL_HISTORY_INTERVAL=${HISTORY_INTERVAL_MIN}
   export NL_FRAMES_PER_OUTFILE=1
   export NL_RESTART=.false.
   export NL_RESTART_INTERVAL=${RESTART_INTERVAL_MIN}
   export NL_CYCLING=.true.
   export NL_IO_FORM_HISTORY=2
   export NL_IO_FORM_RESTART=2
   export NL_IO_FORM_INPUT=2
   export NL_IO_FORM_BOUNDARY=2
   export NL_IO_AUXINPUT5_INNAME="'"wrfchemi_d\<domain\>_\<date\>"'"
   export NL_IO_AUXINPUT6_INNAME="'"wrfbiochemi_d\<domain\>_\<date\>"'"
   export NL_IO_AUXINPUT7_INNAME="'"wrffirechemi_d\<domain\>_\<date\>"'"
   export NL_AUXINPUT5_INTERVAL_M=60
   export NL_AUXINPUT6_INTERVAL_M=60480
   export NL_AUXINPUT7_INTERVAL_M=60
   export NL_FRAMES_PER_AUXINPUT5=1
   export NL_FRAMES_PER_AUXINPUT6=1
   export NL_FRAMES_PER_AUXINPUT7=1
   export NL_IO_FORM_AUXINPUT5=2
   export NL_IO_FORM_AUXINPUT6=2
   export NL_IO_FORM_AUXINPUT7=2
   export NL_IOFIELDS_FILENAME="'"hist_io_flds"'"
   export NL_WRITE_INPUT=.true.
   export NL_INPUTOUT_INTERVAL=${INPUTOUT_INTERVAL_MIN}
   export NL_INPUT_OUTNAME="'"wrfapm_d\<domain\>_\<date\>"'"
   export NL_DEBUG_LEVEL=0
#
# DOMAINS
   export NL_TIME_STEP=180
   export NL_TIME_STEP_FRACT_NUM=0
   export NL_TIME_STEP_FRACT_DEN=1
   export NL_MAX_DOM=1
   export NL_S_WE=1
   export NL_E_WE=101
   export NL_S_SN=1
   export NL_E_SN=41
   export NL_E_VERT=34
   export NL_P_TOP_REQUESTED=1000
   export NL_INTERP_TYPE=1
   export NL_T_EXTRAP_TYPE=1
   export NL_NUM_METGRID_LEVELS=27
   export NL_NUM_METGRID_SOIL_LEVELS=4
   export NL_DX=100000.0
   export NL_DY=100000.0
   export NL_GRID_ID=1
   export NL_PARENT_ID=0
   export NL_I_PARENT_START=0
   export NL_J_PARENT_START=0
   export NL_PARENT_GRID_RATIO=1
   export NL_PARENT_TIME_STEP_RATIO=1
   export NL_FEEDBACK=0
   export NL_SMOOTH_OPTION=1
   export NL_ETA_LEVELS=1.000,0.993,0.983,0.970,0.954,0.934,0.909,0.880,\
0.8341923,0.7883847,0.7425771,0.6967695,0.6174707,0.5455519,0.4804399,0.4215993,0.36853,0.3207655,\
0.2778706,0.2394401,0.2050965,0.1744887,0.1472903,0.1231982,0.1019311,0.08322784,0.06684654,0.05256274,\
0.04016809,0.0294686,0.02028209,0.01243387,0.005746085,0.000
#
# PHYSICS
   export NL_MP_PHYSICS=2
   export NL_RA_LW_PHYSICS=1
   export NL_RA_SW_PHYSICS=2
   export NL_RADT=40
   export NL_SF_SFCLAY_PHYSICS=2
   export NL_SF_SURFACE_PHYSICS=2
   export NL_BL_PBL_PHYSICS=2
   export NL_BLDT=0
   export NL_CU_PHYSICS=5
   export NL_CUDT=0
   export NL_ISFFLX=1
   export NL_IFSNOW=0
   export NL_ICLOUD=0
   export NL_SURFACE_INPUT_SOURCE=1
   export NL_NUM_SOIL_LAYERS=4
   export NL_SF_URBAN_PHYSICS=0
   export NL_MAXIENS=1
   export NL_MAXENS=3
   export NL_MAXENS2=3
   export NL_MAXENS3=16
   export NL_ENSDIM=144
   export NL_MP_ZERO_OUT=2
   export NL_CU_RAD_FEEDBACK=.false.
   export NL_CU_DIAG=1
   export NL_PROGN=0
   export NL_CUGD_AVEDX=1
   export NL_NUM_LAND_CAT=24
#
# DYNAMICS
   export NL_USE_BASEPARAM_FR_NML=.true.
   export NL_RK_ORD=3
   export NL_W_DAMPING=1
   export NL_DIFF_OPT=1
   export NL_KM_OPT=4
   export NL_DIFF_6TH_OPT=0
   export NL_DIFF_6TH_FACTOR=0.12
   export NL_BASE_TEMP=290.
   export NL_DAMP_OPT=3
   export NL_ZDAMP=5000
   export NL_DAMPCOEF=0.01
   export NL_KHDIF=0
   export NL_KVDIF=0
   export NL_NON_HYDROSTATIC=.true.
   export NL_MOIST_ADV_OPT=2
   export NL_SCALAR_ADV_OPT=2
   export NL_CHEM_ADV_OPT=2
   export NL_TKE_ADV_OPT=2
   export NL_TIME_STEP_SOUND=6
#
# BDY_CONTROL
   export NL_SPEC_BDY_WIDTH=5
   export NL_SPEC_ZONE=1
   export NL_RELAX_ZONE=4
   export NL_SPECIFIED=.true.
   export NL_NESTED=.false.
   export NL_REAL_DATA_INIT_TYPE=3
#
# NAMELIST_QUILT
   export NL_NIO_TASKS_PER_GROUP=0
   export NL_NIO_GROUPS=1
#
# NAMELIST CHEM
   export NL_KEMIT=10
   export NL_CHEM_OPT=112
   export NL_BIOEMDT=3
   export NL_PHOTDT=18
   export NL_CHEMDT=3.0
   export NL_IO_STYLE_EMISSIONS=2
   export NL_EMISS_INPT_OPT=111
   export NL_EMISS_OPT=8
   export NL_CHEM_IN_OPT=0
   export NL_PHOT_OPT=3
   export NL_GAS_DRYDEP_OPT=1
   export NL_AER_DRYDEP_OPT=1
   export NL_BIO_EMISS_OPT=3
   export NL_GAS_BC_OPT=112
   export NL_GAS_IC_OPT=112
   export NL_GAS_BC_OPT=112
   export NL_AER_BC_OPT=112
   export NL_AER_IC_OPT=112
   export NL_GASCHEM_ONOFF=1
   export NL_AERCHEM_ONOFF=1
   export NL_WETSCAV_ONOFF=0
   export NL_CLDCHEM_ONOFF=0
   export NL_VERTMIX_ONOFF=1
   export NL_CHEM_CONV_TR=1
   export NL_SEAS_OPT=1
   export NL_DUST_OPT=1
   export NL_DMSEMIS_OPT=1
   export NL_BIOMASS_BURN_OPT=2
   export NL_PLUMERISEFIRE_FRQ=60
   export NL_HAVE_BCS_CHEM=.true.
   export NL_AER_RA_FEEDBACK=0
   export NL_NE_AREA=118
   export NL_OPT_PARS_OUT=1
   export NL_SCALE_FIRE_EMISS=.true.
   export NL_HAVE_BCS_UPPER=.true.
   export NL_FIXED_UBC_INNAME="ubvals_b40.20th.track1_1996-2005.nc"
   export NL_CHEMDIAG=1
#
# Setup CENTRALDIR
   cd ${RUN_DIR}/${L_DATE}
#
# Setup WRFCHEM advance_model.ksh directory structure
   export CENTRALDIR=${RUN_DIR}/${L_DATE}/DART_CENTRALDIR
   export WRF_RUN_DIR=${CENTRALDIR}/WRF_RUN
   export WRFCHEM_RUN_DIR=${CENTRALDIR}/WRFCHEM_RUN
   export WRFBDY_DIR=${CENTRALDIR}/WRF
#
# Make $CENTRALDIR, if necessary  and go there
   if [[ -d ${CENTRALDIR} ]]; then
      cd ${CENTRALDIR}
   else
      mkdir -p ${CENTRALDIR}
      cd ${CENTRALDIR}
   fi
#
# Make $WRF_RUN_DIR, if necessary
   if [[ -d ${WRF_RUN_DIR} ]]; then
      echo ${WRF_RUN_DIR} exists
   else
      mkdir -p ${WRF_RUN_DIR}
   fi
#
# Make $WRFCHEM_RUN_DIR, if necessary
   if [[ -d ${WRFCHEM_RUN_DIR} ]]; then
      echo ${WRFCHEM_RUN_DIR} exists
   else
      mkdir -p ${WRFCHEM_RUN_DIR}
   fi
#
# Make $WRFBDY_DIR, if necessary
   if [[ -d ${WRFBDY_DIR} ]]; then
      echo ${WRFBDY_DIR} exists
   else
      mkdir -p ${WRFBDY_DIR}
   fi
#
# Copy necessary executables from DART to $CENTRALDIR
   cp ${DART_DIR}/models/wrf_chem/shell_scripts/advance_perf_model.ksh ${CENTRALDIR}/.
   cp ${DART_DIR}/models/wrf_chem/shell_scripts/advance_model.ksh ${CENTRALDIR}/.
   cp ${DART_DIR}/models/wrf_chem/shell_scripts/da_run_hold.ksh ${CENTRALDIR}/.
   cp ${DART_DIR}/models/wrf_chem/work/input.nml ${CENTRALDIR}/.
   cp ${DART_DIR}/models/wrf_chem/work/advance_time ${CENTRALDIR}/.
   cp ${DART_DIR}/models/wrf_chem/work/pert_wrf_bc ${CENTRALDIR}/.
   cp ${DART_DIR}/models/wrf_chem/work/update_wrf_bc ${CENTRALDIR}/.
   cp ${DART_DIR}/models/wrf_chem/work/dart_to_wrf ${CENTRALDIR}/.
   cp ${DART_DIR}/models/wrf_chem/work/wrf_to_dart ${CENTRALDIR}/.
   cp ${DART_DIR}/models/wrf_chem/work/filter ${CENTRALDIR}/.
   cp ${DART_DIR}/models/wrf_chem/work/restart_file_tool ${CENTRALDIR}/.
   cp ${DART_DIR}/system_simulation/final_full_precomputed_tables/final_full.${NUM_MEMBERS} ${CENTRALDIR}/.
   cp ${WRFCHEM_DIR}/test/em_real/wrf.exe ${CENTRALDIR}/.
#
########################################################################
#
# RUN PERFECT_MODEL
#
########################################################################
   echo BEGIN PERFECT_MODEL
   if [[ ${RUN_WARM} == true && ${WARM_PERFECT_MODEL} == true && ${RUN_PERFECT_MODEL} == true ]]; then
      export WARM_PERFECT_MODEL=true
      export WARM_FILTER=true
      export WARM_WRFCHEM=true
      export WARM_ARCHIVE=true
#
      if [[ ! -d ${RUN_DIR}/${L_DATE}/perfect_model ]]; then
         mkdir -p ${RUN_DIR}/${L_DATE}/perfect_model
         cd ${RUN_DIR}/${L_DATE}/perfect_model
      else
         cd ${RUN_DIR}/${L_DATE}/perfect_model
      fi
#
# Setup perfet model namelist 
# &perfect_model_obs_nml
      export NL_START_FROM_RESTART=.true.
      export NL_OUTPUT_RESTART=.true.
      export NL_ASYNC=2
      export NL_INIT_TIME_DAYS=-1
      export NL_INIT_TIME_SECONDS=-1
      export NL_FIRST_OBS_DAYS=-1
      export NL_FIRST_OBS_SECONDS=-1
      export NL_LAST_OBS_DAYS=-1
      export NL_LAST_OBS_SECONDS=-1
      export NL_OUTPUT_INTERVAL=1
      export NL_RESTART_IN_FILE_NAME="perfect_ics"
      export NL_RESTART_OUT_FILE_NAME="perfect_restart"
      export NL_OBS_SEQ_IN_FILE_NAME="obs_seq.in"
      export NL_OBS_SEQ_OUT_FILE_NAME="obs_seq.out"
      export NL_ADV_ENS_COMMAND="'./advance_perf_model.ksh'"
      export NL_OUTPUT_TIMESTAMPS=.false.
      export NL_TRACE_EXECUTION=.true.
      export NL_OUTPUT_FORWARD_OP_ERRORS=.false.
      export NL_PRINT_EVERY_NTH_OBS=-1
      export NL_SILENCE=.false.
#
# Get the obs_seq.out file for current cycle
      cd ${CENTRALDIR}
      export FILE=${OBS_SEQ_FLNAME}${L_DATE}.out
      if [[ ! -e ${DATA_DIR}/${OBS_SEQ_DIR}/${L_DATE}/${FILE} ]]; then
         hsi get ${CENTRALDIR}/obs_seq.in : ${HSI_DATA_DIR}/${OBS_SEQ_DIR}/${L_DATE}/${FILE}
      else
         cp ${DATA_DIR}/${OBS_SEQ_DIR}/${L_DATE}/${FILE} ${CENTRALDIR}/obs_seq.in
      fi
#
# Copy executable
      if [[ -e ${DART_WRF_CHEM}/perfect_model_obs ]]; then
         cp ${DART_WRF_CHEM}/perfect_model_obs ${CENTRALDIR}/.
      else
         echo ${DART_WRF_CHEM}/perfect_model_obs does not exist.
         exit
      fi
#
# Copy wrf_chem input file to $CENTRALDIR for use as template
      if [[ ! -e ${DATA_DIR}/${RC_DIR}/${L_DATE}/wrfinput_d${DOMAIN}_${L_FILE_DATE} ]]; then
         hsi get ${CENTRALDIR}/wrfinput_d${DOMAIN} : ${HSI_DATA_DIR}/${RC_DIR}/${L_DATE}/wrfinput_d${DOMAIN}_${L_FILE_DATE}
      else
         cp ${DATA_DIR}/${RC_DIR}/${L_DATE}/wrfinput_d${DOMAIN}_${L_FILE_DATE} ${CENTRALDIR}/wrfinput_d${DOMAIN}
      fi
#
# Copy wrf_chem bdy file to $CENTRALDIR for use as template
      if [[ ! -e ${DATA_DIR}/${RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE} ]]; then
         hsi get ${CENTRALDIR}/wrfbdy_d${DOMAIN} : ${HSI_DATA_DIR}/${RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE}
      else
         cp ${DATA_DIR}/${RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE} ${CENTRALDIR}/wrfbdy_d${DOMAIN}
      fi
#
# Copy wrf_chem input file to $CENTRALDIR/WRF for PAST DATE to cover obs_seq.in file
      if [[ ! -e ${DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfinput_d${DOMAIN}_${PAST_FILE_DATE} ]]; then
         hsi get ${CENTRALDIR}/WRF/wrfinput_d${DOMAIN}_${PAST_DAY_GREG}_${PAST_SEC_GREG}_0001 : ${HSI_DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfinput_d${DOMAIN}_${PAST_FILE_DATE}
      else
         cp ${DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfinput_d${DOMAIN}_${PAST_FILE_DATE} ${CENTRALDIR}/WRF/wrfinput_d${DOMAIN}_${PAST_DAY_GREG}_${PAST_SEC_GREG}_0001
      fi
#
# Copy wrf_chem bdy files to $CENTRALDIR/WRF for PAST DATE and L_DATE to cover obs_seq.in file
# First wrfbdy file
      if [[ ! -e ${DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfbdy_d${DOMAIN}_${PAST_FILE_DATE} ]]; then
         hsi get ${CENTRALDIR}/WRF/wrfbdy_d${DOMAIN}_${DAY_GREG}_${SEC_GREG}_0001 : ${HSI_DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfbdy_d${DOMAIN}_${PAST_FILE_DATE}
      else
         cp ${DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfbdy_d${DOMAIN}_${PAST_FILE_DATE} ${CENTRALDIR}/WRF/wrfbdy_d${DOMAIN}_${DAY_GREG}_${SEC_GREG}_0001
      fi
#
# Second wrfbdy file
      if [[ ! -e ${DATA_DIR}/${RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE} ]]; then
         hsi get ${CENTRALDIR}/WRF/wrfbdy_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_0001 : ${HSI_DATA_DIR}/${RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE}
      else
         cp ${DATA_DIR}/${RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE} ${CENTRALDIR}/WRF/wrfbdy_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_0001
      fi
#
# Copy necessary files to $WRF_RUN_DIR 
      cp ${WRFCHEM_DIR}/test/em_real/wrf.exe ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/CAM_ABS_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/CAM_AEROPT_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/ETAMPNEW_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/GENPARM.TBL ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/LANDUSE.TBL ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/RRTMG_LW_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/RRTMG_SW_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/RRTM_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/SOILPARM.TBL ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/URBPARM.TBL ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/VEGPARM.TBL ${WRF_RUN_DIR}/.
      cp ${DART_DIR}/models/wrf_chem/run_scripts/hist_io_flds ${WRF_RUN_DIR}/.
#
      cd ${WRFCHEM_RUN_DIR} 
      if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/clim_p_trop.nc ]]; then
         hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/clim_p_trop.nc
      else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/clim_p_trop.nc ./.
      fi
      if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/exo_coldens_d${DOMAIN} ]]; then
         hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/exo_coldens_d${DOMAIN} 
      else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/exo_coldens_d${DOMAIN} ./.
      fi
      if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/ubvals_b40.20th.track1_1996-2005.nc ]]; then
         hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/ubvals_b40.20th.track1_1996-2005.nc 
      else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/ubvals_b40.20th.track1_1996-2005.nc ./.
      fi
      if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/wrf_season_wes_usgs_d${DOMAIN}.nc ]]; then
         hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/wrf_season_wes_usgs_d${DOMAIN}.nc 
      else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/wrf_season_wes_usgs_d${DOMAIN}.nc ./.
      fi
#
# Convert the wrfinput files to DART output format for advance_model
# &wrf_to_dart_nml
      export NL_DART_RESTART_NAME="'perfect_ics'"
      export NL_PRINT_DATA_RANGES=.false.
#
# Go to work directory
      cd ${CENTRALDIR}
      rm input.nml
      ${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_input.nml.ksh
#
# Make run directory for file conversons
      mkdir convert_file 
      cd convert_file 
      cp ${CENTRALDIR}/input.nml ./.
      cp ${CENTRALDIR}/wrf_to_dart ./.
      cp ${CENTRALDIR}/restart_file_tool ./.
      cp ${CENTRALDIR}/wrfinput_d${DOMAIN} ./.
#
# Create job script 
      rm conv_*.out
      rm conv_*.err
      rm index_restart_file_tool*
      if [[ -f job.ksh ]]; then rm -rf job.ksh; fi
      touch job.ksh
      RANDOM=$$
      export JOBRND=conv_$RANDOM
      cat << EOF >job.ksh
#!/bin/ksh -aeux
#BSUB -P ${PROJ_NUMBER}
#BSUB -n 1                                  # number of total (MPI) tasks
#BSUB -J ${JOBRND}                          # job name
#BSUB -o ${JOBRND}.out                      # output filename
#BSUB -e ${JOBRND}.err                      # error filename
#BSUB -W 00:10                              # wallclock time (minutes)
#BSUB -q geyser
#
# Run wrf_to_dart
./wrf_to_dart > index_wrf_to_dart 2>&1 
#
# Run restart_file_tool to add target date/time stamp
#./restart_file_tool > index_restart_file_tool 2>&1
#cp assim_model_state_tp.0001 ${CENTRALDIR}/assim_model_state_tp_0001
#cp assim_model_state_ic.0001 ${CENTRALDIR}/assim_model_state_ic_0001
#cp assim_model_state_ic.0001 ${CENTRALDIR}/assim_model_state_ic.0001
cp perfect_ics ${CENTRALDIR}/perfect_ics
#
export RC=\$?     
if [[ -f CONV_SUCCESS ]]; then rm -rf CONV_SUCCESS; fi     
if [[ -f CONV_FAILED ]]; then rm -rf CONV_FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch CONV_SUCCESS
else
   touch CONV_FAILED 
   exit
fi
EOF
#
# Submit convert file script and wait until job completes
      bsub -K < job.ksh 
#
# Check that filter_ic_new file exists
      if [[ ! -e ${CENTRALDIR}/convert_file/perfect_ics ]]; then
         echo APM: ${CENTRALDIR}/convert_file/perfect_ics failed.
         exit
      fi 
#
# Copy the wrfchem static chemistry data to $CENTRALDIR/WRFCHEM_RUN
      cd ${CENTRALDIR}/WRFCHEM_RUN
# First file
      if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/${PAST_YY}${PAST_MM}${PAST_DD}/wrfbiochemi_d${DOMAIN}_${PAST_FILE_DATE} ]]; then
         hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${PAST_YY}${PAST_MM}${PAST_DD}/wrfbiochemi_d${DOMAIN}_${PAST_FILE_DATE} 
      else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/${PAST_YY}${PAST_MM}${PAST_DD}/wrfbiochemi_d${DOMAIN}_${PAST_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
      fi
# Second file
      if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/${L_YY}${L_MM}${L_DD}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} ]]; then
         hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${L_YY}${L_MM}${L_DD}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} 
      else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/${L_YY}${L_MM}${L_DD}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
      fi
#
# Copy the wrfchem time dependent chemistry data to $CENTRALDIR/WRFCHEM_RUN
      cd ${CENTRALDIR}/WRFCHEM_RUN
      cp ${CENTRALDIR}/advance_time ./.
      cp ${CENTRALDIR}/input.nml ./.
      export LL_DATE=${PAST_DATE}
      while [[ ${LL_DATE} -le ${NEXT_DATE} ]]; do
         export LL_YY=`echo ${LL_DATE} | cut -c1-4`
         export LL_MM=`echo ${LL_DATE} | cut -c5-6`
         export LL_DD=`echo ${LL_DATE} | cut -c7-8`
         export LL_HH=`echo ${LL_DATE} | cut -c9-10`
         export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
         if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE} ]]; then
            hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE}
         else         
            cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
         fi
         if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} ]]; then
            hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE}
         else
            cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
         fi
         export LL_DATE=`echo ${LL_DATE} +1h | ./advance_time`
      done
#
# Generate DART input.nml and WRFCHEM namelist.input files
      cd ${CENTRALDIR}
      rm namelist.input
      rm input.nml
      ${DART_DIR}/models/wrf_chem/namelist_scripts/WRFCHEM/wrfchem_create_namelist.input.ksh
      ${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_input.nml.ksh
#
# Create job script 
      rm perfm_*.out
      rm perfm_*.err
      rm index_perfect_model*
      if [[ -f job.ksh ]]; then rm -rf job.ksh; fi
      touch job.ksh
      RANDOM=$$
      export JOBRND=perfm_$RANDOM
      cat << EOF >job.ksh
#!/bin/ksh -x
#BSUB -P ${PROJ_NUMBER}
#BSUB -x                                    # exclusive use of node (not_shared)
#BSUB -n ${NUM_TASKS}                       # number of total (MPI) tasks
#BSUB -R "span[ptile=${TASKS_PER_NODE}]"    # mpi tasks per node
#BSUB -J ${JOBRND}                          # job name
#BSUB -o ${JOBRND}.out                      # output filename
#BSUB -e ${JOBRND}.err                      # error filename
#BSUB -W ${TIME_LIMIT_PERFM}               # wallclock time (minutes)
#BSUB -q ${JOB_CLASS_PERFM}
#
./perfect_model_obs > index_perfect_model 2>&1 

export RC=\$?     
if [[ -f PERF_MODEL_SUCCESS ]]; then rm -rf PERF_MODEL_SUCCESS; fi     
if [[ -f PERF_MODEL_FAILED ]]; then rm -rf PERF_MODEL_FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch PERF_MODEL_SUCCESS
else
   touch PERF_MODEL_FAILED 
   exit
fi
EOF
#
      bsub -K < job.ksh 
#
# Archive perfect model obs_seq file
      export FILE1=${OBS_SEQ_OUT_NAME}${L_DATE}.out
      export FILE2=True_State_${L_DATE}.nc
      cp obs_seq.out ${RUN_DIR}/${L_DATE}/perfect_model/${FILE1}
      cp True_State.nc ${RUN_DIR}/${L_DATE}/perfect_model/${FILE2}
      hsi "mkdir -p ${HSI_RUN_DIR}/${L_DATE}"
      hsi "cd ${HSI_RUN_DIR}/${L_DATE}; put -R ${RUN_DIR}/${L_DATE}/perfect_model"
   fi
   echo COMPLETED PERFECT_MODEL
#
########################################################################
#
# RUN_INITIAL CODE BLOCK
#
########################################################################
   echo BEGIN RUN_INITIAL CODE BLOCK
   if [[ ${RUN_WARM} == true && ${WARM_INITIAL_WRFCHEM} == true && ${RUN_INITIAL_WRFCHEM} == true ]]; then
      export RUN_INITIAL_WRFCHEM=false
      export WARM_PERFECT_MODEL=true
      export WARM_INITIAL_WRFCHEM=false
      export WARM_FILTER=true
      export WARM_WRFCHEM=true
      export WARM_ARCHIVE=true
#
      if [[ ! -d ${RUN_DIR}/${PAST_DATE}/initial ]]; then
         mkdir -p ${RUN_DIR}/${PAST_DATE}/initial
         cd ${RUN_DIR}/${PAST_DATE}/initial
      else
         cd ${RUN_DIR}/${PAST_DATE}/initial
      fi
      export CENTRALDIR=${RUN_DIR}/${PAST_DATE}/DART_CENTRALDIR
      export WRF_RUN_DIR=${CENTRALDIR}/WRF_RUN
      export WRFCHEM_RUN_DIR=${CENTRALDIR}/WRFCHEM_RUN
      export WRFBDY_DIR=${CENTRALDIR}/WRF
      mkdir -p ${CENTRALDIR}
      mkdir -p ${WRF_RUN_DIR}
      mkdir -p ${WRFCHEM_RUN_DIR}
      mkdir -p ${WRFBDY_DIR}
#
# Copy necessary executables from DART to $CENTRALDIR
      cp ${DART_DIR}/models/wrf_chem/shell_scripts/advance_perf_model.ksh ${CENTRALDIR}/.
      cp ${DART_DIR}/models/wrf_chem/shell_scripts/advance_model.ksh ${CENTRALDIR}/.
      cp ${DART_DIR}/models/wrf_chem/shell_scripts/da_run_hold.ksh ${CENTRALDIR}/.
      cp ${DART_DIR}/models/wrf_chem/work/input.nml ${CENTRALDIR}/.
      cp ${DART_DIR}/models/wrf_chem/work/advance_time ${CENTRALDIR}/.
      cp ${DART_DIR}/models/wrf_chem/work/pert_wrf_bc ${CENTRALDIR}/.
      cp ${DART_DIR}/models/wrf_chem/work/update_wrf_bc ${CENTRALDIR}/.
      cp ${DART_DIR}/models/wrf_chem/work/dart_to_wrf ${CENTRALDIR}/.
      cp ${DART_DIR}/models/wrf_chem/work/wrf_to_dart ${CENTRALDIR}/.
      cp ${DART_DIR}/models/wrf_chem/work/filter ${CENTRALDIR}/.
      cp ${DART_DIR}/models/wrf_chem/work/restart_file_tool ${CENTRALDIR}/.
      cp ${DART_DIR}/system_simulation/final_full_precomputed_tables/final_full.${NUM_MEMBERS} ${CENTRALDIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/wrf.exe ${CENTRALDIR}/.
#
# Copy necessary files to $WRF_RUN_DIR 
      cp ${WRFCHEM_DIR}/test/em_real/wrf.exe ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/CAM_ABS_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/CAM_AEROPT_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/ETAMPNEW_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/GENPARM.TBL ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/LANDUSE.TBL ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/RRTMG_LW_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/RRTMG_SW_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/RRTM_DATA ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/SOILPARM.TBL ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/URBPARM.TBL ${WRF_RUN_DIR}/.
      cp ${WRFCHEM_DIR}/test/em_real/VEGPARM.TBL ${WRF_RUN_DIR}/.
      cp ${DART_DIR}/models/wrf_chem/run_scripts/hist_io_flds ${WRF_RUN_DIR}/.
#
# Copy some necessary files to $WRFCHEM_RUN_DIR
      if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/clim_p_trop.nc ]]; then
         hsi get ${WRFCHEM_RUN_DIR}/clim_p_trop.nc : ${HSI_DATA_DIR}/${EMISSIONS_DIR}/clim_p_trop.nc
      else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/clim_p_trop.nc ${WRFCHEM_RUN_DIR}/clim_p_trop.nc
      fi
      if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/exo_coldens_d${DOMAIN} ]]; then
         hsi get ${WRFCHEM_RUN_DIR}/exo_coldens_d${DOMAIN} : ${HSI_DATA_DIR}/${EMISSIONS_DIR}/exo_coldens_d${DOMAIN} 
      else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/exo_coldens_d${DOMAIN} ${WRFCHEM_RUN_DIR}/exo_coldens_d${DOMAIN}
      fi
      if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/ubvals_b40.20th.track1_1996-2005.nc ]]; then
         hsi get ${WRFCHEM_RUN_DIR}/ubvals_b40.20th.track1_1996-2005.nc : ${HSI_DATA_DIR}/${EMISSIONS_DIR}/ubvals_b40.20th.track1_1996-2005.nc 
      else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/ubvals_b40.20th.track1_1996-2005.nc ${WRFCHEM_RUN_DIR}/ubvals_b40.20th.track1_1996-2005.nc
      fi
      if [[ ! -e ${DATA_DIR}/${EMISSIONS_DIR}/wrf_season_wes_usgs_d${DOMAIN}.nc ]]; then
         hsi get ${WRFCHEM_RUN_DIR}/wrf_season_wes_usgs_d${DOMAIN}.nc : ${HSI_DATA_DIR}/${EMISSIONS_DIR}/wrf_season_wes_usgs_d${DOMAIN}.nc 
      else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/wrf_season_wes_usgs_d${DOMAIN}.nc ${WRFCHEM_RUN_DIR}/wrf_season_wes_usgs_d${DOMAIN}.nc
      fi
#
# Copy wrfinput file to $CENTRALDIR for use as template
      if [[ ! -e ${DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfinput_d${DOMAIN}_${PAST_FILE_DATE} ]]; then
         hsi get ${CENTRALDIR}/wrfinput_d${DOMAIN} : ${HSI_DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfinput_d${DOMAIN}_${PAST_FILE_DATE}
      else
         cp ${DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfinput_d${DOMAIN}_${PAST_FILE_DATE} ${CENTRALDIR}/wrfinput_d${DOMAIN}
      fi
#
# Copy wrfbdy file to $CENTRALDIR for use as template
      if [[ ! -e ${DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfbdy_d${DOMAIN}_${PAST_FILE_DATE} ]]; then
         hsi get ${CENTRALDIR}/wrfbdy_d${DOMAIN} : ${HSI_DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfbdy_d${DOMAIN}_${PAST_FILE_DATE}
      else
         cp ${DATA_DIR}/${RC_DIR}/${PAST_DATE}/wrfbdy_d${DOMAIN}_${PAST_FILE_DATE} ${CENTRALDIR}/wrfbdy_d${DOMAIN}
      fi
#    
# Copy dart executables
      cp ${CENTRALDIR}/advance_model.ksh ./.
      cp ${CENTRALDIR}/da_run_hold.ksh ./.
#    
# Get WRFINPUT and WRFBDY files and convert to DART format for call to advance_model at initial time
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         if ${USE_HSI}; then
            hsi get wrfinput_d${DOMAIN} : ${HSI_DATA_DIR}/${WPB_RC_DIR}/${PAST_DATE}/wrfinput_d${DOMAIN}_${PAST_FILE_DATE}.e${CMEM} 
         else
            cp ${DATA_DIR}/${WPB_RC_DIR}/${PAST_DATE}/wrfinput_d${DOMAIN}_${PAST_FILE_DATE}.e${CMEM} wrfinput_d${DOMAIN}
         fi
         cp wrfinput_d${DOMAIN} ${CENTRALDIR}/WRF/wrfinput_d${DOMAIN}_${PAST_DAY_GREG}_${PAST_SEC_GREG}_${KMEM}
#    
# Convert the wrfinput files to DART output format for advance_model
# &wrf_to_dart_nml
         export NL_DART_RESTART_NAME="'assim_model_state_tp_${KMEM}'"
         export NL_PRINT_DATA_RANGES=.false.
#    
# &restart_file_tool_nml
         export NL_ENS_SIZE=1
         export NL_INPUT_FILE_NAME="'assim_model_state_tp'"
         export NL_OUTPUT_FILE_NAME="'assim_model_state_ic'"
         export NL_OUTPUT_IS_MODEL_ADVANCE_FILE=.true.
         export NL_OVERWRITE_ADVANCE_TIME=.true.
         export NL_NEW_ADVANCE_DAYS=${DAY_GREG}
         export NL_NEW_ADVANCE_SECS=${SEC_GREG}
         rm input.nml
         ${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_input.nml.ksh
#    
# make run directory for file conversons 
         mkdir convert_file_${KMEM} 
         cd convert_file_${KMEM} 
         cp ${RUN_DIR}/${PAST_DATE}/initial/input.nml ./.
         cp ${CENTRALDIR}/wrf_to_dart ./.
         cp ${CENTRALDIR}/restart_file_tool ./.
         cp ${CENTRALDIR}/wrfinput_d${DOMAIN} ./.
#    
# APM: modify for submission to geyser or caldera
# Create job script 
         if [[ -f job.ksh ]]; then rm -rf job.ksh; fi
         touch job.ksh
         RANDOM=$$
         export JOBRND=conv_$RANDOM
         cat << EOF >job.ksh
#!/bin/ksh -aeux
#BSUB -P ${PROJ_NUMBER}
#BSUB -n 1                                  # number of total (MPI) tasks
#BSUB -J ${JOBRND}                          # job name
#BSUB -o ${JOBRND}.out                      # output filename
#BSUB -e ${JOBRND}.err                      # error filename
#BSUB -W 00:10                              # wallclock time (minutes)
#BSUB -q geyser
#
# Run wrf_to_dart
./wrf_to_dart > index_wrf_to_dart 2>&1 
cp assim_model_state_tp_${KMEM} assim_model_state_tp.0001
#
# Run restart_file_tool to add target date/time stamp
./restart_file_tool > index_restart_file_tool 2>&1
rm -rf assim_model_state_tp.0001
mv assim_model_state_ic.0001 assim_model_state_ic_${KMEM}
cp assim_model_state_ic_${KMEM} ${CENTRALDIR}/assim_model_state_ic_${KMEM}
#
export RC=\$?     
if [[ -f CONV_SUCCESS ]]; then rm -rf CONV_SUCCESS; fi     
if [[ -f CONV_FAILED ]]; then rm -rf CONV_FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch CONV_SUCCESS
else
   touch CONV_FAILED 
   exit
fi
EOF
#
# Submit convert file script for each and wait until job completes
         bsub < job.ksh 
         cd ..
         let IMEM=${IMEM}+1
      done
#    
# Wait for wrf_to_dart to complete for each member
      ./da_run_hold.ksh ${JOBRND}
#    
# Check that all filter_ic_new.xxxx files exist
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         cd ${RUN_DIR}/${PAST_DATE}/initial
         if [[ ! -e convert_file_${KMEM}/assim_model_state_ic_${KMEM} ]]; then
            echo APM: ${RUN_DIR}/${L_DATE}/initial/convert_file_${KMEM}/assim_model_state_ic_${KMEM} failed.
            exit
         fi 
         let IMEM=${IMEM}+1
      done
#    
# Copy WRFBDY files to $CENTRALDIR/WRF
      cd ${CENTRALDIR}/WRF
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         if ${USE_HSI}; then
            hsi get wrfbdy_d${DOMAIN}_${DAY_GREG}_${SEC_GREG}_${KMEM} : ${HSI_DATA_DIR}/${WPB_RC_DIR}/${PAST_DATE}/wrfbdy_d${DOMAIN}_${PAST_FILE_DATE}.e${CMEM} 
         else
            cp ${DATA_DIR}/${WPB_RC_DIR}/${PAST_DATE}/wrfbdy_d${DOMAIN}_${PAST_FILE_DATE}.e${CMEM} wrfbdy_d${DOMAIN}_${DAY_GREG}_${SEC_GREG}_${KMEM}
         fi
         let IMEM=${IMEM}+1
      done
#    
# Copy the wrfchem static chemistry data to $CENTRALDIR/WRFCHEM_RUN
      cd ${CENTRALDIR}/WRFCHEM_RUN
      if ${USE_HSI}; then
         hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${PAST_YY}${PAST_MM}${PAST_DD}/wrfbiochemi_d${DOMAIN}_${PAST_FILE_DATE} 
      else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/${PAST_YY}${PAST_MM}${PAST_DD}/wrfbiochemi_d${DOMAIN}_${PAST_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
      fi
#    
# Copy the wrfchem time dependent chemistry data to $CENTRALDIR/WRFCHEM_RUN
      cd ${CENTRALDIR}/WRFCHEM_RUN
      cp ${CENTRALDIR}/advance_time ./.
      cp ${CENTRALDIR}/input.nml ./.
      if ${USE_HSI}; then
         export LL_DATE=${PAST_DATE}
         while [[ ${LL_DATE} -le ${L_DATE} ]]; do
            export LL_YY=`echo ${LL_DATE} | cut -c1-4`
            export LL_MM=`echo ${LL_DATE} | cut -c5-6`
            export LL_DD=`echo ${LL_DATE} | cut -c7-8`
            export LL_HH=`echo ${LL_DATE} | cut -c9-10`
            export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
            hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE}
            hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE}
            export LL_DATE=`echo ${LL_DATE} +1h | ./advance_time`
         done
      else
         export LL_DATE=${PAST_DATE}
         while [[ ${LL_DATE} -le ${L_DATE} ]]; do
            export LL_YY=`echo ${LL_DATE} | cut -c1-4`
            export LL_MM=`echo ${LL_DATE} | cut -c5-6`
            export LL_DD=`echo ${LL_DATE} | cut -c7-8`
            export LL_HH=`echo ${LL_DATE} | cut -c9-10`
            export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
            cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
            cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
            export LL_DATE=`echo ${LL_DATE} +1h | ./advance_time` 
         done
      fi
#    
# Generate DART input.nml and WRFCHEM namelist.input files
      cd ${CENTRALDIR}
      rm namelist.input
      rm input.nml
      export NL_START_YEAR=${PAST_YY}
      export NL_START_MONTH=${PAST_MM}
      export NL_START_DAY=${PAST_DD}
      export NL_START_HOUR=${PAST_HH}
      export NL_END_YEAR=${L_YY}
      export NL_END_MONTH=${L_MM}
      export NL_END_DAY=${L_DD}
      export NL_END_HOUR=${L_HH}
      ${DART_DIR}/models/wrf_chem/namelist_scripts/WRFCHEM/wrfchem_create_namelist.input.ksh
      ${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_input.nml.ksh
#    
# Generate job script to run advance_model.ksh for each member
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
#
# APM: START NEW CODE FOR WRFCHEM_RUN_DIR/MEMBER_XXX
#
# Copy the wrfchem static chemistry data to $CENTRALDIR/WRFCHEM_RUN for this member
         cd ${CENTRALDIR}/WRFCHEM_RUN
         if [[ ! -d MEMBER_${KMEM} ]]; then
            mkdir -p ${CENTRALDIR}/WRFCHEM_RUN/MEMBER_${KMEM}
            cd ${CENTRALDIR}/WRFCHEM_RUN/MEMBER_${KMEM}
         else
            cd ${CENTRALDIR}/WRFCHEM_RUN/MEMBER_${KMEM}
         fi
         rm -rf wrfbiochemi_*
         rm -rf wrfchemi_*
         rm -rf wrffirechemi_*
         cp ${CENTRALDIR}/advance_time ./.
         cp ${CENTRALDIR}/input.nml ./.
         if ${USE_HSI}; then
            hsi get wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} : ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${L_YY}${L_MM}${L_DD}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE}.e${CMEM}
         else
            cp ${DATA_DIR}/${EMISSIONS_DIR}/${L_YY}${L_MM}${L_DD}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE}.e${CMEM} wrfbiochemi_d${DOMAIN}_${L_FILE_DATE}
         fi
#
# Copy the wrfchem time dependent chemistry data to $CENTRALDIR/WRFCHEM_RUN for this member
         if ${USE_HSI}; then
            export LL_DATE=${L_DATE}
            while [[ ${LL_DATE} -le ${NEXT_DATE} ]]; do
               export LL_YY=`echo ${LL_DATE} | cut -c1-4`
               export LL_MM=`echo ${LL_DATE} | cut -c5-6`
               export LL_DD=`echo ${LL_DATE} | cut -c7-8`
               export LL_HH=`echo ${LL_DATE} | cut -c9-10`
               export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
               hsi get wrfchemi_d${DOMAIN}_${LL_FILE_DATE} : ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE}.e${CMEM}
               hsi get wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} : ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE}.e${CMEM}
               export LL_DATE=`echo ${LL_DATE} +1h | ./advance_time`
            done
         else
            export LL_DATE=${L_DATE}
            while [[ ${LL_DATE} -le ${NEXT_DATE} ]]; do
               export LL_YY=`echo ${LL_DATE} | cut -c1-4`
               export LL_MM=`echo ${LL_DATE} | cut -c5-6`
               export LL_DD=`echo ${LL_DATE} | cut -c7-8`
               export LL_HH=`echo ${LL_DATE} | cut -c9-10`
               export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
               cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE}.e${CMEM} wrfchemi_d${DOMAIN}_${LL_FILE_DATE}
               cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE}.e${CMEM} wrffirechemi_d${DOMAIN}_${LL_FILE_DATE}
               export LL_DATE=`echo ${LL_DATE} +1h | ./advance_time` 
            done
         fi
         cd ${CENTRALDIR}
#
# APM: END NEW CODE FOR WRFCHEM_RUN_DIR/MEMBER_XXX
#
# Create filter control file
         if [[ -f filter_control_${KMEM} ]]; then rm -rf filter_control_${KMEM}; fi
         touch filter_control_${KMEM} 
         echo ${KMEM} >> filter_control_${KMEM} 
         echo assim_model_state_ic_${KMEM} >> filter_control_${KMEM} 
         echo assim_model_state_ud_${KMEM} >> filter_control_${KMEM}
#    
# Create job script 
         if [[ -f job.ksh ]]; then rm -rf job.ksh; fi
         touch job.ksh
         RANDOM=$$
         export JOBRND=advm_$RANDOM
         cat << EOF >job.ksh
#!/bin/ksh -aeux
#BSUB -P ${PROJ_NUMBER}
#BSUB -x                                    # exclusive use of node (not_shared)
#BSUB -n ${NUM_TASKS}                       # number of total (MPI) tasks
#BSUB -R "span[ptile=${TASKS_PER_NODE}]"    # mpi tasks per node
#BSUB -J ${JOBRND}                          # job name
#BSUB -o ${JOBRND}.out                      # output filename
#BSUB -e ${JOBRND}.err                      # error filename
#BSUB -W ${TIME_LIMIT_WRF}               # wallclock time (minutes)
#BSUB -q ${JOB_CLASS_WRF}
#
./advance_model.ksh 1 1 filter_control_${KMEM} > index_advance_model_${KMEM} 2>&1 

export RC=\$?     
if [[ -f ADV_MODEL_SUCCESS ]]; then rm -rf ADV_MODEL_SUCCESS; fi     
if [[ -f ADV_MODEL_FAILED ]]; then rm -rf ADV_MODEL_FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch ADV_MODEL_SUCCESS
else
   touch ADV_MODEL_FAILED 
   exit
fi
EOF
#
# Run advance_model and wait until job completes
#         if [[ -f assim_model_state_ud.0001 ]]; then
#            rm -rf  assim_model_state_ud.*
#         fi
         bsub < job.ksh 
         let IMEM=${IMEM}+1
      done
#    
# Wait for advance_model to complete for each member
      ./da_run_hold.ksh ${JOBRND}
#    
# Check that all wrfout files exist
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         cd ${RUN_DIR}/${PAST_DATE}/initial
         export WRFOUT_FILE=wrfout_d${DOMAIN}_${L_FILE_DATE} 
         export L_FILE=${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE}
         if [[ ! -e ${L_FILE} ]]; then
            echo APM: ${L_FILE} failed.
            exit
         fi 
         let IMEM=${IMEM}+1
      done
#    
# Save WRFCHEM forecasts to archive directory
      if [[ ! -d ${RUN_DIR}/${PAST_DATE}/wrfchem_forecast ]]; then
         mkdir -p ${RUN_DIR}/${PAST_DATE}/wrfchem_forecast
         cd ${RUN_DIR}/${PAST_DATE}/wrfchem_forecast
      else
         cd ${RUN_DIR}/${PAST_DATE}/wrfchem_forecast
      fi
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; fi
         export WRFOUT_FILE=wrfout_d${DOMAIN}_${L_FILE_DATE} 
         cp ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE} ${WRFOUT_FILE}_${KMEM}
         let IMEM=${IMEM}+1
      done
      cp ${CENTRALDIR}/advance_temp_0001/namelist.input ./.
#    
# Archive initial WRFCHEM forecasts
      cd ${RUN_DIR}/${PAST_DATE}
      hsi "mkdir -p ${HSI_RUN_DIR}/${PAST_DATE}"
      hsi "cd ${HSI_DATA_DIR}/${PAST_DATE}; put -R wrfchem_forecast"
#
# Reset CENTRALDIR
      export CENTRALDIR=${RUN_DIR}/${L_DATE}/DART_CENTRALDIR
      export WRF_RUN_DIR=${CENTRALDIR}/WRF_RUN
      export WRFCHEM_RUN_DIR=${CENTRALDIR}/WRFCHEM_RUN
      export WRFBDY_DIR=${CENTRALDIR}/WRF
   fi
   echo COMPLETED RUN_INITIAL CODE BLOCK
#
########################################################################
#
# RUN_FILTER CODE BLOCK
#
########################################################################
   echo BEGIN RUN_FILTER CODE BLOCK  
   if [[ ${RUN_WARM} == true && ${WARM_FILTER} == true && ${RUN_FILTER} == true ]]; then
      export WARM_PERFECT_MODEL=true
      export WARM_FILTER=true
      export WARM_WRFCHEM=true
      export WARM_ARCHIVE=true
#
# Setup run directory
      if [[ ! -d ${RUN_DIR}/${L_DATE}/dart_filter ]]; then
         mkdir -p ${RUN_DIR}/${L_DATE}/dart_filter
         cd ${RUN_DIR}/${L_DATE}/dart_filter
      else
         cd ${RUN_DIR}/${L_DATE}/dart_filter
      fi
#
# Setup filter namelist    
# filter.nml
      export NL_ENS_SIZE=${NUM_MEMBERS}
      export NL_NUM_OUTPUT_STATE_MEMBERS=${NUM_MEMBERS}
      export NL_NUM_OUTPUT_OBS_MEMBERS=${NUM_MEMBERS}
      export NL_OUTPUT_RESTART=.true.
      export NL_START_FROM_RESTART=.true.
      export NL_OBS_SEQUENCE_IN_NAME="'obs_seq.out'"       
      export NL_OBS_SEQUENCE_OUT_NAME="'obs_seq.final'"
      export NL_RESTART_IN_FILE_NAME="'filter_ic_old'"       
      export NL_RESTART_OUT_FILE_NAME="'filter_ic_new'"       
      set -A temp `echo ${ASIM_MIN_DATE} 0 -g | ./advance_time`
      (( temp[1]=${temp[1]}+1 ))
      export NL_FIRST_OBS_DAYS=${temp[0]}
      export NL_FIRST_OBS_SECONDS=${temp[1]}
      set -A temp `echo ${ASIM_MAX_DATE} 0 -g | ./advance_time`
      export NL_LAST_OBS_DAYS=${temp[0]}
      export NL_LAST_OBS_SECONDS=${temp[1]}
      if ${USE_DART_INFL}; then
         export NL_INF_FLAVOR_PRIOR=2
      else 
         export NL_INF_FLAVOR_PRIOR=0
      fi
      export NL_INF_FLAVOR_POST=0  
      if [[ ${L_DATE} -eq ${FIRST_FILTER_DATE} ]]; then
         export NL_INF_INITIAL_FROM_RESTART_PRIOR=.false.
         export NL_INF_SD_INITIAL_FROM_RESTART_PRIOR=.false.
         export NL_INF_INITIAL_FROM_RESTART_POST=.false.
         export NL_INF_SD_INITIAL_FROM_RESTART_POST=.false.
      else
         export NL_INF_INITIAL_FROM_RESTART_PRIOR=.true.
         export NL_INF_SD_INITIAL_FROM_RESTART_PRIOR=.true.
         export NL_INF_INITIAL_FROM_RESTART_POST=.true.
         export NL_INF_SD_INITIAL_FROM_RESTART_POST=.true.
      fi
      export NL_INF_IN_FILE_NAME_PRIOR="'prior_inflate_ic_old'"
      export NL_INF_IN_FILE_NAME_POST="'post_inflate_ics'"
      export NL_INF_OUT_FILE_NAME_PRIOR="'prior_inflate_ic_new'"
      export NL_INF_OUT_FILE_NAME_POST="'prior_inflate_restart'"
      export NL_INF_DIAG_FILE_NAME_PRIOR="'prior_inflate_diag'"
      export NL_INF_DIAG_FILE_NAME_POST="'post_inflate_diag'"
      export NL_INF_INITIAL_PRIOR=1.0
      export NL_INF_INITIAL_POST=1.0
      export NL_INF_SD_INITIAL_PRIOR=0.6
      export NL_INF_SD_INITIAL_POST=0.0
      export NL_INF_DAMPING_PRIOR=0.9
      export NL_INF_DAMPING_POST=1.0
      export NL_INF_LOWER_BOUND_PRIOR=1.0
      export NL_INF_LOWER_BOUND_POST=1.0
      export NL_INF_UPPER_BOUND_PRIOR=100.0
      export NL_INF_UPPER_BOUND_POST=100.0
      export NL_INF_SD_LOWER_BOUND_PRIOR=0.6
      export NL_INF_SD_LOWER_BOUND_POST=0.0
#
# Copy dart executables
      cp ${CENTRALDIR}/advance_time ./.
      cp ${CENTRALDIR}/wrf_to_dart ./.
      cp ${CENTRALDIR}/wrfinput_d${DOMAIN} ./.
      cp ${CENTRALDIR}/filter ./.
      cp ${CENTRALDIR}/restart_file_tool ./.
      cp ${CENTRALDIR}/da_run_hold.ksh ./.
      cp ${CENTRALDIR}/final_full.${NUM_MEMBERS} ./.
#
# Copy wrfinput files to parent directory because hsi get does not work from bsubed script
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         rm -rf wrfinput_d${DOMAIN}_${KMEM}
         if [[ -e ${RUN_DIR}/${PAST_DATE}/wrfchem_forecast/wrfout_d${DOMAIN}_${L_FILE_DATE}_${KMEM} ]]; then
            cp ${RUN_DIR}/${PAST_DATE}/wrfchem_forecast/wrfout_d${DOMAIN}_${L_FILE_DATE}_${KMEM} wrfinput_d${DOMAIN}_${KMEM}
         elif [[ ${USE_HSI} ]]; then
            echo APM: DART FAILED FOR MEMBER ${KMEM} ON DATE ${L_DATE}
            exit
#             hsi get wrfinput_d${DOMAIN}_${KMEM} : ${HSI_DATA_DIR}/${WPB_RC_DIR}/${L_DATE}/wrfinput_d${DOMAIN}_${L_FILE_DATE}.e${CMEM}
         else
            echo APM: DART FAILED FOR MEMBER ${KMEM} ON DATE ${L_DATE}
            exit
#               cp ${DATA_DIR}/${WPB_RC_DIR}/${L_DATE}/wrfinput_d${DOMAIN}_${L_FILE_DATE}.e${CMEM} wrfinput_d${DOMAIN}_${KMEM}
         fi    
         let IMEM=${IMEM}+1
      done
#
# Make DART input.nml for wrf_to_dart
# &wrf_to_dart_nml
      export NL_DART_RESTART_NAME="'dart_wrf_vector'"
      export NL_PRINT_DATA_RANGES=.false.
      rm input.nml
      ${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_input.nml.ksh
#
# APM: modify for submission to geyser or caldera
# Create job script
      if [[ -f job.ksh ]]; then rm -rf job.ksh; fi
      touch job.ksh
      RANDOM=$$
      export JOBRND=conv_$RANDOM
      rm conv_*.* 
      cat << EOF >job.ksh
#!/bin/ksh -x
#BSUB -P ${PROJ_NUMBER}
#BSUB -x                                    # exclusive use of node (not_shared)
#BSUB -n 1                                  # number of total (MPI) tasks
#BSUB -R "span[ptile=${TASKS_PER_NODE}]"    # mpi tasks per node
#BSUB -J ${JOBRND}                          # job name
#BSUB -o ${JOBRND}.jout                      # output filename
#BSUB -e ${JOBRND}.jerr                      # error filename
#BSUB -W ${TIME_LIMIT_WRF}               # wallclock time (minutes)
#BSUB -q ${JOB_CLASS_WRF}
#
# Loop through ensemble members
let IMEM=1
while [[ \${IMEM} -le ${NUM_MEMBERS} ]]; do
   export KMEM=\${IMEM}
   export CMEM=\${IMEM}
   if [[ \${IMEM} -lt 1000 ]]; then export KMEM=0\${IMEM}; fi
   if [[ \${IMEM} -lt 100 ]]; then export KMEM=00\${IMEM}; export CMEM=0\${IMEM}; fi
   if [[ \${IMEM} -lt 10 ]]; then export KMEM=000\${IMEM}; export CMEM=00\${IMEM}; fi
#
# make run directory for file conversions
   if [[ ! -e convert_file_\${KMEM} ]]; then
      mkdir convert_file_\${KMEM}
   fi 
   cd convert_file_\${KMEM}
   rm -rf wrfinput_*
   cp ../wrf_to_dart ./.
   cp ../input.nml ./.
   cp ../wrfinput_d${DOMAIN}_\${KMEM} wrfinput_d${DOMAIN}
#
# Run wrf_to_dart
   ./wrf_to_dart > index_wrf_to_dart 2>&1 
   mv dart_wrf_vector ../filter_ic_old.\${KMEM}
#
   export RC=\$?     
   if [[ -f CONV_SUCCESS ]]; then rm -rf CONV_SUCCESS; fi     
   if [[ -f CONV_FAILED ]]; then rm -rf CONV_FAILED; fi          
   if [[ \$RC = 0 ]]; then
      touch CONV_SUCCESS
   else
      touch CONV_FAILED 
      exit
   fi
   cd ..
   let IMEM=\${IMEM}+1
done
EOF
#
# Submit convert file script for each and wait until job completes
      bsub -K < job.ksh 
#
# APM:Check that dart_wrf_vector exists
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         if [[ ! -e ${RUN_DIR}/${L_DATE}/dart_filter/filter_ic_old.${KMEM} ]]; then
            echo APM: ${RUN_DIR}/${L_DATE}/dart_filter/filter_ic_old.${KMEM} failed.
            exit
         fi 
         let IMEM=${IMEM}+1
      done
#
# Copy "out" inflation files from prior cycle to "in" inflation files for current cycle
      if ${USE_DART_INF}; then
         if [[ ${L_DATE} -eq ${FIRST_FILTER_DATE} ]]; then
            export NL_INF_INITIAL_FROM_RESTART_PRIOR=.false.
            export NL_INF_SD_INITIAL_FROM_RESTART_PRIOR=.false.
            export NL_INF_INITIAL_FROM_RESTART_POST=.false.
            export NL_INF_SD_INITIAL_FROM_RESTART_POST=.false.
         else
            export NL_INF_INITIAL_FROM_RESTART_PRIOR=.true.
            export NL_INF_SD_INITIAL_FROM_RESTART_PRIOR=.true.
            export NL_INF_INITIAL_FROM_RESTART_POST=.true.
            export NL_INF_SD_INITIAL_FROM_RESTART_POST=.true.
         fi
         if [[ ${L_DATE} -ne ${FIRST_FILTER_DATE} ]]; then
            if [[ ${NL_INF_FLAVOR_PRIOR} != 0 ]]; then
               export INF_OUT_FILE_NAME_PRIOR=${RUN_DIR}/${PAST_DATE}/dart_filter/prior_inflate_ic_new
               cp ${INF_OUT_FILE_NAME_PRIOR} prior_inflate_ic_old
            fi
            if [[ ${NL_INF_FLAVOR_POST} != 0 ]]; then
               export INF_OUT_FILE_NAME_POST=${RUN_DIR}/${PAST_DATE}/dart_filter/post_inflate_ic_new
               cp ${NL_INF_OUT_FILE_NAME_POST} post_infalte_ic_old
            fi 
         fi
      fi
#
# Get the obs_seq.out file for current cycle
      export FILE1=${OBS_SEQ_OUT_NAME}${L_DATE}.out
      if [[ -e ${RUN_DIR}/${L_DATE}/perfect_model/${FILE1} ]]; then
         cp ${RUN_DIR}/${L_DATE}/perfect_model/${FILE1} obs_seq.out
      else
         hsi get obs_seq.out : ${HSI_RUN_DIR}/${L_DATE}/perfect_model/${FILE1}
      fi
#
# Generate input.nml
      set -A temp `echo ${ASIM_MIN_DATE} 0 -g | ./advance_time`
      (( temp[1]=${temp[1]}+1 ))
      export NL_FIRST_OBS_DAYS=${temp[0]}
      export NL_FIRST_OBS_SECONDS=${temp[1]}
      set -A temp `echo ${ASIM_MAX_DATE} 0 -g | ./advance_time`
      export NL_LAST_OBS_DAYS=${temp[0]}
      export NL_LAST_OBS_SECONDS=${temp[1]}
      export NL_ENS_SIZE=${NUM_MEMBERS}
      rm input.nml
      ${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_input.nml.ksh
#
# Generate job script to run filter
      if [[ -f job.ksh ]]; then
         rm job.ksh
      fi
      touch job.ksh
      RANDOM=$$
      rm -rf *.jerr
      rm -rf *.jout
      export JOBRND=filt_$RANDOM
      cat << EOF >job.ksh
#!/bin/ksh -aeux
#BSUB -P ${PROJ_NUMBER}
#BSUB -x                                    # exclusive use of node (not_shared)
#BSUB -n ${NUM_TASKS}                       # number of total (MPI) tasks
#BSUB -R "span[ptile=${TASKS_PER_NODE}]"    # mpi tasks per node
#BSUB -J ${JOBRND}                          # job name
#BSUB -o ${JOBRND}.jout                      # output filename
#BSUB -e ${JOBRND}.jerr                      # error filename
#BSUB -W ${TIME_LIMIT_FILTER}               # wallclock time (minutes)
#BSUB -q ${JOB_CLASS_FILTER}
#
mpirun.lsf ./filter > index_filter 2>&1 
export RC=\$?
if [[ -f FILTER_SUCCESS ]]; then rm -rf FILTER_SUCCESS; fi     
if [[ -f FILTER_FAILED ]]; then rm -rf FILTER_FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch FILTER_SUCCESS
else
   touch FILTER_FAILED 
   exit
fi
EOF
#
# Run filter and wait until job completes
      bsub -K < job.ksh
#
# Check whether filter ran successfully
      if [[ -e FILTER_FAILED ]]; then
         echo DART-WRFCHEM FILTER failed
         exit
      fi
#
# APM:Check that all filter_ic_new.xxxx files exist
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         cd ${RUN_DIR}/${L_DATE}/dart_filter
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         export L_FILE=filter_ic_new.${KMEM}
         if [[ ! -e ${L_FILE} ]]; then
            echo APM: ${L_FILE} does not exit.
            exit
         fi 
         let IMEM=${IMEM}+1
      done
#
# Update the internal time stamp in the posterior analysis for each ensemble member
      export NL_INPUT_FILE_NAME="'filter_ic_new'"
      export NL_OUTPUT_FILE_NAME="'assim_model_state_ic'"
      export NL_SINGLE_RESTART_FILE_IN=.false.
      export NL_SINGLE_RESTART_FILE_OUT=.false.
      export NL_INPUT_IS_MODEL_ADVANCE_FILE=.false.
      export NL_OUTPUT_IS_MODEL_ADVANCE_FILE=.true.
      export NL_OVERWRITE_ADVANCE_TIME=.true.
      export NL_NEW_ADVANCE_DAYS=${NEXT_DAY_GREG}
      export NL_NEW_ADVANCE_SECS=${NEXT_SEC_GREG}
      export NL_ENS_SIZE=${NUM_MEMBERS}
      rm input.nml
      ${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_input.nml.ksh
#
# Run restart_file_tool to add target date/time stamp
      ./restart_file_tool > index_restart_file_tool 2>&1
#
# APM:Check that all assim_model_state_ic.xxxx files exist
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         cd ${RUN_DIR}/${L_DATE}/dart_filter
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         export L_FILE=assim_model_state_ic.${KMEM}
         if [[ ! -e ${L_FILE} ]]; then
            echo APM: ${L_FILE} failed.
            exit
         fi 
         let IMEM=${IMEM}+1
      done
   fi
   echo COMPLETED RUN_FILTER CODE BLOCK
#
########################################################################
#
# RUN_WRFCHEM CODE BLOCK
#
########################################################################
   echo BEGIN RUN_WRFCHEM CODE BLOCK
   if [[ ${RUN_WARM} == true && ${WARM_WRFCHEM} == true && ${RUN_WRFCHEM} == true ]]; then
      export WARM_PERFECT_MODEL=true
      export WARM_FILTER=true
      export WARM_WRFCHEM=true
      export WARM_ARCHIVE=true
      if [[ ! -d ${RUN_DIR}/${L_DATE}/cycle ]]; then
         mkdir -p ${RUN_DIR}/${L_DATE}/cycle
         cd ${RUN_DIR}/${L_DATE}/cycle
      else
         cd ${RUN_DIR}/${L_DATE}/cycle
      fi
#
# Copy dart executables
      cp ${CENTRALDIR}/advance_time ./.
      cp ${CENTRALDIR}/wrf_to_dart ./.
      cp ${CENTRALDIR}/restart_file_tool ./.
      cp ${CENTRALDIR}/advance_model.ksh ./.
#
# Copy the DART filter posterior analyses
      rm -rf ${CENTRALDIR}/assim_model_state_*
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         cp ${RUN_DIR}/${L_DATE}/dart_filter/assim_model_state_ic.${KMEM} ${CENTRALDIR}/assim_model_state_ic_${KMEM}
         let IMEM=${IMEM}+1
      done
#
# Copy past WRFOUT files to $CENTRALDIR/WRF as WRFINPUT file templates
      cd ${CENTRALDIR}/WRF
      rm -rf wrfinput_d${DOMAIN}_*
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         if ${USE_HSI}; then
            hsi get wrfinput_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM} : ${HSI_SAVE_DIR}/${PAST_DATE}/wrfchem_forecast/wrfout_d${DOMAIN}_${L_FILE_DATE}_${KMEM} 
         else
            cp ${RUN_DIR}/${PAST_DATE}/wrfchem_forecast/wrfout_d${DOMAIN}_${L_FILE_DATE}_${KMEM} wrfinput_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM}
         fi
         let IMEM=${IMEM}+1
      done
#
# One WRFINPUT file as template to $CENTRALDIR
      cp wrfinput_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_0001 ${CENTRALDIR}/wrfinput_d${DOMAIN}
#
# Copy WRFBDY files to $CENTRALDIR/WRF
      cd ${CENTRALDIR}/WRF
      rm -rf wrfbdy_d${DOMAIN}_*
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         if ${USE_HSI}; then
            hsi get wrfbdy_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM} : ${HSI_DATA_DIR}/${WPB_RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE}.e${CMEM} 
         else
            cp ${DATA_DIR}/${WPB_RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE}.e${CMEM} wrfbdy_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM}
         fi
         let IMEM=${IMEM}+1
      done
#
# Copy chem static chemistry data to $CENTRALDIR/WRFCHEM_RUN
      cd ${CENTRALDIR}/WRFCHEM_RUN
      rm -rf wrfbiochemi_d${DOMAIN}_*
      if ${USE_HSI}; then
         hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${L_YY}${L_MM}${L_DD}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} 
            else
         cp ${DATA_DIR}/${EMISSIONS_DIR}/${L_YY}${L_MM}${L_DD}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
      fi
#
# Copy the wrfchem time dependent chemistry data to $CENTRALDIR/WRFCHEM_RUN
      cd ${CENTRALDIR}/WRFCHEM_RUN
      rm -rf wrfchemi_d${DOMAIN}*
      rm -rf wrffirechemi_d${DOMAIN}*
      cp ${CENTRALDIR}/advance_time ./.
      cp ${CENTRALDIR}/input.nml ./.
      if ${USE_HSI}; then
         export LL_DATE=${L_DATE}
         while [[ ${LL_DATE} -le ${NEXT_DATE} ]]; do
            export LL_YY=`echo ${LL_DATE} | cut -c1-4`
            export LL_MM=`echo ${LL_DATE} | cut -c5-6`
            export LL_DD=`echo ${LL_DATE} | cut -c7-8`
            export LL_HH=`echo ${LL_DATE} | cut -c9-10`
            export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
            hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE}
            hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE}
            export LL_DATE=`echo ${LL_DATE} +1h | ./advance_time`
         done
      else
         export LL_DATE=${L_DATE}
         while [[ ${LL_DATE} -le ${NEXT_DATE} ]]; do
            export LL_YY=`echo ${LL_DATE} | cut -c1-4`
            export LL_MM=`echo ${LL_DATE} | cut -c5-6`
            export LL_DD=`echo ${LL_DATE} | cut -c7-8`
            export LL_HH=`echo ${LL_DATE} | cut -c9-10`
            export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
            cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
            cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
            export LL_DATE=`echo ${LL_DATE} +1h | ./advance_time` 
         done
      fi
#
# Generate DART input.nml and WRFCHEM namelist.input files
      cd ${CENTRALDIR}
      rm namelist.input
      rm input.nml
      ${DART_DIR}/models/wrf_chem/namelist_scripts/WRFCHEM/wrfchem_create_namelist.input.ksh
      ${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_input.nml.ksh
#
# Run WRFCHEM
# Generate job script to run advance_model.ksh for each member
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
#
# APM: START NEW CODE FOR WRFCHEM_RUN_DIR/MEMBER_XXX
#
# Copy the wrfchem static chemistry data to $CENTRALDIR/WRFCHEM_RUN for this member
         cd ${CENTRALDIR}/WRFCHEM_RUN
         if [[ ! -d MEMBER_${KMEM} ]]; then
            mkdir -p ${CENTRALDIR}/WRFCHEM_RUN/MEMBER_${KMEM}
            cd ${CENTRALDIR}/WRFCHEM_RUN/MEMBER_${KMEM}
         else
            cd ${CENTRALDIR}/WRFCHEM_RUN/MEMBER_${KMEM}
         fi
         rm -rf wrfbiochemi_*
         rm -rf wrfchemi_*
         rm -rf wrffirechemi_*
         cp ${CENTRALDIR}/advance_time ./.
         cp ${CENTRALDIR}/input.nml ./.
         if ${USE_HSI}; then
            hsi get wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} : ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${L_YY}${L_MM}${L_DD}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE}.e${CMEM}
         else
            cp ${DATA_DIR}/${EMISSIONS_DIR}/${L_YY}${L_MM}${L_DD}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE}.e${CMEM} wrfbiochemi_d${DOMAIN}_${L_FILE_DATE}
         fi
#
# Copy the wrfchem time dependent chemistry data to $CENTRALDIR/WRFCHEM_RUN for this member
         if ${USE_HSI}; then
            export LL_DATE=${L_DATE}
            while [[ ${LL_DATE} -le ${NEXT_DATE} ]]; do
               export LL_YY=`echo ${LL_DATE} | cut -c1-4`
               export LL_MM=`echo ${LL_DATE} | cut -c5-6`
               export LL_DD=`echo ${LL_DATE} | cut -c7-8`
               export LL_HH=`echo ${LL_DATE} | cut -c9-10`
               export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
               hsi get wrfchemi_d${DOMAIN}_${LL_FILE_DATE} : ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE}.e${CMEM}
               hsi get wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} : ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE}.e${CMEM}
               export LL_DATE=`echo ${LL_DATE} +1h | ./advance_time`
            done
         else
            export LL_DATE=${L_DATE}
            while [[ ${LL_DATE} -le ${NEXT_DATE} ]]; do
               export LL_YY=`echo ${LL_DATE} | cut -c1-4`
               export LL_MM=`echo ${LL_DATE} | cut -c5-6`
               export LL_DD=`echo ${LL_DATE} | cut -c7-8`
               export LL_HH=`echo ${LL_DATE} | cut -c9-10`
               export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
               cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE}.e${CMEM} wrfchemi_d${DOMAIN}_${LL_FILE_DATE}
               cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE}.e${CMEM} wrffirechemi_d${DOMAIN}_${LL_FILE_DATE}
               export LL_DATE=`echo ${LL_DATE} +1h | ./advance_time` 
            done
         fi
         cd ${CENTRALDIR}
#
# APM: END NEW CODE FOR WRFCHEM_RUN_DIR/MEMBER_XXX
#
# Create filter control file
         if [[ -f filter_control_${KMEM} ]]; then rm -rf filter_control_${KMEM}; fi
         touch filter_control_${KMEM} 
         echo ${KMEM} >> filter_control_${KMEM} 
         echo assim_model_state_ic_${KMEM} >> filter_control_${KMEM} 
         echo assim_model_state_ud_${KMEM} >> filter_control_${KMEM}
#
# Create job script 
         if [[ -f job.ksh ]]; then rm -rf job.ksh; fi
         touch job.ksh
         RANDOM=$$
         export JOBRND=advm_$RANDOM
         rm -rf advm*.fout
         rm  -rf advm*.ferr
         cat << EOF >job.ksh
#!/bin/ksh -aeux
#BSUB -P ${PROJ_NUMBER}
#BSUB -x                                    # exclusive use of node (not_shared)
#BSUB -n ${NUM_TASKS}                       # number of total (MPI) tasks
#BSUB -R "span[ptile=${TASKS_PER_NODE}]"    # mpi tasks per node
#BSUB -J ${JOBRND}                          # job name
#BSUB -o ${JOBRND}.fout                      # output filename
#BSUB -e ${JOBRND}.ferr                      # error filename
#BSUB -W ${TIME_LIMIT_WRF}               # wallclock time (minutes)
#BSUB -q ${JOB_CLASS_WRF}
#
./advance_model.ksh 1 1 filter_control_${KMEM} > index_advance_model_${KMEM} 2>&1 

export RC=\$?     
if [[ -f ADV_MODEL_SUCCESS ]]; then rm -rf ADV_MODEL_SUCCESS; fi     
if [[ -f ADV_MODEL_FAILED ]]; then rm -rf ADV_MODEL_FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch ADV_MODEL_SUCCESS
else
   touch ADV_MODEL_FAILED 
fi
EOF
         bsub < job.ksh 
         let IMEM=${IMEM}+1
      done
#
# Wait for advance_model to complete for each member
      ./da_run_hold.ksh ${JOBRND}
#
# APM:Check that all wrfout files exist
         if [[ ! -d ${RUN_DIR}/${L_DATE}/wrfchem_forecast ]]; then
            mkdir -p ${RUN_DIR}/${L_DATE}/wrfchem_forecast
         fi
         if [[ -e ${RUN_DIR}/${L_DATE}/wrfchem_forecast/WARM_COLD_START_FILE ]]; then
            rm -rf ${RUN_DIR}/${L_DATE}/wrfchem_forecast/WARM_COLD_START_FILE
         fi
         touch ${RUN_DIR}/${L_DATE}/wrfchem_forecast/WARM_COLD_START_FILE
#
# APM:Check that all wrfout files exist
      export COLD_START_FLG=0
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
#         cd ${RUN_DIR}/${L_DATE}/dart_filter
         export KMEM=${IMEM}
         export CMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; export CMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; export CMEM=00${IMEM}; fi
         export WRFOUT_FILE_ANL=wrfout_d${DOMAIN}_${L_FILE_DATE} 
         export WRFOUT_FILE_FOR=wrfout_d${DOMAIN}_${NEXT_FILE_DATE} 
         export WRFOUT_FILE_APM=wrfapm_d${DOMAIN}_${NEXT_FILE_DATE} 
         if [[ ! -e ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_ANL} ]]; then
            echo APM: ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_ANL} failed.
            export COLD_START_FLG=1
#            exit
         fi
         if [[ ! -e ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_FOR} ]]; then
            echo APM: ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_FOR} failed.
            export COLD_START_FLG=1
#            exit
         fi
         if [[ ! -e ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_APM} ]]; then
            echo APM: ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_APM} failed.
            export COLD_START_FLG=1
#            exit
         fi
#
# Start of WARM/COLD START CODE
         if [[ ${COLD_START_FLG} -eq 1 ]]; then
            echo APM: WARM START required for member ${KMEM}. >> ${RUN_DIR}/${L_DATE}/wrfchem_forecast/WARM_COLD_START_FILE
#
# Go to advance_temp directory for this member
            cd ${RUN_DIR}/${L_DATE}/cycle
            if [[ ! -e advance_time ]]; then
              cp ${CENTRALDIR}/advance_time ./.
              if [[ ! -e advance_time ]]; then echo APM: cp advance_time failed; exit; fi
            elif [[ ! -e wrf_to_dart ]]; then
              cp ${CENTRALDIR}/wrf_to_dart ./.
              if [[ ! -e wrf_to_dart ]]; then echo APM: cp wrf_to_dart failed; exit; fi
            elif [[ ! -e restart_file_tool ]]; then
              cp ${CENTRALDIR}/WRF_RUN/restart_file_tool ./.
              if [[ ! -e restart_file_tool ]]; then echo APM: cp restart_file_tool failed; exit; fi
            elif [[ ! -e advance_model.ksh ]]; then
              cp ${CENTRALDIR}/WRF_RUN/advance_model.ksh ./.
              if [[ ! -e advance_model.ksh ]]; then echo APM: cp advance_model.ksh failed; exit; fi
            fi
#
# Copy the DART filter posterior analyses
            rm -rf ${CENTRALDIR}/assim_model_state_ic_${KMEM}
            cp ${RUN_DIR}/${L_DATE}/dart_filter/assim_model_state_ic.${KMEM} ${CENTRALDIR}/assim_model_state_ic_${KMEM}
            if [[ ! -e ${CENTRALDIR}/assim_model_state_ic_${KMEM} ]]; then echo APM: cp ${CENTRALDIR}/assim_model_state_ic_${KMEM} failed; exit; fi
#
# Copy past WRFOUT files to $CENTRALDIR/WRF as WRFINPUT file templates
            if [[ ! -e ${CENTRALDIR}/WRF/wrfinput_d${DOMAIN}_*_${KMEM} ]]; then
               if ${USE_HSI}; then
                  hsi get ${CENTRALDIR}/WRF/wrfinput_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM} : ${HSI_SAVE_DIR}/${PAST_DATE}/wrfchem_forecast/wrfout_d${DOMAIN}_${L_FILE_DATE}_${KMEM} 
               else
                  cp ${RUN_DIR}/${PAST_DATE}/wrfchem_forecast/wrfout_d${DOMAIN}_${L_FILE_DATE}_${KMEM} ${CENTRALDIR}/WRF/wrfinput_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM}
               fi
               if [[ ! -e ${CENTRALDIR}/WRF/wrfinput_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM} ]]; then echo APM: cp ${CENTRALDIR}/WRF/wrfinput_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM} failed; exit; fi
            fi
#
# One WRFINPUT file as template to $CENTRALDIR
            rm -rf ${CENTRALDIR}/wrfinput_d${DOMAIN}
            cp ${CENTRALDIR}/WRF/wrfinput_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM} ${CENTRALDIR}/wrfinput_d${DOMAIN}
#
# Copy WRFBDY files to $CENTRALDIR/WRF
            cd ${CENTRALDIR}/WRF
            if [[ ! -e  wrfbdy_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM} ]]; then
               if ${USE_HSI}; then
                  hsi get wrfbdy_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM} : ${HSI_DATA_DIR}/${WPB_RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE}.e${CMEM} 
               else
                  cp ${DATA_DIR}/${WPB_RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE}.e${CMEM} wrfbdy_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM}
               fi
               if [[ ! -e wrfbdy_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM} ]]; then echo APM: cp wrfbdy_d${DOMAIN}_${NEXT_DAY_GREG}_${NEXT_SEC_GREG}_${KMEM} failed; exit; fi
            fi
#
# Copy chem static chemistry data to $CENTRALDIR/WRFCHEM_RUN
            cd ${CENTRALDIR}/WRFCHEM_RUN
            if [[ ! -e ${WRFCHEM_RUN_DIR}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} ]]; then
               if ${USE_HSI}; then
                  hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${L_YY}${L_MM}${L_DD}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} 
               else
                  cp ${DATA_DIR}/${EMISSIONS_DIR}/${L_YY}${L_MM}${L_DD}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
               fi
               if [[ ! -e ${WRFCHEM_RUN_DIR}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} ]]; then echo APM: cp ${WRFCHEM_RUN_DIR}/wrfbiochemi_d${DOMAIN}_${L_FILE_DATE} failed; exit; fi
            fi
#
# Copy the wrfchem time dependent chemistry data to $CENTRALDIR/WRFCHEM_RUN
            cd ${CENTRALDIR}/WRFCHEM_RUN
            rm -rf wrfchemi_d${DOMAIN}*
            rm -rf wrffirechemi_d${DOMAIN}*
            cp ${CENTRALDIR}/advance_time ./.
            cp ${CENTRALDIR}/input.nml ./.
            if ${USE_HSI}; then
               export LL_DATE=${L_DATE}
               while [[ ${LL_DATE} -le ${NEXT_DATE} ]]; do
                  export LL_YY=`echo ${LL_DATE} | cut -c1-4`
                  export LL_MM=`echo ${LL_DATE} | cut -c5-6`
                  export LL_DD=`echo ${LL_DATE} | cut -c7-8`
                  export LL_HH=`echo ${LL_DATE} | cut -c9-10`
                  export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
                  if [[ ! -e ${WRFCHEM_RUN_DIR}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE} ]]; then 
                     hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE}
                     if [[ ! -e ${WRFCHEM_RUN_DIR}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE} ]]; then echo APM: cp wrfchemi_d${DOMAIN}_${LL_FILE_DATE} failed; exit; fi
                  fi
                  if [[ ! -e ${WRFCHEM_RUN_DIR}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} ]]; then
                     hsi get ${HSI_DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE}
                     if [[ ! -e ${WRFCHEM_RUN_DIR}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} ]]; then echo APM: cp wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} failed; exit; fi
                  fi
                  export LL_DATE=`echo ${LL_DATE} +1h | ./advance_time`
               done 
            else
               export LL_DATE=${L_DATE}
               while [[ ${LL_DATE} -le ${NEXT_DATE} ]]; do
                  export LL_YY=`echo ${LL_DATE} | cut -c1-4`
                  export LL_MM=`echo ${LL_DATE} | cut -c5-6`
                  export LL_DD=`echo ${LL_DATE} | cut -c7-8`
                  export LL_HH=`echo ${LL_DATE} | cut -c9-10`
                  export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
                  if [[ ! -e ${WRFCHEM_RUN_DIR}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE} ]]; then 
                     cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
                     if [[ ! -e ${WRFCHEM_RUN_DIR}/wrfchemi_d${DOMAIN}_${LL_FILE_DATE} ]]; then echo APM: cp wrfchemi_d${DOMAIN}_${LL_FILE_DATE} failed; exit; fi
                  fi
                  if [[ ! -e ${WRFCHEM_RUN_DIR}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} ]]; then
                     cp ${DATA_DIR}/${EMISSIONS_DIR}/${LL_YY}${LL_MM}${LL_DD}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} ${WRFCHEM_RUN_DIR}/.
                    if [[ ! -e ${WRFCHEM_RUN_DIR}/wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} ]]; then echo APM: cp wrffirechemi_d${DOMAIN}_${LL_FILE_DATE} failed; exit; fi
                  fi
                  export LL_DATE=`echo ${LL_DATE} +1h | ./advance_time` 
               done
            fi
#
# Generate DART input.nml and WRFCHEM namelist.input files
            cd ${CENTRALDIR}
            rm namelist.input
            rm input.nml
            ${DART_DIR}/models/wrf_chem/namelist_scripts/WRFCHEM/wrfchem_create_namelist.input.ksh
            ${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_input.nml.ksh
#
# Loop for restarting failed member
            let COLD_START_CNT=1
            while [[ ${COLD_START_CNT} -lt ${COLD_START_LIMIT} ]]; do 
#
# Run WRFCHEM
# Generate job script to run advance_model.ksh for each member
#
# Create filter control file
               if [[ -f filter_control_${KMEM} ]]; then rm -rf filter_control_${KMEM}; fi
               touch filter_control_${KMEM} 
               echo ${KMEM} >> filter_control_${KMEM} 
               echo assim_model_state_ic_${KMEM} >> filter_control_${KMEM} 
               echo assim_model_state_ud_${KMEM} >> filter_control_${KMEM}
#
# Create job script 
               if [[ -f job.ksh ]]; then rm -rf job.ksh; fi
               touch job.ksh
               RANDOM=$$
               export JOBRND=advm_$RANDOM
               rm -rf advm*.fout
               rm  -rf advm*.ferr
               cat << EOF >job.ksh
#!/bin/ksh -aeux
#BSUB -P ${PROJ_NUMBER}
#BSUB -x                                    # exclusive use of node (not_shared)
#BSUB -n ${NUM_TASKS}                       # number of total (MPI) tasks
#BSUB -R "span[ptile=${TASKS_PER_NODE}]"    # mpi tasks per node
#BSUB -J ${JOBRND}                          # job name
#BSUB -o ${JOBRND}.fout                      # output filename
#BSUB -e ${JOBRND}.ferr                      # error filename
#BSUB -W ${TIME_LIMIT_WRF}               # wallclock time (minutes)
#BSUB -q ${JOB_CLASS_WRF}
#
./advance_model.ksh 1 1 filter_control_${KMEM} > index_advance_model_${KMEM} 2>&1 

export RC=\$?     
if [[ -f ADV_MODEL_SUCCESS ]]; then rm -rf ADV_MODEL_SUCCESS; fi     
if [[ -f ADV_MODEL_FAILED ]]; then rm -rf ADV_MODEL_FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch ADV_MODEL_SUCCESS
else
   touch ADV_MODEL_FAILED 
fi
EOF
               bsub -K < job.ksh
               export COLD_START_FLG=0 
               export WRFOUT_FILE_ANL=wrfout_d${DOMAIN}_${L_FILE_DATE} 
               export WRFOUT_FILE_FOR=wrfout_d${DOMAIN}_${NEXT_FILE_DATE} 
               export WRFOUT_FILE_APM=wrfapm_d${DOMAIN}_${NEXT_FILE_DATE} 
               echo APM: COLD_START_CNT equals ${COLD_START_CNT}. >> ${RUN_DIR}/${L_DATE}/wrfchem_forecast/WARM_COLD_START_FILE
               if [[ ! -e ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_ANL} ]]; then
                  echo APM: ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_ANL} failed. >> ${RUN_DIR}/${L_DATE}/wrfchem_forecast/WARM_COLD_START_FILE
                  export COLD_START_FLG=1
#                  exit
               fi
               if [[ ! -e ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_FOR} ]]; then
                  echo APM: ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_FOR} failed. >> ${RUN_DIR}/${L_DATE}/wrfchem_forecast/WARM_COLD_START_FILE
                  export COLD_START_FLG=1
#                  exit
               fi
               if [[ ! -e ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_APM} ]]; then
                  echo APM: ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_APM} failed. >> ${RUN_DIR}/${L_DATE}/wrfchem_forecast/WARM_COLD_START_FILE
                  export COLD_START_FLG=1
#                  exit
               fi
               if [[ ${COLD_START_FLG} -eq 0 ]]; then
                  let COLD_START_CNT=${COLD_START_LIMIT}
               else
                  let COLD_START_CNT=${COLD_START_CNT}+1 
               fi
            done
#
# Perform cold start if warm start failed              
            if [[ ${COLD_START_FLG} -eq 1 ]]; then 
#
# WARM_START failed
               echo APM: COLD START required for member ${KMEM}. >> ${RUN_DIR}/${L_DATE}/wrfchem_forecast/WARM_COLD_START_FILE
#
###########################
               exit
###########################
#
# Go to advance_temp directory for this member
               cd ${CENTRALDIR}/advance_temp_${KMEM}
#
# Get WRFINPUT and WRFBDY files and convert to DART format for the COLD START time
               if ${USE_HSI}; then
                  hsi get wrfinput_d${DOMAIN} : ${HSI_DATA_DIR}/${WPB_RC_DIR}/${L_DATE}/wrfinput_d${DOMAIN}_${L_FILE_DATE}.e${CMEM} 
                  hsi get wrfbdy_d${DOMAIN} : ${HSI_DATA_DIR}/${WPB_RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE}.e${CMEM} 
               else
                  cp ${DATA_DIR}/${WPB_RC_DIR}/${L_DATE}/wrfinput_d${DOMAIN}_${L_FILE_DATE}.e${CMEM} wrfinput_d${DOMAIN}
                  cp ${DATA_DIR}/${WPB_RC_DIR}/${L_DATE}/wrfbdy_d${DOMAIN}_${L_FILE_DATE}.e${CMEM} wrfbdy_d${DOMAIN}
               fi
               cp wrfinput_d${DOMAIN} ${CENTRALDIR}/WRF/wrfinput_d${DOMAIN}_${DAY_GREG}_${SEC_GREG}_${KMEM}
               cp wrfbdy_d${DOMAIN} ${CENTRALDIR}/WRF/wrfbdy_d${DOMAIN}_${DAY_GREG}_${SEC_GREG}_${KMEM}
#
# Convert the wrfinput files to DART output format for advance_model
# &wrf_to_dart_nml
               export NL_DART_RESTART_NAME="'assim_model_state_tp_${KMEM}'"
               export NL_PRINT_DATA_RANGES=.false.
#
# &restart_file_tool_nml
               export NL_ENS_SIZE=1
               export NL_INPUT_FILE_NAME="'assim_model_state_tp'"
               export NL_OUTPUT_FILE_NAME="'assim_model_state_ic'"
               export NL_OUTPUT_IS_MODEL_ADVANCE_FILE=.true.
               export NL_OVERWRITE_ADVANCE_TIME=.true.
               export NL_NEW_ADVANCE_DAYS=${NEXT_DAY_GREG}
               export NL_NEW_ADVANCE_SECS=${NEXT_SEC_GREG}
               rm input.nml
               ${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_input.nml.ksh
#
# make run directory for file conversons
               mkdir convert_file_${KMEM} 
               cd convert_file_${KMEM} 
               cp ../input.nml ./.
               cp ../wrfinput_d${DOMAIN} ./.
               cp ../../wrf_to_dart ./.
               cp ../../restart_file_tool ./.
#
# APM: modify for submission to geyser or caldera
# Create job script 
               if [[ -f job.ksh ]]; then rm -rf job.ksh; fi
               touch job.ksh
               RANDOM=$$
               export JOBRND=conv_$RANDOM
               cat << EOF >job.ksh
#!/bin/ksh -aeux
#BSUB -P ${PROJ_NUMBER}
#BSUB -n 1                                  # number of total (MPI) tasks
#BSUB -J ${JOBRND}                          # job name
#BSUB -o ${JOBRND}.out                      # output filename
#BSUB -e ${JOBRND}.err                      # error filename
#BSUB -W 00:10                              # wallclock time (minutes)
#BSUB -q geyser
#
# Run wrf_to_dart
./wrf_to_dart > index_wrf_to_dart 2>&1 
cp assim_model_state_tp_${KMEM} assim_model_state_tp.0001
#
# Run res
./restart_file_tool > index_restart-file_tool 2>&1
rm -rf assim_model_state_tp.0001
mv assim_model_state_ic.0001 assim_model_state_ic_${KMEM}
cp assim_model_state_ic_${KMEM} ${CENTRALDIR}/assim_model_state_ic_${KMEM}
#
export RC=\$?     
if [[ -f CONV_SUCCESS ]]; then rm -rf CONV_SUCCESS; fi     
if [[ -f CONV_FAILED ]]; then rm -rf CONV_FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch CONV_SUCCESS
else
   touch CONV_FAILED 
   exit
fi
EOF
#
# Submit convert file script for each and wait until job completes
               bsub -K < job.ksh 
#
# Check whether DART wrfinput file exist
               if [[ ! -e ${CENTRALDIR}/advance_temp_${KMEM}/convert_file_${KMEM}/assim_model_state_ic_${KMEM} ]]; then
                  echo APM: COLD START conversion ${CENTRALDIR}/advance_temp_${KMEM}/convert_file_${KMEM}/assim_model_state_ic_${KMEM} failed.
                  exit
               fi 
#
# Copy COLD START DART wrfinput file to run directory 
               rm -rf ${CENTRALDIR}/assim_model_state_${KMEM}
               cp ${CENTRALDIR}/advance_temp_${KMEM}/convert_file_${KMEM}/assim_model_state_ic_${KMEM} ${CENTRALDIR}/assim_model_state_ic_${KMEM}
#
# Run WRFCHEM
# Generate job script to run advance_model.ksh for this member
# Create filter control file
               cd ${CENTRALDIR}
               if [[ -f filter_control_${KMEM} ]]; then rm -rf filter_control_${KMEM}; fi
               touch filter_control_${KMEM} 
               echo ${KMEM} >> filter_control_${KMEM} 
               echo assim_model_state_ic_${KMEM} >> filter_control_${KMEM} 
               echo assim_model_state_ud_${KMEM} >> filter_control_${KMEM}
#
# Create job script 
               if [[ -f job.ksh ]]; then rm -rf job.ksh; fi
               touch job.ksh
               RANDOM=$$
               export JOBRND=advm_$RANDOM
               rm -rf advm*.fout
               rm  -rf advm*.ferr
               cat << EOF >job.ksh
#!/bin/ksh -aeux
#BSUB -P ${PROJ_NUMBER}
#BSUB -x                                    # exclusive use of node (not_shared)
#BSUB -n ${NUM_TASKS}                       # number of total (MPI) tasks
#BSUB -R "span[ptile=${TASKS_PER_NODE}]"    # mpi tasks per node
#BSUB -J ${JOBRND}                          # job name
#BSUB -o ${JOBRND}.fout                      # output filename
#BSUB -e ${JOBRND}.ferr                      # error filename
#BSUB -W ${TIME_LIMIT_WRF}               # wallclock time (minutes)
#BSUB -q ${JOB_CLASS_WRF}
#
./advance_model.ksh 1 1 filter_control_${KMEM} > index_advance_model_${KMEM} 2>&1 

export RC=\$?     
if [[ -f ADV_MODEL_SUCCESS ]]; then rm -rf ADV_MODEL_SUCCESS; fi     
if [[ -f ADV_MODEL_FAILED ]]; then rm -rf ADV_MODEL_FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch ADV_MODEL_SUCCESS
else
   touch ADV_MODEL_FAILED 
fi
EOF
               bsub -K < job.ksh
#
# Check whether wrfout files exist               
               export WRFOUT_FILE_ANL=wrfout_d${DOMAIN}_${L_FILE_DATE} 
               export WRFOUT_FILE_FOR=wrfout_d${DOMAIN}_${NEXT_FILE_DATE} 
               export WRFOUT_FILE_APM=wrfapm_d${DOMAIN}_${NEXT_FILE_DATE} 
               if [[ ! -e ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_ANL} ]]; then
                  echo APM: ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_ANL} COLD START failed.
                  exit
               fi
               if [[ ! -e ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_FOR} ]]; then
                  echo APM: ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_FOR} COLD START failed.
                  exit
               fi
               if [[ ! -e ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_APM} ]]; then
                  echo APM: ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_APM} COLD_START failed.
                  exit
               fi
               export COLD_START_FLG=0
            fi
         fi
# End of COLD START CODE
#
         echo " " >> WARM_COLD_START_FILE
         let IMEM=${IMEM}+1
      done
#
# Save WRFCHEM forecasts to archive directory
      if [[ ! -d ${RUN_DIR}/${L_DATE}/wrfchem_forecast ]]; then
         mkdir -p ${RUN_DIR}/${L_DATE}/wrfchem_forecast
         cd ${RUN_DIR}/${L_DATE}/wrfchem_forecast
      else
         cd ${RUN_DIR}/${L_DATE}/wrfchem_forecast
      fi
      let IMEM=1
      while [[ ${IMEM} -le ${NUM_MEMBERS} ]]; do
         export KMEM=${IMEM}
         if [[ ${IMEM} -lt 1000 ]]; then export KMEM=0${IMEM}; fi
         if [[ ${IMEM} -lt 100 ]]; then export KMEM=00${IMEM}; fi
         if [[ ${IMEM} -lt 10 ]]; then export KMEM=000${IMEM}; fi
         export WRFOUT_FILE_ANL=wrfout_d${DOMAIN}_${L_FILE_DATE} 
         export WRFOUT_FILE_FOR=wrfout_d${DOMAIN}_${NEXT_FILE_DATE} 
         export WRFOUT_FILE_APM=wrfapm_d${DOMAIN}_${NEXT_FILE_DATE} 
         cp ${CENTRALDIR}/advance_temp_${KMEM}/wrfinput_d${DOMAIN} wrfinput_d${DOMAIN}_${KMEM}
         cp ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_ANL} ${WRFOUT_FILE_ANL}_${KMEM}
         cp ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_FOR} ${WRFOUT_FILE_FOR}_${KMEM}
         cp ${CENTRALDIR}/advance_temp_${KMEM}/${WRFOUT_FILE_APM} ${WRFOUT_FILE_APM}_${KMEM}
         let IMEM=${IMEM}+1
      done
      cp ${CENTRALDIR}/advance_temp_0001/namelist.input ./.
   fi
   echo COMPLETED RUN_WRFCHEM CODE BLOCK
#
########################################################################
#
# RUN_ARCHIVE CODE BLOCK
#
########################################################################
   echo BEGIN RUN_ARCHIVE CODE BLOCK
   if [[ ${RUN_WARM} == true && ${WARM_ARCHIVE} == true && ${RUN_ARCHIVE} == true ]]; then
      export WARM_PERFECT_MODEL=true
      export WARM_FILTER=true
      export WARM_WRFCHEM=true
      export WARM_ARCHIVE=true
#
      rm -rf ${RUN_DIR}/${L_DATE}/cycle
      cd ${RUN_DIR}/${L_DATE}/dart_filter
      rm -rf advance_time
      rm -rf filter
      rm -rf restart_file_tool
      rm -rf wrf_to_dart
      rm -rf dart_log.nml
      rm -rf dart_log.out
      rm -rf filt_*.jerr
      rm -rf filt_*.jout
      rm -rf job.ksh
      cd ..
      hsi "cd ${HSI_DATA_DIR}/${L_DATE}; put -R dart_filter"
      hsi "cd ${HSI_DATA_DIR}/${L_DATE}; put -R wrfchem_forecast"
   fi
   echo COMPLETED RUN_ARCHIVE CODE BLOCK
   export L_DATE=${NEXT_DATE}
done  
exit
