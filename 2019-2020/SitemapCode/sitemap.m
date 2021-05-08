%%%created by MAZ on 4/17/2020 to plot locations of HARP sites

%% LOAD YOUR SITES
%%%%%you can use data stored in Pac_latLongs if your site is in there.
%%%%%Otherwise, you'll have to enter the latLongs of your site on your
%%%%%own...

load Pac_latLongs.mat
CB_latLongs = [58.66961667,-148.03]; %10
KOA_latLongs = [57.224,-150.53]; %01
%% get means

%change this to w/e sites you care about to calculate mean lat/lon
%locations- see get_latLon below 
CB = get_latLon(CB_latLongs,'CB');
KOA = get_latLon(KOA_latLongs,'KOA');

%% conversions to table
%whatever your sites were above, concatenate them and make them into a
%table
fullSites = [CB;KOA];
fullSiteMat = cell2mat(fullSites(:,2:3));

fullSiteTab = array2table(fullSiteMat);
fullSiteTab.Properties.VariableNames = {'Latitude', 'Longitude'};
%you'll need to edit these labels based on your site names 
fullSiteTab.Labels = {'CB';'KOA'};

%% plotting
lats = fullSiteTab.Latitude;
longs = fullSiteTab.Longitude;
labs = fullSiteTab.Labels;
%below is the color of your markers, edit if needed
C = [1 0 0];
%size of markers 
markSize = 80;


%within plotting: changing the text line will change alignment, etc of your
%site labels 
figure
gm = geoscatter(fullSiteTab.Latitude,fullSiteTab.Longitude,markSize,'.','MarkerEdgeColor',C);
for iSite = 1:2
    text(lats(iSite),longs(iSite)-1,labs(iSite),'HorizontalAlignment','right','FontSize',12);
end

%use geolimits to edit the size of your plot as desired
geolimits([55 60],[-170 -140]);

%use geobasemap to change the basemap underneath your sites- you can google
%options for this 
geobasemap landcover


%save your map to wherever you want 
set(gcf,'Color','w');
print('E:\SeaTech\SeaTech_Map','-dpng')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate average location from given latLongs. inputs are your latitudes
% and longitudes, and then the string you want saved as your site for
% plotting use
function meanLoc = get_latLon(latLons,siteName)

latLonFull = meanm(latLons(:,1),latLons(:,2));
siteNameCell = {siteName};
meanLoc = [siteNameCell, num2cell(latLonFull)];
end


