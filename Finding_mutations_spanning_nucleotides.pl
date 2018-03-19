#!/usr/bin/perl/
use strict;
if(@ARGV != 5)
{
   print("\nCheck command Usage: perl Finding_mutations_spanning_nucleotides.pl reference_file.txt sequence_file.txt reference_nucleotide sequence_nucleotide outputfile\n\n");
   exit;
}
my($ref) = $ARGV[0];
my($seq) = $ARGV[1];
my($refNUC) = $ARGV[2];
my($seqNUC) = $ARGV[3];
my($output) = $ARGV[4];
open(OUT,">$output");
print OUT ("Mutation\tPosition\tSpanning_nucleotides\n");
local ($/) = ">";
open(A, $ref);
while(<A>)
{
   chomp $_;
   $a = $_;
}
$a =~ s/\n+//g;
$a =~ s/\r+//g;
my($c) = length($a);
local ($/) = ">";
open(B, $seq);
my($b);
while($b = <B>) {
   chomp $b;
   $b =~ s/\n+//g;
   $b =~ s/\r+//g;
   for(0 .. length($a))
   {
      my($temp1) = substr($a, $_, 1);
      my($temp2) = substr($b, $_, 1);
      if($temp1 ne $temp2)
      {
         if($temp1 =~ /$refNUC/ && $temp2 =~ /$seqNUC/)
         {
            if($_ >= 1)
            {
               if($_ <= ($c-3))
               {
                  my($m) = substr($a,$_-2,5);
                  my($g) = $_+1;
                  print OUT ("$refNUC to $seqNUC\t$g\t$m\n");
               }
               elsif($_==($c-2))
               {
                  my($m) = substr($a,$_-1,3);
                  my($g) = $_+1;
                  print OUT ("$refNUC to $seqNUC\t$g\t$m\n");
               }
               else
               {
                  my($m) = substr($a,$_-2,3);
                  my($g) = $_+1;
                  print OUT ("$refNUC to $seqNUC\t$g\t$m\n");
               }
            }
            elsif($_== 1)
            {
               my($m) = substr($a,$_-1,3);
               my($g) = $_+1;
               print OUT ("$refNUC to $seqNUC\t$g\t$m\n");
            }
            elsif($_==($c-1))
            {
               my($m) = substr($a,$_-2,3);
               my($g) = $_+1;
               print OUT ("$refNUC to $seqNUC\t$g\t$m\n");
            }
            else
            {
               my($m) = substr($a,$_,3);
               my($g) = $_+1;
               print OUT ("$refNUC to $seqNUC\t$g\t$m\n"); 
            }
         }
      }
   }
}

