#!/bin/bash
#SBATCH --job-name="compile_ECOMAN2.0-geodynamics/compile.log"
#SBATCH --output=/home/nredick/nredick-pfs/mysoftware/ECOMAN2.0-geodynamics/%x_%j.out
#SBATCH --error=/home/nredick/nredick-pfs/mysoftware/ECOMAN2.0-geodynamics/%x_%j.err
#SBATCH --time=0:30:00                      # 30 mins
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=high
#SBATCH --mem=512G                          # to use magali's nodes
#SBATCH --constraint='zen|zen2|zen3'        # do not run or compile on zen4 nodes
#SBATCH --account=billengrp
#SBATCH --mail-type=end
#SBATCH --mail-user=nrredick@ucdavis.edu
#SBATCH --chdir=/quobyte/billengrp/nredick/mysoftware/ECOMAN2.0-geodynamics

###################################################################################
### this script compiles the D-REX_M and VIZTOMO codes in ECOMAN2.0-geodynamics ###
###################################################################################

# load modules
module load hdf5/1.14.5%oneapi@2025.0.0
module load openmpi/5.0.5%oneapi@2025.0.0
module load pmix/5.0.3%oneapi@2025.0.0 ucx/1.17.0%oneapi@2025.0.0 intel-oneapi-mkl/2024.0.0%oneapi@2025.0.0     # added 2026.02.09 for compatibility with changes to openmpi

# module load openmpi hdf5

### COMPILE D-REX_M

# enter the D-REX_M dir 
cd ./D-REX_M

# run the compilation script 
srun bash_compile_redick 

### COMPILE VIZTOMO

cd ../VIZTOMO

srun bash_compile_redick

exit 0 
