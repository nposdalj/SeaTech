%%This script was written on 03112021 to extract click times from
%%GofAK_CB10 and GofAK_KOA that match up with fishing vessel presence for
%%SeaTech student Rio. NP

%%This has to be run in Matlab 2020
%% 
clear all;close all;clc;
%% Load necessary files
%load click times for KOA
load(['E:\Project_Sites\KOA\Seasonality\KOA_workspace125.mat']); %load workspace
KOA = clickData;
clearvars -except KOA

%table wrangling
KOA.PPall = []; %delete PPall
KOA.Properties.VariableNames = {'ICI'};
rows = KOA.ICI > 300; %get rid of rows with ICIs less than 300 ms
KOA = KOA(rows,:);
rows = KOA.ICI < 2000; %get rid of rows with ICIs greater than 2000 ms
KOA = KOA(rows,:);

%load click times for CB
load(['E:\Project_Sites\CB\Seasonality\CB_workspace125.mat']); %load workspace
CB = clickData;
clearvars -except KOA CB

%table wrangling
CB.PPall = []; %delete PPall
CB.Properties.VariableNames = {'ICI'};
rows = CB.ICI > 300; %get rid of rows with ICIs less than 300 ms
CB = CB(rows,:);
rows = CB.ICI < 2000; %get rid of rows with ICIs greater than 2000 ms
CB = CB(rows,:);

%load ship times from excel
ships = readtable('C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhales\GofAK_FishingVessels_SpermWhales.xlsx');

%% Getting Encounter times

%Encounter 1
%Hear
rangeOfTimes = timerange(ships.Hear_Start(1),ships.Hear_End(1));
[tf,whichrows]=withinrange(CB,rangeOfTimes);
Enc1_H = CB(whichrows,:);
% Enc1_H.ICIRound = round(Enc1_H.ICI,-1);
% figure
% hist(Enc1_H.ICIRound);
% mode(Enc1_H.ICIRound)
writetimetable(Enc1_H,'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhales\Encounter1_H.xlsx');

%See
rangeOfTimes = timerange(ships.See_Start(1),ships.See_End(1));
[tf,whichrows]=withinrange(CB,rangeOfTimes);
Enc1_S = CB(whichrows,:);
Enc1_H.ICIRound = round(Enc1_H.ICI,-1);
figure
hist(Enc1_H.ICIRound);
mode(Enc1_H.ICIRound)
writetimetable(Enc1_S,'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhales\Encounter1_S.xlsx');

%Encounter 2
%Hear
rangeOfTimes = timerange(ships.Hear_Start(2),ships.Hear_End(2));
[tf,whichrows]=withinrange(KOA,rangeOfTimes);
Enc2_H = KOA(whichrows,:);
writetimetable(Enc2_H,'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhales\Encounter2.xlsx');

%Encounter 3
%Hear
rangeOfTimes = timerange(ships.Hear_Start(3),ships.Hear_End(3));
[tf,whichrows]=withinrange(KOA,rangeOfTimes);
Enc3_H = KOA(whichrows,:);
writetimetable(Enc3_H,'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhales\Encounter3_H.xlsx');

%See
rangeOfTimes = timerange(ships.See_Start(3),ships.See_End(3));
[tf,whichrows]=withinrange(KOA,rangeOfTimes);
Enc3_S = KOA(whichrows,:);
writetimetable(Enc3_S,'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhales\Encounter3_S.xlsx');

%Encounter 4
%See
rangeOfTimes = timerange(ships.See_Start(4),ships.See_End(4));
[tf,whichrows]=withinrange(KOA,rangeOfTimes);
Enc4_S = KOA(whichrows,:);
writetimetable(Enc4_S,'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhales\Encounter4_S.xlsx');

%Encounter 5
%Hear
rangeOfTimes = timerange(ships.Hear_Start(5),ships.Hear_End(5));
[tf,whichrows]=withinrange(KOA,rangeOfTimes);
Enc5_H = KOA(whichrows,:);
writetimetable(Enc5_H,'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhales\Encounter5_H.xlsx');

%Encounter 6
%See
rangeOfTimes = timerange(ships.See_Start(6),ships.See_End(6));
[tf,whichrows]=withinrange(CB,rangeOfTimes);
Enc6_S = CB(whichrows,:);
writetimetable(Enc6_S,'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhales\Encounter6_S.xlsx');

%Encounter 9
%Hear
rangeOfTimes = timerange(ships.Hear_Start(9),ships.Hear_End(9));
[tf,whichrows]=withinrange(KOA,rangeOfTimes);
Enc9_H = KOA(whichrows,:);
writetimetable(Enc9_H,'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhales\Encounter9_H.xlsx');

%See
rangeOfTimes = timerange(ships.See_Start(9),ships.See_End(9));
[tf,whichrows]=withinrange(KOA,rangeOfTimes);
Enc9_S = KOA(whichrows,:);
writetimetable(Enc9_S,'C:\Users\nposd\Documents\GitHub\SeaTech\SpermWhales\Encounter9_S.xlsx');
    
