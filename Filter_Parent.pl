use strict;
my ($parentpool_1,$parentpool_2,$lines);
my (@lines,@line,@p);
open(IN,"$ARGV[0]");
$parentpool_1=$ARGV[1];
$parentpool_2=$ARGV[2];
@lines=<IN>;
for $lines(@lines){
   @line=split/\t/,$lines;
   for(@line){
      if(/[01]\/[01].*/g){
         push @p,$_;
      }
   }  
   if(($p[$parentpool_1-1].$p[$parentpool_2-1])=~/([01])\/([01]).*([01])\/([01]).*/){
      if($1==$2 and $3==$4){
         if($1!=$3){
            print $lines;
         }
      }
   }
   @p=();
}
close(IN);