#!/bin/ksh -aux
#      cd ${RUN_DIR}/${DATE}/combine_obs
#
# GET EXECUTABLES
      cp ${WRFCHEM_DART_WORK_DIR}/obs_sequence_tool ./.
      export NUM_FILES=0
#
# GET OBS_SEQ FILES TO COMBINE
# MET OBS
      if [[ -s ${PREPBUFR_MET_OBS_DIR}/obs_seq_prep_${DATE}.out && ${RUN_MET_OBS} == true ]]; then 
         (( NUM_FILES=${NUM_FILES}+1 ))
         cp ${PREPBUFR_MET_OBS_DIR}/obs_seq_prep_${DATE}.out ./obs_seq_MET_${DATE}.out
         export FILE_LIST[${NUM_FILES}]=obs_seq_MET_${DATE}.out
      fi
#
# MOPITT CO TOTAL_COL
      if [[ -s ${MOPITT_CO_TOTAL_COL_OBS_DIR}/obs_seq_mopitt_co_total_col_${DATE}.out && ${RUN_MOPITT_CO_TOTAL_COL_OBS} == true ]]; then 
         cp ${MOPITT_CO_TOTAL_COL_OBS_DIR}/obs_seq_mopitt_co_total_col_${DATE}.out ./obs_seq_MOP_CO_TOTAL_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MOP_CO_TOTAL_COL_${DATE}.out
      fi
#
      # MOPITT CO PROFILE
      if [[ -s ${MOPITT_CO_PROFILE_OBS_DIR}/obs_seq_mopitt_co_profile_${DATE}.out && (${RUN_MOPITT_CO_PROFILE_OBS} == true || ${RUN_MOPITT_V8_CO_PROFILE_OBS} == true) ]]; then
         cp ${MOPITT_CO_PROFILE_OBS_DIR}/obs_seq_mopitt_co_profile_${DATE}.out ./obs_seq_MOP_CO_PROFILE_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MOP_CO_PROFILE_${DATE}.out
      fi
#
# MOPITT CO CPSR
      if [[ -s ${MOPITT_CO_CPSR_OBS_DIR}/obs_seq_mopitt_co_cpsr_${DATE}.out && ${RUN_MOPITT_CO_CPSR_OBS} == true ]]; then 
         cp ${MOPITT_CO_CPSR_OBS_DIR}/obs_seq_mopitt_co_cpsr_${DATE}.out ./obs_seq_MOP_CO_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MOP_CO_CPSR_${DATE}.out
      fi
#
# IASI CO TOTAL COL
      if [[ -s ${IASI_CO_TOTAL_COL_OBS_DIR}/obs_seq_iasi_co_total_col_${DATE}.out && ${RUN_IASI_CO_TOTAL_COL_OBS} == true ]]; then 
         cp ${IASI_CO_TOTAL_COL_OBS_DIR}/obs_seq_iasi_co_total_col_${DATE}.out ./obs_seq_IAS_CO_TOTAL_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_IAS_CO_TOTAL_COL_${DATE}.out
      fi
#
# IASI CO PROFILE
      if [[ -s ${IASI_CO_PROFILE_OBS_DIR}/obs_seq_iasi_co_profile_${DATE}.out && ${RUN_IASI_CO_PROFILE_OBS} == true ]]; then 
         cp ${IASI_CO_PROFILE_OBS_DIR}/obs_seq_iasi_co_profile_${DATE}.out ./obs_seq_IAS_CO_PROFILE_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_IAS_CO_PROFILE_${DATE}.out
      fi
#
# IASI CO CPSR
      if [[ -s ${IASI_CO_CPSR_OBS_DIR}/obs_seq_iasi_co_cpsr_${DATE}.out && ${RUN_IASI_CO_CPSR_OBS} == true ]]; then 
         cp ${IASI_CO_CPSR_OBS_DIR}/obs_seq_iasi_co_cpsr_${DATE}.out ./obs_seq_IAS_CO_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_IAS_CO_CPSR_${DATE}.out
      fi
#
# IASI O3 PROFILE
      if [[ -s ${IASI_O3_PROFILE_OBS_DIR}/obs_seq_iasi_o3_profile_${DATE}.out && ${RUN_IASI_O3_PROFILE_OBS} == true ]]; then 
         cp ${IASI_O3_PROFILE_OBS_DIR}/obs_seq_iasi_o3_profile_${DATE}.out ./obs_seq_IAS_O3_PROFILE_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_IAS_O3_PROFILE_${DATE}.out
      fi
#
# IASI O3 CPSR
      if [[ -s ${IASI_O3_CPSR_OBS_DIR}/obs_seq_iasi_o3_cpsr_${DATE}.out && ${RUN_IASI_O3_CPSR_OBS} == true ]]; then 
         cp ${IASI_O3_OBS_DIR}/obs_seq_iasi_o3_cpsr_${DATE}.out ./obs_seq_IAS_O3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_IAS_O3_CPSR_${DATE}.out
      fi
#
# MODIS AOD TOTAL COL
      if [[ -s ${MODIS_AOD_TOTAL_COL_OBS_DIR}/obs_seq_modis_aod_total_col_${DATE}.out && ${RUN_MODIS_AOD_TOTAL_COL_OBS} == true ]]; then 
         cp ${MODIS_AOD_TOTAL_COL_OBS_DIR}/obs_seq_modis_aod_total_col_${DATE}.out ./obs_seq_MOD_AOD_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MOD_AOD_TOTAL_COL_${DATE}.out
      fi
#
# OMI O3 TOTAL COL
      if [[ -s ${OMI_O3_TOTAL_COL_OBS_DIR}/obs_seq_omi_o3_total_col_${DATE}.out && ${RUN_OMI_O3_TOTAL_COL_OBS} == true ]]; then 
         cp ${OMI_O3_TOTAL_COL_OBS_DIR}/obs_seq_omi_o3_total_col_${DATE}.out ./obs_seq_OMI_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_O3_TOTAL_COL_${DATE}.out
      fi
#
# OMI O3 TROP COL
      if [[ -s ${OMI_O3_TROP_COL_OBS_DIR}/obs_seq_omi_o3_trop_col_${DATE}.out && ${RUN_OMI_O3_TROP_COL_OBS} == true ]]; then 
         cp ${OMI_O3_TROP_COL_OBS_DIR}/obs_seq_omi_o3_trop_col_${DATE}.out ./obs_seq_OMI_O3_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_O3_TROP_COL_${DATE}.out
      fi
#
# OMI O3 PROFILE
      if [[ -s ${OMI_O3_PROFILE_OBS_DIR}/obs_seq_omi_o3_profile_${DATE}.out && ${RUN_OMI_O3_PROFILE_OBS} == true ]]; then 
         cp ${OMI_O3_PROFILE_OBS_DIR}/obs_seq_omi_o3_profile_${DATE}.out ./obs_seq_OMI_O3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_O3_PROFILE_${DATE}.out
      fi
#
# OMI O3 CPSR
      if [[ -s ${OMI_O3_CPSR_OBS_DIR}/obs_seq_omi_o3_cpsr_${DATE}.out && ${RUN_OMI_O3_CPSR_OBS} == true ]]; then 
         cp ${OMI_O3_CPSR_OBS_DIR}/obs_seq_omi_o3_cpsr_${DATE}.out ./obs_seq_OMI_O3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_O3_CPSR_${DATE}.out
      fi
#
# OMI NO2 TOTAL COL
      if [[ -s ${OMI_NO2_TOTAL_COL_OBS_DIR}/obs_seq_omi_no2_total_col_${DATE}.out && ${RUN_OMI_NO2_TOTAL_COL_OBS} == true ]]; then 
         cp ${OMI_NO2_TOTAL_COL_OBS_DIR}/obs_seq_omi_no2_total_col_${DATE}.out ./obs_seq_OMI_NO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_NO2_TOTAL_COL_${DATE}.out
      fi
#
# OMI NO2 TROP COL
      if [[ -s ${OMI_NO2_TROP_COL_OBS_DIR}/obs_seq_omi_no2_trop_col_${DATE}.out && ${RUN_OMI_NO2_TROP_COL_OBS} == true ]]; then 
         cp ${OMI_NO2_TROP_COL_OBS_DIR}/obs_seq_omi_no2_trop_col_${DATE}.out ./obs_seq_OMI_NO2_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_NO2_TROP_COL_${DATE}.out
      fi
#
# OMI SO2 TOTAL COL
      if [[ -s ${OMI_SO2_TOTAL_COL_OBS_DIR}/obs_seq_omi_so2_total_col_${DATE}.out && ${RUN_OMI_SO2_TOTAL_COL_OBS} == true ]]; then 
         cp ${OMI_SO2_TOTAL_COL_OBS_DIR}/obs_seq_omi_so2_total_col_${DATE}.out ./obs_seq_OMI_SO2_TOTAL_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_SO2_TOTAL_COL_${DATE}.out
      fi
#
# OMI SO2 PBL COL
      if [[ -s ${OMI_SO2_PBL_COL_OBS_DIR}/obs_seq_omi_so2_pbl_col_${DATE}.out && ${RUN_OMI_SO2_PBL_COL_OBS} == true ]]; then 
          cp ${OMI_SO2_PBL_COL_OBS_DIR}/obs_seq_omi_so2_pbl_col_${DATE}.out ./obs_seq_OMI_SO2_PBL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_SO2_PBL_COL_${DATE}.out
      fi
#
# OMI HCHO TOTAL COL
      if [[ -s ${OMI_HCHO_TOTAL_COL_OBS_DIR}/obs_seq_omi_hcho_total_col_${DATE}.out && ${RUN_OMI_HCHO_TOTAL_COL_OBS} == true ]]; then 
         cp ${OMI_HCHO_TOTAL_COL_OBS_DIR}/obs_seq_omi_hcho_total_col_${DATE}.out ./obs_seq_OMI_HCHO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_HCHO_TOTAL_COL_${DATE}.out
      fi
#
# OMI HCHO TROP COL
      if [[ -s ${OMI_HCHO_TROP_COL_OBS_DIR}/obs_seq_omi_hcho_trop_col_${DATE}.out && ${RUN_OMI_HCHO_TROP_COL_OBS} == true ]]; then 
         cp ${OMI_HCHO_TROP_COL_OBS_DIR}/obs_seq_omi_hcho_trop_col_${DATE}.out ./obs_seq_OMI_HCHO_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_HCHO_TROP_COL_${DATE}.out
      fi
#
# TROPOMI CO TOTAL COL
      if [[ -s ${TROPOMI_CO_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_co_total_col_${DATE}.out && ${RUN_TROPOMI_CO_TOTAL_COL_OBS} == true ]]; then 
         cp ${TROPOMI_CO_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_co_total_col_${DATE}.out ./obs_seq_TROPOMI_CO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_CO_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI O3 TOTAL COL
      if [[ -s ${TROPOMI_O3_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_o3_total_col_${DATE}.out && ${RUN_TROPOMI_O3_TOTAL_COL_OBS} == true ]]; then 
         cp ${TROPOMI_O3_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_o3_total_col_${DATE}.out ./obs_seq_TROPOMI_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_O3_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI O3 TROP COL
      if [[ -s ${TROPOMI_O3_TROP_COL_OBS_DIR}/obs_seq_tropomi_o3_trop_col_${DATE}.out && ${RUN_TROPOMI_O3_TROP_COL_OBS} == true ]]; then 
         cp ${TROPOMI_O3_TROP_COL_OBS_DIR}/obs_seq_tropomi_o3_trop_col_${DATE}.out ./obs_seq_TROPOMI_O3_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_O3_TROP_COL_${DATE}.out
      fi
#
# TROPOMI O3 PROFILE
      if [[ -s ${TROPOMI_O3_PROFILE_OBS_DIR}/obs_seq_tropomi_o3_profile_${DATE}.out && ${RUN_TROPOMI_O3_PROFILE_OBS} == true ]]; then 
         cp ${TROPOMI_O3_PROFILE_OBS_DIR}/obs_seq_tropomi_o3_profile_${DATE}.out ./obs_seq_TROPOMI_O3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_O3_PROFILE_${DATE}.out
      fi
#
# TROPOMI O3 CPSR
      if [[ -s ${TROPOMI_O3_CPSR_OBS_DIR}/obs_seq_tropomi_o3_cpsr_${DATE}.out && ${RUN_TROPOMI_O3_CPSR_OBS} == true ]]; then 
         cp ${TROPOMI_O3_CPSR_OBS_DIR}/obs_seq_tropomi_o3_cpsr_${DATE}.out ./obs_seq_TROPOMI_O3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_O3_CPSR_${DATE}.out
      fi
#
# TROPOMI NO2 TOTAL COL
      if [[ -s ${TROPOMI_NO2_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_no2_total_col_${DATE}.out && ${RUN_TROPOMI_NO2_TOTAL_COL_OBS} == true ]]; then 
         cp ${TROPOMI_NO2_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_no2_total_col_${DATE}.out ./obs_seq_TROPOMI_NO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_NO2_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI NO2 TROP COL
      if [[ -s ${TROPOMI_NO2_TROP_COL_OBS_DIR}/obs_seq_tropomi_no2_trop_col_${DATE}.out && ${RUN_TROPOMI_NO2_TROP_COL_OBS} == true ]]; then 
         cp ${TROPOMI_NO2_TROP_COL_OBS_DIR}/obs_seq_tropomi_no2_trop_col_${DATE}.out ./obs_seq_TROPOMI_NO2_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_NO2_TROP_COL_${DATE}.out
      fi
#
# TROPOMI SO2_TOTAL_COL
      if [[ -s ${TROPOMI_SO2_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_so2_total_col_${DATE}.out && ${RUN_TROPOMI_SO2_TOTAL_COL_OBS} == true ]]; then 
         cp ${TROPOMI_SO2_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_so2_total_col_${DATE}.out ./obs_seq_TROPOMI_SO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_SO2_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI SO2 PBL COL
      if [[ -s ${TROPOMI_SO2_PBL_COL_OBS_DIR}/obs_seq_tropomi_so2_pbl_col_${DATE}.out && ${RUN_TROPOMI_SO2_PBL_COL_OBS} == true ]]; then 
         cp ${TROPOMI_SO2_PBL_COL_OBS_DIR}/obs_seq_tropomi_so2_pbl_col_${DATE}.out ./obs_seq_TROPOMI_SO2_PBL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_SO2_PBL_COL_${DATE}.out
      fi
#
# TROPOMI CH4 TOTAL COL
      if [[ -s ${TROPOMI_CH4_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_ch4_total_col_${DATE}.out && ${RUN_TROPOMI_CH4_TOTAL_COL_OBS} == true ]]; then 
         cp ${TROPOMI_CH4_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_ch4_total_col_${DATE}.out ./obs_seq_TROPOMI_CH4_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_CH4_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI CH4 TROP COL
      if [[ -s ${TROPOMI_CH4_TROP_COL_OBS_DIR}/obs_seq_tropomi_ch4_trop_col_${DATE}.out && ${RUN_TROPOMI_CH4_TROP_COL_OBS} == true ]]; then 
         cp ${TROPOMI_CH4_TROP_COL_OBS_DIR}/obs_seq_tropomi_ch4_trop_col_${DATE}.out ./obs_seq_TROPOMI_CH4_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_CH4_TROP_COL_${DATE}.out
      fi
#
# TROPOMI CH4 PROFILE
      if [[ -s ${TROPOMI_CH4_PROFILE_OBS_DIR}/obs_seq_tropomi_ch4_profile_${DATE}.out && ${RUN_TROPOMI_CH4_PROFILE_OBS} == true ]]; then 
         cp ${TROPOMI_CH4_PROFILE_OBS_DIR}/obs_seq_tropomi_ch4_profile_${DATE}.out ./obs_seq_TROPOMI_CH4_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_CH4_PROFILE_${DATE}.out
      fi
#
# TROPOMI CH4 CPSR
      if [[ -s ${TROPOMI_CH4_CPSR_OBS_DIR}/obs_seq_tropomi_ch4_cpsr_${DATE}.out && ${RUN_TROPOMI_CH4_CPSR_OBS} == true ]]; then 
         cp ${TROPOMI_CH4_CPSR_OBS_DIR}/obs_seq_tropomi_ch4_cpsr_${DATE}.out ./obs_seq_TROPOMI_CH4_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_CH4_CPSR_${DATE}.out
      fi
#
# TROPOMI HCHO TOTAL COL
      if [[ -s ${TROPOMI_HCHO_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_hcho_total_col_${DATE}.out && ${RUN_TROPOMI_HCHO_TOTAL_COL_OBS} == true ]]; then 
         cp ${TROPOMI_HCHO_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_hcho_total_col_${DATE}.out ./obs_seq_TROPOMI_HCHO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_HCHO_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI HCHO TROP COL
      if [[ -s ${TROPOMI_HCHO_TROP_COL_OBS_DIR}/obs_seq_tropomi_hcho_trop_col_${DATE}.out && ${RUN_TROPOMI_HCHO_TROP_COL_OBS} == true ]]; then 
         cp ${TROPOMI_HCHO_TROP_COL_OBS_DIR}/obs_seq_tropomi_hcho_trop_col_${DATE}.out ./obs_seq_TROPOMI_HCHO_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_HCHO_TROP_COL_${DATE}.out
      fi
#
# TEMPO O3 TOTAL COL
      if [[ -s ${TEMPO_O3_TOTAL_COL_OBS_DIR}/obs_seq_tempo_o3_total_col_${DATE}.out && ${RUN_TEMPO_O3_TOTAL_COL_OBS} == true ]]; then 
         cp ${TEMPO_O3_TOTAL_COL_OBS_DIR}/obs_seq_tempo_o3_total_col_${DATE}.out ./obs_seq_TEMPO_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_O3_TOTAL_COL_${DATE}.out
      fi
#
# TEMPO O3 TROP COL
      if [[ -s ${TEMPO_O3_TROP_COL_OBS_DIR}/obs_seq_tempo_o3_trop_col_${DATE}.out && ${RUN_TEMPO_O3_TROP_COL_OBS} == true ]]; then 
         cp ${TEMPO_O3_TROP_COL_OBS_DIR}/obs_seq_tempo_o3_trop_col_${DATE}.out ./obs_seq_TEMPO_O3_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_O3_TROP_COL_${DATE}.out
      fi
#
# TEMPO O3 PROFILE
      if [[ -s ${TEMPO_O3_PROFILE_OBS_DIR}/obs_seq_tempo_o3_profile_${DATE}.out && ${RUN_TEMPO_O3_PROFILE_OBS} == true ]]; then 
         cp ${TEMPO_O3_PROFILE_OBS_DIR}/obs_seq_tempo_o3_profile_${DATE}.out ./obs_seq_TEMPO_O3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_O3_PROFILE_${DATE}.out
      fi
#
# TEMPO O3 CPSR
      if [[ -s ${TEMPO_O3_CPSR_OBS_DIR}/obs_seq_tempo_o3_cpsr_${DATE}.out && ${RUN_TEMPO_O3_CPSR_OBS} == true ]]; then 
         cp ${TEMPO_O3_CPSR_OBS_DIR}/obs_seq_tempo_o3_cpsr_${DATE}.out ./obs_seq_TEMPO_O3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_O3_CPSR_${DATE}.out
      fi
#
# TEMPO NO2 TOTAL COL
      if [[ -s ${TEMPO_NO2_TOTAL_COL_OBS_DIR}/obs_seq_tempo_no2_total_col_${DATE}.out && ${RUN_INETEMPO_NO2_TOTAL_COL_OBS} == true ]]; then 
         cp ${TEMPO_NO2_TOTAL_COL_OBS_DIR}/obs_seq_tempo_no2_total_col_${DATE}.out ./obs_seq_TEMPO_NO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_NO2_TOTAL_COL_${DATE}.out
      fi
#
# TEMPO NO2 TROP COL
      if [[ -s ${TEMPO_NO2_TROP_COL_OBS_DIR}/obs_seq_tempo_no2_trop_col_${DATE}.out && ${RUN_TEMPO_NO2_TROP_COL_OBS} == true ]]; then 
         cp ${TEMPO_NO2_TROP_COL_OBS_DIR}/obs_seq_tempo_no2_trop_col_${DATE}.out ./obs_seq_TEMPO_NO2_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_NO2_TROP_COL_${DATE}.out
      fi
#
# TES CO TOTAL COL
      if [[ -s ${TES_CO_TOTAL_COL_OBS_DIR}/obs_seq_tes_co_total_col_${DATE}.out && ${RUN_TES_CO_TOTAL_COL_OBS} == true ]]; then 
         cp ${TES_CO_TOTAL_COL_OBS_DIR}/obs_seq_tes_co_total_col_${DATE}.out ./obs_seq_TES_CO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO_TOTAL_COL_${DATE}.out
      fi
#
# TES CO TROP COL
      if [[ -s ${TES_CO_TROP_COL_OBS_DIR}/obs_seq_tes_co_trop_col_${DATE}.out && ${RUN_TES_CO_TROP_COL_OBS} == true ]]; then 
         cp ${TES_CO_TROP_COL_OBS_DIR}/obs_seq_tes_co_trop_col_${DATE}.out ./obs_seq_TES_CO_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO_TROP_COL_${DATE}.out
      fi
#
# TES CO PROFILE
      if [[ -s ${TES_CO_PROFILE_OBS_DIR}/obs_seq_tes_co_profile_${DATE}.out && ${RUN_TES_CO_PROFILE_OBS} == true ]]; then 
         cp ${TES_CO_PROFILE_OBS_DIR}/obs_seq_tes_co_profile_${DATE}.out ./obs_seq_TES_CO_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO_PROFILE_${DATE}.out
      fi
#
# TES CO CPSR
      if [[ -s ${TES_CO_CPSR_OBS_DIR}/obs_seq_tes_co_cpsr_${DATE}.out && ${RUN_TES_CO_CPSR_OBS} == true ]]; then 
         cp ${TES_CO_CPSR_OBS_DIR}/obs_seq_tes_co_cpsr_${DATE}.out ./obs_seq_TES_CO_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO_CPSR_${DATE}.out
      fi
#
# TES CO2 TOTAL COL
      if [[ -s ${TES_CO2_TOTAL_COL_OBS_DIR}/obs_seq_tes_co2_total_col_${DATE}.out && ${RUN_TES_CO2_TOTAL_COL_OBS} == true ]]; then 
         cp ${TES_CO2_TOTAL_COL_OBS_DIR}/obs_seq_tes_co2_total_col_${DATE}.out ./obs_seq_TES_CO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO2_TOTAL_COL_${DATE}.out
      fi
#
# TES CO2 TROP COL
      if [[ -s ${TES_CO2_TROP_COL_OBS_DIR}/obs_seq_tes_co2_trop_col_${DATE}.out && ${RUN_TES_CO2_TROP_COL_OBS} == true ]]; then 
         cp ${TES_CO2_TROP_COL_OBS_DIR}/obs_seq_tes_co2_trop_col_${DATE}.out ./obs_seq_TES_CO2_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO2_TROP_COL_${DATE}.out
      fi
#
# TES CO2 PROFILE
      if [[ -s ${TES_CO2_PROFILE_OBS_DIR}/obs_seq_tes_co2_profile_${DATE}.out && ${RUN_TES_CO2_PROFILE_OBS} == true ]]; then 
         cp ${TES_CO2_PROFILE_OBS_DIR}/obs_seq_tes_co2_profile_${DATE}.out ./obs_seq_TES_CO2_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO2_PROFILE_${DATE}.out
      fi
#
# TES CO2 CPSR
      if [[ -s ${TES_CO2_CPSR_OBS_DIR}/obs_seq_tes_co2_cpsr_${DATE}.out && ${RUN_TES_CO2_CPSR_OBS} == true ]]; then 
         cp ${TES_CO2_CPSR_OBS_DIR}/obs_seq_tes_co2_cpsr_${DATE}.out ./obs_seq_TES_CO2_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO2_CPSR_${DATE}.out
      fi
#
# TES O3 TOTAL COL
      if [[ -s ${TES_O3_TOTAL_COL_OBS_DIR}/obs_seq_tes_o3_total_col_${DATE}.out && ${RUN_TES_O3_TOTAL_COL_OBS} == true ]]; then 
         cp ${TES_O3_TOTAL_COL_OBS_DIR}/obs_seq_tes_o3_total_col_${DATE}.out ./obs_seq_TES_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_O3_TOTAL_COL_${DATE}.out
      fi
#
# TES O3 TROP COL
      if [[ -s ${TES_O3_TROP_COL_OBS_DIR}/obs_seq_tes_o3_trop_col_${DATE}.out && ${RUN_TES_O3_TROP_COL_OBS} == true ]]; then 
         cp ${TES_O3_TROP_COL_OBS_DIR}/obs_seq_tes_o3_trop_col_${DATE}.out ./obs_seq_TES_O3_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_O3_TROP_COL_${DATE}.out
      fi
#
# TES O3 PROFILE
      if [[ -s ${TES_O3_PROFILE_OBS_DIR}/obs_seq_tes_o3_profile_${DATE}.out && ${RUN_TES_O3_PROFILE_OBS} == true ]]; then 
         cp ${TES_O3_PROFILE_OBS_DIR}/obs_seq_tes_o3_profile_${DATE}.out ./obs_seq_TES_O3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_O3_PROFILE_${DATE}.out
      fi
#
# TES O3 CPSR
      if [[ -s ${TES_O3_CPSR_OBS_DIR}/obs_seq_tes_o3_cpsr_${DATE}.out && ${RUN_TES_O3_CPSR_OBS} == true ]]; then 
         cp ${TES_O3_CPSR_OBS_DIR}/obs_seq_tes_o3_cpsr_${DATE}.out ./obs_seq_TES_O3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_O3_CPSR_${DATE}.out
      fi
#
# TES NH3 TOTAL COL
      if [[ -s ${TES_NH3_TOTAL_COL_OBS_DIR}/obs_seq_tes_nh3_total_col_${DATE}.out && ${RUN_TES_NH3_TOTAL_COL_OBS} == true ]]; then 
         cp ${TES_NH3_TOTAL_COL_OBS_DIR}/obs_seq_tes_nh3_total_col_${DATE}.out ./obs_seq_TES_NH3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_NH3_TOTAL_COL_${DATE}.out
      fi
#
# TES NH3 TROP COL
      if [[ -s ${TES_NH3_TROP_COL_OBS_DIR}/obs_seq_tes_nh3_trop_col_${DATE}.out && ${RUN_TES_NH3_TROP_COL_OBS} == true ]]; then 
         cp ${TES_NH3_TROP_COL_OBS_DIR}/obs_seq_tes_nh3_trop_col_${DATE}.out ./obs_seq_TES_NH3_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_NH3_TROP_COL_${DATE}.out
      fi
#
# TES NH3 PROFILE
      if [[ -s ${TES_NH3_PROFILE_OBS_DIR}/obs_seq_tes_nh3_profile_${DATE}.out && ${RUN_TES_NH3_PROFILE_OBS} == true ]]; then 
         cp ${TES_NH3_PROFILE_OBS_DIR}/obs_seq_tes_nh3_profile_${DATE}.out ./obs_seq_TES_NH3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_NH3_PROFILE_${DATE}.out
      fi
#
# TES NH3 CPSR
      if [[ -s ${TES_NH3_CPSR_OBS_DIR}/obs_seq_tes_nh3_cpsr_${DATE}.out && ${RUN_TES_NH3_CPSR_OBS} == true ]]; then 
         cp ${TES_NH3_CPSR_OBS_DIR}/obs_seq_tes_nh3_cpsr_${DATE}.out ./obs_seq_TES_NH3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_NH3_CPSR_${DATE}.out
      fi
#
# TES CH4 TOTAL CH4L
      if [[ -s ${TES_CH4_TOTAL_COL_OBS_DIR}/obs_seq_tes_ch4_total_col_${DATE}.out && ${RUN_TES_CH4_TOTAL_COL_OBS} == true ]]; then 
         cp ${TES_CH4_TOTAL_COL_OBS_DIR}/obs_seq_tes_ch4_total_col_${DATE}.out ./obs_seq_TES_CH4_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CH4_TOTAL_COL_${DATE}.out
      fi
#
# TES CH4 TROP COL
      if [[ -s ${TES_CH4_TROP_COL_OBS_DIR}/obs_seq_tes_ch4_trop_col_${DATE}.out && ${RUN_TES_CH4_TROP_COL_OBS} == true ]]; then 
         cp ${TES_CH4_TROP_COL_OBS_DIR}/obs_seq_tes_ch4_trop_col_${DATE}.out ./obs_seq_TES_CH4_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CH4_TROP_COL_${DATE}.out
      fi
#
# TES CH4 PROFILE
      if [[ -s ${TES_CH4_PROFILE_OBS_DIR}/obs_seq_tes_ch4_profile_${DATE}.out && ${RUN_TES_CH4_PROFILE_OBS} == true ]]; then 
         cp ${TES_CH4_PROFILE_OBS_DIR}/obs_seq_tes_ch4_profile_${DATE}.out ./obs_seq_TES_CH4_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CH4_PROFILE_${DATE}.out
      fi
#
# TES CH4 CPSR
      if [[ -s ${TES_CH4_CPSR_OBS_DIR}/obs_seq_tes_ch4_cpsr_${DATE}.out && ${RUN_TES_CH4_CPSR_OBS} == true ]]; then 
         cp ${TES_CH4_CPSR_OBS_DIR}/obs_seq_tes_ch4_cpsr_${DATE}.out ./obs_seq_TES_CH4_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CH4_CPSR_${DATE}.out
      fi
#
# CRIS CO TOTAL COL
      if [[ -s ${CRIS_CO_TOTAL_COL_OBS_DIR}/obs_seq_cris_co_total_col_${DATE}.out && ${RUN_CRIS_CO_TOTAL_COL_OBS} == true ]]; then 
         cp ${CRIS_CO_TOTAL_COL_OBS_DIR}/obs_seq_cris_co_total_col_${DATE}.out ./obs_seq_CRIS_CO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CO_TOTAL_COL_${DATE}.out
      fi
#
# CRIS CO PROFILE
      if [[ -s ${CRIS_CO_PROFILE_OBS_DIR}/obs_seq_cris_co_profile_${DATE}.out && ${RUN_CRIS_CO_PROFILE_OBS} == true ]]; then 
         cp ${CRIS_CO_PROFILE_OBS_DIR}/obs_seq_cris_co_profile_${DATE}.out ./obs_seq_CRIS_CO_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CO_PROFILE_${DATE}.out
      fi
#
# CRIS CO CPSR
      if [[ -s ${CRIS_CO_CPSR_OBS_DIR}/obs_seq_cris_co_cpsr_${DATE}.out && ${RUN_CRIS_CO_CPSR_OBS} == true ]]; then 
         cp ${CRIS_CO_CPSR_OBS_DIR}/obs_seq_cris_co_cpsr_${DATE}.out ./obs_seq_CRIS_CO_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CO_CPSR_${DATE}.out
      fi
#
# CRIS O3 TOTAL COL
      if [[ -s ${CRIS_O3_TOTAL_COL_OBS_DIR}/obs_seq_cris_o3_total_col_${DATE}.out && ${RUN_CRIS_O3_TOTAL_COL_OBS} == true ]]; then 
         cp ${CRIS_O3_TOTAL_COL_OBS_DIR}/obs_seq_cris_o3_total_col_${DATE}.out ./obs_seq_CRIS_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_O3_TOTAL_COL_${DATE}.out
      fi
#
# CRIS O3 PROFILE
      if [[ -s ${CRIS_O3_PROFILE_OBS_DIR}/obs_seq_cris_o3_profile_${DATE}.out && ${RUN_CRIS_O3_PROFILE_OBS} == true ]]; then 
         cp ${CRIS_O3_PROFILE_OBS_DIR}/obs_seq_cris_o3_profile_${DATE}.out ./obs_seq_CRIS_O3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_O3_PROFILE_${DATE}.out
      fi
#
# CRIS O3 CPSR
      if [[ -s ${CRIS_O3_CPSR_OBS_DIR}/obs_seq_cris_o3_cpsr_${DATE}.out && ${RUN_CRIS_O3_CPSR_OBS} == true ]]; then 
         cp ${CRIS_O3_CPSR_OBS_DIR}/obs_seq_cris_o3_cpsr_${DATE}.out ./obs_seq_CRIS_O3_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_O3_CPSR_${DATE}.out
      fi
#
# CRIS NH3 TOTAL COL
      if [[ -s ${CRIS_NH3_TOTAL_COL_OBS_DIR}/obs_seq_cris_nh3_total_col_${DATE}.out && ${RUN_CRIS_NH3_TOTAL_COL_OBS} == true ]]; then 
         cp ${CRIS_NH3_TOTAL_COL_OBS_DIR}/obs_seq_cris_nh3_total_col_${DATE}.out ./obs_seq_CRIS_NH3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_NH3_TOTAL_COL_${DATE}.out
      fi
#
# CRIS NH3 PROFILE
      if [[ -s ${CRIS_NH3_PROFILE_OBS_DIR}/obs_seq_cris_nh3_profile_${DATE}.out && ${RUN_CRIS_NH3_PROFILE_OBS} == true ]]; then 
         cp ${CRIS_NH3_PROFILE_OBS_DIR}/obs_seq_cris_nh3_profile_${DATE}.out ./obs_seq_CRIS_NH3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_NH3_PROFILE_${DATE}.out
      fi
#
# CRIS NH3 CPSR
      if [[ -s ${CRIS_NH3_CPSR_OBS_DIR}/obs_seq_cris_nh3_cpsr_${DATE}.out && ${RUN_CRIS_NH3_CPSR_OBS} == true ]]; then 
         cp ${CRIS_NH3_CPSR_OBS_DIR}/obs_seq_cris_nh3_cpsr_${DATE}.out ./obs_seq_CRIS_NH3_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_NH3_CPSR_${DATE}.out
      fi
#
# CRIS CH4 TOTAL CH4L
      if [[ -s ${CRIS_CH4_TOTAL_COL_OBS_DIR}/obs_seq_cris_ch4_total_col_${DATE}.out && ${RUN_CRIS_CH4_TOTAL_COL_OBS} == true ]]; then 
         cp ${CRIS_CH4_TOTAL_COL_OBS_DIR}/obs_seq_cris_ch4_total_col_${DATE}.out ./obs_seq_CRIS_CH4_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CH4_TOTAL_COL_${DATE}.out
      fi
#
# CRIS CH4 PROFILE
      if [[ -s ${CRIS_CH4_PROFILE_OBS_DIR}/obs_seq_cris_ch4_profile_${DATE}.out && ${RUN_CRIS_CH4_PROFILE_OBS} == true ]]; then 
         cp ${CRIS_CH4_PROFILE_OBS_DIR}/obs_seq_cris_ch4_profile_${DATE}.out ./obs_seq_CRIS_CH4_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CH4_PROFILE_${DATE}.out
      fi
#
# CRIS CH4 CPSR
      if [[ -s ${CRIS_CH4_CPSR_OBS_DIR}/obs_seq_cris_ch4_cpsr_${DATE}.out && ${RUN_CRIS_CH4_CPSR_OBS} == true ]]; then 
         cp ${CRIS_CH4_CPSR_OBS_DIR}/obs_seq_cris_ch4_cpsr_${DATE}.out ./obs_seq_CRIS_CH4_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CH4_CPSR_${DATE}.out
      fi
#
# CRIS PAN TOTAL COL
      if [[ -s ${CRIS_PAN_TOTAL_COL_OBS_DIR}/obs_seq_cris_pan_total_col_${DATE}.out && ${RUN_CRIS_PAN_TOTAL_COL_OBS} == true ]]; then 
         cp ${CRIS_PAN_TOTAL_COL_OBS_DIR}/obs_seq_cris_pan_total_col_${DATE}.out ./obs_seq_CRIS_PAN_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_PAN_TOTAL_COL_${DATE}.out
      fi
#
# CRIS PAN PROFILE
      if [[ -s ${CRIS_PAN_PROFILE_OBS_DIR}/obs_seq_cris_pan_profile_${DATE}.out && ${RUN_CRIS_PAN_PROFILE_OBS} == true ]]; then 
         cp ${CRIS_PAN_PROFILE_OBS_DIR}/obs_seq_cris_pan_profile_${DATE}.out ./obs_seq_CRIS_PAN_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_PAN_PROFILE_${DATE}.out
      fi
#
# CRIS PAN CPSR
      if [[ -s ${CRIS_PAN_CPSR_OBS_DIR}/obs_seq_cris_pan_cpsr_${DATE}.out && ${RUN_CRIS_PAN_CPSR_OBS} == true ]]; then 
         cp ${CRIS_PAN_CPSR_OBS_DIR}/obs_seq_cris_pan_cpsr_${DATE}.out ./obs_seq_CRIS_PAN_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_PAN_CPSR_${DATE}.out
      fi
#
# GOME2A NO2 TOTAL COL
      if [[ -s ${GOME2A_NO2_TOTAL_COL_OBS_DIR}/obs_seq_gome2a_no2_total_col_${DATE}.out && ${RUN_GOME2A_NO2_TOTAL_COL_OBS} == true ]]; then 
         cp ${GOME2A_NO2_TOTAL_COL_OBS_DIR}/obs_seq_gome2a_no2_total_col_${DATE}.out ./obs_seq_GOME2A_NO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_GOME2A_NO2_TOTAL_COL_${DATE}.out
      fi
#
# GOME2A NO2 TROP COL
      if [[ -s ${GOME2A_NO2_TROP_COL_OBS_DIR}/obs_seq_gome2a_no2_trop_col_${DATE}.out && ${RUN_GOME2A_NO2_TROP_COL_OBS} == true ]]; then 
         cp ${GOME2A_NO2_TROP_COL_OBS_DIR}/obs_seq_gome2a_no2_trop_col_${DATE}.out ./obs_seq_GOME2A_NO2_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_GOME2A_NO2_TROP_COL_${DATE}.out
      fi
#
# SCIAM NO2 TOTAL COL
      if [[ -s ${SCIAM_NO2_TOTAL_COL_OBS_DIR}/obs_seq_sciam_no2_total_col_${DATE}.out && ${RUN_SCIAM_NO2_TOTAL_COL_OBS} == true ]]; then 
         cp ${SCIAM_NO2_TOTAL_COL_OBS_DIR}/obs_seq_sciam_no2_total_col_${DATE}.out ./obs_seq_SCIAM_NO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_SCIAM_NO2_TOTAL_COL_${DATE}.out
      fi
#
# SCIAM NO2 TROP COL
      if [[ -s ${SCIAM_NO2_TROP_COL_OBS_DIR}/obs_seq_sciam_no2_trop_col_${DATE}.out && ${RUN_SCIAM_NO2_TROP_COL_OBS} == true ]]; then 
         cp ${SCIAM_NO2_TROP_COL_OBS_DIR}/obs_seq_sciam_no2_trop_col_${DATE}.out ./obs_seq_SCIAM_NO2_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_SCIAM_NO2_TROP_COL_${DATE}.out
      fi
#
# MLS O3 TOTAL COL
      if [[ -s ${MLS_O3_TOTAL_COL_OBS_DIR}/obs_seq_mls_o3_total_col_${DATE}.out && ${RUN_MLS_O3_TOTAL_COL_OBS} == true ]]; then 
         cp ${MLS_O3_TOTAL_COL_OBS_DIR}/obs_seq_mls_o3_total_col_${DATE}.out ./obs_seq_MLS_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_O3_TOTAL_COL_${DATE}.out
      fi
#
# MLS O3 PROFILE
      if [[ -s ${MLS_O3_PROFILE_OBS_DIR}/obs_seq_mls_o3_profile_${DATE}.out && ${RUN_MLS_O3_PROFILE_OBS} == true ]]; then 
         cp ${MLS_O3_PROFILE_OBS_DIR}/obs_seq_mls_o3_profile_${DATE}.out ./obs_seq_MLS_O3_PROFILE_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_O3_PROFILE_${DATE}.out
      fi
#
# MLS O3 CPSR
      if [[ -s ${MLS_O3_CPSR_OBS_DIR}/obs_seq_mls_o3_cpsr_${DATE}.out && ${RUN_MLS_O3_CPSR_OBS} == true ]]; then 
         cp ${MLS_O3_CPSR_OBS_DIR}/obs_seq_mls_o3_cpsr_${DATE}.out ./obs_seq_MLS_O3_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_O3_CPSR_${DATE}.out
      fi
#
# MLS HNO3 TOTAL COL
      if [[ -s ${MLS_HNO3_TOTAL_COL_OBS_DIR}/obs_seq_mls_hno3_total_col_${DATE}.out && ${RUN_MLS_HNO3_TOTAL_COL_OBS} == true ]]; then 
         cp ${MLS_HNO3_TOTAL_COL_OBS_DIR}/obs_seq_mls_hno3_total_col_${DATE}.out ./obs_seq_MLS_HNO3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_HNO3_TOTAL_COL_${DATE}.out
      fi
#
# MLS HNO3 PROFILE
      if [[ -s ${MLS_HNO3_PROFILE_OBS_DIR}/obs_seq_mls_hno3_profile_${DATE}.out && ${RUN_MLS_HNO3_PROFILE_OBS} == true ]]; then 
         cp ${MLS_HNO3_PROFILE_OBS_DIR}/obs_seq_mls_hno3_profile_${DATE}.out ./obs_seq_MLS_HNO3_PROFILE_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_HNO3_PROFILE_${DATE}.out
      fi
#
# MLS HNO3 CPSR
      if [[ -s ${MLS_HNO3_CPSR_OBS_DIR}/obs_seq_mls_hno3_cpsr_${DATE}.out && ${RUN_MLS_HNO3_CPSR_OBS} == true ]]; then 
         cp ${MLS_HNO3_CPSR_OBS_DIR}/obs_seq_mls_hno3_cpsr_${DATE}.out ./obs_seq_MLS_HNO3_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_HNO3_CPSR_${DATE}.out
      fi
#
# OMI NO2 DOMINO TOTAL COL
      if [[ -s ${OMI_NO2_DOMINO_TOTAL_COL_OBS_DIR}/obs_seq_omi_no2_domino_total_col_${DATE}.out && ${RUN_OMI_NO2_DOMINO_TOTAL_COL_OBS} == true ]]; then 
         cp ${OMI_NO2_DOMINO_TOTAL_COL_OBS_DIR}/obs_seq_omi_no2_domino_total_col_${DATE}.out ./obs_seq_OMI_NO2_DOMINO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_NO2_DOMINO_TOTAL_COL_${DATE}.out
      fi
#
# OMI NO2 DOMINO TROP COL
      if [[ -s ${OMI_NO2_DOMINO_TROP_COL_OBS_DIR}/obs_seq_omi_no2_domino_trop_col_${DATE}.out && ${RUN_OMI_NO2_DOMINO_TROP_COL_OBS} == true ]]; then 
         cp ${OMI_NO2_DOMINO_TROP_COL_OBS_DIR}/obs_seq_omi_no2_domino_trop_col_${DATE}.out ./obs_seq_OMI_NO2_DOMINO_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_NO2_DOMINO_TROP_COL_${DATE}.out
      fi
#
# AIRNOW CO
      if [[ -s ${AIRNOW_CO_OBS_DIR}/obs_seq_airnow_co_${DATE}.out && ${RUN_AIRNOW_CO_OBS} == true ]]; then 
         cp ${AIRNOW_CO_OBS_DIR}/obs_seq_airnow_co_${DATE}.out ./obs_seq_AIR_CO_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_CO_${DATE}.out
      fi
#
# AIRNOW O3
      if [[ -s ${AIRNOW_O3_OBS_DIR}/obs_seq_airnow_o3_${DATE}.out && ${RUN_AIRNOW_O3_OBS} == true ]]; then 
         cp ${AIRNOW_O3_OBS_DIR}/obs_seq_airnow_o3_${DATE}.out ./obs_seq_AIR_O3_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_O3_${DATE}.out
      fi
#
# AIRNOW NO2
      if [[ -s ${AIRNOW_NO2_OBS_DIR}/obs_seq_airnow_no2_${DATE}.out && ${RUN_AIRNOW_NO2_OBS} == true ]]; then 
         cp ${AIRNOW_NO2_OBS_DIR}/obs_seq_airnow_no2_${DATE}.out ./obs_seq_AIR_NO2_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_NO2_${DATE}.out
      fi
#
# AIRNOW SO2
      if [[ -s ${AIRNOW_SO2_OBS_DIR}/obs_seq_airnow_so2_${DATE}.out && ${RUN_AIRNOW_SO2_OBS} == true ]]; then 
         cp ${AIRNOW_SO2_OBS_DIR}/obs_seq_airnow_so2_${DATE}.out ./obs_seq_AIR_SO2_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_SO2_${DATE}.out
      fi
#
# AIRNOW PM10
      if [[ -s ${AIRNOW_PM10_OBS_DIR}/obs_seq_airnow_pm10_${DATE}.out && ${RUN_AIRNOW_PM10_OBS} == true ]]; then 
         cp ${AIRNOW_PM10_OBS_DIR}/obs_seq_airnow_pm10_${DATE}.out ./obs_seq_AIR_PM10_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_PM10_${DATE}.out
      fi
#
# AIRNOW PM25
      if [[ -s ${AIRNOW_PM25_OBS_DIR}/obs_seq_airnow_pm25_${DATE}.out && ${RUN_AIRNOW_PM25_OBS} == true ]]; then 
         cp ${AIRNOW_PM25_OBS_DIR}/obs_seq_airnow_pm25_${DATE}.out ./obs_seq_AIR_PM25_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_PM25_${DATE}.out
      fi
      export NL_NUM_INPUT_FILES=${NUM_FILES}
#
# All files present
      if [[ ${NL_NUM_INPUT_FILES} -eq 97 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\',\'${FILE_LIST[93]}\',\'${FILE_LIST[94]}\',\'${FILE_LIST[95]}\',\'${FILE_LIST[96]}\',\'${FILE_LIST[97]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 96 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\',\'${FILE_LIST[93]}\',\'${FILE_LIST[94]}\',\'${FILE_LIST[95]}\',\'${FILE_LIST[96]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 95 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\',\'${FILE_LIST[93]}\',\'${FILE_LIST[94]}\',\'${FILE_LIST[95]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 94 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\',\'${FILE_LIST[93]}\',\'${FILE_LIST[94]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 93 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\',\'${FILE_LIST[93]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 92 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 91 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 90 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 89 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 88 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\'
   elif [[ ${NL_NUM_INPUT_FILES} -eq 87 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\'
   elif [[ ${NL_NUM_INPUT_FILES} -eq 86 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 85 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\'

      elif [[ ${NL_NUM_INPUT_FILES} -eq 84 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 83 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 82 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 81 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 80 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\'v,\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 79 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 78 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 77 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 76 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 75 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 74 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 73 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 72 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 71 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 70 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 69 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 68 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 67 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 66 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 65 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 64 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 63 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 62 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 61 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 60 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 59 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 58 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 57 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 56 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 55 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 54 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 53 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 52 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 51 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 50 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 49 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 48 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 47 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 46 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 45 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 44 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 43 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 42 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 41 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 40 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 39 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 38 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 37 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 36 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 35 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 34 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 33 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 32 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 31 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\',\'${FILE_LIST[31]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 30 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\',\'${FILE_LIST[30]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 29 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\',\'${FILE_LIST[29]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 28 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\',\'${FILE_LIST[28]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 27 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\',\'${FILE_LIST[27]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 26 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\',\'${FILE_LIST[26]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 25 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\',\'${FILE_LIST[25]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 24 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 23 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 22 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 21 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 20 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 19 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 18 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 17 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 16 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 15 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 14 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 13 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 12 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 11 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 10 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 9 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 8 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 7 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 6 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 5 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 4 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 3 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 2 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 1 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 0 ]]; then
         echo APM: ERROR no obs_seq files for FILTER
         exit
      fi
#
      export NL_FILENAME_OUT="'obs_seq.proc'"
      export NL_FIRST_OBS_DAYS=${ASIM_MIN_DAY_GREG}
      export NL_FIRST_OBS_SECONDS=${ASIM_MIN_SEC_GREG}
      export NL_LAST_OBS_DAYS=${ASIM_MAX_DAY_GREG}
      export NL_LAST_OBS_SECONDS=${ASIM_MAX_SEC_GREG}
      export NL_SYNONYMOUS_COPY_LIST="'NCEP BUFR observation','MOPITT CO observation','IASI CO observation','IASI O3 observation','OMI O3 observation','OMI NO2 observation','OMI SO2 observation','OMI HCHO observation','TROPOMI CO observation','TROPOMI O3 observation','TROPOMI NO2 observation','TROPOMI SO2 observation','TROPOMI CH4 observation','TROPOMI HCHO observation','TEMPO O3 observation','TEMPO NO2 observation','AIRNOW observation','MODIS observation','TES CO observation','TES CO2 observation','TES O3 observation','TES NH3 observation','TES CH4 observation','CRIS CO observation','CRIS O3 observation','CRIS NH3 observation','CRIS CH4 observation','CRIS PAN observation','SCIAM NO2 observation','GOME2A NO2 observation','MLS O3 observation','MLS HNO3 observation','OMI NO2 DOMINO observation'"
      export NL_SYNONYMOUS_QC_LIST="'NCEP QC index','MOPITT CO QC index','IASI CO QC index','IASI O3 QC index','OMI O3 QC index','OMI NO2 QC index','OMI SO2 QC index','OMI HCHO QC index','TROPOMI CO QC index','TROPOMI O3 QC index','TROPOMI NO2 QC index','TROPOMI SO2 QC index','TROPOMI CH4 QC index','TROPOMI HCHO QC index','TEMPO O3 QC index','TEMPO NO2 QC index','AIRNOW QC index','MODIS QC index','TES CO QC index','TES CO2 QC index','TES O3 QC index','TES NH3 QC index','TES CH4 QC index','CRIS CO QC index','CRIS O3 QC index','CRIS NH3 QC index','CRIS CH4 QC index','CRIS PAN QC index','SCIAM NO2 QC index','GOME2A NO2 QC index','MLS O3 QC index','MLS HNO3 QC index','OMI NO2 DOMINO QC index'"
      rm -rf input.nml
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NOX=${USE_LOG_NOX_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_HNO3=${USE_LOG_HNO3_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
      ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_dart_input_nml.ksh
      ./obs_sequence_tool > index.html 2>&1
      mv obs_seq.proc obs_seq_comb_${DATE}.out
      rm -rf dart_log* input.nml obs_sequence_tool
