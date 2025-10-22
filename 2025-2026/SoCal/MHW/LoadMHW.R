# --- 1. Load required packages ---
library(ncdf4)      # To open and read NetCDF files
library(raster)     # To work with spatial data
library(tidyverse)  # For data wrangling

# --- 2. File paths (update if needed) ---
anom_file <- "/mnt/data/oisst.mon.anom_latest.nc"         # SST anomalies
quantile_file <- "/mnt/data/oisst.mon.quantile90_latest.nc" # 90th percentile MHW threshold

# --- 3. Open NetCDF files ---
nc_anom <- nc_open(anom_file)
nc_quant <- nc_open(quantile_file)

# --- 4. Inspect variable names ---
names(nc_anom$var)
names(nc_quant$var)

# Usually you'll see something like "sst" or "anom" for anomalies,
# and "sst" or "quantile90" for threshold values.

# --- 5. Load data as raster stacks (easier for time series) ---
anom_stack <- stack(anom_file)
quant_stack <- stack(quantile_file)

# Check structure
anom_stack
quant_stack

# --- 6. Extract coordinates and time dimension ---
lon <- ncvar_get(nc_anom, "lon")
lat <- ncvar_get(nc_anom, "lat")
time <- ncvar_get(nc_anom, "time") # usually in days since 1800-01-01
time_units <- ncatt_get(nc_anom, "time", "units")$value
time_origin <- str_extract(time_units, "\\d{4}-\\d{2}-\\d{2}")
dates <- as.Date(time, origin = time_origin)

# --- 7. Choose a site (example: Onslow Bay, 34°N, 76°W) ---
site_lat <- 34
site_lon <- -76

# Find nearest grid cell
lon_idx <- which.min(abs(lon - (ifelse(site_lon < 0, site_lon + 360, site_lon))))
lat_idx <- which.min(abs(lat - site_lat))

# --- 8. Extract SST anomaly and threshold time series ---
anom_vals <- raster::extract(anom_stack, cbind(lon[lon_idx], lat[lat_idx]))
quant_vals <- raster::extract(quant_stack, cbind(lon[lon_idx], lat[lat_idx]))

# --- 9. Combine into a tidy dataframe ---
df <- tibble(
  date = dates,
  sst_anom = as.numeric(anom_vals),
  mhw_thresh = as.numeric(quant_vals)
) %>%
  mutate(
    mhw_condition = ifelse(sst_anom >= mhw_thresh, 1, 0)
  )

# --- 10. Quick look ---
head(df)
summary(df)

# --- 11. Plot: visualize heatwave vs baseline months ---
ggplot(df, aes(x = date)) +
  geom_line(aes(y = sst_anom), color = "steelblue") +
  geom_line(aes(y = mhw_thresh), color = "firebrick") +
  geom_ribbon(aes(ymin = mhw_thresh, ymax = sst_anom),
              data = df %>% filter(mhw_condition == 1),
              fill = "red", alpha = 0.3) +
  labs(
    title = "Marine Heatwave Conditions at Site",
    y = "SST anomaly (°C)", x = "Date"
  ) +
  theme_minimal()

# --- 12. Save time series for further analysis ---
write.csv(df, "marine_heatwave_timeseries.csv", row.names = FALSE)

# --- 13. Close connections ---
nc_close(nc_anom)
nc_close(nc_quant)
