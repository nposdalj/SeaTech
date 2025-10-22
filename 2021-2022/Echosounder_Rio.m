%% This script was written by NP and RCB to compile the echosounder logs from WAT_GS and plot them with sperm whale presence.
% 2/8/22
%% User Defined Parameters
% Rio
% echoDIR = 'C:\Users\Rio.Bacha\Documents\Echosounder Logs'; % local directory for echosounder logs
% pmDIR = 'C:\Users\Rio.Bacha\Documents\Sperm Whale Data\SpermWhale_BinData_GS.csv'; % local directory for sperm whale data
% saveDIR = 'C:\Users\Rio.Bacha\Documents\Plots & Tables'; % local directory to save tables

%Natalie
echoDIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EchoLogs'; % local directory for echosounder logs
pmDIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\PmData\SpermWhale_BinData_GS.csv'; % local directory for sperm whale data
controlDIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\PmData\SpermWhale_BinData_BP.csv'; 
saveDIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\Plots_Tables'; % local directory to save tables
SST_GS_DIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\SST_GS_Daily.csv'; % local directory for SST data
SST_BP_DIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\SST_BP_Daily.csv'; % local directory for SST data
CHL_GS_DIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\Chla_GS_Daily.csv'; % local directory for SST data
CHL_BP_DIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\Chla_BP_Daily.csv'; % local directory for SST data
ENV_DAILY_DIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\ENV_Daily.csv'; %combined in these excel because it was a pain in the ass
%% Load echosounder logs
fileList = cellstr(ls(echoDIR)); % Get a list of all the files in the directory
detfn = ['WAT_GS','.*','.xls']; % Define parts of the file name
fileMatchIdx = find(~cellfun(@isempty,regexp(fileList,detfn))>0); % Find the file name that matches the filePrefix
concatFiles = fileList(fileMatchIdx); % Concatenate all detections from the same site

% Loop through all of the logs and load them into one table
echoTABLE = []; % create an empty table for echosounder data
for idsk = 1 : length(concatFiles)
 fprintf('Loading %d/%d file %s\n',idsk,length(concatFiles),fullfile(echoDIR,concatFiles{idsk}))
 D = readtable(fullfile(echoDIR,concatFiles{idsk})); %Upload temporar table
 D.Comments = [];
 if idsk == 1
     echoTABLE = D;
 else
     echoTABLE = [echoTABLE; D];
 end
end

%For Rio
% Delete all columns that are unnecessary
echoTABLE.InputFile = [];
echoTABLE.EventNumber = [];
echoTABLE.SpeciesCode = [];
echoTABLE.Call = [];
echoTABLE.Parameter1 = [];
echoTABLE.Parameter2 = [];
echoTABLE.Parameter3 = [];
echoTABLE.Parameter4 = [];
echoTABLE.Parameter5 = [];
echoTABLE.Parameter6 = [];
echoTABLE.Image = [];
echoTABLE.Audio = [];
%Create a new column for duration
echoTABLE.EchoDuration = echoTABLE.EndTime - echoTABLE.StartTime;
% Delete rows with NaNs
echoTABLE = rmmissing(echoTABLE);
%% Upload sperm whale data
%GS
pmDATA = readtable(pmDIR); % Upload sperm whale data to Matlab
% Deleting unnecessary columns in sperm whale data
pmDATA.Effort_Bin = []; 
pmDATA.Effort_Sec = [];
pmDATA.PreAbs = [];
% Regrouping sperm whale data on the daily level
pmDailyDATA = table2timetable(pmDATA);
pmDailyDATA = retime(pmDailyDATA,'daily','sum');

% Evaluating how many start and end days are different 
startDAY = day(echoTABLE.StartTime); % Finding day
endDAY = day(echoTABLE.EndTime); % Finding day
difference = endDAY - startDAY; % Finding difference of start and end days
sum(difference);

% Duplicate table and delete column
echoDailyTABLE = echoTABLE;
echoDailyTABLE.EndTime = [];
echoDailyTABLE = table2timetable(echoDailyTABLE);
echoDailyTABLE = retime(echoDailyTABLE,'daily','sum');
echoDailyTABLE.EchoDuration = minutes(echoDailyTABLE.EchoDuration);

%Control (BP)
pmDATA_control = readtable(controlDIR); % Upload sperm whale data to Matlab
% Deleting unnecessary columns in sperm whale data
pmDATA_control.Effort_Bin = []; 
pmDATA_control.Effort_Sec = [];
pmDATA_control.PreAbs = [];
pmDailyDATA_control = table2timetable(pmDATA_control);
pmDailyDATA_control = retime(pmDailyDATA_control,'daily','sum');
pmDailyDATA_control.Properties.VariableNames{1} = 'Count_Click_Control';
pmDailyDATA_control.Properties.VariableNames{2} = 'Count_Bin_Control';
%% Environmental Data
SST_GS = readtable(SST_GS_DIR); %load SST table from the csv
SST_BP = readtable(SST_BP_DIR);
CHL_GS = readtable(CHL_GS_DIR);
CHL_BP = readtable(CHL_BP_DIR);
ENV_Daily = readtable(ENV_DAILY_DIR);
%% Combine All data
temptable = timetable2table(outerjoin(pmDailyDATA,echoDailyTABLE));
temptable2 = outerjoin(temptable,timetable2table(pmDailyDATA_control));
temptable2.Properties.VariableNames{1} ='tbin';
masterTABLE = outerjoin(temptable2,ENV_Daily);
masterTABLE(:,'tbin_right') = [];
masterTABLE(:,'tbin_ENV_Daily') = [];
masterTABLE.EchoDuration(ismissing(masterTABLE.EchoDuration)) = 0; %replace NANs with zero
masterTABLE.Count_Bin_Control(ismissing(masterTABLE.Count_Bin_Control)) = 0; %replace NANs with zero
masterTABLE.Count_Click_Control(ismissing(masterTABLE.Count_Click_Control)) = 0; %replace NANs with zero
masterTABLE.Properties.VariableNames{1} ='tbin';
%% Count Bin to minutes
masterTABLE.Count_Bin = masterTABLE.Count_Bin*5;
masterTABLE.Count_Bin_Control = masterTABLE.Count_Bin_Control*5;
%% Retime to weekly
masterTABLE_weekly = retime(table2timetable(masterTABLE),'weekly','mean');
%% Normalize Presence before running statistical tests
masterTABLE.NormCountBin = normalize(masterTABLE.Count_Bin);
masterTABLE.NormCountBinControl = normalize(masterTABLE.Count_Bin_Control);
%% Statistical analysis for echosounder on raw data
%Split data into 3 data sets and run kruskal wallis test on GS and BP
masterTAB = table2timetable(masterTABLE);
FirstTR = timerange('2016-11-16','2017-05-10');
FirstNumDays = daysact('2016-11-16','2017-05-10'); %175
First = masterTAB(FirstTR,:);
FirstCTR = timerange('2017-05-10','2017-11-01'); %175 days at GS
FirstCTR = masterTAB(FirstCTR,:);
x1 = [First.Count_Bin,First.Count_Bin_Control,FirstCTR.Count_Bin];
p1 = kruskalwallis(x1);
figure
bar(First.tbin,First.Count_Bin,'r')
hold on
bar(First.tbin,First.Count_Bin_Control)

SecondTR = timerange('2017-11-02','2018-04-04');
SecondNumDays = daysact('2017-11-02','2018-04-04'); %153
Second = masterTAB(SecondTR,:);
SecondCTR = timerange('2018-05-01','2018-10-01'); %175 days at GS
SecondCTR = masterTAB(SecondCTR,:);
x2 = [Second.Count_Bin,Second.Count_Bin_Control,SecondCTR.Count_Bin];
p2 = kruskalwallis(x2);
figure
bar(Second.tbin,Second.Count_Bin,'r')
hold on
bar(Second.tbin,Second.Count_Bin_Control)

ThirdTR = timerange('2018-11-08','2019-03-29');
ThirdNumDays = daysact('2018-11-08','2019-03-29'); %141
Third = masterTAB(ThirdTR,:);
x3 = [Third.Count_Bin,Third.Count_Bin_Control];
p3 = kruskalwallis(x3);
figure
bar(Third.tbin,Third.Count_Bin,'r')
hold on
bar(Third.tbin,Third.Count_Bin_Control)

%Run Kruskall Wallis with all data when there was the echosounder
EchomasterTAB = [First; Second; Third];
x4 = [EchomasterTAB.Count_Bin, EchomasterTAB.Count_Bin_Control];
p4 = kruskalwallis(x4);

%Run Kruskall Wallis with GS data only when there was and wasn't the
%echosounder
GSprelim = [First;Second];
GSprelim2 = [FirstCTR;SecondCTR];
x5 = [GSprelim.Count_Bin,GSprelim2.Count_Bin_Control];
p5 = kruskalwallis(x5);
%% Statistical analysis for echosounder on normalized data
%Split data into 3 data sets and run kruskal wallis test on GS and BP
masterTAB = table2timetable(masterTABLE);

FirstTR = timerange('2016-11-16','2017-05-10');
FirstNumDays = daysact('2016-11-16','2017-05-10'); %175
First = masterTAB(FirstTR,:);
FirstCTR = timerange('2017-05-10','2017-11-01'); %175 days at GS
FirstCTR = masterTAB(FirstCTR,:);
x1 = [First.NormCountBin,First.NormCountBinControl,FirstCTR.NormCountBin];
p1 = kruskalwallis(x1);

SecondTR = timerange('2017-11-02','2018-04-04');
SecondNumDays = daysact('2017-11-02','2018-04-04'); %153
Second = masterTAB(SecondTR,:);
SecondCTR = timerange('2018-05-01','2018-10-01'); %175 days at GS
SecondCTR = masterTAB(SecondCTR,:);
x2 = [Second.NormCountBin,Second.NormCountBinControl,SecondCTR.NormCountBin];
p2 = kruskalwallis(x2);

ThirdTR = timerange('2018-11-08','2019-03-29');
ThirdNumDays = daysact('2018-11-08','2019-03-29'); %141
Third = masterTAB(ThirdTR,:);
x3 = [Third.NormCountBin,Third.NormCountBinControl];
p3 = kruskalwallis(x3);

%Run Kruskall Wallis with all data when there was the echosounder
EchomasterTAB = [First; Second; Third];
x4 = [EchomasterTAB.NormCountBin, EchomasterTAB.NormCountBinControl];
p4 = kruskalwallis(x4);
xlabel('Site','FontSize',12)
ylabel('Normalized Daily Sperm Whale Presence','FontSize',12)
title('Comparing Normalized Presence of Sperm Whales','FontSize',15)
xticklabels({'GS','BP'})

%Run Kruskall Wallis with GS data only when there was and wasn't the
%echosounder
GSprelim = [First;Second];
GSprelim2 = [FirstCTR;SecondCTR];
x5 = [GSprelim.NormCountBin,GSprelim2.NormCountBin];
p5 = kruskalwallis(x5);
xlabel('Within GS','FontSize',12)
ylabel('Normalized Daily Sperm Whale Presence','FontSize',12)
title('Comparing Normalized Presence of Sperm Whales','FontSize',15)
xticklabels({'Echosounder','No Echosounder'})
%Make box plots
%% Plot data
% Plot echosounder data
figure
plot(echoTABLE.StartTime,echoTABLE.EchoDuration,'o'); %This is plotting echosounder duration according to start time
title('GS Echosounder Duration');
xlabel('Date (Daily)');
ylabel('Duration');
fn = [saveDIR,'\Dot Plot GS Echosounder Duration']; %Where to save and specify the file name
saveas(gcf,fn,'png');

figure
bar(echoTABLE.StartTime,echoTABLE.EchoDuration); %This is plotting echosounder duration in bar plot according to start time

% Plotting sperm whale presence
figure
plot(pmDATA.tbin,pmDATA.Count_Click,'o'); % This is plotting click count
figure
plot(pmDATA.tbin,pmDATA.Count_Bin,'o'); % This is plotting bin count
figure
bar(pmDATA.tbin,pmDATA.Count_Click); % This is plotting click count in bar plot
figure
bar(pmDATA.tbin,pmDATA.Count_Bin); % This is plotting bin count in bar plot

%Plotting sperm whale presence weekly
figure 
bar(masterTABLE_weekly.tbin,masterTABLE_weekly.Count_Bin)
hold on
plot(masterTABLE_weekly.tbin,masterTABLE_weekly.EchoDuration,'.')

% Plotting echosounder with sperm whale presence
figure
yyaxis left
bar(masterTABLE.tbin,masterTABLE.Count_Click);
hold on
yyaxis right
plot(masterTABLE.tbin,masterTABLE.EchoDuration,'.')

% Plot Control Data
figure 
bar(masterTABLE_weekly.tbin,masterTABLE_weekly.Count_Bin_Control)
xlim([masterTABLE_weekly.tbin(1) masterTABLE_weekly.tbin(end)])
xlabel('Week')
ylabel('Average Sperm Whale Presence (min)')
title('Weekly Sperm Whale Presence at the Blake Plateau Site')

%Plot echsounder weekly
figure
yyaxis left
bar(masterTABLE_weekly.tbin,masterTABLE_weekly.Count_Bin)
xlim([masterTABLE_weekly.tbin(1) masterTABLE_weekly.tbin(end)])
xlabel('Week')
ylabel('Average Sperm Whale Presence (min)')
hold on
yyaxis right
plot(masterTABLE_weekly.tbin,masterTABLE_weekly.EchoDuration,'.r','MarkerSize',10)
ylabel('Average Echosounder Duration (min)')
title({'Weekly Sperm Whale and Echosounder Presence','at the Gulf Stream Site'})

% Plot environmental data with echsounder at GS
figure
bar(masterTABLE_weekly.tbin, masterTABLE_weekly.Count_Bin,'k')
set(gca,'FontSize',24)
addaxis(masterTABLE_weekly.tbin,masterTABLE_weekly.SST_GS,'b','LineWidth',3)
addaxis(masterTABLE_weekly.tbin,masterTABLE_weekly.EchoDuration,'.r','MarkerSize',10)
addaxis(masterTABLE_weekly.tbin,masterTABLE_weekly.chlor_a_GS,'g','LineWidth',3)
addaxislabel(1,'Average Weekly Sperm Whale Presence (min)','FontSize',40)
addaxislabel(2, 'SST (C)','FontSize',40)
addaxislabel(3, 'Average Weekly Echosounder Duration (min)','FontSize',40)
addaxislabel(4, 'Chl a (mg/m^3)','FontSize',40)
xlim([masterTABLE_weekly.tbin(1) masterTABLE_weekly.tbin(end)])
title(['Weekly Presence of Sperm whales at the Gulf Stream Site'])
legend('Sperm Whale','SST','Echosounder','Chl a');
xlabel('Date')

% Plot environmental data at BP
figure
bar(masterTABLE_weekly.tbin, masterTABLE_weekly.Count_Bin_Control,'k')
set(gca,'FontSize',24)
addaxis(masterTABLE_weekly.tbin,masterTABLE_weekly.SST_BP,'b','LineWidth',3)
addaxis(masterTABLE_weekly.tbin,masterTABLE_weekly.chlor_a_BP,'g','LineWidth',3)
addaxislabel(1,'Average Weekly Sperm Whale Presence (min)','FontSize',40)
addaxislabel(2, 'SST (C)','FontSize',40)
addaxislabel(3, 'Chl a (mg/m^3)','FontSize',40)
xlim([masterTABLE_weekly.tbin(1) masterTABLE_weekly.tbin(end)])
title(['Weekly Presence of Sperm whales at the Blake Plateau Site'])
legend('Sperm Whale','SST','Chl a');
xlabel('Date')

%% Show seasonal pattern with plots
masterTABLE.JD = day(masterTABLE.tbin,'dayofyear');
[MD,~] = findgroups(masterTABLE.JD);
masterTABLE.JD = categorical(masterTABLE.JD);

%mean for GS
[mean, sem, std, var, range] = grpstats(masterTABLE.Count_Bin, masterTABLE.JD, {'mean','sem','std','var','range'}); %takes the mean of each day of the year
meantable = array2table(mean);
semtable = array2table(sem);
stdtable = array2table(std);
vartable = array2table(var);
rangetable = array2table(range);
newcol_mean = (1:length(mean))';
meanarray365 = [newcol_mean mean sem std var range];
meantab365 = array2table(meanarray365);
meantab365.Properties.VariableNames = {'Day' 'HoursProp' 'SEM' 'Std' 'Var' 'Range'};

%mean for BP
[mean, sem, std, var, range] = grpstats(masterTABLE.Count_Bin_Control, masterTABLE.JD, {'mean','sem','std','var','range'}); %takes the mean of each day of the year
meantable = array2table(mean);
semtable = array2table(sem);
stdtable = array2table(std);
vartable = array2table(var);
rangetable = array2table(range);
newcol_mean = (1:length(mean))';
meanarray365 = [newcol_mean mean sem std var range];
meantab365CTR = array2table(meanarray365);
meantab365CTR.Properties.VariableNames = {'Day' 'HoursProp' 'SEM' 'Std' 'Var' 'Range'};

figure
bar(meantab365.Day,meantab365.HoursProp)
xlim([1 365])
xticks([45, 135, 225, 315])
xticklabels({'Winter','Spring','Summer','Fall'})
xlabel('Season','FontSize',20)
ylabel('Average Sperm Whale Presence (min)','FontSize',20)
title('Seasonal Presence of Sperm whales at the Gulf Stream Site','FontSize',25)
ax = gca;
ax.FontSize = 15;

figure
bar(meantab365CTR.Day,meantab365CTR.HoursProp)
xlim([1 365])
xticks([45, 135, 225, 315])
xticklabels({'Winter','Spring','Summer','Fall'})
xlabel('Season','FontSize',20)
ylabel('Average Sperm Whale Presence (min)','FontSize',20)
title('Seasonal Presence of Sperm whales at the Blake Plataeu Site','FontSize',25)
ax = gca;
ax.FontSize = 15;
