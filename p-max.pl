use strict;
my ($file_1,$chr,$interval,$lines,$max,$pos);
my (@line,@lines);
$file_1=shift;
open(IN,"$file_1");
$chr=shift;
while(<IN>){
	push @line, [split];
}
my @lines=grep{$_->[0]==$chr}@line;
my $interval=$lines[1][1]-$lines[0][1];
$max=0;
for $lines(@lines){	
	if($lines->[2] > $max){
	 $max=$lines->[2];
	 $pos=$lines->[1];	 
	}
}
print"$max $pos";