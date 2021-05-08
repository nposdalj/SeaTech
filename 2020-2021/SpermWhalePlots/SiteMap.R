library(marmap)
library(ggplot2)
library(oce)
library(ocedata)
library(mapproj)
library(maps)
library(mapdata)
library("ggplot2")
library("sf")
library(rnaturalearth)
library(rnaturalearthdata)
library(rgeos)
library(GISTools)
library(prettymapr)
data(coastlineWorldFine)
data(topoWorld)
library(inlmisc)

GOA_BSAI = getNOAA.bathy(lon1 = -170, lon2 = -140, lat1 = 44 , lat2 = 66, resolution = 20, antimeridian = FALSE)
summary(GOA_BSAI)

#make HARP points
filename = paste("C:/Users/nposd/Documents/Presentations/AMSS/Figures/LatLongTAB.csv",sep="")
LatLongs = read.csv(filename) #harp locations

#Option 1

#convert bathymetry to data frame
bf = fortify.bathy(GOA_BSAI)

# get regional polygons
reg = map_data("world2")
reg = subset(reg, region %in% c('Canada', 'USA'))

# convert lat longs
reg$long = (360 - reg$long)*-1

#set map limits
lons = c(-190+360, -140+360)
lats = c(50, 60)

#make a plot
ggplot()+
  
  #add 100m countour
  geom_contour(data = bf,
               aes(x = x, y = y, z = z),
               breaks = c(100),
               size = c(0.3),
               colours = "grey")+
  
  # add 250m contour
  geom_contour(data = bf, 
               aes(x=x, y=y, z=z),
               breaks=c(250),
               size=c(0.6),
               colour="grey")+
  
  #add coastline
  geom_polygon(data = reg, aes(x = long, y = lat, group = group), 
               fill = "darkgrey", color = NA) + 
  
  
  # add points
  geom_point(data = LatLongs, aes(x = Long, y = Lat),
             colour = "black", fill = "grey", 
             stroke = .5, size = 2, 
             alpha = 1, shape = 21)+
  
  # configure projection and plot domain
  coord_map(xlim = lons, ylim = lats)+
  
  # formatting
  ylab("")+xlab("")+
  theme_bw()


#Option 2
plot(GOA_BSAI, image = TRUE, land = TRUE, lwd = 0.1,
     bpal = list(c(0, max(GOA_BSAI), grey(.7), grey(.9), grey(.95)), 
                 c(min(GOA_BSAI), 0, "darkblue","lightblue")))
plot(GOA_BSAI, n = 1, lwd = 0.5, add = TRUE)
get.box(GOA_BSAI)
scaleBathy(GOA_BSAI, deg = 2, x = "bottomleft",inset = 5)


#Option 3
# Creating a custom palette of blues
blues <- c("lightsteelblue4", "lightsteelblue3",
           "lightsteelblue2", "lightsteelblue1")
# Plotting the bathymetry with different colors for land and sea
plot(GOA_BSAI, image = TRUE, land = TRUE, axes = FALSE, lwd = 0.1,
     bpal = list(c(0, max(GOA_BSAI), "grey"),
                 c(min(GOA_BSAI),0,blues)))
box(GOA_BSAI, 5)
scaleBathy(GOA_BSAI, deg = 2, x = "bottomright",inset = 12, pch =100)
scaleBathy(GOA_BSAI, deg = 2, x = "bottomright",inset = 5, pch =100)
scaleBathy(GOA_BSAI, deg = 2, x = "bottomright",inset = 5, pch =100)
scaleBathy(GOA_BSAI, deg = 2, x = "bottomright",inset = 5, pch =100)
scaleBathy(GOA_BSAI, deg = 2, x = "bottomright",inset = 5, pch =100)
scaleBathy(GOA_BSAI, deg = 2, x = "bottomright",inset = 5, pch =100)
scaleBathy(GOA_BSAI, deg = 2, x = "bottomright",inset = 5, pch =100)
points(LatLongs$Long[1],LatLongs$Lats[1], col = "red",pch =20, cex = 3)
points(LatLongs$Longs[7],LatLongs$Lats[7], col = "white",pch =18, cex = 2.5)
points(LatLongs$Long[5],LatLongs$Lats[5], col = "brown",pch =17, cex = 2)
points(LatLongs$Long[6],LatLongs$Lats[6], col = "brown",pch =17, cex = 2)
points(LatLongs$Longs[3],LatLongs$Lats[3], col = "white",pch =15, cex = 2)
points(LatLongs$Longs[2],LatLongs$Lats[2], col = "green",pch =18, cex = 3)
points(LatLongs$Longs[4],LatLongs$Lats[4], col = "green",pch =18, cex = 3)
legend(x = 170.5,y=65.25,legend = c("Abyssal Deep", "Seamount","Slope","Island"), col =c("red","brown","yellow","green"), pch = c(20, 17, 15, 18),pt.cex =2)

legend(x = -170,y=65.25,legend = c("KOA","CB"), col =c("blue","blue"), pch = c(18,15),pt.cex =2.5)

#Option 4
# Create nice color palettes
blues <- c("lightsteelblue4", "lightsteelblue3", "lightsteelblue2", "lightsteelblue1")
greys <- c(grey(0.6), grey(0.93), grey(0.99))

# Second option
plot(GOA_BSAI, im=TRUE, land=TRUE, bpal=list(c(min(GOA_BSAI),0,blues),c(0,max(GOA_BSAI),greys)), lwd=.05, las=1 )
map("worldHires", res=0, lwd=0.7, add=TRUE)
points(LatLongs$Longitude,LatLongs$Latitude, bg = "red",pch =20)

# Add -200m and -1000m isobath
plot(GOA_BSAI, deep=-200, shallow=-200, step=0, lwd=0.5, drawlabel=TRUE, add=TRUE)
plot(GOA_BSAI, deep=-1000, shallow=-1000, step=0, lwd=0.3, drawlabel=TRUE, add=TRUE)

#Option 5
autoplot.bathy(GOA_BSAI, geom=c("tile","contour")) +
  scale_fill_gradient2(low="dodgerblue4", mid="gainsboro", high="darkgreen") +
  geom_point(data = LatLongs, aes(x = Lat, y = Long),
             colour = 'black', size = 3, alpha = 1, shape = 15) +
  labs(y = "Latitude", x = "Longitude", fill = "Elevation") +
  coord_cartesian(expand = 0)+
  ggtitle("A marmap map with ggplot2") 
