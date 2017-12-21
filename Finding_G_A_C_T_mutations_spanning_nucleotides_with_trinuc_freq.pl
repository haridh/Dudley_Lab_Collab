#!/usr/bin/perl/
use strict;
if(@ARGV != 2)
{
   print("\nCheck command Usage: perl Finding_G_A_C_T_mutations_spanning_nucleotides_with_trinuc_freq.pl reference_file.txt sequence_file.txt\n\n");
   exit;
}
my($ref) = $ARGV[0];
my($seq) = $ARGV[1];
my(%count1);
my(%count2);
my(@strings1);
my(@strings2);
open(OUT1,">G_A_mutations.txt");
open(OUT2,">C_T_mutations.txt");
open(OUT3,">G_A_Freq.txt");
open(OUT4,">C_T_Freq.txt");
print OUT1 ("Mutation\tPosition\tSpanning_nucleotides\n");
print OUT2 ("Mutation\tPosition\tSpanning_nucleotides\n");
print OUT3 ("Spanning_nucleotides\tFrequency\n");
print OUT4 ("Spanning_nucleotides\tFrequency\n");
my(@m);
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
         if($temp1 =~ /G/ && $temp2 =~ /A/)
         {
            if($_ <= ($c-3))
            {
               my($m) = substr($a,$_,3);
               my($g) = $_+1;
               print OUT1 ("$temp1 to $temp2\t$g\t$m\n");               
               push(@strings1, "$m");
            }
            elsif($_==($c-2))
            {
               my($m) = substr($a,$_,3);
               my($g) = $_+1;
               print OUT1 ("$temp1 to $temp2\t$g\t$m\n");
               push(@strings1, "$m");
            }
            else
            {
               my($m) = substr($a,$_,1);
               my($g) = $_+1;
               print OUT1 ("$temp1 to $temp2\t$g\t$m\nLast_nucleotise\n");
               push(@strings1, "$m");
            }
         }
         elsif($temp1 =~ /C/ && $temp2 =~ /T/)
         {
            if($_ <= ($c-3))
            {
               my($m) = substr($a,$_-2,3);
               my($g) = $_+1;
               print OUT2 ("$temp1 to $temp2\t$g\t$m\n");
               push(@strings2, "$m");
            }
            elsif($_==($c-2))
            {
               my($m) = substr($a,$_-2,3);
               my($g) = $_+1;
               print OUT2 ("$temp1 to $temp2\t$g\t$m\n");
               push(@strings2, "$m");
            }
            else
            {
               my($m) = substr($a,$_,1);
               my($g) = $_+1;
               print OUT2 ("$temp1 to $temp2\t$g\t$m\nLast_nucleotide\n");
               push(@strings2, "$m");
            }
         }
      }
   }
}
foreach my $str1 (@strings1)
{
   $count1{$str1}++;
}
foreach my $str1 (sort keys %count1)
{
   print OUT3 ("$str1\t$count1{$str1}\n");
}
foreach my $str2 (@strings2)
{
   $count2{$str2}++;
}
foreach my $str2 (sort keys %count2)
{
   print OUT4 ("$str2\t$count2{$str2}\n");
}

