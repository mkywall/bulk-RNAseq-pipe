#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=30:00:00
#SBATCH --partition=standard
#SBATCH --account=xxx
#SBATCH --mem=100000

module load anaconda3

conda env create --name sm-qpbulk --file environment_QPbulk.yaml
source activate sm-qpbulk

snakemake -s Snakefile_xxx --cores 10
