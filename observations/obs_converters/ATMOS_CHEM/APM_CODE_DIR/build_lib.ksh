#!/bin/ksh -aux


#ifort -c model_fields_vertlocl.f90 mapping_code.f90 cpsr_code.f90 time_code.f90 upper_bdy_code.f90
ifort -c model_fields_vertlocl.f90 mapping_code.f90 cpsr_code.f90 time_code.f90

#ar cr libapm_code.a model_fields_vertlocl.o mapping_code.o cpsr_code.o time_code.o upper_bdy_code.o
ar cr libapm_code.a model_fields_vertlocl.o mapping_code.o cpsr_code.o time_code.o

rm -rf *.o

