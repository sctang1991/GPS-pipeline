use strict;
my ($region,$denoise,$chr_num,$i,$m,$j,$x,$chromosome,$count,$sum,$ratio);
my (@line,@max,@length,@interval);
open(IN,"$ARGV[0]");
@line=<IN>;
$region=$ARGV[1]*100000;
$denoise=$ARGV[2];
$chr_num=$ARGV[3];
foreach $i(1...$chr_num){
   foreach(@line){
      if(/(\d+)\t(\d+)\t\d+/){
         if($1==$i){            
            $max[$i]=$2 if $max[$i]<$2;
            push @{$chromosome->[$i]},$_;
            $length[$i]++;           
         }         
      }
   }
   $interval[$i]=int($max[$i]/$region)+1;
}
close(IN);
foreach $i(1...$chr_num){
   foreach $m(0...$interval[$i]){
      foreach (@{$chromosome->[$i]}){
         if(/(\d+)\t(\d+)\t(\d+)/){
            if($2>=$m*$region and $2<($m+1)*$region){
               $sum->[$i][$m]++;
               $count->[$i][$m]++ if $3>$denoise;
            }
         }
      }
      if ($sum->[$i][$m]>=10){
      $ratio->[$i][$m]=$count->[$i][$m]/$sum->[$i][$m];}
      else{$ratio->[$i][$m]=0;}
   }
}
for $i($1...$chr_num){
   for $j(1...$interval[$i]){
      $x=($j-0.5)*$region/100000;
      print "$i\t$x\t$ratio->[$i][$j]\n";
   }
}
    
         