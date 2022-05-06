%% clear
clear all; close all;clc;
%% load data
SST_GS_DIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\SST_GS.csv';
SST_GS = readtable(SST_GS_DIR);
SST_BP_DIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\SST_BP.csv';
SST_BP = readtable(SST_BP_DIR);
Chla_GS_DIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\Chla_GS.csv';
Chla_GS = readtable(Chla_GS_DIR);
Chla_BP_DIR = 'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\Chla_BP.csv';
Chla_BP = readtable(Chla_BP_DIR);
%% Delete first row
SST_BP(1,:) = [];
SST_GS(1,:) = [];
Chla_BP(1,:) = [];
Chla_GS(1,:) = [];
Chla_BP(:,'altitude') = [];
Chla_GS(:,'altitude') = [];
%% String to double
SST_BP.latitude = str2double(SST_BP.latitude);
SST_BP.longitude = str2double(SST_BP.longitude);
SST_BP.analysed_sst = str2double(SST_BP.analysed_sst);
SST_BP.analysis_error = str2double(SST_BP.analysis_error);

SST_GS.latitude = str2double(SST_GS.latitude);
SST_GS.longitude = str2double(SST_GS.longitude);
SST_GS.analysed_sst = str2double(SST_GS.analysed_sst);
SST_GS.analysis_error = str2double(SST_GS.analysis_error);

Chla_BP.latitude = str2double(Chla_BP.latitude);
Chla_BP.longitude = str2double(Chla_BP.longitude);
Chla_BP.chlor_a = str2double(Chla_BP.chlor_a);

Chla_GS.latitude = str2double(Chla_GS.latitude);
Chla_GS.longitude = str2double(Chla_GS.longitude);
Chla_GS.chlor_a = str2double(Chla_GS.chlor_a);
%% Convert date
SST_BP_time = eraseBetween(SST_BP.time,11,20);
SST_BP.time = datetime(SST_BP_time,'InputFormat','yyyy-MM-dd');

SST_GS_time = eraseBetween(SST_GS.time,11,20);
SST_GS.time = datetime(SST_GS_time,'InputFormat','yyyy-MM-dd');

Chla_BP_time = eraseBetween(Chla_BP.time,11,20);
Chla_BP.time = datetime(Chla_BP_time,'InputFormat','yyyy-MM-dd');

Chla_GS_time = eraseBetween(Chla_GS.time,11,20);
Chla_GS.time = datetime(Chla_GS_time,'InputFormat','yyyy-MM-dd');
%% Retime to get daily mean
SST_BP = table2timetable(SST_BP);
SST_GS = table2timetable(SST_GS);
Chla_BP = table2timetable(Chla_BP);
Chla_GS = table2timetable(Chla_GS);

SST_BP_daily = retime(SST_BP,'daily','mean');
SST_GS_daily = retime(SST_GS,'daily','mean');
Chla_BP_daily = retime(Chla_BP,'daily','mean');
Chla_GS_daily = retime(Chla_GS,'daily','mean');
%% Save tables
writetable(timetable2table(SST_BP_daily),'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\SST_BP_Daily.csv');
writetable(timetable2table(SST_GS_daily),'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\SST_GS_Daily.csv');
writetable(timetable2table(Chla_BP_daily),'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\Chla_BP_Daily.csv');
writetable(timetable2table(Chla_GS_daily),'C:\Users\nposd\Documents\GitHub\SeaTech\2021-2022\EnvironmentalData\Chla_GS_Daily.csv');