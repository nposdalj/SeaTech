OGmasterLOG = readtable('E:\SeaTech\MasterLog_KOA.xlsx');
OGmasterLOG = removevars(OGmasterLOG,{'InputFile','EventNumber','Call','Var7',...
    'Var8','Var9','Var10','Var11','Var12','Var13'});
OGmasterLOG = movevars(OGmasterLOG,'SpeciesCode','After','EndTime');

OGmasterLOG.SpeciesCode = strrep(OGmasterLOG.SpeciesCode,'Bb1','Bb');

%Anthro
AnthroStart = OGmasterLOG.StartTime(strcmp(OGmasterLOG.SpeciesCode,'Anthro'));
AnthroEnd = OGmasterLOG.EndTime(strcmp(OGmasterLOG.SpeciesCode,'Anthro'));
Anthro = [AnthroStart AnthroEnd];
AnthroTab = array2table(Anthro);
AnthroTab.Time = between (AnthroStart,AnthroEnd,'Time');
AnthroTab.Properties.VariableNames = {'Start' 'End' 'Time'};
AnthroTab.Hours = hours(AnthroEnd-AnthroStart);
AnthroTab.StartWeek = week(AnthroTab.Start);
AnthroTab.EndWeek = week(AnthroTab.End);
AnthroTab.Diff = AnthroTab.EndWeek-AnthroTab.StartWeek;
AnthroTab.StartGroup = categorical(AnthroTab.StartWeek);
Anthro_sumarray = grpstats(AnthroTab.Hours,AnthroTab.StartGroup,@sum);
Anthro_groups = unique(AnthroTab.StartGroup);
Anthro_groupss = str2num(char(Anthro_groups));
Anthro_finalTAB = [Anthro_groupss Anthro_sumarray];
Anthro_finalTAB(14,1) = 39;

%Pm
PmStart = OGmasterLOG.StartTime(strcmp(OGmasterLOG.SpeciesCode,'Pm'));
PmEnd = OGmasterLOG.EndTime(strcmp(OGmasterLOG.SpeciesCode,'Pm'));
Pm = [PmStart PmEnd];
PmTab = array2table(Pm);
PmTab.Time = between(PmStart,PmEnd,'Time');
PmTab.Properties.VariableNames = {'Start' 'End' 'Time'};
PmTab.Hours = hours(PmEnd-PmStart);
PmTab.StartWeek = week(PmTab.Start);
PmTab.EndWeek = week(PmTab.End);
PmTab.Diff = PmTab.EndWeek-PmTab.StartWeek;
PmTab.StartGroup = categorical(PmTab.StartWeek);
Pm_sumarray = grpstats(PmTab.Hours,PmTab.StartGroup,@sum);
Pm_groups = unique(PmTab.StartGroup);
Pm_groupss = str2num(char(Pm_groups));
Pm_finalTAB = [Pm_groupss Pm_sumarray];
Pm_finalTAB(23,1) = 39;

%Oo
OoStart = OGmasterLOG.StartTime(strcmp(OGmasterLOG.SpeciesCode,'Oo'));
OoEnd = OGmasterLOG.EndTime(strcmp(OGmasterLOG.SpeciesCode,'Oo'));
Oo = [OoStart OoEnd];
OoTab = array2table(Oo);
OoTab.Time = between (OoStart,OoEnd,'Time');
OoTab.Properties.VariableNames = {'Start' 'End' 'Time'};
OoTab.Hours = hours(OoEnd-OoStart);
OoTab.StartWeek = week(OoTab.Start);
OoTab.EndWeek = week(OoTab.End);
OoTab.Diff = OoTab.EndWeek-OoTab.StartWeek;
OoTab.StartGroup = categorical(OoTab.StartWeek);
Oo_sumarray = grpstats(OoTab.Hours,OoTab.StartGroup,@sum);
Oo_groups = unique(OoTab.StartGroup);
Oo_groupss = str2num(char(Oo_groups));
Oo_finalTAB = [Oo_groupss Oo_sumarray];
Oo_finalTAB(14,1) = 17;
Oo_finalTAB(15,1) = 39;

%Bb1
BbStart = OGmasterLOG.StartTime(strcmp(OGmasterLOG.SpeciesCode,'Bb'));
BbEnd = OGmasterLOG.EndTime(strcmp(OGmasterLOG.SpeciesCode,'Bb'));
Bb = [BbStart BbEnd];
BbTab = array2table(Bb);
BbTab.Time = between (BbStart,BbEnd,'Time');
BbTab.Properties.VariableNames = {'Start' 'End' 'Time'};
BbTab.Hours = hours(BbEnd-BbStart);
BbTab.StartWeek = week(BbTab.Start);
BbTab.EndWeek = week(BbTab.End);
BbTab.Diff = BbTab.EndWeek-BbTab.StartWeek;
BbTab.StartGroup = categorical(BbTab.StartWeek);
Bb_sumarray = grpstats(BbTab.Hours,BbTab.StartGroup,@sum);
Bb_groups = unique(BbTab.StartGroup);
Bb_groupss = str2num(char(Bb_groups));
Bb_finalTAB = [Bb_groupss Bb_sumarray];
Bb_finalTAB(17,1) = 39;

%Ms
MsStart = OGmasterLOG.StartTime(strcmp(OGmasterLOG.SpeciesCode,'Ms'));
MsEnd = OGmasterLOG.EndTime(strcmp(OGmasterLOG.SpeciesCode,'Ms'));
Ms = [MsStart MsEnd];
MsTab = array2table(Ms);
MsTab.Time = between (MsStart,MsEnd,'Time');
MsTab.Properties.VariableNames = {'Start' 'End' 'Time'};
MsTab.Hours = hours(MsEnd-MsStart);
MsTab.StartWeek = week(MsTab.Start);
MsTab.EndWeek = week(MsTab.End);
MsTab.Diff = MsTab.EndWeek-MsTab.StartWeek;
MsTab.StartGroup = categorical(MsTab.StartWeek);
Ms_sumarray = grpstats(MsTab.Hours,MsTab.StartGroup,@sum);
Ms_groups = unique(MsTab.StartGroup);
Ms_groupss = str2num(char(Ms_groups));
Ms_finalTAB = [Ms_groupss Ms_sumarray];

%% load ship detector sounds
KOA_ship = load('E:\SeaTech\GofAK_KOA_disk02-03.mat');
shipTimes = cell2mat(KOA_ship.times);
shipTimes = datetime(shipTimes,'ConvertFrom','datenum');
shipTAB = array2table(shipTimes);
shipTAB.Properties.VariableNames = {'Start' 'End'};
shipTAB.Hours = hours(shipTAB.End-shipTAB.Start);
shipTAB.StartWeek = week(shipTAB.Start);
shipTAB.EndWeek = week(shipTAB.End);
shipTAB.Diff = shipTAB.EndWeek - shipTAB.StartWeek;
shipTAB.StartGroup = categorical(shipTAB.StartWeek);
ship_sumarray = grpstats(shipTAB.Hours,shipTAB.StartGroup,@sum);
ship_groups = unique(shipTAB.StartGroup);
ship_groupss = str2num(char(ship_groups));
ship_finalTAB = [ship_groupss ship_sumarray];

%% combine anthro + ship times
Anthro_finTAB = array2table(Anthro_finalTAB);
Anthro_finTAB.Properties.VariableNames = {'Week' 'Hours'};
ship_finalTAB = array2table(ship_finalTAB);
ship_finalTAB.Properties.VariableNames = {'Week' 'Hours'};
All_ANTHRO = outerjoin(Anthro_finTAB,ship_finalTAB,'MergeKeys',true);

All_ANTHRO_array = grpstats(All_ANTHRO.Hours,All_ANTHRO.Week,@sum);
All_ANTHRO_groups = unique(All_ANTHRO.Week);
All_ANTHRO_groupss = str2num(char(All_ANTHRO_groups));
All_ANTHRO_finalTAB = [All_ANTHRO_groups All_ANTHRO_array];

%% Individual Plots
xtl = {{'May','2019'},{'Jun','2019'},{'Jul','2019'},{'Aug','2019'},{'Sept','2019'}};
%just echosounders
figure
bar(Anthro_finalTAB(:,1),Anthro_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,4.3,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,8.2,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Echosounders at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend([effort],'Effort')
saveas(gcf,'E:\SeaTech\KOA_EchoSounders_weekly_presence.png');
close all

%echosounders + ships from detector
figure
bar(All_ANTHRO_finalTAB(:,1),All_ANTHRO_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,7,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,13.8,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Anthropogenic Sounds at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend([effort],'Effort')
saveas(gcf,'E:\SeaTech\KOA_All_Anthro_weekly_presence.png');
close all

figure
bar(Pm_finalTAB(:,1),Pm_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,76,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,138,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Sperm Whales at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend([effort],'Effort')
saveas(gcf,'E:\SeaTech\KOA_Pm_weekly_presence.png');
close all

figure
bar(Oo_finalTAB(:,1),Oo_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,2.8,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,5,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Killer Whales at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend([effort],'Effort')
saveas(gcf,'E:\SeaTech\KOA_Oo_weekly_presence.png');
close all

figure
bar(Bb_finalTAB(:,1),Bb_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,9,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,17,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Baird''s Beaked Whale at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend([effort],'Effort')
saveas(gcf,'E:\SeaTech\KOA_Bb_weekly_presence.png');
close all

figure
bar(Ms_finalTAB(:,1),Ms_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,0.45,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,0.85,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Stejneger''s Beaked Whale at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend([effort],'Effort')
saveas(gcf,'E:\SeaTech\KOA_Ms_weekly_presence.png');
close all
%% Weekly plots anthro + all species

%Anthro + PM
figure
bar(Pm_finalTAB(:,1),Pm_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
hold on
bar(All_ANTHRO_finalTAB(:,1),All_ANTHRO_finalTAB(:,2),'r','BarWidth',1)
plot(17,70,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,128,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Anthropogenic Sounds and Sperm Whales at Site KOA')
%xtix = xticks([18 23 28 33 38]);
%xlabel('Months in 2019')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend('Sperm Whale','Anthropogenic Noise','Effort','Location','NorthWest')
saveas(gcf,'E:\SeaTech\KOA_All_Anthro_withPM_weekly_presence.png');
close all

%Anthro + Oo
figure
bar(All_ANTHRO_finalTAB(:,1),All_ANTHRO_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Oo_finalTAB(:,1),Oo_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,7.6,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,13.8,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Anthropogenic Sounds and Killer Whales at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend('Anthropogenic Noise','Killer Whales','Effort','Location','NorthWest')
saveas(gcf,'E:\SeaTech\KOA_Oo_withAnthro_weekly_presence.png');
close all

%Anthro + Bb - NEEDS MANUAL ADJUSTMENT OF SIZE
figure
bar(All_ANTHRO_finalTAB(:,1),All_ANTHRO_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Bb_finalTAB(:,1),Bb_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,9,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,17,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Anthropogenic Noise and Baird''s Beaked Whale at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend('Anthropogenic Noise','Baird''s Beaked Whale','Effort','Location','Best')
saveas(gcf,'E:\SeaTech\KOA_Bb_withAnthro_weekly_presence.png');
close all

%Anthro + Ms - NEEDS MANUAL ADJUSTMENT OF SIZE
figure
bar(All_ANTHRO_finalTAB(:,1),All_ANTHRO_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Ms_finalTAB(:,1),Ms_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,7,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,13.5,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Anthropogenic Sounds and Stejneger''s Beaked Whale at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend('Anthropogenic Noise','Baird''s Beaked Whale','Effort','Location','NorthWest')
saveas(gcf,'E:\SeaTech\KOA_Ms_withAnthro_weekly_presence.png');
close all
%% Weekly plots with Oo and each species

%Oo + PM
figure
bar(Pm_finalTAB(:,1),Pm_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
hold on
bar(Oo_finalTAB(:,1),Oo_finalTAB(:,2),'r','BarWidth',1)
plot(17,67,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,135,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Killer Whales and Sperm Whales at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend('Sperm Whales','Killer Whales','Effort','Location','NorthWest')
saveas(gcf,'E:\SeaTech\KOA_Oo_withPM_weekly_presence.png');
close all

%Oo + Bb - NEEDS MANUAL ADJUSTMENTS
figure
bar(Oo_finalTAB(:,1),Oo_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Bb_finalTAB(:,1),Bb_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,9,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,17,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Killer Whales and Baird''s Beaked Whale at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend('Killer Whale','Baird''s Beaked Whale','Effort','Location','Best')
saveas(gcf,'E:\SeaTech\KOA_Bb_withOo_weekly_presence.png');
close all

%Oo + Ms - NEEDS MANUAL ADJUSTMENT
figure
bar(Oo_finalTAB(:,1),Oo_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Ms_finalTAB(:,1),Ms_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,2.5,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,5,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Killer Whales and Stejneger''s Beaked Whale at Site KOA')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend('Killer Whale','Stejneger''s Beaked Whale','Effort','Location','Best')
saveas(gcf,'E:\SeaTech\KOA_Ms_withOo_weekly_presence.png');
close all
