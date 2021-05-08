library(dplyr)
library(tidyverse)

setwd('G:/My Drive/AIS Data')
files = list.files(pattern = "csv$")

#Specify lat and long of HARP

#CB10
latCB = 58.66961667
longCB = -148.03
lat_hi_CB = latCB + ((10/6377)*(180/pi))
lat_lo_CB = latCB - ((10/6377)*(180/pi))
long_hi_CB = longCB + ((10/6378)*(180/pi))/cos(latCB*pi/180)
long_lo_CB = longCB - ((10/6378)*(180/pi))/cos(latCB*pi/180)

#KOA01
  latKOA = 57.224
  longKOA = -150.53
  lat_hi_KOA = latKOA + ((10/6377)*(180/pi))
  lat_lo_KOA = latKOA - ((10/6377)*(180/pi))
  long_hi_KOA = longKOA + ((10/6378)*(180/pi))/cos(latKOA*pi/180)
  long_lo_KOA = longKOA - ((10/6378)*(180/pi))/cos(latKOA*pi/180)

fishingCB = NULL
fishingKOA = NULL

for (i in 1:length(files)){
  filename = files[i]
  AIS_data = read.csv(filename)
  AIS_data = AIS_data[c(-1,-5,-6,-7,-9,-10,-13,-14,-15,-16,-17)]
  AIS_fishing = AIS_data[AIS_data$VesselType == 30, ]
  AIS_fishing = na.omit(AIS_fishing)
  #CB
  fishing_temp_CB = AIS_fishing %>%
  filter(LON<long_hi_CB & LON > long_lo_CB) %>%
  filter(LAT<lat_hi_CB & LAT > lat_lo_CB)
  fishingCB = rbind(fishingCB,fishing_temp_CB)
  #KOA
  fishing_temp_KOA = AIS_fishing %>%
    filter(LON<long_hi_KOA & LON > long_lo_KOA) %>%
    filter(LAT<lat_hi_KOA & LAT > lat_lo_KOA)
  fishingKOA = rbind(fishingKOA,fishing_temp_KOA)
  cat("Finished Processing ", filename," file ",i,"/",length(files))
}

library(writexl)
write_xlsx(fishingCB,'G:/My Drive/AIS Data/Fishing_CB.xlsx')
write_xlsx(fishingKOA,'G:/My Drive/AIS Data/Fishing_KOA.xlsx')