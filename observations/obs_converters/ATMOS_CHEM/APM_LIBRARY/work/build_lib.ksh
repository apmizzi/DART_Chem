#!/bin/ksh -aux

export APM_CODE_PATH=../../APM_CODE_DIR

ifort -c ${APM_CODE_PATH}/model_fields_vertlocl.f90 ${APM_CODE_PATH}/mapping_code.f90 ${APM_CODE_PATH}/cpsr_code.f90 ${APM_CODE_PATH}/time_code.f90 ${APM_CODE_PATH}/upper_bdy_code.f90 -I ./

ar cr libapm_code.a model_fields_vertlocl.o mapping_code.o cpsr_code.o time_code.o upper_bdy_code.o

cp libapm_code.a ../
