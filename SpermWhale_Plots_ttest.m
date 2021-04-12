%This script was made by Rio and Natalie for SeaTech 2021. This script will
%produce plots for Rio's sperm whale project. It will also calculate the
%t-test for the means between vessel encounters and natural foraging times.
%Created in MATLAB 2016b
%April 5, 2021
%RB and NP

%% Load the data
%Encounter 1
Encounter1 = readtable('C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhalePlots\Encounter1.xlsx');%load the Encounter 1 data
NatEncounter1 = readtable('C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhalePlots\April_CB.xlsx');%load the April data

%Ecounter 2
Encounter2 = readtable('C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhalePlots\Encounter2.xlsx');%load the Encounter 2 data

%% Take a random value of the natural encounter
%Encounter 1
NatEncounter1_sample = randsample(NatEncounter1.ICI,550);
NatEncounter1_sample = array2table(NatEncounter1_sample); %turns the array into a table

%Ecounter 2

%% Calculate the statistics
%Encounter 1
[h,p,ci,stats] = ttest2(Encounter1.ICI,NatEncounter1_sample.NatEncounter1_sample);

%Encounter 2

%% Combine the two tables
%Encounter 1
Encounter1.SampleNum = Encounter1.ICIRounded*0+1; %specify that this is sample 1
%NatEncounter1_sample
NatEncounter1_sample.SampleNum = NatEncounter1_sample.NatEncounter1_sample*0+2; %specify that this is sample 2
%combine table
BoxPlot = array2table([Encounter1.ICI Encounter1.SampleNum]);
BoxPlot.Properties.VariableNames{1} = 'ICI';
BoxPlot.Properties.VariableNames{2} = 'SampleNum';
NatEncounter1_sample.Properties.VariableNames{1} = 'ICI';
BoxPlotTable = [BoxPlot; NatEncounter1_sample];

%Encounter 2

%% Box and whisker plots
%Encounter 1
figure
boxplot(BoxPlotTable.ICI,BoxPlotTable.SampleNum)

%Encounter 2
