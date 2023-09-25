#!/bin/ksh -aux
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
   export NL_AUXINPUT2_INNAME=\'wrfinput_d\<domain\>\'
   export NL_AUXINPUT5_INNAME=\'wrfchemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT6_INNAME=\'wrfbiochemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT7_INNAME=\'wrffirechemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT12_INNAME=\'wrfinput_d\<domain\>\'
   export NL_AUXINPUT2_INTERVAL_M=60480,60480
   export NL_AUXINPUT5_INTERVAL_M=60,60
   export NL_AUXINPUT6_INTERVAL_M=60480,60480
   export NL_AUXINPUT7_INTERVAL_M=60,60
   export NL_AUXINPUT12_INTERVAL_M=60480,60480
   export NL_FRAMES_PER_AUXINPUT2=1,1
   export NL_FRAMES_PER_AUXINPUT5=1,1
   export NL_FRAMES_PER_AUXINPUT6=1,1
   export NL_FRAMES_PER_AUXINPUT7=1,1
   export NL_FRAMES_PER_AUXINPUT12=1,1
   export NL_IO_FORM_AUXINPUT2=2
   export NL_IO_FORM_AUXINPUT5=2
   export NL_IO_FORM_AUXINPUT6=2
   export NL_IO_FORM_AUXINPUT7=2
   export NL_IO_FORM_AUXINPUT12=2
   export NL_IOFIELDS_FILENAME=\'hist_io_flds_v1\',\'hist_io_flds_v2\'
   export NL_WRITE_INPUT=".true."
   export NL_INPUTOUT_INTERVAL=360
   export NL_INPUT_OUTNAME=\'wrfapm_d\<domain\>_\<date\>\'
   export NL_FORCE_USE_OLD_DATA=".true."
#
# DOMAINS NAMELIST:
   export NL_TIME_STEP=60
   export NNL_TIME_STEP=${NL_TIME_STEP}
   export NL_TIME_STEP_FRACT_NUM=0
   export NL_TIME_STEP_FRACT_DEN=1
#
   export NL_USE_ADAPTIVE_TIME_STEP=".true."
   export NL_STEP_TO_OUTPUT_TIME=".true."
   export NL_TARGET_CFL=1.2
   export NL_TARGET_HCFL=.84
   export NL_MAX_STEP_INCREASE_PCT=5
   export NL_STARTING_TIME_STEP=15
   export NL_STARTING_TIME_STEP_DEN=1
   export NL_MAX_TIME_STEP=90
   export NL_MAX_TIME_STEP_DEN=1
   export NL_MIN_TIME_STEP=30
   export NL_MIN_TIME_STEP_DEN=1
#
   export NL_MAX_DOM=${MAX_DOMAINS}
   export NL_S_WE=1,1
   export NL_E_WE=${NNXP_STAG_CR},${NNXP_STAG_FR}
   export NL_S_SN=1,1
   export NL_E_SN=${NNYP_STAG_CR},${NNYP_STAG_FR}
   export NL_S_VERT=1,1
   export NL_E_VERT=${NNZP_STAG_CR},${NNZP_STAG_FR}
   export NL_NUM_METGRID_LEVELS=27
   export NL_NUM_METGRID_SOIL_LEVELS=4
   export NL_DX=${DX_CR},${DX_FR}
   export NL_DY=${DX_CR},${DX_FR}
   export NL_GRID_ID=1,2
   export NL_PARENT_ID=0,1
   export NL_I_PARENT_START=${ISTR_CR},${ISTR_FR}
   export NL_J_PARENT_START=${JSTR_CR},${JSTR_FR}
   export NL_PARENT_GRID_RATIO=1,5
   export NL_PARENT_TIME_STEP_RATIO=1,5
   export NL_FEEDBACK=0
   export NL_SMOOTH_OPTION=1
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
   export NL_P_TOP_REQUESTED=1000.
   export NL_ETA_LEVELS=1.000000,0.996200,0.989737,0.982460,0.974381,0.965422,\
0.955498,0.944507,0.932347,0.918907,0.904075,0.887721,0.869715,0.849928,\
0.828211,0.804436,0.778472,0.750192,0.719474,0.686214,0.650339,0.611803,\
0.570656,0.526958,0.480854,0.432582,0.382474,0.330973,0.278674,0.226390,\
0.175086,0.132183,0.096211,0.065616,0.039773,0.018113,0.000000,
#
# PHYSICS NAMELIST:
   export NL_MP_PHYSICS=8,8
   export NL_RA_LW_PHYSICS=4,4
   export NL_RA_SW_PHYSICS=4,4
   export NL_RADT=15,3
   export NL_SF_SFCLAY_PHYSICS=1,1
   export NL_SF_SURFACE_PHYSICS=2,2
   export NL_BL_PBL_PHYSICS=1,1
   export NL_BLDT=0,0
   export NL_CU_PHYSICS=1,0
   export NL_CUDT=0,0
   export NL_CUGD_AVEDX=1
   export NL_CU_RAD_FEEDBACK=".true.",".true."
   export NL_CU_DIAG=0,0
   export NL_ISFFLX=1
   export NL_IFSNOW=0
   export NL_ICLOUD=1
   export NL_SURFACE_INPUT_SOURCE=1
   export NL_NUM_SOIL_LAYERS=4
   export NL_MP_ZERO_OUT=2
   export NL_NUM_LAND_CAT=28
   export NL_SF_URBAN_PHYSICS=1,1
   export NL_MAXIENS=1
   export NL_MAXENS=3
   export NL_MAXENS2=3
   export NL_MAXENS3=16
   export NL_ENSDIM=144
#
# DYNAMICS NAMELIST:
   export NL_ISO_TEMP=200.
   export NL_TRACER_OPT=0,0
   export NL_W_DAMPING=1
   export NL_DIFF_OPT=2
   export NL_DIFF_6TH_OPT=0,0
   export NL_DIFF_6TH_FACTOR=0.12,0.12
   export NL_KM_OPT=4
   export NL_DAMP_OPT=1
   export NL_ZDAMP=5000,5000
   export NL_DAMPCOEF=0.15,0.15
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
   export NL_HYBRID_OPT=0
#
# BDY_CONTROL NAMELIST:
   export NL_SPEC_BDY_WIDTH=5
   export NL_SPEC_ZONE=1
   export NL_RELAX_ZONE=4
   export NL_SPECIFIED=".true.",".false."
   export NL_NESTED=".false.",".true."
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
   export NL_CHEM_OPT=112,112
   export NL_BIOEMDT=0,0
   export NL_PHOTDT=0,0
   export NL_CHEMDT=0,0
   export NL_IO_STYLE_EMISSIONS=2
   export NL_EMISS_INPT_OPT=111,111
   export NL_EMISS_OPT=8,8
   export NL_EMISS_OPT_VOL=0,0
   export NL_CHEM_IN_OPT=1,1
   export NL_PHOT_OPT=3,3
   export NL_GAS_DRYDEP_OPT=1,1
   export NL_AER_DRYDEP_OPT=1,1
   export NL_BIO_EMISS_OPT=3,3
   export NL_NE_AREA=118
   export NL_GAS_BC_OPT=112,112
   export NL_GAS_IC_OPT=112,112
   export NL_GAS_BC_OPT=112,112
   export NL_AER_BC_OPT=112,112
   export NL_AER_IC_OPT=112,112
   export NL_GASCHEM_ONOFF=1,1
   export NL_AERCHEM_ONOFF=1,1
#
# APM NO_CHEM
#   export NL_WETSCAV_ONOFF=0,0
   export NL_WETSCAV_ONOFF=1,1
   export NL_CLDCHEM_ONOFF=0,0
   export NL_VERTMIX_ONOFF=1,1
   export NL_CHEM_CONV_TR=0,0
   export NL_CONV_TR_WETSCAV=1,1
   export NL_CONV_TR_AQCHEM=0,0
   export NL_SEAS_OPT=0
#
# APM NO_CHEM
#   export NL_DUST_OPT=0
   export NL_DUST_OPT=1
   export NL_DMSEMIS_OPT=1
   export NL_BIOMASS_BURN_OPT=2,2
   export NL_PLUMERISEFIRE_FRQ=15,15
   export NL_SCALE_FIRE_EMISS=".true.",".true."
   export NL_HAVE_BCS_CHEM=".true.",".true."
#
# APM NO_CHEM
   export NL_AER_RA_FEEDBACK=0,0
#   export NL_AER_RA_FEEDBACK=1,1
   export NL_CHEMDIAG=0,1
   export NL_AER_OP_OPT=1
   export NL_OPT_PARS_OUT=1
   export NL_HAVE_BCS_UPPER=".true.",".true."
   export NL_FIXED_UBC_PRESS=50.,50.
   export NL_FIXED_UBC_INNAME=\'ubvals_b40.20th.track1_1996-2005.nc\'
#
   
