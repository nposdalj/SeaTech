%% This code was modified by NP on 4/4/2022 from the M_Map website to plot bathymetry in the GOA/BSAI
%source - https://www.eoas.ubc.ca/~rich/map.html#examples
close all;clear all;clc;
%% Load Site data
SiteData = readtable('C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\LatLongTAB.csv'); %load the csv with the latitude and longitude data
SaveDir = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\Plots_Tables'; %what folder do you want to save the map in
%% Create map 
%The projections that successfully work: UTM, Transverse mercator (or this), Mercator (probably the best),...
%Miller Cylindrical, Albers Equal-Area Conic, Lambert Conformal Conic, Hammer-Aitoff, Mollweide, Robinson
m_proj('Mercator','long',[-82 -75],'lat',[29 37]); %identify ranges of the map (what is the max and min you want to show on the map)
[CS,CH]=m_etopo2('contourf',[-7000:1000:-1000 -500 -200 0 ],'edgecolor','none'); %load bathymetry from ETOPO 1
m_gshhs_f('patch',[.7 .7 .7],'edgecolor','none');
m_line(SiteData.Longitude(1),SiteData.Latitude(1),'marker','s',...
           'linest','none','markerfacecolor','w','clip','point');
m_text(SiteData.Longitude(1)-1,SiteData.Latitude(1),SiteData.Site(1),'FontWeight','Bold','FontSize',12);
m_line(SiteData.Longitude(2),SiteData.Latitude(2),'marker','s',...
           'linest','none','markerfacecolor','w','clip','point');
m_text(SiteData.Longitude(2)-1,SiteData.Latitude(2),SiteData.Site(2),'FontWeight','Bold','FontSize',12);
m_grid('linest','none','tickdir','out','box','fancy','fontsize',16,'xtick',5);
colormap(m_colmap('blues'));  
caxis([-7000 000]);
[ax,h]=m_contfbar([.3 .6],.8,CS,CH,'endpiece','no','axfrac',.05,'YColor','white');
title(ax,'meters')
ax.FontSize = 8;
set(gcf,'color','w');  % otherwise 'print' turns lakes black
%% Save plot
%png
filename = [SaveDir,'\SiteMap.png'];
saveas(gcf,filename, 'png')