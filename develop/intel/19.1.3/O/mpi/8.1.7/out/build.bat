#!/bin/sh -l
#PBS -N build.bat
#PBS -l walltime=1:00:00
#PBS -q dev
#PBS -A GFS-DEV
#PBS -l select=1:ncpus=128:mpiprocs=128
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

module unload PrgEnv-cray PrgEnv-gnu
module load PrgEnv-intel cray-pals craype cmake
module load intel/19.1.3.304 cray-mpich/8.1.7
module load netcdf/4.7.4
module load hdf5/1.10.6

set -x
export ESMF_MPIRUN=mpirun.unicos
export ESMF_CXXCOMPILECPPFLAGS=-fPIC
export ESMF_CXXLINKOPTS="-fPIC -lnetcdff -lnetcdff"
export ESMF_NETCDF=nc-config
sed -i 's/^aprun/mpiexec/' scripts/mpirun.unicos
sed -i 's/lmpi++/lfmpich/' build_config/Linux.intel.default/build_rules.mk
export ESMF_DIR=/home/rocky/esmfdev/esmf-testing-scratch/intel_19.1.3_mpi_O_develop/esmf
export ESMF_COMPILER=intel
export ESMF_COMM=mpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /home/rocky/esmfdev/esmf-testing-scratch/intel_19.1.3_mpi_O_develop/module-build.log
cd /home/rocky/esmfdev/esmf-testing-scratch/intel_19.1.3_mpi_O_develop/esmf
set -o pipefail
make info 2>&1| tee ../info.log
echo `date` > ../build.log
echo 'FAKE BUILD JOB COMPLETE' >> ../build.log
