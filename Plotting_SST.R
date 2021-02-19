library(ncdf4)
library(httr)

setwd('C:/Users/nposd/Downloads')
SSTnc = nc_open('GofAK_SST.nc') #load the SST data
SSTX = SSTnc$var[[1]]
SST = ncvar_get(SSTnc,SSTX)

dates_SST = as.POSIXlt(SSTX$dim[[4]]$vals,origin='1970-01-01',tz='GMT')
dates_SST
long_SST = SSTX$dim[[1]]$vals #get longs
lat_SST = SSTX$dim[[2]]$vals #get lats

#set color breaks
h=hist(SST[,,1], 100, plot=FALSE) 
breaks=h$breaks 
n=length(breaks)-1

#define a color palette
jet.colors <-colorRampPalette(c("blue", "#007FFF", "cyan","#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000")) #define color palette
c=jet.colors(n)
layout(matrix(c(1,2,3,0,4,0), nrow=1, ncol=2), widths=c(5,1), heights=4) 
layout.show(2) 
par(mar=c(3,3,3,1))

#plot the SST map
image(long_SST,lat_SST,SST[,,1],col=c,breaks=breaks,xlab='',ylab='',axes=TRUE,xaxs='i',yaxs='i',asp=1, main=paste("Daily SST", dates_SST[1]))
points(209.47,rep(57.22), pch=20, cex=2) #Add KOA_01
points(211.97,rep(58.67), pch=20, cex=2) #Add CB_10
par(new=TRUE) 
contour(long_SST,lat_SST,SST[,,1],levels=5,xaxs='i',yaxs='i',labcex=0.8,vfont = c("sans serif", "bold"),axes=FALSE,asp=1) 

par(mar=c(3,1,3,3))
source('scale.R') 
image.scale(SST[,,1], col=c, breaks=breaks, horiz=FALSE, yaxt="n",xlab='',ylab='',main='SST') 
axis(4, las=1) 
box()

#plotting a time series
I=which(long_SST>=205 & long_SST<=220)
J=which(lat_SST>=55 & lat_SST<=61)
sst2=SST[I,J,] 

n=dim(sst2)[3] 

res=rep(NA,n) 
for (i in 1:n) 
  res[i]=mean(sst2[,,i],na.rm=TRUE) 

plot(1:n,res,axes=FALSE,type='o',pch=20,xlab='Day',ylab='SST (ºC)')
axis(2) 
axis(1,1:n,format(dates_SST,'%m')) 
box()