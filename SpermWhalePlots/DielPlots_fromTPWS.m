%Diel plots from TPWS files modified by Natalie Posdaljian on 06172020
%originally for Baja_GI_01

clearvars
close all

%% Parameters defined by user
filePrefix = 'GofAK_KOA_01'; % File name to match. 
siteabrev = 'KOA'; %abbreviation of site.
titleNAME = 'Gulf of Alaska - Kodiak Island';
WorkspaceDir = 'I:\My Drive\GofAK_TPWS_metadataReduced\SeasonalityAnalysis\KOA';
saveDir = 'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhalePlots'; %specify directory to save files
UTCOffset = -7;

fixStart = dbISO8601toSerialDate('2019-04-25T08:00:00Z'); %the master start time of your data
fixEnd = dbISO8601toSerialDate('2019-09-27T03:27:30Z'); %the master end time of your data

shipTimes = 'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhalePlots\GofAK_FishingVessels_SpermWhales_forDielPlots.xlsx';

Lat = 40.177; %latitude of your site
Long = 148.03; %longitude of your site
%% load workspace
load([WorkspaceDir,'\',siteabrev,'_workspaceStep2.mat']);
shipTimes = readtable(shipTimes);
%% Diel Plots for all Sperm Whales
%select manually which indices you want to plot for effort
detections = [];
noeffTimes = [];
ship = [];
effort = [];
selectIdx = 1;

% plot detections
t = sprintf('%s - %s', filePrefix, siteabrev);
rect = [0, 0, 500, 800];
figh = figure('NumberTitle','off','Name',t,'Position',rect,...
        'Units','Pixel');
    
detections = timetable2table(clickData);
clickStartTimes = datenum(clickData.tbin);

%Plot presence
sightH = visPresence(sort(clickStartTimes), ...
    'Color',[0 0 0],...
    'Resolution_m', 8,'DateTickInterval',60,...
    'LineStyle', 'none', ...
    'Label', t,...
    'DateRange', [fixStart, fixEnd]);

hold on
shipStartTimes = x2mdate(datenum(shipTimes.StartTime(string(shipTimes.Site) == siteabrev)));
shipEndTimes = x2mdate(datenum(shipTimes.EndTime(string(shipTimes.Site) == siteabrev)));
shipH = visPresence([shipStartTimes shipEndTimes],..., ...
    'Color',[1 0 0],...
    'Resolution_m', 8,'DateTickInterval',60,...
    'LineStyle', 'none', ...
    'Label', t,...
    'DateRange', [fixStart, fixEnd]);


set(gca, 'YDir', 'reverse');  %upside down plot
title({'Presence of Sperm Whales and Fishing Vessels','at the Kodiak Island Site in the Gulf of Alaska'})
%grid off