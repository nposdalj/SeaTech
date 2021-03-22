clearvars
close all
%% Parameters defined by user
filePrefix = 'GofAK_CB04'; % File name to match. 
siteabrev = 'CB04'; %abbreviation of site.
Year = '2014';
Species = 'Bb1Clicks';
saveDir = 'C:\Users\nposd\Documents\GitHub\SeaTech\Plots'; %specify directory to save files
titleNAME = 'Gulf of Alaska - Continental Slope';
DetDir = 'C:\Users\nposd\Documents\GitHub\SeaTech\Tethys'; %specify directory with detections
EnvDir = 'C:\Users\nposd\Documents\GitHub\SeaTech\Environmental_TimeSeries'; %specify directory with environmental data
%% load presence data
DetFN = [DetDir,'\',Species,'_',siteabrev,'.csv'];
Det = readtable(DetFN);
%% load environmental
SSTfn = [EnvDir,'\SST_',Year,'.csv'];
SST = readtable(SSTfn);

Chlafn = [EnvDir,'\ChlA_',Year,'.csv'];
Chla = readtable(Chlafn);
%% Plots
figure
bar(monthlyData.tbin, monthlyData.HoursProp,'k') %plot presence
addaxis(monthlyData.tbin,monthlyData.SST,'b','LineWidth',3) %plot SST
addaxis(monthlyData.tbin,monthlyData.NormEffort_Bin,'.r') %plot effort (if applicable)
addaxis(monthlyData.tbin,monthlyData.CHL,'g','LineWidth',3) %plot Chla
addaxislabel(1,'Presence')
addaxislabel(2, 'SST (C)')
addaxislabel(3, 'Percent Effort')
addaxislabel(4, 'Chl a (mg/m^3)')
legend('Presence','SST','Effort','Chl a');
xlim([min(monthlyData.tbin)-15 max(monthlyData.tbin)+15])
title(['Monthly Presence of Sperm whales in the ',titleNAME])
saveas(gcf,[saveDir,'\',Species,'_',siteabrev,'MonthlyPresence_withEnviro.png']);