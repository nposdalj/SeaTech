library(ncdf4)
library(httr)
library (naniar)
library("rnaturalearth")
library("rnaturalearthdata")
library(ggplot2)
library(rgeos)
library(raster)
library(dplyr)

#Set user directories
setwd('C:/Users/nposd/Documents/GitHub/SeaTech')
saveDir = paste('C:/Users/nposd/Documents/GitHub/SeaTech/Environmental_TimeSeries')
Year = 2014

#load files
ChlA = nc_open(paste("GofAK_Chl_",Year,".nc",sep="")) #name of .nc file for year of interest
names(ChlA$var)
v1=ChlA$var[[1]]
ChlAvar=ncvar_get(ChlA,v1)
ChlA_lon=v1$dim[[1]]$vals
ChlA_lat=v1$dim[[2]]$vals
dates=as.POSIXlt(v1$dim[[3]]$vals,origin='1970-01-01',tz='GMT')

#loading the world
world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)

#plotting all values greater than 5, as 5 so that a few anomalies here and there don't completely shift the color map
ChlAvar[ChlAvar > 5] = 5

#creating maps in ggplot for the first month (if you'd like to plot subsequent months, change the value on lines 26 and 33)
r = raster(t(ChlAvar[,,2]),xmn = min(ChlA_lon),xmx = max(ChlA_lon),ymn=min(ChlA_lat),ymx=max(ChlA_lat)) #change the value in brackets after ChlAvar
points = rasterToPoints(r, spatial = T)
df = data.frame(points)
names(df)[names(df)=="layer"]="Chla"
mid = mean(df$Chla)
ggplot(data=world) +  geom_sf()+coord_sf(xlim= c(-154,-140),ylim=c(55,61),expand=FALSE)+
  geom_raster(data = df , aes(x = x, y = y, fill = Chla)) + 
  ggtitle(paste("Monthly Chl A", dates[1]))+geom_point(x = -148.03, y = 58.67, color = "black",size=3)+ #change the value in the brackets for dates
  xlab("Latitude")+ylab("Longitude")+
  scale_fill_gradient2(midpoint = mid, low="blue", mid = "yellow",high="green")

#plotting time series CB
I=which(ChlA_lon>=-154.5 & ChlA_lon<=-142.2) #change lon to SST_lon values to match ours, use max and min function
J=which(ChlA_lat>=54.8 & ChlA_lat<=61.3) #change ""
sst2=ChlAvar[I,J,] 

n=dim(sst2)[3]

res=rep(NA,n) 
for (i in 1:n) 
  res[i]=mean(sst2[,,i],na.rm=TRUE) 

plot(1:n,res,axes=FALSE,type='o',pch=20,xlab='',ylab='Chla (mg m-3)') 
axis(2) 
axis(1,1:n,format(dates,'%m')) 
box()

#export timeseries as .csv to plot in MATLAB
TimeSeries = data.frame(format(dates,'%m'),res)
TimeSeries %>%
  rename(
    Month = format.dates....m..,
    ChlA = res)
write.csv(TimeSeries,paste(saveDir,"/ChlA_",Year,".csv",sep =""))