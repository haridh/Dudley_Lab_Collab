# Transition-finder
This script can be used to identify sites of G to A and C to T mismatches between a given reference fasta sequence and user generated set of fasta sequences (Test sequences). This script takes two files- (1) Reference file in fasta format and (2) Test file containing multiple fasta sequences. 

# Usage:

perl Finding_G_A_C_T_mutations_spanning_nucleotides_with_trinuc_freq.pl reference_file.txt sequence_file.txt

This will output four files:
1. G_A_mutations.txt - Contains mutation type, mutated position on reference and trinucleotide (Mutated G and two following nucleotides)
2. C_T_mutations.txt - Contains mutation type, mutated position on reference and trinucleotide (Mutated C and two preceding nucleotides)
3. G_A_Freq.txt - Trinucleotide (from G_A_mutations.txt file) and the number of times this trinucleotide was mutated in "Sequence file". 
3. C_T_Freq.txt - Trinucleotide (from C_T_mutations.txt file) and the number of times this trinucleotide was mutated in "Sequence file". 

# Example:
Input files:

Reference file:
>
ATG
CCCGT
TAACCTA

Sequence file:
>
A
TA
CGTGTTGACT
GA
>
GCAC
CAGTTGACTGG
>
CGACCGGTTG
ACTGT
>
CAACC
TGTTGACTGG

Output files:

C_T_mutations.txt  

Mutation	Position	Spanning_nucleotides
C to T	6	CCC
C to T	13	ACC
C to T	13	ACC
C to T	13	ACC
C to T	6	CCC
C to T	13	ACC

C_T_Freq.txt

Spanning_nucleotides	Frequency
ACC	4
CCC	2
