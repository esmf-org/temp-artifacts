#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o /work/noaa/nems/tufuk/esmf-test-scripts/python_scripts/test/intel_2020.2_intelmpi_g_develop/test.bat_%j.o
#SBATCH -e /work/noaa/nems/tufuk/esmf-test-scripts/python_scripts/test/intel_2020.2_intelmpi_g_develop/test.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=orion
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load intelpython3 cmake
module load intel/2020.2 impi/2020.2
module load netcdf/4.7.4

set -x
export ESMF_DIR=/work/noaa/nems/tufuk/esmf-test-scripts/python_scripts/test/intel_2020.2_intelmpi_g_develop/esmf
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /work/noaa/nems/tufuk/esmf-test-scripts/python_scripts/test/intel_2020.2_intelmpi_g_develop/module-test.log
cd /work/noaa/nems/tufuk/esmf-test-scripts/python_scripts/test/intel_2020.2_intelmpi_g_develop/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd ../nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc.log
