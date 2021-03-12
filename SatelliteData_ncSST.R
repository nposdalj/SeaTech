library(ncdf4)
library(httr)
library(sf)
library(dplyr)
library(raster)
library(rgeos)
library(ggplot2)
library("rnaturalearth")
library("rnaturalearthdata")

#load files
SST = nc_open("GofAK_SST_2019.nc")
names(SST$var)
v1=SST$var[[1]]
SSTvar=ncvar_get(SST,v1)
SST_lon=v1$dim[[1]]$vals
SST_lat=v1$dim[[2]]$vals
dates=as.POSIXlt(v1$dim[[4]]$vals,origin='1970-01-01',tz='GMT')

#loading the world
world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)

#plotting in ggplot
r = raster(t(SSTvar[,,1]),xmn = min(SST_lon),xmx = max(SST_lon),ymn=min(SST_lat),ymx=max(SST_lat))
points = rasterToPoints(r, spatial = TRUE)
df = data.frame(points)
names(df)[names(df)=="layer"]="SST"
mid = mean(df$SST)
ggplot(data=world) +  geom_sf()+coord_sf(xlim= c(-154,-140),ylim=c(55,61),expand=FALSE)+
  geom_raster(data = df , aes(x = x, y = y, fill = SST)) + 
  ggtitle(paste("Monthly SST", dates[1]))+geom_point(x = 211.97, y = 58.67, color = "black",size=3)+
  xlab("Latitude")+ylab("Longitude")+
  scale_fill_gradient2(midpoint = mid, low="yellow", mid = "orange",high="red")

#plotting time series HZ 
I=which(ChlA_lon>=-154.5 & ChlA_lon<=-142.2) #change lon to SST_lon values to match ours, use max and min function
J=which(ChlA_lat>=54.8 & ChlA_lat<=61.3) #change ""
sst2=SSTvar[I,J,]

n=dim(sst2)[3] 

res=rep(NA,n) 
for (i in 1:n) 
  res[i]=mean(sst2[,,i],na.rm=TRUE) 

plot(1:n,res,axes=FALSE,type='o',pch=20,xlab='',ylab='SST (ºC)') 
axis(2) 
axis(1,1:n,format(dates,'%m')) 
box()

#plotting time series GS 
I=which(SST_lon>=-76.25 & SST_lon<=-75.75) #change lon to SST_lon values to match ours, use max and min function
J=which(SST_lat>=33.41991667 & SST_lat<=33.91991667) #change ""
sst2=SSTvar[I,J,] 

n=dim(sst2)[3] 

res=rep(NA,n) 
for (i in 1:n) 
  res[i]=mean(sst2[,,i],na.rm=TRUE) 

plot(1:n,res,axes=FALSE,type='o',pch=20,xlab='',ylab='SST (ºC)') 
axis(2) 
axis(1,1:n,format(dates,'%m')) 
box()