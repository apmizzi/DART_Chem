#!/bin/ksh -aeux 
#
   ifort -C test_o3_bdy.f90 -o test_o3_bdy.exe -I$NETCDF_DIR/include -L$NETCDF_DIR/lib -lnetcdff -lnetcdf
#
#   rm -rf index_test_o3_bdy
#   ./test_o3_bdy.exe > index_test_o3_bdy
   ./test_o3_bdy.exe
#
   exit   
