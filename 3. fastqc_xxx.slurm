#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=30:00:00
#SBATCH --partition=standard
#SBATCH --account=alzgen
#SBATCH --mem=100000

module load fastqc

MERGE_DIR=path/to/merged/reads/reads
FILT_DIR=path/to/filtered/reads/filtered
TRIM_DIR=path/to/trimmed/reads/trim_results

MERGE_OUTPUT_DIR=path/to/save/mergedread/QCfiles/merge_QC
FILT_OUTPUT_DIR=/path/to/save/filteredread/QCfiles/filt_QC
TRIM_OUTPUT_DIR=/path/to/save/trimmedread/QCfiles/trim_QC



merge_qc_func () {
  local file=$1
  echo "$file"
  srun fastqc $file --outdir $MERGE_OUTPUT_DIR
}

filt_qc_func () {
  local file=$1
  echo "$file"
  srun fastqc $file --outdir $FILT_OUTPUT_DIR
}


trim_qc_func () {
  local file=$1
  echo "$file"
  srun fastqc $file --outdir $TRIM_OUTPUT_DIR
}

# Doing QC in parallel
for file in $MERGE_DIR/*; do merge_qc_func "$file" & done
wait

for file in $FILT_DIR/*; do filt_qc_func "$file" & done
wait

for file in $TRIM_DIR/*; do trim_qc_func "$file" & done
wait
 