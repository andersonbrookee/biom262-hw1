#!/bin/csh
#PBS -q <queue name>
#PBS -N <job name>
#PBS -l nodes=10:ppn=2
#PBS -l walltime=0:50:00
#PBS -o <output file>
#PBS -e <error file>
#PBS -V
#PBS -M <email address list>
#PBS -m abe
#PBS -A <account>
cd /oasis/tscc/scratch/<user name>
mpirun -v -machinefile $PBS_NODEFILE -np 20 <./mpi.out>

awk '{if ($4=="NFKB") print}' tf.bed > tf.nfkb.bed
awk '{if ($3=="transcript") print}' data/gencode.v19.annotation.chr22.gtf > gencode.v19.annotation.chr22.transcript.gtf
module load biotools
bedtools flank -i gencode.v19.annotation.chr22.transcript.gtf -g data/hg19.genome -l 2000 -r 0 -s > gencode.v19.annotation.chr22.transcript.promoter.gtf

