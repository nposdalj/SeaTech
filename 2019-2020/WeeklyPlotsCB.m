OGmasterLOG = readtable('E:\SeaTech\CB_10_disk01_masterlog.xlsx');
OGmasterLOG = removevars(OGmasterLOG,{'InputFile','EventNumber','Call','Parameter1',...
    'Parameter2','Parameter3','Parameter4','Parameter5','Parameter6','Comments',...
    'Image','Audio','Student'});
OGmasterLOG = movevars(OGmasterLOG,'SpeciesCode','After','EndTime');
% OGmasterLOG.StartTime = datetime(x2mdate(OGmasterLOG.StartTime),'ConvertFrom','datenum');
% OGmasterLOG.EndTime = datetime(x2mdate(OGmasterLOG.EndTime),'ConvertFrom','datenum');

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
Oo_finalTAB(18,1) = 39;

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

%Lo
LoStart = OGmasterLOG.StartTime(strcmp(OGmasterLOG.SpeciesCode,'Lo'));
LoEnd = OGmasterLOG.EndTime(strcmp(OGmasterLOG.SpeciesCode,'Lo'));
Lo = [LoStart LoEnd];
LoTab = array2table(Lo);
LoTab.Time = between (LoStart,LoEnd,'Time');
LoTab.Properties.VariableNames = {'Start' 'End' 'Time'};
LoTab.Hours = hours(LoEnd-LoStart);
LoTab.StartWeek = week(LoTab.Start);
LoTab.EndWeek = week(LoTab.End);
LoTab.Diff = LoTab.EndWeek-LoTab.StartWeek;
LoTab.StartGroup = categorical(LoTab.StartWeek);
Lo_sumarray = grpstats(LoTab.Hours,LoTab.StartGroup,@sum);
Lo_groups = unique(LoTab.StartGroup);
Lo_groupss = str2num(char(Lo_groups));
Lo_finalTAB = [Lo_groupss Lo_sumarray];
Lo_finalTAB(2,1) = 39;
Lo_finalTAB(3,1) = 18;
Lo_finalTAB(4,1) = 23;
Lo_finalTAB(5,1) = 28;
Lo_finalTAB(6,1) = 33;
Lo_finalTAB(7,1) = 38;

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
Ms_finalTAB(18,1) = 17;

%Gg
GgStart = OGmasterLOG.StartTime(strcmp(OGmasterLOG.SpeciesCode,'Gg'));
GgEnd = OGmasterLOG.EndTime(strcmp(OGmasterLOG.SpeciesCode,'Gg'));
Gg = [GgStart GgEnd];
GgTab = array2table(Gg);
GgTab.Time = between (GgStart,GgEnd,'Time');
GgTab.Properties.VariableNames = {'Start' 'End' 'Time'};
GgTab.Hours = hours(GgEnd-GgStart);
GgTab.StartWeek = week(GgTab.Start);
GgTab.EndWeek = week(GgTab.End);
GgTab.Diff = GgTab.EndWeek-GgTab.StartWeek;
GgTab.StartGroup = categorical(GgTab.StartWeek);
Gg_sumarray = grpstats(GgTab.Hours,GgTab.StartGroup,@sum);
Gg_groups = unique(GgTab.StartGroup);
Gg_groupss = str2num(char(Gg_groups));
Gg_finalTAB = [Gg_groupss Gg_sumarray];
Gg_finalTAB(5,1) = 17;
Gg_finalTAB(6,1) = 39;

%% load ship detector sounds
CB_ship = load('E:\SeaTech\GofAK_CB10_disk01-03');
shipTimes = cell2mat(CB_ship.times);
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
%% Plots
xtl = {{'May','2019'},{'Jun','2019'},{'Jul','2019'},{'Aug','2019'},{'Sept','2019'}};

%just echosounders
figure
bar(Anthro_finalTAB(:,1),Anthro_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,11,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,22,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Echo Sounders at Site CB')
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
legend([effort],'Effort','location','NorthWest')
saveas(gcf,'E:\SeaTech\CB_EchoSounders_weekly_presence.png');
close all

%echosounders + ships from detector
figure
bar(All_ANTHRO_finalTAB(:,1),All_ANTHRO_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,25,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,53,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Anthropogenic Sounds at Site CB')
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
legend([effort],'Effort','location','NorthWest')
saveas(gcf,'E:\SeaTech\CB_All_Anthro_weekly_presence.png');
close all

figure
bar(Pm_finalTAB(:,1),Pm_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,65,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,130,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Sperm Whales at Site CB')
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
legend([effort],'Effort','location','NorthWest')
saveas(gcf,'E:\SeaTech\CB_Pm_weekly_presence.png');
close all

figure
bar(Oo_finalTAB(:,1),Oo_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,30,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,59,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Killer Whales at Site CB')
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
saveas(gcf,'E:\SeaTech\CB_Oo_weekly_presence.png');
close all

figure
bar(Bb_finalTAB(:,1),Bb_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,19,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,38,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Baird''s Beaked Whale at Site CB')
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
saveas(gcf,'E:\SeaTech\CB_Bb_weekly_presence.png');
close all

figure
bar(Ms_finalTAB(:,1),Ms_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,0.55,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,1.04,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Stejneger''s Beaked Whale at Site CB')
% xticks([18 23 28 33 38]);
% xlabel('Month')
yyaxis left
ylabel('Cumulative Hours/Week (hrs)')
yyaxis right
ylabel('% Effort/Week')
ylim([0 100])
%set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
h = my_xticklabels(gca,[18 23 28 33 38],xtl);
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
legend([effort],'Effort')
saveas(gcf,'E:\SeaTech\CB_Ms_weekly_presence.png');
close all

% figure(6)
% bar(Lo_finalTAB(:,1),Lo_finalTAB(:,2),'k','BarWidth',1)
% title('Weekly Presence of ?? at Site CB')
% xticks([18 23 28 33 38]);
% xlabel('Month')
% yyaxis left
% ylabel('Cumulative Hours/Week')
% yyaxis right
% ylabel('% Effort/Week')
% ylim([0 100])
% set(gca,'xticklabel',{'May','Jun','Jul','Aug','Sept'});
% ax = gca;
% ax.YAxis(1).Color = 'k';
% ax.YAxis(2).Color = 'k';
% saveas(gcf,'E:\SeaTech\CB_Lo_weekly_presence.png');

figure
bar(Gg_finalTAB(:,1),Gg_finalTAB(:,2),'k','BarWidth',1)
hold on
effort = plot(17,0.38,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,0.73,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Risso''s Dolphins at Site CB')
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
saveas(gcf,'E:\SeaTech\CB_Gg_weekly_presence.png');
close all

%% Weekly plots anthro + all species

%Anthro + PM - NEEDS MANUAL MODIFICATION OF SIZE
figure
bar(Pm_finalTAB(:,1),Pm_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
hold on
bar(All_ANTHRO_finalTAB(:,1),All_ANTHRO_finalTAB(:,2),'r','BarWidth',1)
plot(17,70,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,132,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Anthropogenic Sounds and Sperm Whales at Site CB')
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
saveas(gcf,'E:\SeaTech\CB_All_Anthro_withPM_weekly_presence.png');
close all

%Anthro + Oo
figure
bar(All_ANTHRO_finalTAB(:,1),All_ANTHRO_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Oo_finalTAB(:,1),Oo_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,33,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,59,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Anthropogenic Sounds and Killer Whales at Site CB')
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
legend('Anthropogenic Noise','Killer Whales','Effort','Location','Best')
saveas(gcf,'E:\SeaTech\CB_Oo_withAnthro_weekly_presence.png');
close all

%Anthro + Bb - NEEDS MANUAL ADJUSTMENT OF SIZE
figure
bar(All_ANTHRO_finalTAB(:,1),All_ANTHRO_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Bb_finalTAB(:,1),Bb_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,37,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,53,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Anthropogenic Noise and Baird''s Beaked Whale at Site CB')
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
saveas(gcf,'E:\SeaTech\KOA_CB_withAnthro_weekly_presence.png');
close all

%Anthro + Ms - NEEDS MANUAL ADJUSTMENT OF SIZE
figure
bar(All_ANTHRO_finalTAB(:,1),All_ANTHRO_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Ms_finalTAB(:,1),Ms_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,37,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,49,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Anthropogenic Sounds and Stejneger''s Beaked Whale at Site CB')
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
legend('Anthropogenic Noise','Stejneger''s Beaked Whale','Effort','Location','Best')
saveas(gcf,'E:\SeaTech\CB_Ms_withAnthro_weekly_presence.png');
close all

%Anthro + Gg 
figure
bar(All_ANTHRO_finalTAB(:,1),All_ANTHRO_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Gg_finalTAB(:,1),Gg_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,26,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,49,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Anthropogenic Sounds and Risso''s Dolphin at Site CB')
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
legend('Anthropogenic Noise','Risso''s Dolphin','Effort','Location','Best')
saveas(gcf,'E:\SeaTech\CB_Gg_withAnthro_weekly_presence.png');
close all

%% Weekly plots with Oo and each species

%Oo + PM NEEDS MANUAL ADJUSTMENT OF PLOT SIZE
figure
bar(Pm_finalTAB(:,1),Pm_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
hold on
bar(Oo_finalTAB(:,1),Oo_finalTAB(:,2),'r','BarWidth',1)
plot(17,67,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,135,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Killer Whales and Sperm Whales at Site CB')
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
saveas(gcf,'E:\SeaTech\CB_Oo_withPM_weekly_presence.png');
close all

%Oo + Bb - NEEDS MANUAL ADJUSTMENTS OF PLOT SIZE
figure
bar(Oo_finalTAB(:,1),Oo_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Bb_finalTAB(:,1),Bb_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,30,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,58,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Killer Whales and Baird''s Beaked Whale at Site CB')
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
saveas(gcf,'E:\SeaTech\CB_Bb_withOo_weekly_presence.png');
close all

%Oo + Ms - NEEDS MANUAL ADJUSTMENT OF PLOT SIZE
figure
bar(Oo_finalTAB(:,1),Oo_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Ms_finalTAB(:,1),Ms_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,30,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,59,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Killer Whales and Stejneger''s Beaked Whale at Site CB')
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
saveas(gcf,'E:\SeaTech\CB_Ms_withOo_weekly_presence.png');
close all

%Oo + Gg
figure
bar(Oo_finalTAB(:,1),Oo_finalTAB(:,2),'r','BarWidth',1)
hold on
bar(Gg_finalTAB(:,1),Gg_finalTAB(:,2),'k','BarWidth',1,'FaceAlpha',0.2)
plot(17,30,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
plot(39,59,'o','MarkerFaceColor', 'k','MarkerEdgeColor','k')
title('Weekly Presence of Killer Whales and Risso''s Dolphins at Site CB')
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
legend('Killer Whale','Risso''s Dolphins','Effort','Location','Best')
saveas(gcf,'E:\SeaTech\CB_Gg_withOo_weekly_presence.png');
close all


