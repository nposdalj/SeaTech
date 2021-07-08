% Vanessa ZoBell 1/20/2021
%
% modified from sumpresweeklyeffort
%
% Variables to change:
% humpdet41: to the directory and file of the automatic humpback detections

%% Read in data

% Read in the humpback automatic detector output for the same deployment
humpDet04 = readtable('C:\Users\HARP\Documents\GitHub\SeaTech\Humpback\Mn_CB04.csv')
%humpDet09

%% Calculating calling hour per day/month from the automatic detector
daydate04start = datenum(dateshift(datetime(datestr(humpDet04(:, 1), 'start', 'day'))))
daydate04end = datenum(dateshift(datetime(datestr(datenum09end)), 'start', 'day'))))


daydate04end = datenum(dateshift(datetime(datestr(datenum09end)), 'start', 'day'))
datenum09 = datestr(table2array(humpDet04(:, 1)))


Z_rowstart = datenum(dateshift(datetime(datestr(table2array(humpDet04(:, 1)))), 'start', 'day'))
Z_rowend = datenum(dateshift(datetime(datestr(table2array(humpDet04(:, 2)))), 'start', 'day'))

k = 1
while k <= size(spdatenums, 1)
    Z_rowstart = floor(spdatenums(k, 1))
    Z_rowend = floor(spdatenums(k, 2))

if Z_rowstart~=Z_rowend; %If wrap over more than one day
    next_day_end = spdatenums(k, 2); % save the end date
    spdatenums(k, 2) = Z_rowstart+1; % save midnight as the correct end
    new_row = [Z_rowstart+1, next_day_end]; %  make a new row to insert with the remainder
    spdatenums = vertcat(spdatenums(1:k, :), new_row, spdatenums(k+1:end, :)); % reconcatonnate the array
    k = k +1
    for q = 2:Z_rowend-Z_rowstart; %for more than 2 days
        spdatenums(k, 2) = z_rowstart_q; 
        new_row = [Z_rowstart+q, next_day_end]
        spdatenums = vertcat(spdatenums(1:k, :), new_row, spdatenums((k+1):end, :)); 
    end
end
k = k+1
end

        
%find elapsed time, anything under 1 minute is rounded up to 1 min
spdatediff = bsxfun(@minus,(spdatenums(:,2)), (spdatenums(:,1)));
    for itr=1:length(spdatediff)
        if spdatediff(itr)<=.0007
            spdatediff(itr)=.0007;
        end
    end
    
    
% Add up all bouts that happened on the same julian day - this is GMT.
starttimes=floor(spdatenums(:,1));
k2 =1;
idx = 1;
starttimes_n = [];
while idx<=length(starttimes)
        same_days =[];
        same_days = find (starttimes == starttimes(idx));
        starttimes_n(k2,1)= starttimes(idx);
        starttimes_n(k2,2)= sum(spdatediff(same_days));
        k2=k2+1;
        idx=max(same_days)+1;
end


% this part makes sure days where no detections were made are still
% incorporated in the plot
days_of_data = [floor(spdatenums(1, 1)):1:floor(spdatenums(end, 2))]'
perdayscaled=[starttimes_n(:,1), starttimes_n(:,2)*24]; % turn the number into hours per day.

% Organizes all days into one array. days_of_data is assumed to be
% sequential
days_with_hits = size(perdayscaled,1);

for i = 1:days_with_hits
    index = find(days_of_data(:,1) == perdayscaled(i,1));
    if size(index,1) == 1
        days_of_data(index,2) = perdayscaled(i,2);
    else
        disp('Inconsistent data. Multiple or 0 entries for a day');
        return
    end
end
days_of_data(:, 3) = 24; %hours of effort
days_of_data(:, 4) = days_of_data(:, 2)./days_of_data(:, 3)*100

% Plotting (editted from sumpres_min_weekly_effort.m)
%  This section depends on
%   spdatenums,         an cell array with all the start and stop times
%   days_of_data,      an cell array with everyday and their counts
%   speciesname,        a cell array with species names as strings



%y axis limits
minY = 0;
halfY = 6;
maxY = 12;

xstep_length = 1;
xstep_unit = 'month';

useOffEffortBars = 1;
useNormalizedData = 1;
offeffortcolor = [205 201 201]/255;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
currentdata = days_of_data

num_of_weeks = ceil(size(currentdata,1)/7);
perweek = zeros(num_of_weeks,2);



%Organize the days into weeks and take their sums.
for i = 1:num_of_weeks
        % Use the first day of the week to identify the week
        first_day = 7*(i-1) + 1;
        last_day = min(first_day + 6, size(currentdata ,1));
        perweek(i,1) = currentdata(first_day,1);
        perweek(i,2) = sum(currentdata(first_day:last_day,2));
        perweek(i,3) = (sum(currentdata(first_day:last_day,3)))/(7*24)*100;
        
end


    
starttimes_n=[];
first_day = currentdata(1,1);
last_day = currentdata(end,1);
current_day = first_day;


[Y, M, D, H, MN, S] = datevec(current_day);
current_day = addtodate(current_day, -D + 1,'day');
xtick = [current_day];
    
    
while (last_day > current_day)
    xtick = [xtick addtodate(current_day, xstep_length, xstep_unit)];
    current_day = addtodate(current_day, xstep_length, xstep_unit);
end
    



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if useNormalizedData
figure(2)
bar(perweek(:, 1), perweek(:, 2), 'FaceColor', [0 0 0])
hold on
datetick
ylabel('Calling Hours per Week')
yyaxis right
bar(currentdata(:, 1), currentdata(:, 2), 'FaceColor', [0.5 0.5 0.5])
ylabel('Calling Hours per Day')

%% Kellan will overlay the calling hours per day from the automatic and manual detections

datenum09 = datestr(table2array(humpDet04(:, 1)))
datenum09(:, 8) = '2'
datenum09(:, 9) = '0'
datenum09 = datenum(datenum09)
daydate09start = datenum(dateshift(datetime(datestr(datenum09)), 'start', 'day'))

datenum09end = datestr(table2array(humpDet09(:, 2)))
datenum09end(:, 8) = '2'
datenum09end(:, 9) = '0'
datenum09end = datenum(datenum09end)
daydate04end = datenum(dateshift(datetime(datestr(datenum09end)), 'start', 'day'))
spdatenums = [datenum09 datenum09end]
