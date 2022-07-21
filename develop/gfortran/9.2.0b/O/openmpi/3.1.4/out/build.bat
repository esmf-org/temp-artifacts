#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-test-dev/gfortran_9.2.0b_openmpi_O_develop/build.bat_%j.o
#SBATCH -e /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-test-dev/gfortran_9.2.0b_openmpi_O_develop/build.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load gnu/9.2.0 openmpi/3.1.4

set -x
tar xvfz ~/pytest-input.tar.gz
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-test-dev/gfortran_9.2.0b_openmpi_O_develop/esmf
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-test-dev/gfortran_9.2.0b_openmpi_O_develop/module-build.log
cd /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-test-dev/gfortran_9.2.0b_openmpi_O_develop/esmf
set -o pipefail
make info 2>&1| tee ../info.log
make -j 40 2>&1| tee ../build.log
