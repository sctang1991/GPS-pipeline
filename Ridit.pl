use strict;
sub ridit{    
   my ($i,$sum_total,$sum_ref,$sum_snp,$cumsum,$num,$m,$cumfr,$cumfrr,$r_ref,$r_snp,$var,$z,$u,$p);
   my (@a,@sum,@r,@cumsum);
   $num= @_;
   for $i(0...$num-1){      
       $a[$i]=shift @_;
       $sum_total+=$a[$i];
       if($i%2==0){
         $sum_ref+=$a[$i];
      }
      if($i%2==1)
      {$sum_snp+=$a[$i];}
   }
      $cumsum[0]=0;
      while($i<$num){
      $m=$i/2;      
      $sum[$m]=$a[$i]+$a[$i+1]; 
      $cumsum[$m+1]=$cumsum[$m]+$sum[$m] if $m+1<$num/2;
      $r[$m]=($cumsum[$m]+$sum[$m]/2)/$sum_total;
      $cumfr+=$sum[$m]*$r[$m];
      $cumfrr+=$sum[$m]*$r[$m]*$r[$m];
      $r_ref+=($a[$i]*$r[$m]/$sum_ref);
      $r_snp+=($a[$i+1]*$r[$m]/$sum_snp);     
      $i+=2;
      }
      $var=($cumfrr-$cumfr*$cumfr/$sum_total)/($sum_total-1);
      $z=abs($r_ref-$r_snp)/sqrt($var*$sum_total/($sum_ref*$sum_snp));
      $u=abs($r_ref-$r_snp)/sqrt((1/12)*$sum_total/($sum_ref*$sum_snp));
      use Statistics::Distributions;
      $p=Statistics::Distributions::uprob($z);
      return($p);
}
my ($file,$result,$p);
my (@order,@line,@lines,@d,@order_d);
$file=shift;
open (IN,"$file");
@order=@ARGV;
chomp(@line=<IN>);
foreach (@line){ 
   @lines=split/\t/,$_;
   for(@lines){    
      if(/[01]\/[01]:(\d+),(\d+)/g){      
         push @d,$1,$2;
      }
   }
   for (@order){
      push @order_d,$d[2*$_-2],$d[2*$_-1]; 
   }  
   $p=&ridit(@order_d);
   $result=-log($p);
   if(/[chromosome|chr](\d+)\s(\d+)/){            
      print "$1\t$2\t$result\n";
   }
   @d=();
   @order_d=();
} 
close(IN);
