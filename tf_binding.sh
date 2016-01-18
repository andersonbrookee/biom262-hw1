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

#exercise  4
module load biotools
bedtools intersect -a gencode.v19.annotation.chr22.transcript.promoter.gtf \
                             -b tf.nfkb.bed > gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
#exercise 5
module load biotools
bedtools getfasta -s -fi GRCh37.p13.chr22.fa -bed gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf -fo gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta

#exercise 6
grep -Ff gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta nfkb_11mer.txt | wc -l
grep -v ^\> gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta  | wc -l
grep -v ^\> nfkb_11mer.txt | wc -l

