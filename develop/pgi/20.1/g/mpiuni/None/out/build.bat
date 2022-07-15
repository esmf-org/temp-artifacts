#!/bin/sh -l
#PBS -N build.bat
#PBS -l walltime=1:00:00
#PBS -q medium
#PBS -A UNUSED
#PBS -l nodes=1:ppn=48
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

module load compiler/pgi/20.1 
module load tool/netcdf/4.7.4/pgi/20.1

set -x
export ESMF_DIR=/scratch/cluster/dunlap/esmf-test-dev/pgi_20.1_mpiuni_g_develop/esmf
export ESMF_COMPILER=pgi
export ESMF_COMM=mpiuni
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
export ESMF_MPIRUN=/scratch/cluster/dunlap/esmf-test-dev/pgi_20.1_mpiuni_g_develop/esmf/src/Infrastructure/stubs/mpiuni/mpirun
module list >& /scratch/cluster/dunlap/esmf-test-dev/pgi_20.1_mpiuni_g_develop/module-build.log
cd /scratch/cluster/dunlap/esmf-test-dev/pgi_20.1_mpiuni_g_develop/esmf
make info 2>&1| tee ../info.log
make -j 48 2>&1| tee ../build.log
