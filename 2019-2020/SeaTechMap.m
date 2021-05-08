
close all;clear all;clc;

%% load lat and longs for each site
CB_mean = [58.66961667,-148.03]; %10
CBtext = repmat({'CB'},size(CB_mean,1),1);
CB = [CBtext num2cell(CB_mean)];

KOA_mean = [57.224,-150.53];
KOAtext = repmat({'KOA'},size(KOA_mean,1),1);
KOA = [KOAtext num2cell(KOA_mean)];
%% create one table with all lat and longs
LL = [CB; KOA];
LatLong = cell2mat(LL(:,2:3));

LatLongTAB = array2table(LatLong);
LatLongTAB.Properties.VariableNames = {'Latitude' 'Longitude'};

LatLongTAB{:,'Site'} = {'CB';'KOA'};
%% grey site map
figure(1)
LatLongTAB.Site = categorical(LatLongTAB.Site);
A = 200;
latitude = LatLongTAB.Latitude;
longitude = LatLongTAB.Longitude;
gm = geoscatter(latitude,longitude,A,'.','k');  
text(latitude(1),longitude(1)-0.5,'CB','HorizontalAlignment','right','FontSize',16);
text(latitude(2)-0.5,longitude(2)+2,'KOA','HorizontalAlignment','right','FontSize',16);
geolimits([55 60],[-170 -140]);
set(gcf,'Color','w');
save('Site_mapGrey.png');
export_fig Site_mapHQGrey.png
%% colorterrain site map
figure(2)
LatLongTAB.Site = categorical(LatLongTAB.Site);
A = 200;
latitude = LatLongTAB.Latitude;
longitude = LatLongTAB.Longitude;
gm = geoscatter(latitude,longitude,A,'.','k');  
geobasemap colorterrain
text(latitude(1),longitude(1)-0.5,'CB','HorizontalAlignment','right','FontSize',16);
text(latitude(2)-0.5,longitude(2)+2,'KOA','HorizontalAlignment','right','FontSize',16);
geolimits([55 60],[-170 -140]);
set(gcf,'Color','w');
save('Site_mapColor.png');
export_fig Site_mapHQColor.png