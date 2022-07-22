#!/bin/sh -l
#SBATCH --account=hfv3gfs
#SBATCH -o /lfs4/HFIP/hfv3gfs/Mark.Potts/esmf-tests/intel_2020.2_intelmpi_O_develop/test.bat_%j.o
#SBATCH -e /lfs4/HFIP/hfv3gfs/Mark.Potts/esmf-tests/intel_2020.2_intelmpi_O_develop/test.bat_%j.e
#SBATCH --time=2:00:00
#SBATCH --partition=xjet
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load cmake
module load intel/2020.2 impi/2020.2
module load netcdf/4.7.0
module load hdf5/1.10.6

set -x
export ESMF_DIR=/lfs4/HFIP/hfv3gfs/Mark.Potts/esmf-tests/intel_2020.2_intelmpi_O_develop/esmf
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /lfs4/HFIP/hfv3gfs/Mark.Potts/esmf-tests/intel_2020.2_intelmpi_O_develop/module-test.log
cd /lfs4/HFIP/hfv3gfs/Mark.Potts/esmf-tests/intel_2020.2_intelmpi_O_develop/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd ../nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc.log
