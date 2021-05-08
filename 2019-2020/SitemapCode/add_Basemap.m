%%just to keep track of this, using addCustomBasemap to add an ocean
%%basemap I found on arcGIS

mapURL = "https://services.arcgisonline.com/arcgis/rest/services/Ocean/World_Ocean_Base/MapServer/tile/${z}/${y}/${x}";
addCustomBasemap('oceanBasemap',mapURL);
