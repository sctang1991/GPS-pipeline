library("ggplot2")
a<-read.table("pvalue.txt")
chr<-a[,1]
position<-a[,2]/100000
pvalue<-a[,3]
b<-data.frame(chr,position,pvalue)
p<-qplot(position,pvalue,data=b,size=I(0.5))
p+facet_grid(~chr,scales="free_x")
ggsave("pvalue.png",width=20)

