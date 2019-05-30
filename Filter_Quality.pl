use strict;
my($input,$quality);
$input=$ARGV[0];
$quality=$ARGV[1];
open (IN,"$input");
while(<IN>){
  if($_=~/[GATC]+\s(\d+)/g){
     if($1>$quality){
        print $_;
     }
  }
}
close(IN);
