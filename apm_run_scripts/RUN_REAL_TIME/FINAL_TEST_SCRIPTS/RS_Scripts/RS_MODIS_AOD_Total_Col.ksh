#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/modis_aod_total_col_obs
#
# SET MODIS PARAMETERS
      export MODIS_FILE_PRE='MYD04_L2.A'
      export MODIS_FILE_EXT='hdf'
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export MOD_OUTFILE=\'MODIS_AOD_${D_DATE}.dat\'
      export MOD_OUTFILE_NQ=MODIS_AOD_${D_DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${MOD_OUTFILE}
#
#  SET OBS WINDOW
      (( N_YYYY=${YYYY}+0 ))
      (( N_MM=${MM}+0 ))
      (( N_DD=${DD}+0 ))
      (( N_HH=${HH}+0 ))
      (( N_ASIM_WIN=${ASIM_WINDOW}+0 ))
#
# SET MODIS INPUT DATA FILE
      export MODIS_INDIR=${EXPERIMENT_MODIS_AOD_DIR}
#
# COPY EXECUTABLE
      export FILE=modis_aod_total_col_extract.pro
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MODIS_AOD/native_to_ascii/${FILE} ./.
#
      rm -rf job.ksh
      touch job.ksh
      RANDOM=$$
      export JOBRND=${RANDOM}_idl_modis
      cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile modis_aod_total_col_extract.pro
modis_aod_total_col_extract, "${MODIS_INDIR}", "${OUTFILE_NQ}", ${N_YYYY}, ${N_MM}, ${N_DD}, ${N_HH}, ${N_ASIM_WIN}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
fi
EOFF
#      qsub -Wblock=true job.ksh 
      chmod +x job.ksh
      ./job.ksh > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOD_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOD_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOD_OUTFILE_NQ}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOD_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOD_OUTFILE_NQ}
         rm -rf ${OUTFILE_NQ}
      fi
#
# SET NAMELIST TO CONVERT MODIS ASCII TO OBS_SEQ 
      export NL_MOD_OUTFILE=obs_seq_modis_aod_total_col_${DATE}.out
#
      export BIN_BEG_YR=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      export BIN_END_YR=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
#
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MODIS_AOD}
      export NL_FILENAME=modis_asciidata.input
#
# SETUP NAMELIST
      rm -rf create_modis_obs_nml.nl
      rm -rf input.nml
      rm -rf ${NL_FILENAME}
      cp ${MOD_OUTFILE_NQ} ${NL_FILENAME}
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_modis_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MODIS_AOD/work/modis_aod_total_col_ascii_to_obs ./.
#
# RUN OBS CONVERTER      
      ./modis_aod_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s modis_aod_total_col_obs_seq.out ]]; then
         mv modis_aod_total_col_obs_seq.out ${NL_MOD_OUTFILE}
      else
         touch NO_MODIS_AOD_${DATE}
      fi
#
# Clean directory
      rm create_modis* dart_log* input.nml job.ksh *.dat modis_aod_total*
      rm modis_asciidata*
