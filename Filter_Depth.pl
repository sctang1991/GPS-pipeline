use strict;
my ($num,$range1,$range2,$depth1,$depth2,$count,$i,$line,$n,$depth);
my (@line,@lines,@alldepth,@quantile,@d);
open(IN,"$ARGV[0]")||die;
@line=<IN>;
foreach $line(@line){
   @lines=split(/\t/,$line);
   foreach (@lines){
      if(/[01]\/[01]:\d+,\d+:(\d+)/){
         push @alldepth,$1;
      }
   }
}
$num=$ARGV[1];
$range1=$ARGV[2];
$range2=$ARGV[3];
foreach $n(0...$num-1){      
   foreach $i(0...$#alldepth){
      if($i % $num==$n){
         push @{$depth->[$n]},$alldepth[$i];
      }
   }
}
sub quantile{
	my($d,$c,$interval,$quantile1,$quantile2);
	my @depth;
  $d=pop @_;
  $c=pop @_;
  @depth=@_;
  @depth=sort {$a<=>$b}(@depth);
  $interval=$#depth;
  $quantile1=$depth[int($interval*$c)]+($interval*$c-int($interval*$c))*($depth[int($interval*$c)+1]-$depth[int($interval*$c)]);
  $quantile2=$depth[int($interval*$d)]+($interval*$d-int($interval*$d))*($depth[int($interval*$d)+1]-$depth[int($interval*$d)]);
  return($quantile1,$quantile2);
}
foreach $i(0...$num-1){
   ($depth1,$depth2)=&quantile(@{$depth->[$i]},$range1,$range2);
   push @quantile,$depth1;
   push @quantile,$depth2;
}
foreach $line(@line){
   @lines=split(/\t/,$line);
   foreach (@lines){
      if(/[01]\/[01]:\d+,\d+:(\d+)/){
         push @d,$1;
      }
   }
   foreach $i(0...$num-1){
      if($quantile[2*$i]<$d[$i] and $d[$i]<$quantile[2*$i+1]){
         $count++;
      }
   }
   if($count==$num){
      print "$line";
   }
   $count=0;
   @d=();
}
close(IN);      
      
        
   
   
