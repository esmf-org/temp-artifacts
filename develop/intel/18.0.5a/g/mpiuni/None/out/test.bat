#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-test-dev/intel_18.0.5a_mpiuni_g_develop/test.bat_%j.o
#SBATCH -e /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-test-dev/intel_18.0.5a_mpiuni_g_develop/test.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load intel/18.0.5.274 
module load netcdf/4.6.1

set -x
tar xvfz ~/pytest-input.tar.gz
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-test-dev/intel_18.0.5a_mpiuni_g_develop/esmf
export ESMF_COMPILER=intel
export ESMF_COMM=mpiuni
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
export ESMF_MPIRUN=/scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-test-dev/intel_18.0.5a_mpiuni_g_develop/esmf/src/Infrastructure/stubs/mpiuni/mpirun
module list >& /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-test-dev/intel_18.0.5a_mpiuni_g_develop/module-test.log
cd /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-test-dev/intel_18.0.5a_mpiuni_g_develop/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
