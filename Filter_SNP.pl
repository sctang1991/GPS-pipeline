use strict;
my ($file,$num,$line,$count,$i,$sum);
my (@line,@order,@lines,@pool);
$file=shift;
open(IN,"$file")|| die;
@line=<IN>;
$num=shift;
@order=@ARGV;
LINE:foreach $line(@line){
       if($line=~/[01]\/[01]:0,0/){
   	     next LINE;}
       @lines=split(/\t/,$line);
       foreach (@lines){   	  
         if(/[01]\/[01].*/){
           push @pool,$_;
         }
       }
       if($#pool==($num-1)){
         for $i(@order){
   	       if($pool[$i-1]=~/[01]\/[01]:0,\d+/){
   	     	   $count++;
   	       }
   	       if($pool[$i-1]=~/[01]\/[01]:\d+,0/){
   	     	   $sum++;
   	       }
   	     }
   	   }   	  	     
       if($count!=@order and $sum!=@order){
       	if($#pool==($num-1)){
   	     print"$line";
       }
      }
       $count=0;
       $sum=0;
       @pool=();
  
}
   
close(IN);
            
            
            
            
   