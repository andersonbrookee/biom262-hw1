#!/bin/csh
#PBS -q hotel
#PBS -N plumber
#PBS -l nodes=1:ppn=2
#PBS -l walltime=0:10:00
#PBS -o output
#PBS -e error
#PBS -V
#PBS -M eporetsky@ucsd.edu
#PBS -m abe

cd ~/code/biom262-2016/weeks/week01/data

#exercise 1
awk '{if ($4=="NFKB") print}' tf.bed > tf.nfkb.bed

wc -l tf.nfkb.bed
echo '--- First 10 lines ---'
head tf.nfkb.bed
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{print $0}'  tf.nfkb.bed | head
echo '--- Last 10 lines ---'
tail tf.nfkb.bed

#exercise 2
awk '{if ($3=="transcript") print}' gencode.v19.annotation.chr22.gtf > gencode.v19.annotation.chr22.transcript.gtf

wc -l gencode.v19.annotation.chr22.transcript.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.gtf
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{print $0}' gencode.v19.annotation.chr22.transcript.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.gtf

#exerice 3
module load biotools
bedtools flank -i gencode.v19.annotation.chr22.transcript.gtf -g hg19.genome -l 2000 -r 0 -s > gencode.v19.annotation.chr22.transcript.promoter.gtf

wc -l gencode.v19.annotation.chr22.transcript.promoter.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.gtf
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{print rand()" "$0}' gencode.v19.annotation.chr22.transcript.promoter.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.gtf

#exercise  4
module load biotools
bedtools intersect -a gencode.v19.annotation.chr22.transcript.promoter.gtf \
                             -b tf.nfkb.bed > gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf

wc -l gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
echo '--- Random 10 lines ---'
awk -v seed=908 'BEGIN{srand(seed);}{print $0}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf

#exercise 5
module load biotools
bedtools getfasta -s -fi GRCh37.p13.chr22.fa -bed gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf -fo gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta

wc -l gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
echo '--- Random 10 lines ---'
awk -v seed=908 'BEGIN{srand(seed);}{print $0}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta

#exercise 6
echo " "
echo "Exercise 6 - Count of patterns between 11mers and promoters"
grep -Ff gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta nfkb_11mer.txt | wc -l

echo " "
echo "Hello I am a message in standard out (stdout)"
echo "Hello I am a message in standard error (stderr)" >&2
