library(ncdf4)
library(httr)

setwd('C:/Users/nposd/Downloads')
Chlnc = nc_open('GofAK_Chl.nc') #load the Chl data
ChlX = Chlnc$var[[1]]
Chl = ncvar_get(Chlnc,ChlX)

dates_Chl = as.POSIXlt(ChlX$dim[[3]]$vals,origin='1970-01-01',tz='GMT') #get the dates
long_Chl = ChlX$dim[[1]]$vals #get longs
lat_Chl = ChlX$dim[[2]]$vals #get lats

h=hist(Chl[,,1], 100, plot=FALSE) 
breaks=h$breaks 
n=length(breaks)-1

jet.colors <-colorRampPalette(c("blue", "#007FFF", "cyan","#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000")) #define color palette
c=jet.colors(n)
layout(matrix(c(1,2,3,0,4,0), nrow=1, ncol=2), widths=c(5,1), heights=4) 
layout.show(2) 
par(mar=c(3,3,3,1))

image(long_Chl,lat_Chl,Chl[,,1],col=c,breaks=breaks,xlab='',ylab='',axes=TRUE,xaxs='i',yaxs='i',asp=1, main=paste("Daily Chl", dates_Chl[1]))
points(202:205,rep(26,4), pch=20, cex=2)
par(new=TRUE) 
contour(long_Chl,lat_Chl,Chl[,,1],levels=5,xaxs='i',yaxs='i',labcex=0.8,vfont = c("sans serif", "bold"),axes=FALSE,asp=1) 

par(mar=c(3,1,3,3))
source('scale.R') 
image.scale(Chl[,,1], col=c, breaks=breaks, horiz=FALSE, yaxt="n",xlab='',ylab='',main='Chl') 
axis(4, las=1) 
box()

#plotting a time series
I=which(long_Chl>=205 & long_Chl<=220)
J=which(lat_Chl>=55 & lat_Chl<=61)
sst2=Chl[I,J,] 

n=dim(sst2)[3] 

res=rep(NA,n) 
for (i in 1:n) 
  res[i]=mean(sst2[,,i],na.rm=TRUE) 

plot(1:n,res,axes=FALSE,type='o',pch=20,xlab='Day',ylab='Chlorophyll')
axis(2) 
axis(1,1:n,format(dates_Chl,'%m')) 
box()