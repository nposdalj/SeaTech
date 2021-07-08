clearvars
close all
%% Parameters defined by user
filePrefix = 'GofAK_CB04'; % File name to match. 
siteabrev = 'CB04'; %abbreviation of site.
Year = '2019';
Species = 'OoClicks';
saveDir = 'C:\Users\HARP\Documents\GitHub\SeaTech\Plots'; %specify directory to save files
titleNAME = 'Gulf of Alaska - Continental Slope';
DetDir = 'C:\Users\HARP\Documents\GitHub\SeaTech\Tethys'; %specify directory with detections
EnvDir = 'C:\Users\HARP\Documents\GitHub\SeaTech\Environmental_TimeSeries'; %specify directory with environmental data
%% load presence data
%DetFN = [DetDir,'\',Species,'_',siteabrev,'.csv'];
DetFN = 'C:\Users\HARP\Documents\GitHub\SeaTech\Humpback\Mn_CB04_CallingHoursPerDay.csv'
Det = table2array(readtable(DetFN));
Day = Det(:, 1)
Hours = Det(:, 2)


DetFN05 = 'C:\Users\HARP\Documents\GitHub\SeaTech\Humpback\Mn_CB05_CallingHoursPerDay.csv'
DetFN05 = table2array(readtable(DetFN05));
Day05 = DetFN05(:, 1)
Hours05 = DetFN05(:, 2)
Effort05 = (DetFN05(:, 3)/24)*100

DetFN10 = 'C:\Users\HARP\Documents\GitHub\SeaTech\Humpback\Mn_CB10_CallingHoursPerDay.csv'
DetFN10 = table2array(readtable(DetFN10));
Day10 = DetFN10(:, 1)
Hours10 = DetFN10(:, 2)
Effort10 = (DetFN10(:, 3)/24)*100
%% load environmental
SSTfn = [EnvDir,'\SST_',Year,'.csv'];
SST = table2array(readtable(SSTfn));
monthSST = SST(:, 1);
datenumSST = datenum(2014, monthSST, 1)
concSST = SST(:, 2);

Chlafn = [EnvDir,'\ChlA_',Year,'.csv'];
Chla = table2array(readtable(Chlafn));
monthCHLA = Chla(:, 1); 
datenumCHLA = datenum(2014, monthCHLA, 1)
concCHLA = Chla(:, 2);


%% Plots 2014
figure
bar(Day, Hours,'k') %plot presence
hold on
bar(Day05, Hours05, 'k')
bar(Day10, Hours10, 'm')
ylim([0 5])
datetick;
addaxis(datenumSST, concSST,'b','LineWidth',3) %plot SST
addaxis(datenumCHLA, concCHLA, 'g', 'LineWidth', 3)
addaxis(DetFN05(:, 1), Effort05, 'o')
addaxis(monthlyData.tbin,monthlyData.SST,'b','LineWidth',3) %plot SST
addaxis(monthlyData.tbin,monthlyData.NormEffort_Bin,'.r') %plot effort (if applicable)
addaxis(monthlyData.tbin,monthlyData.CHL,'g','LineWidth',3) %plot Chla
addaxislabel(1,'Calling Hours Per Day')
addaxislabel(2, 'SST (C)')
addaxislabel(3, 'Percent Effort')
addaxislabel(3, 'Chl a (mg/m^3)')
legend('Humpback Calling Hours Per Day','SST','Chl a');
xlim([min(monthlyData.tbin)-15 max(monthlyData.tbin)+15])
title(['Humpback Calling Hours in the Gulf of Alaska (2014)]')
saveas(gcf,[saveDir,'\',Species,'_',siteabrev,'MonthlyPresence_withEnviro.png']);

figure
bar(Day05+(5*365), Hours05, 'FaceColor', [0 0.4470 0.7410])
hold on
bar(Day10, Hours10, 'FaceColor', [0.9290 0.6940 0.1250])
patch(x, y, [0.5, 0.5, 0.5])
bar(Day05+(5*365), Hours05, 'FaceColor', [0 0.4470 0.7410])
bar(Day10, Hours10, 'FaceColor', [0.9290 0.6940 0.1250])
yyaxis right
plot(Day05+(5*365)+0.5, Effort05, 'o', 'Color', [0 0.4470 0.7410], 'MarkerFaceColor', [0 0.4470 0.7410])
plot(Day10, Effort10, 'o', 'Color', [0.9290 0.6940 0.1250], 'MarkerFaceColor', [0.9290 0.6940 0.1250])

ylabel('Percent Effort')
ylim([0 100])
legend('2014', '2019')
xlabel('Date')
ylabel('Calling Hours per Day')

x = [737547 737554 737554 737547]
y = [0 0 9 9]



figure(3)
yyaxis left
plot(datenumSST, concSST,'b','LineWidth',3) %plot SST
hold on
plot(datenumSST, concSST2014, 'b')
ylabel('SST (C)')
yyaxis right
plot(datenumCHLA2019, concCHLA,'g','LineWidth',3) %plot SST
hold on
plot(datenumCHLA2014, concCHLA2014, 'g')
ylabel('Chl a (mg/m^3)')
legend('SST 2019', 'SST 2014', 'CHLA 2019', 'CHLA 2014')

figure(4)
plot(datenumSST, concSST2014, 'b')
hold on
plot(datenumSST, concSST, 'Color', 'b', 'Linewidth', 3)
ylabel('SST (C)')
datetick('x', 'mmm')
legend('2014', '2019')
title('Sea Surface Temperature in the Gulf of Alaska')
grid on


figure(5)
plot(datenumCHLA2014, concCHLA2014, 'g')
hold on
plot(datenumCHLA2019, concCHLA, 'Color', 'g', 'Linewidth', 3)
ylabel('Chl a (mg/m^3)')
datetick('x', 'mmm')
legend('2014', '2019')
title('Chlorophyll-A Concentration in the Gulf of Alaska')
grid on



f0 = 1500/(4*120(sqrt(1-1500/