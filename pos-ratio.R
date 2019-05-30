library("ggplot2")
a<-read.table("ratio.txt")
chr<-a[,1]
position<-a[,2]
ratio<-a[,3]
b<-data.frame(chr,position,ratio)
p<-qplot(position,ratio,data=b)
p+facet_grid(~chr,scales="free_x")
ggsave("ratio.png",width=20)

