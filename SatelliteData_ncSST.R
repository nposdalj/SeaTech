library(ncdf4)
library(httr)
library(sf)
library(dplyr)
library(raster)
library(rgeos)
library(ggplot2)
library("rnaturalearth")
library("rnaturalearthdata")
library(sp)

#Set user directories
setwd('C:/Users/nposd/Documents/GitHub/SeaTech') #set working directory
saveDir = paste('C:/Users/nposd/Documents/GitHub/SeaTech/Environmental_TimeSeries') #save directory for time series
Year = 2019 #Year of interest
Month = 1 #month of interest for plotting

#load files
SST = nc_open(paste("GofAK_SST_",Year,".nc",sep="")) #name of .nc file for year of interest
names(SST$var)
v1=SST$var[[1]]
SSTvar=ncvar_get(SST,v1)
SST_lon=v1$dim[[1]]$vals
SST_lat=v1$dim[[2]]$vals
dates=as.POSIXlt(v1$dim[[3]]$vals,origin='1970-01-01',tz='GMT')

#loading the world
world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)

#####plotting in ggplot######
r = raster(t(SSTvar[,,Month]),xmn = min(SST_lon),xmx = max(SST_lon),ymn=min(SST_lat),ymx=max(SST_lat))
rr = flip(r,direction = "y")
points = rasterToPoints(rr, spatial = TRUE)
df = data.frame(points)
names(df)[names(df)=="layer"]="SST"
mid = mean(df$SST)

ggplot(data=world) +  geom_sf()+coord_sf(xlim= c(-154,-140),ylim=c(55,61),expand=FALSE)+
  geom_raster(data = df , aes(x = x, y = y, fill = SST)) + 
  ggtitle(paste("Monthly SST", dates[Month]))+geom_point(x = -148.03, y = 58.67, color = "black",size=3)+
  xlab("Latitude")+ylab("Longitude")+
  scale_fill_gradient2(midpoint = mid, low="yellow", mid = "orange",high="red")

#plotting time series CB
I=which(SST_lon>=-154.5 & SST_lon<=-142.2) #change lon to SST_lon values to match ours, use max and min function
J=which(SST_lat>=54.8 & SST_lat<=61.3) #change ""
sst2=SSTvar[I,J,]

n=dim(sst2)[3] 

res=rep(NA,n) 
for (i in 1:n) 
  res[i]=mean(sst2[,,i],na.rm=TRUE) 

plot(1:n,res,axes=FALSE,type='o',pch=20,xlab='',ylab='SST (ºC)') 
axis(2) 
axis(1,1:n,format(dates,'%m')) 
box()

#export timeseries as .csv to plot in MATLAB
TimeSeries = data.frame(format(dates,'%m'),res)
TimeSeries %>%
  rename(
    Month = format.dates....m..,
    ChlA = res)
write.csv(TimeSeries,paste(saveDir,"/SST_",Year,".csv",sep =""))