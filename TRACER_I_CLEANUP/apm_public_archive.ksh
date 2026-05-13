#!/bin/ksh -aux
   export NUM_MEMBERS=30
   export WRFDA_VER=WRFDAv4.3.2_dmpar
   export BUILD_DIR=/nobackupp28/amizzi/TRUNK/${WRFDA_VER}/var/build
   export NUM_EXPS=20
   export OUTPUT_DIR_PATH=/nobackupp28/amizzi/OUTPUT_DATA
#
   export EXP_INPUT_DIR[1]=INPUT_2005_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[2]=INPUT_2006_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[3]=INPUT_2007_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[4]=INPUT_2008_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[5]=INPUT_2009_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[6]=INPUT_2010_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[7]=INPUT_2011_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[8]=INPUT_2012_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[9]=INPUT_2013_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[10]=INPUT_2014_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[11]=INPUT_2015_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[12]=INPUT_2016_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[13]=INPUT_2017_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[14]=INPUT_2018_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[15]=INPUT_2019_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[16]=INPUT_2020_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[17]=INPUT_2021_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[18]=INPUT_2022_NOAA_EMISADJ_30MEMS
   export EXP_INPUT_DIR[19]=INPUT_2023_NOAA_EMISADJ_30MEMS
#
   export EXP_OUTPUT_DIR[1]=OUTPUT_2005_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[2]=OUTPUT_2006_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[3]=OUTPUT_2007_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[4]=OUTPUT_2008_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[5]=OUTPUT_2009_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[6]=OUTPUT_2010_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[7]=OUTPUT_2011_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[8]=OUTPUT_2012_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[9]=OUTPUT_2013_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[10]=OUTPUT_2014_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[11]=OUTPUT_2015_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[12]=OUTPUT_2016_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[13]=OUTPUT_2017_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[14]=OUTPUT_2018_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[15]=OUTPUT_2019_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[16]=OUTPUT_2020_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[17]=OUTPUT_2021_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[18]=OUTPUT_2022_NOAA_EMISADJ_30MEMS
   export EXP_OUTPUT_DIR[19]=OUTPUT_2023_NOAA_EMISADJ_30MEMS
#
   export DATE_YYYY_INC=1
   export DATE_DIR_INC=3
   export DATE_YYYY_STR=2011
   export DATE_YYYY_END=2011
   export DATE_YYYY=${DATE_YYYY_STR}
   export MMDDHH_STR=040218
   export MMDDHH_END=040218
   export MMDDHH=${MMDDHH_STR}
#
# If DATE_YYYY_STR does not equal 2005, ICNT needs to be adjusted to the correct index
   let ICNT=${DATE_YYYY_STR}-2005
#
   while [[ ${DATE_YYYY} -le ${DATE_YYYY_END} ]]; do
      let ICNT=${ICNT}+1
#
# INPUT_DIR file deletion
# OUTPUT_DIR file deletion
      export DATE_DIR_STR=${DATE_YYYY}${MMDDHH_STR}
      export DATE_DIR_END=${DATE_YYYY}${MMDDHH_END}
      export DATE_DIR=${DATE_DIR_STR}
      while [[ ${DATE_DIR} -le ${DATE_DIR_END} ]]; do
         export L_DATE=${DATE_DIR}
         export L_DATE_END=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${DATE_DIR_INC} 2>/dev/null)
         let DCNT=1
	 while [[ ${L_DATE} -le ${L_DATE_END} ]]; do 
            export YYYY=$(echo ${L_DATE} | cut -c1-4)
            export MM=$(echo ${L_DATE} | cut -c5-6)
            export DD=$(echo ${L_DATE} | cut -c7-8)
            export HH=$(echo ${L_DATE} | cut -c9-10)
            export FILE_DATE[DCNT]=${YYYY}-${MM}-${DD}_${HH}:00:00
	    let DCNT=${DCNT}+1
            export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
         done
#
         export PUBLIC_ARCHIVE_DIR=${OUTPUT_DIR_PATH}/PUBLIC_ARCHIVE/${EXP_INPUT_DIR[${ICNT}]}/${DATE_DIR}
	 mkdir -p ${PUBLIC_ARCHIVE_DIR} 
         cd ${OUTPUT_DIR_PATH}/${EXP_OUTPUT_DIR[${ICNT}]}/${DATE_DIR}
#
# Copy files to public archive
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10 ]]; then export CMEM=e00${MEM}; fi
            export L_RUN_DIR=run_${CMEM}
#
# wrfchem_initial
#            echo 'APM: Copy wrfchem_initial/'${L_RUN_DIR}'/wrfchemi_d01_'${FILE_DATE[1]}.${CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrfchemi_d01_${FILE_DATE[1]} ${PUBLIC_ARCHIVE_DIR}/wrfchemi_d01_${FILE_DATE[1]}.$(CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrfchemi_d01_${FILE_DATE[2]} ${PUBLIC_ARCHIVE_DIR}/wrfchemi_d01_${FILE_DATE[2]}.$(CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrfchemi_d01_${FILE_DATE[3]} ${PUBLIC_ARCHIVE_DIR}/wrfchemi_d01_${FILE_DATE[3]}.$(CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrfchemi_d01_${FILE_DATE[4]} ${PUBLIC_ARCHIVE_DIR}/wrfchemi_d01_${FILE_DATE[4]}.$(CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrffirechemi_d01_${FILE_DATE[1]} ${PUBLIC_ARCHIVE_DIR}/wrffirechemi_d01_${FILE_DATE[1]}.$(CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrffirechemi_d01_${FILE_DATE[2]} ${PUBLIC_ARCHIVE_DIR}/wrffirechemi_d01_${FILE_DATE[2]}.$(CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrffirechemi_d01_${FILE_DATE[3]} ${PUBLIC_ARCHIVE_DIR}/wrffirechemi_d01_${FILE_DATE[3]}.$(CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrffirechemi_d01_${FILE_DATE[4]} ${PUBLIC_ARCHIVE_DIR}/wrffirechemi_d01_${FILE_DATE[4]}.$(CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrfout_d01_${FILE_DATE[1]} ${PUBLIC_ARCHIVE_DIR}/wrfout_d01_${FILE_DATE[1]}.$(CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrfout_d01_${FILE_DATE[2]} ${PUBLIC_ARCHIVE_DIR}/wrfout_d01_${FILE_DATE[2]}.$(CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrfout_d01_${FILE_DATE[3]} ${PUBLIC_ARCHIVE_DIR}/wrfout_d01_${FILE_DATE[3]}.$(CMEM}
#            cp -r wrfchem_initial/${L_RUN_DIR}/wrfout_d01_${FILE_DATE[4]} ${PUBLIC_ARCHIVE_DIR}/wrfout_d01_${FILE_DATE[4]}.$(CMEM}
#
# wrfchem_cycle_cr
            touch ${PUBLIC_ARCHIVE_DIR}/wrfout_d01_${FILE_DATE[1]}.${CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrfchemi_d01_${FILE_DATE[1]} ${PUBLIC_ARCHIVE_DIR}/wrfchemi_d01_${FILE_DATE[1]}.$(CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrfchemi_d01_${FILE_DATE[2]} ${PUBLIC_ARCHIVE_DIR}/wrfchemi_d01_${FILE_DATE[2]}.$(CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrfchemi_d01_${FILE_DATE[3]} ${PUBLIC_ARCHIVE_DIR}/wrfchemi_d01_${FILE_DATE[3]}.$(CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrfchemi_d01_${FILE_DATE[4]} ${PUBLIC_ARCHIVE_DIR}/wrfchemi_d01_${FILE_DATE[4]}.$(CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrffirechemi_d01_${FILE_DATE[1]} ${PUBLIC_ARCHIVE_DIR}/wrffirechemi_d01_${FILE_DATE[1]}.$(CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrffirechemi_d01_${FILE_DATE[2]} ${PUBLIC_ARCHIVE_DIR}/wrffirechemi_d01_${FILE_DATE[2]}.$(CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrffirechemi_d01_${FILE_DATE[3]} ${PUBLIC_ARCHIVE_DIR}/wrffirechemi_d01_${FILE_DATE[3]}.$(CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrffirechemi_d01_${FILE_DATE[4]} ${PUBLIC_ARCHIVE_DIR}/wrffirechemi_d01_${FILE_DATE[4]}.$(CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrfout_d01_${FILE_DATE[1]} ${PUBLIC_ARCHIVE_DIR}/wrfout_d01_${FILE_DATE[1]}.$(CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrfout_d01_${FILE_DATE[2]} ${PUBLIC_ARCHIVE_DIR}/wrfout_d01_${FILE_DATE[2]}.$(CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrfout_d01_${FILE_DATE[3]} ${PUBLIC_ARCHIVE_DIR}/wrfout_d01_${FILE_DATE[3]}.$(CMEM}
#            cp -r wrfchem_cycle_cr/${L_RUN_DIR}/wrfout_d01_${FILE_DATE[4]} ${PUBLIC_ARCHIVE_DIR}/wrfout_d01_${FILE_DATE[4]}.$(CMEM}
            let MEM=${MEM}+1
         done
         export DATE_DIR=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} ${DATE_DIR_INC} 2>/dev/null)
      done
   let DATE_YYYY=${DATE_YYYY}+${DATE_YYYY_INC}
done
echo "APM: End of files delete script "
exit
   
