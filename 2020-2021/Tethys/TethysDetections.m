q = dbInit('Server', 'breach.ucsd.edu', 'Port', 9779);
dbSpeciesFmt('Input', 'Abbrev', 'SIO.SWAL.v1');

% Orca Detections
OoWhistles = dbGetDetections(q, 'Project', 'GofAK', 'Site', 'CB', 'Deployment', 4, ...
    'SpeciesID', 'Oo', 'Call', 'Whistles');
OoClicks = dbGetDetections(q, 'Project', 'GofAK', 'Site', 'CB', 'Deployment', 4, ...
    'SpeciesID', 'Oo', 'Call', 'Clicks');

% Humpback Detections
Mn04 = dbGetDetections(q, 'Project', 'GofAK', 'Site', 'CB', 'Deployment', 4, ...
    'SpeciesID', 'Mn');
Mn05 = dbGetDetections(q, 'Project', 'GofAK', 'Site', 'CB', 'Deployment', 5, ...
    'SpeciesID', 'Mn');
Mn09 = dbGetDetections(q, 'Project', 'GofAK', 'Site', 'CB', 'Deployment', 9, ...
    'SpeciesID', 'Mn');
%% Convert to datetime and export as csv
OoClicks = table(datetime(OoClicks,'ConvertFrom','datenum'));
writetable(OoClicks,'C:\Users\HARP\Documents\GitHub\SeaTech\Tethys\Mn_CB04.csv');
OoWhistles = table(datetime(OoWhistles,'ConvertFrom','datenum'));
writetable(OoWhistles,'C:\Users\nposd\Documents\GitHub\SeaTech\Tethys\OoWhistles_CB05.csv');


writetable(OoClicks,'C:\Users\HARP\Documents\GitHub\SeaTech\Tethys\Mn_CB04.csv');
