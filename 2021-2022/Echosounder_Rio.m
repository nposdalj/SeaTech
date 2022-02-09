%% This script was written by NP and RCB to compile the echosounder logs from WAT_GS and plot them with sperm whale presence.
% 2/8/22
%% User Defined Parameters
echoDIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EchoLogs'; % local directory for echosounder logs
pmDIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\PmData\SpermWhale_BinData_GS.csv'; % local directory for sperm whale data
saveDIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\Plots_Tables'; % local directory to save tables
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

%Create a new column for duration
echoTABLE.echoTIME = echoTABLE.EndTime - echoTABLE.StartTime;

%% Upload sperm whale data
pmDATA = readtable(pmDIR); % Upload sperm whale data to Matlab
% Deleting unnecessary columns in sperm whale data
pmDATA.Effort_Bin = []; 
pmDATA.Effort_Sec = [];
pmDATA.PreAbs = [];
%% Compile echosounder and sperm whale data into one table
%% Plot data
% Plot Echosounder data


% Plotting sperm whale presence
figure
plot(pmDATA.tbin,pmDATA.Count_Click,'o'); % This is plotting click count
figure
plot(pmDATA.tbin,pmDATA.Count_Bin,'o'); % This is plotting bin count
figure
bar(pmDATA.tbin,pmDATA.Count_Click); % This is plotting click count in bar plot
figure
bar(pmDATA.tbin,pmDATA.Count_Bin); % This is plotting bin count in bar plot
%% Statistical analysis