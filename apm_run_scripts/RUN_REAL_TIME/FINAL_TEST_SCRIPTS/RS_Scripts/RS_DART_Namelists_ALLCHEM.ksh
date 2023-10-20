#!/bin/ksh -aux
#
# DART input.nml parameters
# &filter.nml
   export NL_COMPUTE_POSTERIOR=.true.
   export NL_INPUT_QC_THRESHOLD=3.
   export NL_OUTLIER_THRESHOLD=3.
   export NL_ENABLE_SPECIAL_OUTLIER_CODE=.true.
   export NL_SPECIAL_OUTLIER_THRESHOLD=4.
   export NL_ENS_SIZE=${NUM_MEMBERS}
   export NL_OUTPUT_RESTART=.true.
   export NL_START_FROM_RESTART=.true.
   export NL_OBS_SEQUENCE_IN_NAME="'obs_seq.out'"       
   export NL_OBS_SEQUENCE_OUT_NAME="'obs_seq.final'"
   export NL_RESTART_IN_FILE_NAME="'filter_ic_old'"       
   export NL_RESTART_OUT_FILE_NAME="'filter_ic_new'"       
   set -A temp `echo ${ASIM_MIN_DATE} 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
   (( temp[1]=${temp[1]}+1 ))
   export NL_FIRST_OBS_DAYS=${temp[0]}
   export NL_FIRST_OBS_SECONDS=${temp[1]}
   set -A temp `echo ${ASIM_MAX_DATE} 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
   export NL_LAST_OBS_DAYS=${temp[0]}
   export NL_LAST_OBS_SECONDS=${temp[1]}
   export NL_NUM_OUTPUT_STATE_MEMBERS=0
   export NL_NUM_OUTPUT_OBS_MEMBERS=${NUM_MEMBERS}
   if ${USE_DART_INFL}; then
      export NL_INF_FLAVOR_POST=4
   else 
      export NL_INF_FLAVOR_POST=0
   fi
   export NL_INF_FLAVOR_PRIOR=0  
   if [[ ${START_DATE} -eq ${FIRST_DART_INFLATE_DATE} ]]; then
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
   export NL_INF_SD_INITIAL_POST=0.6
   export NL_INF_DAMPING_PRIOR=0.9
   export NL_INF_DAMPING_POST=0.9
   export NL_INF_LOWER_BOUND_PRIOR=1.0
   export NL_INF_LOWER_BOUND_POST=1.0
   export NL_INF_UPPER_BOUND_PRIOR=100.0
   export NL_INF_UPPER_BOUND_POST=100.0
   export NL_INF_SD_LOWER_BOUND_PRIOR=0.6
   export NL_INF_SD_LOWER_BOUND_POST=0.6
#
# APM: NEED TO ADD NEW CHEMISTRY OBSERVATIONS HERE AND TO VERTICAL LOCALIZATION
# CUTOFF VALUES
#   CO      0.1
#   O3      0.05 
#   NO2     0.05
#   SO2     1.0
#   PM10    0.05
#   PM25    0.05
#   AOD     0.05
#   CO2     0.1
#   NH3     0.1
#   CH4     0.1
#   HNO3    0.1
#   HCHO    0.1
#   PAN     0.1
#   MET SFC 0.05
# &assim_tools_nml
   export NL_CUTOFF=0.1
   export NL_SPECIAL_LOCALIZATION_OBS_TYPES="'MOPITT_CO_TOTAL_COL','MOPITT_CO_PROFILE','MOPITT_CO_CPSR','IASI_CO_TOTAL_COL','IASI_CO_PROFILE','IASI_CO_CPSR','TROPOMI_CO_TOTAL_COL','AIRNOW_CO','IASI_O3_PROFILE','IASI_O3_CPSR','OMI_O3_TOTAL_COL','OMI_O3_TROP_COL','OMI_O3_PROFILE','OMI_O3_CPSR','TROPOMI_O3_TOTAL_COL','TROPOMI_O3_TROP_COL','TROPOMI_O3_PROFILE','TROPOMI_O3_CPSR','TEMPO_O3_TOTAL_COL','TEMPO_O3_TROP_COL','TEMPO_O3_PROFILE','TEMPO_O3_CPSR','AIRNOW_O3','OMI_NO2_TOTAL_COL','OMI_NO2_TROP_COL','TROPOMI_NO2_TOTAL_COL','TROPOMI_NO2_TROP_COL','TEMPO_NO2_TOTAL_COL','TEMPO_NO2_TROP_COL','AIRNOW_NO2','OMI_SO2_TOTAL_COL','OMI_SO2_PBL_COL','TROPOMI_SO2_TOTAL_COL','TROPOMI_SO2_PBL_COL','AIRNOW_SO2','MODIS_AOD_TOTAL_COL','AIRNOW_PM10','AIRNOW_PM25','LAND_SFC_U_WIND_COMPONENT','LAND_SFC_V_WIND_COMPONENT','LAND_SFC_SPECIFIC_HUMIDITY'"
   export NL_SPECIAL_LOCALIZATION_CUTOFFS=0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.1,0.1,0.1,0.1,0.1,0.05,0.05,0.05,0.05,0.05,0.05
   export NL_SAMPLING_ERROR_CORRECTION=.true.
   export NL_ADAPTIVE_LOCALIZATION_THRESHOLD=2000
#
# &ensemble_manager_nml
   export NL_SINGLE_RESTART_FILE_IN=.false.       
   export NL_SINGLE_RESTART_FILE_OUT=.false.       
#
# &assim_model_nml
   export NL_WRITE_BINARY_RESTART_FILE=.true.
#
# &model_nml
   export NL_ADD_EMISS=.${L_ADD_EMISS}.
   export NL_DEFAULT_STATE_VARIABLES=.false.
   export NL_CONV_STATE_VARIABLES="'U',     'QTY_U_WIND_COMPONENT',     'TYPE_U',  'UPDATE','999',
          'V',     'QTY_V_WIND_COMPONENT',     'TYPE_V',  'UPDATE','999',
          'W',     'QTY_VERTICAL_VELOCITY',    'TYPE_W',  'UPDATE','999',
          'PH',    'QTY_GEOPOTENTIAL_HEIGHT',  'TYPE_GZ', 'UPDATE','999',
          'T',     'QTY_POTENTIAL_TEMPERATURE','TYPE_T',  'UPDATE','999',
          'MU',    'QTY_PRESSURE',             'TYPE_MU', 'UPDATE','999',
          'QVAPOR','QTY_VAPOR_MIXING_RATIO',   'TYPE_QV', 'UPDATE','999',
          'QRAIN', 'QTY_RAINWATER_MIXING_RATIO','TYPE_QRAIN', 'UPDATE','999',
          'QCLOUD','QTY_CLOUD_LIQUID_WATER',   'TYPE_QCLOUD', 'UPDATE','999',
          'QSNOW', 'QTY_SNOW_MIXING_RATIO',    'TYPE_QSNOW', 'UPDATE','999',
          'QICE',  'QTY_CLOUD_ICE',            'TYPE_QICE', 'UPDATE','999',
          'U10',   'QTY_U_WIND_COMPONENT',     'TYPE_U10','UPDATE','999',
          'V10',   'QTY_V_WIND_COMPONENT',     'TYPE_V10','UPDATE','999',
          'T2',    'QTY_TEMPERATURE',          'TYPE_T2', 'UPDATE','999',
          'TH2',   'QTY_POTENTIAL_TEMPERATURE','TYPE_TH2','UPDATE','999',
          'Q2',    'QTY_SPECIFIC_HUMIDITY',    'TYPE_Q2', 'UPDATE','999',
          'PSFC',  'QTY_PRESSURE',             'TYPE_PS', 'UPDATE','999',
          'co',    'QTY_CO',                   'TYPE_CO', 'UPDATE','999',
          'o3',    'QTY_O3',                   'TYPE_O3', 'UPDATE','999',
          'no',    'QTY_NO',                   'TYPE_NO', 'UPDATE','999',
          'no2',   'QTY_NO2',                  'TYPE_NO2', 'UPDATE','999',
          'so2',   'QTY_SO2',                  'TYPE_SO2', 'UPDATE','999',
          'sulf',  'QTY_SO4',                  'TYPE_SO4', 'UPDATE','999',
          'hno4',  'QTY_HNO4',                 'TYPE_HNO4', 'UPDATE','999',
          'n2o5',  'QTY_N2O5',                 'TYPE_N2O5', 'UPDATE','999',
          'c2h6',  'QTY_C2H6',                 'TYPE_C2H6', 'UPDATE','999',
          'acet',  'QTY_ACET',                 'TYPE_ACET', 'UPDATE','999',
          'c2h4',  'QTY_C2H4',                 'TYPE_C2H4', 'UPDATE','999',
          'c3h6',  'QTY_C3H6',                 'TYPE_C3H6', 'UPDATE','999',
          'tol',   'QTY_TOL',                  'TYPE_TOL', 'UPDATE','999',
          'mvk',   'QTY_MVK',                  'TYPE_MVK', 'UPDATE','999',
          'bigalk','QTY_BIGALK',               'TYPE_BIGALK', 'UPDATE','999',
          'isopr', 'QTY_ISOPR',                'TYPE_ISOPR', 'UPDATE','999',
          'macr',  'QTY_MACR',                 'TYPE_MACR', 'UPDATE','999',
          'c3h8',  'QTY_C3H8',                 'TYPE_C3H8', 'UPDATE','999',
          'c10h16','QTY_C10H16',               'TYPE_C10H16', 'UPDATE','999',
          'DUST_1','QTY_DST01',                'TYPE_DST01','UPDATE','999',
          'DUST_2','QTY_DST02',                'TYPE_DST02','UPDATE','999',
          'DUST_3','QTY_DST03',                'TYPE_DST03','UPDATE','999',
          'DUST_4','QTY_DST04',                'TYPE_DST04','UPDATE','999',
          'DUST_5','QTY_DST05',                'TYPE_DST05','UPDATE','999',
          'BC1','QTY_BC1',                     'TYPE_BC1','UPDATE','999',
          'BC2','QTY_BC2',                     'TYPE_BC2','UPDATE','999',
          'OC1','QTY_OC1',                     'TYPE_OC1','UPDATE','999',
          'OC2','QTY_OC2',                     'TYPE_OC2','UPDATE','999',
          'TAUAER1','QTY_TAUAER1',             'TYPE_EXTCOF','UPDATE','999',
          'TAUAER2','QTY_TAUAER2',             'TYPE_EXTCOF','UPDATE','999',
          'TAUAER3','QTY_TAUAER3',             'TYPE_EXTCOF','UPDATE','999',
          'TAUAER4','QTY_TAUAER4',             'TYPE_EXTCOF','UPDATE','999',
          'PM10','QTY_PM10',                   'TYPE_PM10','UPDATE','999',
          'P10','QTY_P10',                     'TYPE_P10','UPDATE','999',
          'P25','QTY_P25',                     'TYPE_P25','UPDATE','999',
          'SEAS_1','QTY_SSLT01',               'TYPE_SSLT01','UPDATE','999',
          'SEAS_2','QTY_SSLT02',               'TYPE_SSLT02','UPDATE','999',
          'SEAS_3','QTY_SSLT03',               'TYPE_SSLT03','UPDATE','999',
          'SEAS_4','QTY_SSLT04',               'TYPE_SSLT04','UPDATE','999',
          'hcho',  'QTY_HCHO',                 'TYPE_HCHO', 'UPDATE','999',
          'hno3',  'QTY_HNO3',                 'TYPE_HNO3', 'UPDATE','999',
          'nh3',   'QTY_NH3',                  'TYPE_NH3', 'UPDATE','999',
          'pan',   'QTY_PAN',                  'TYPE_PAN', 'UPDATE','999',
          'ch4',   'QTY_CH4',                  'TYPE_CH4', 'UPDATE','999'"
#
# Both of these need kind and type definitions.
# Also need to modify the WRF-Chem model_mod.f90 to
# add get_type_ind_from_type_string statements   
#
# The next line should be the same as NL_EMISS_CHEMI_VARIABLES without quotes etc.
   export WRFCHEMI_DARTVARS="E_CO,E_NO,E_NO2,E_SO2,E_BC,E_OC,E_PM_10,E_PM_25"
#
# The next line should be the same as NL_EMISS_FIRECHEMI_VARIABLES without quotes etc.
   export WRFFIRECHEMI_DARTVARS="ebu_in_co,ebu_in_no,ebu_in_no2,ebu_in_so2,ebu_in_oc,ebu_in_bc,ebu_in_c2h4,ebu_in_ch2o,ebu_in_ch3oh"
#
   export NL_EMISS_CHEMI_VARIABLES="'E_CO',    'QTY_E_CO',    'TYPE_E_CO',     'UPDATE','999',
          'E_NO'        ,'QTY_E_NO',           'TYPE_E_NO',   'UPDATE','999',
          'E_NO2'       ,'QTY_E_NO2',          'TYPE_E_NO2',  'UPDATE','999',
          'E_SO2'       ,'QTY_E_SO2',          'TYPE_E_SO2',  'UPDATE','999',
          'E_OC'        ,'QTY_E_OC',           'TYPE_E_OC',   'UPDATE','999',
          'E_BC'        ,'QTY_E_BC',           'TYPE_E_BC',   'UPDATE','999',
          'E_PM_10'     ,'QTY_E_PM10',         'TYPE_E_PM10', 'UPDATE','999',
          'E_PM_25'     ,'QTY_E_PM25',         'TYPE_E_PM25', 'UPDATE','999'"
   export NL_EMISS_FIRECHEMI_VARIABLES="'ebu_in_co'   ,'QTY_EBU_CO',         'TYPE_EBU_CO',  'UPDATE','999',
          'ebu_in_no'    ,'QTY_EBU_NO',         'TYPE_EBU_NO',   'UPDATE','999',
          'ebu_in_no2'   ,'QTY_EBU_NO2',        'TYPE_EBU_NO2',  'UPDATE','999',
          'ebu_in_so2'   ,'QTY_EBU_SO2',        'TYPE_EBU_SO2',  'UPDATE','999',
          'ebu_in_oc'    ,'QTY_EBU_OC',         'TYPE_EBU_OC',   'UPDATE','999',
          'ebu_in_bc'    ,'QTY_EBU_BC',         'TYPE_EBU_BC',   'UPDATE','999',
          'ebu_in_c2h4'  ,'QTY_EBU_C2H4',       'TYPE_EBU_C2H4', 'UPDATE','999',
          'ebu_in_ch2o'  ,'QTY_EBU_CH2O',       'TYPE_EBU_CH2O', 'UPDATE','999',
          'ebu_in_ch3oh' ,'QTY_EBU_CH3OH',      'TYPE_EBU_CH3OH','UPDATE','999'"
   export NL_WRF_STATE_BOUNDS="'QVAPOR','0.0','NULL','CLAMP',
          'QRAIN', '0.0','NULL','CLAMP',
          'QCLOUD','0.0','NULL','CLAMP',
          'QSNOW', '0.0','NULL','CLAMP',
          'QICE',  '0.0','NULL','CLAMP',
          'co',    '${CO_MIN}','${CO_MAX}','CLAMP',
          'o3',    '${O3_MIN}','${O3_MAX}','CLAMP',
          'no',    '${NO_MIN}','${NO_MAX}','CLAMP',
          'no2',   '${NO2_MIN}','${NO2_MAX}','CLAMP',
          'so2',   '${SO2_MIN}','${SO2_MAX}','CLAMP',
          'sulf',  '${SO4_MIN}','${SO4_MAX}','CLAMP',
          'hno4',  '0.0','NULL','CLAMP',
          'n2o5',  '0.0','NULL','CLAMP',
          'c2h6',  '0.0','NULL','CLAMP',
          'acet'   '0.0','NULL','CLAMP',
          'c2h4',  '0.0','NULL','CLAMP',
          'c3h6',  '0.0','NULL','CLAMP',
          'tol',   '0.0','NULL','CLAMP',
          'mvk',   '0.0','NULL','CLAMP',
          'bigalk','0.0','NULL','CLAMP',
          'isopr', '0.0','NULL','CLAMP',
          'macr',  '0.0','NULL','CLAMP',
          'c3h8'  ,'0.0','NULL','CLAMP',    
          'c10h16','0.0','NULL','CLAMP',
          'DUST_1','0.0','NULL','CLAMP',
          'DUST_2','0.0','NULL','CLAMP',
          'DUST_3','0.0','NULL','CLAMP',
          'DUST_4','0.0','NULL','CLAMP',
          'DUST_5','0.0','NULL','CLAMP',
          'BC1','0.0','NULL','CLAMP',
          'BC2','0.0','NULL','CLAMP',
          'OC1','0.0','NULL','CLAMP',
          'OC2','0.0','NULL','CLAMP',
          'TAUAER1','0.0','NULL','CLAMP',
          'TAUAER2','0.0','NULL','CLAMP',
          'TAUAER3','0.0','NULL','CLAMP',
          'TAUAER4','0.0','NULL','CLAMP',
          'PM10','0.0','NULL','CLAMP',
          'P10','0.0','NULL','CLAMP',
          'P25','0.0','NULL','CLAMP',
          'SEAS_1','0.0','NULL','CLAMP',
          'SEAS_2','0.0','NULL','CLAMP',
          'SEAS_3','0.0','NULL','CLAMP',
          'SEAS_4','0.0','NULL','CLAMP',
          'hcho'   '0.0','NULL','CLAMP',
          'hno3',  '0.0','NULL','CLAMP',
          'nh3',   '0.0','NULL','CLAMP',
          'pan',   '0.0','NULL','CLAMP',
          'ch4',   '0.0','NULL','CLAMP',
          'E_CO','0.0','NULL','CLAMP',
          'E_NO','0.0','NULL','CLAMP',
          'E_NO2','0.0','NULL','CLAMP',
          'E_SO2','0.0','NULL','CLAMP',
          'E_OC','0.0','NULL','CLAMP',
          'E_BC','0.0','NULL','CLAMP',
          'E_PM_10','0.0','NULL','CLAMP',
          'E_PM_25','0.0','NULL','CLAMP',
          'ebu_in_co','0.0','NULL','CLAMP',
          'ebu_in_no','0.0','NULL','CLAMP',
          'ebu_in_no2','0.0','NULL','CLAMP',
          'ebu_in_so2','0.0','NULL','CLAMP',
          'ebu_in_oc','0.0','NULL','CLAMP',
          'ebu_in_bc','0.0','NULL','CLAMP',
          'ebu_in_c2h4','0.0','NULL','CLAMP',
          'ebu_in_ch2o','0.0','NULL','CLAMP',
          'ebu_in_ch3oh','0.0','NULL','CLAMP'"
   export NL_OUTPUT_STATE_VECTOR=.false.
   export NL_NUM_DOMAINS=${CR_DOMAIN}
   export NL_CALENDAR_TYPE=3
   export NL_ASSIMILATION_PERIOD_SECONDS=${CYCLE_PERIOD_SEC}
# height
#   export NL_VERT_LOCALIZATION_COORD=3
# scale height
   export NL_VERT_LOCALIZATION_COORD=4
   export NL_CENTER_SEARCH_HALF_LENGTH=500000.
   export NL_CENTER_SPLINE_GRID_SCALE=10
   export NL_SFC_ELEV_MAX_DIFF=100.0
   export NL_CIRCULATION_PRES_LEVEL=80000.0
   export NL_CIRCULATION_RADIUS=108000.0
   export NL_ALLOW_OBS_BELOW_VOL=.false.
#
# &obs_diag_nml
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
   export NL_NEW_ADVANCE_DAYS=${NEXT_DAY_GREG}
   export NL_NEW_ADVANCE_SECS=${NEXT_SEC_GREG}
   export NL_OUTPUT_IS_MODEL_ADVANCE_FILE=.true.
   export NL_OVERWRITE_ADVANCE_TIME=.false.
#
# &preprocess_nml
   export NL_INPUT_OBS_KIND_MOD_FILE=\'${DART_DIR}/assimilation_code/modules/observations/DEFAULT_obs_kind_mod.F90\'
   export NL_OUTPUT_OBS_KIND_MOD_FILE=\'${DART_DIR}/assimilation_code/modules/observations/obs_kind_mod.f90\'
   export NL_INPUT_OBS_DEF_MOD_FILE=\'${DART_DIR}/observations/forward_operators/DEFAULT_obs_def_mod.F90\'
   export NL_OUTPUT_OBS_DEF_MOD_FILE=\'${DART_DIR}/observations/forward_operators/obs_def_mod.f90\'
   export NL_INPUT_FILES="'${DART_DIR}/observations/forward_operators/obs_def_reanalysis_bufr_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_upper_atm_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_radar_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_metar_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_dew_point_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_altimeter_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_gps_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_gts_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_vortex_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_AIRNOW_OBS_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_AIRNOW_PM10_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_AIRNOW_PM25_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_PANDA_OBS_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MOPITT_CO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MOPITT_CO_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MOPITT_V5_CO_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MOPITT_CO_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_IASI_CO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_IASI_CO_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_IASI_CO_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_IASI_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_IASI_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MODIS_AOD_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_O3_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_NO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_NO2_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_NO2_DOMINO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_NO2_DOMINO_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_SO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_SO2_PBL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_HCHO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_HCHO_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_CO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_O3_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_NO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_NO2_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_SO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_SO2_PBL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_CH4_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_CH4_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_CH4_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_CH4_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_HCHO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_HCHO_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_O3_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_NO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_NO2_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO2_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO2_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_NH3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_NH3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_NH3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CH4_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CH4_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CH4_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO2_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO2_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_NH3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_NH3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_NH3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CH4_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CH4_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CH4_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_SCIAM_NO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_SCIAM_NO2_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_GOME2A_NO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_GOME2A_NO2_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MLS_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MLS_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MLS_HNO3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MLS_HNO3_PROFILE_mod.f90'"
#
# &obs_kind_nml
   export NL_EVALUATE_THESE_OBS_TYPES=" "
#
   export NL_ASSIMILATE_THESE_OBS_TYPES="'RADIOSONDE_TEMPERATURE',
                                   'RADIOSONDE_U_WIND_COMPONENT',
                                   'RADIOSONDE_V_WIND_COMPONENT',
                                   'RADIOSONDE_SPECIFIC_HUMIDITY',
                                   'RADIOSONDE_SURFACE_ALTIMETER',
                                   'MARINE_SFC_U_WIND_COMPONENT',
                                   'MARINE_SFC_V_WIND_COMPONENT',
                                   'MARINE_SFC_TEMPERATURE',
                                   'MARINE_SFC_SPECIFIC_HUMIDITY',
                                   'MARINE_SFC_ALTIMETER',
                                   'AIRCRAFT_U_WIND_COMPONENT',
                                   'AIRCRAFT_V_WIND_COMPONENT',
                                   'AIRCRAFT_TEMPERATURE',
                                   'ACARS_U_WIND_COMPONENT',
                                   'ACARS_V_WIND_COMPONENT',
                                   'ACARS_TEMPERATURE',
                                   'LAND_SFC_U_WIND_COMPONENT',
                                   'LAND_SFC_V_WIND_COMPONENT',
                                   'LAND_SFC_TEMPERATURE',
                                   'LAND_SFC_SPECIFIC_HUMIDITY',
                                   'LAND_SFC_ALTIMETER',
                                   'SAT_U_WIND_COMPONENT',
                                   'SAT_V_WIND_COMPONENT',
                                   'MOPITT_CO_PROFILE',
                                   'MOPITT_CO_CPSR',
                                   'IASI_CO_PROFILE',
                                   'IASI_CO_CPSR',
                                   'IASI_O3_PROFILE',
                                   'IASI_O3_CPSR',
                                   'MODIS_AOD_TOTAL_COL'
                                   'OMI_O3_PROFILE',
                                   'OMI_O3_CPSR',
                                   'OMI_NO2_TROP_COL',
                                   'OMI_NO2_DOMINO_TROP_COL',
                                   'OMI_SO2_PBL_COL',
                                   'OMI_HCHO_TOTAL_COL',
                                   'TROPOMI_CO_TOTAL_COL',
                                   'TROPOMI_O3_PROFILE',
                                   'TROPOMI_O3_CPSR',
                                   'TROPOMI_NO2_TROP_COL',
                                   'TROPOMI_SO2_PBL_COL',
                                   'TROPOMI_CH4_TOTAL_COL',
                                   'TROPOMI_HCHO_TOTAL_COL',
                                   'TES_CO_PROFILE',
                                   'TES_CO_CPSR',
                                   'TES_CO2_PROFILE',
                                   'TES_CO2_CPSR',
                                   'TES_O3_PROFILE',
                                   'TES_O3_CPSR',
                                   'TES_NH3_PROFILE',
                                   'TES_NH3_CPSR',
                                   'TES_CH4_PROFILE',
                                   'TES_CH4_CPSR',
                                   'CRIS_CO_PROFILE',
                                   'CRIS_CO_CPSR',
                                   'CRIS_O3_PROFILE',
                                   'CRIS_O3_CPSR',
                                   'CRIS_NH3_PROFILE',
                                   'CRIS_NH3_CPSR',
                                   'CRIS_CH4_PROFILE',
                                   'CRIS_CH4_CPSR',
                                   'CRIS_PAN_TOTAL_COL',
                                   'SCIAM_NO2_TROP_COL',
                                   'GOME2A_NO2_TROP_COL',
                                   'MLS_O3_PROFILE',
                                   'MLS_O3_CPSR',
                                   'MLS_HNO3_PROFILE',
                                   'MLS_HNO3_CPSR',
                                   'AIRNOW_CO',
                                   'AIRNOW_O3',
                                   'AIRNOW_NO2',
                                   'AIRNOW_SO2',
                                   'AIRNOW_PM10',
                                   'AIRNOW_PM25'"
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
# APM: NEED TO ADD NEW CHEMISTRY OBSERVATIONS HERE AND HORIZONTAL LOCALIZATION  
   
# &location_nml
   export NL_HORIZ_DIST_ONLY=.false.
   export NL_VERT_NORMALIZATION_PRESSURE=100000.0
   export NL_VERT_NORMALIZATION_HEIGHT=10000.0
   export NL_VERT_NORMALIZATION_LEVELS=20.0
   export NL_VERT_NORMALIZATION_SCALE_HEIGHT=1.5
   export NL_SPECIAL_VERT_NORMALIZATION_OBS_TYPES="'MOPITT_CO_TOTAL_COL','MOPITT_CO_PROFILE','MOPITT_CO_CPSR','IASI_CO_TOTAL_COL','IASI_CO_PROFILE','IASI_CO_CPSR','TROPOMI_CO_TOTAL_COL','TES_CO_TOTAL_COL','TES_CO_TROP_COL','TES_CO_PROFILE','TES_CO_CPSR','CRIS_CO_TOTAL_COL','CRIS_CO_PROFILE','CRIS_CO_CPSR','AIRNOW_CO','TES_CO2_TOTAL_COL','TES_CO2_TROP_COL','TES_CO2_PROFILE','TES_CO2_CPSR','IASI_O3_PROFILE','IASI_O3_CPSR','OMI_O3_TOTAL_COL','OMI_O3_TROP_COL','OMI_O3_PROFILE','OMI_O3_CPSR','TROPOMI_O3_TOTAL_COL','TROPOMI_O3_TROP_COL','TROPOMI_O3_PROFILE','TROPOMI_O3_CPSR','TEMPO_O3_TOTAL_COL','TEMPO_O3_TROP_COL','TEMPO_O3_PROFILE','TEMPO_O3_CPSR','TES_O3_TOTAL_COL','TES_O3_TROP_COL','TES_O3_PROFILE','TES_O3_CPSR','CRIS_O3_TOTAL_COL','CRIS_O3_PROFILE','CRIS_O3_CPSR','MLS_O3_TOTAL_COL','MLS_O3_PROFILE','MLS_O3_CPSR','AIRNOW_O3','OMI_NO2_TOTAL_COL','OMI_NO2_TROP_COL','TROPOMI_NO2_TOTAL_COL','TROPOMI_NO2_TROP_COL','TEMPO_NO2_TOTAL_COL','TEMPO_NO2_TROP_COL','OMI_NO2_DOMINO_TOTAL_COL','OMI_NO2_DOMINO_TROP_COL','SCIAM_NO2_TOTAL_COL','SCIAM_NO2_TROP_COL','GOME2A_NO2_TOTAL_COL','GOME2A_NO2_TROP_COL','AIRNOW_NO2','OMI_SO2_TOTAL_COL','OMI_SO2_PBL_COL','TROPOMI_SO2_TOTAL_COL','TROPOMI_SO2_PBL_COL','AIRNOW_SO2','MODIS_AOD_TOTAL_COL','AIRNOW_PM10','AIRNOW_PM25','MLS_HNO3_TOTAL_COL','MLS_HNO3_PROFILE','MLS_HNO3_CPSR','OMI_HCHO_TOTAL_COL','OMI_HCHO_TROP_COL','TROPOMI_HCHO_TOTAL_COL','TROPOMI_HCHO_TROP_COL','TROPOMI_CH4_TOTAL_COL','TROPOMI_CH4_TROP_COL','TROPOMI_CH4_PROFILE','TROPOMI_CH4_CPSR','TES_CH4_TOTAL_COL','TES_CH4_TROP_COL','TES_CH4_PROFILE','TES_CH4_CPSR','CRIS_CH4_TOTAL_COL','CRIS_CH4_PROFILE','CRIS_CH4_CPSR','TES_NH3_TOTAL_COL','TES_NH3_TROP_COL','TES_NH3_PROFILE','TES_NH3_CPSR','CRIS_NH3_TOTAL_COL','CRIS_NH3_PROFILE','CRIS_NH3_CPSR','CRIS_PAN_TOTAL_COL','CRIS_PAN_PROFILE','CRIS_PAN_CPSR','LAND_SFC_U_WIND_COMPONENT','LAND_SFC_V_WIND_COMPONENT','LAND_SFC_SPECIFIC_HUMIDITY'"
   export NL_SPECIAL_VERT_NORMALIZATION_PRESSURES="100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0"
   export NL_SPECIAL_VERT_NORMALIZATION_HEIGHTS="10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0"
   export NL_SPECIAL_VERT_NORMALIZATION_LEVELS="20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0"
   export NL_SPECIAL_VERT_NORMALIZATION_SCALE_HEIGHTS="1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5"
#
# &obs_impact_tool_nml 
   export NL_IMPACT_TOOL_INPUT="'variable_localization.txt'"
   export NL_IMPACT_TOOL_OUTPUT="'control_impact_runtime.txt'"
   export NL_DART_DEBUG=.false.
