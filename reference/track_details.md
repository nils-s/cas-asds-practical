# Detailed road bike trip data from 2018 to 2023

Track data for road bike trips from 2018 to 2023, including (among
others) the GPS track coordinates, altitude, heart rate, speed, ... The
data frame contains a series of data points for a number of trips, with
data points for individual trips measured approximately every five
seconds. The latitude/longitude coordinates were obtained using GPS,
which means their coordinate reference system is WGS-84 (EPSG 4326).

## Usage

``` r
track_details
```

## Format

### `track_details`

A data frame with 162,175 rows and 38 columns:

- year:

  Year of the trip (integer)

- month:

  Month of the trip (integer)

- day:

  Day of the trip (integer)

- date:

  Date of the trip (date)

- altitude_m:

  Current altitude in meters (integer)

- altitude_differences_downhill_m:

  Altitude gain in meters for this segment (integer)

- altitude_differences_uphill_m:

  Altitude loss in meters for this segment (integer)

- cadence_rpm:

  Pedaling frequency in rpm for this segment (integer)

- calories_kcal:

  Energy consumed for this segment in kcal (integer)

- distance_m:

  Distance travelled in meters for this segment (integer)

- distance_absolute_m:

  Total distance travelled in meters for current track (integer)

- distance_downhill_m:

  Distance travelled going downhill in meters for this segment (integer)

- distance_uphill_m:

  Distance travelled going uphill in meters for this segment (integer)

- heartrate_bpm:

  Heart rate in bpm for this segment (integer)

- incline_percent:

  Current incline in percent (integer)

- latitude:

  Latitude coordinate of current position in WGS-84 CRS (integer)

- longitude:

  Longitude coordinate of current position in WGS-84 CRS (integer)

- power_watts:

  Current power in watts (integer)

- power_to_weight_ratio_watts_kg:

  Current power-to-weight ratio in watts per kg (integer)

- rise_rate_m_min:

  Current rate of altitude gain in meters per minute (integer)

- speed_m_s:

  Current speed in meters per second (integer)

- temperature_c:

  Current temperature in °C (integer)

- training_time_s:

  Length of current segment in 0.01 seconds (i.e. a 5 second segment has
  a training_time_s of 500) (integer)

- training_time_absolute_s:

  Total cumulated training time of the current track in 0.01 seconds
  (integer)

- training_time_downhill_s:

  Time spent going downhill during this segment in 0.01 seconds; always
  \<= training_time_s (integer)

- training_time_uphill_s:

  Time spent going uphill during this segment in 0.01 seconds; always
  \<= training_time_s (integer)

- work_k_j:

  Work done during this segment in kJ (integer)

- time_below_intensity_zones_s:

  Time below heart rate zone 1 in seconds, i.e. heart rate \< 109 bpm
  (integer)

- time_in_intensity_zone1_s:

  Time in heart rate zone 1 in seconds, i.e. heart rate within \[60;70)%
  of configured maximum (182 bpm) = \[109;127) bpm (integer)

- time_in_intensity_zone2_s:

  Time in heart rate zone 2 in seconds, i.e. heart rate within \[70;80)%
  of configured maximum (182 bpm) = \[127;145) bpm (integer)

- time_in_intensity_zone3_s:

  Time in heart rate zone 3 in seconds, i.e. heart rate within \[80;90)%
  of configured maximum (182 bpm) = \[145;164) bpm (integer)

- time_in_intensity_zone4_s:

  Time in heart rate zone 4 in seconds, i.e. heart rate within
  \[90;100)% of configured maximum (182 bpm) = \[164;182) bpm (integer)

- time_above_intensity_zones_s:

  Time above heart rate zone 4 in seconds, i.e. heart rate \>= 182 bpm
  (integer)

- normalized_power_watts:

  Normalized power for this segment in watts (intensity-adjusted version
  of `power_watts`) (integer)

- right_balance:

  ? (integer)

- left_balance:

  ? (integer)

- pedaling_time_s:

  Time spent pedalling during this segment in 0.01 seconds (integer)

- speed_time_min_km:

  Current speed as time in seconds required per kilometer (basically the
  inverse of `speed_m_s`) (integer)
