#!/bin/bash

#SBATCH -p standard
#SBATCH -A overall 
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=100000

MAP_DIR=/path/to/folder-with-aligned-reads/
OUTPUT_DIR=/path/to/save/the/renamed/quants/
SAMPLES="1911c_24I 1911c_24J 1911c_24K 1911c_24L 1911c_48I 1911c_48J 1911c_48K 1911c_48L"  # list of sample ids, seperated by spaces, whole list in quotes


rename_func () {
  sample=$sample_name
  echo "$sample_name"
  cp $MAP_DIR$sample'_transcripts_quan/quant.sf' $OUTPUT_DIR$sample'.sf'
}
# Doing normalization in parallel
for sample_name in $SAMPLES; do rename_func "$sample_name" & done
wait




