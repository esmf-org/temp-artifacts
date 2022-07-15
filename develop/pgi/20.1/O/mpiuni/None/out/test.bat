#!/bin/sh -l
#PBS -N test.bat
#PBS -l walltime=3:00:00
#PBS -q medium
#PBS -A UNUSED
#PBS -l nodes=1:ppn=48
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

module load compiler/pgi/20.1 
module load tool/netcdf/4.7.4/pgi/20.1

set -x
export ESMF_DIR=/scratch/cluster/dunlap/esmf-test-dev/pgi_20.1_mpiuni_O_develop/esmf
export ESMF_COMPILER=pgi
export ESMF_COMM=mpiuni
export ESMF_NETCDF=nc-config
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
export ESMF_MPIRUN=/scratch/cluster/dunlap/esmf-test-dev/pgi_20.1_mpiuni_O_develop/esmf/src/Infrastructure/stubs/mpiuni/mpirun
module list >& /scratch/cluster/dunlap/esmf-test-dev/pgi_20.1_mpiuni_O_develop/module-test.log
cd /scratch/cluster/dunlap/esmf-test-dev/pgi_20.1_mpiuni_O_develop/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
