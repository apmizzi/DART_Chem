#!/bin/ksh -aux
#
# CPSR Truncation (limit the number of CPSR modes assimilated)
   export NL_USE_CPSR_CO_TRUNC=.false.
   export NL_CPSR_CO_TRUNC_LIM=4
   export NL_USE_CPSR_O3_TRUNC=.false.
   export NL_CPSR_O3_TRUNC_LIM=4
#
