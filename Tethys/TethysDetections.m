q = dbInit('Server', 'breach.ucsd.edu', 'Port', 9779);
dbSpeciesFmt('Input', 'Abbrev', 'SIO.SWAL.v1');
OoWhistles = dbGetDetections(q, 'Project', 'GofAK', 'Site', 'CB', 'Deployment', 4, ...
    'SpeciesID', 'Oo', 'Call', 'Whistles');
OoClicks = dbGetDetections(q, 'Project', 'GofAK', 'Site', 'CB', 'Deployment', 4, ...
    'SpeciesID', 'Oo', 'Call', 'Clicks');

%% Convert to datetime and export as csv
OoClicks = table(datetime(OoClicks,'ConvertFrom','datenum'));
writetable(OoClicks,'C:\Users\nposd\Documents\GitHub\SeaTech\Tethys\OoClicks_CB05.csv');
OoWhistles = table(datetime(OoWhistles,'ConvertFrom','datenum'));
writetable(OoWhistles,'C:\Users\nposd\Documents\GitHub\SeaTech\Tethys\OoWhistles_CB05.csv');