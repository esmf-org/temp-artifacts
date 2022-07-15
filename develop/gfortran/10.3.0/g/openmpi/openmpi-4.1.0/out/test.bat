#!/bin/bash -l
export JOBID=NO_BATCH
module load gfortran-10.3.0 openmpi-4.1.0
module load netcdf-4.7.4

set -x
export PATH=/home/rocky/esmfdev/cmake-3.22.1-install/bin:$PATH
export ESMF_DIR=/home/rocky/esmfdev/esmf-testing-scratch2/gfortran_10.3.0_openmpi_g_develop/esmf
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /home/rocky/esmfdev/esmf-testing-scratch2/gfortran_10.3.0_openmpi_g_develop/module-test.log
cd /home/rocky/esmfdev/esmf-testing-scratch2/gfortran_10.3.0_openmpi_g_develop/esmf
echo 'FAKE TEST JOB COMPLETE' >> ../test.log
