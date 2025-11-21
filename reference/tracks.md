# Summary road bike trip data from 2018 to 2023

Aggregated summary track data for road bike trips from 2018 to 2023, one
row per trip. Details for each trip are in `track_details`.

## Usage

``` r
tracks
```

## Format

### `tracks`

A data frame with 157 rows and 15 columns:

- date:

  Date of the trip (date)

- weekday:

  Weekday of the trip; can be calculated from `date` using
  [`base::weekdays()`](https://rdrr.io/r/base/weekday.POSIXt.html), but
  is included directly for convenience (factor)

- distance_km:

  Length of the trip in kilometers (integer)

- time_min:

  Trip duration in minutes (integer)

- altitude_gain_m:

  Cumulated total altitude gain during the trip, only counting positive
  gains (all trips have same start and finish points, i.e. overall gain
  is 0 when including negative gains) (integer)

- temperature_c:

  Median temperature in °C (integer)

- speed_km_h:

  Average speed in km/h (integer)

- avg_hr_bpm:

  Average heart rate in beats per minute (integer)

- below_zones_min:

  Time below heart rate zone 1 in minutes, i.e. heart rate \< 109 bpm
  (integer)

- zone1_min:

  Time in heart rate zone 1 in minutes, i.e. heart rate within \[60;70)%
  of configured maximum (182 bpm) = \[109;127) bpm (integer)

- zone2_min:

  Time in heart rate zone 2 in minutes, i.e. heart rate within \[70;80)%
  of configured maximum (182 bpm) = \[127;145) bpm (integer)

- zone3_min:

  Time in heart rate zone 3 in minutes, i.e. heart rate within \[80;90)%
  of configured maximum (182 bpm) = \[145;164) bpm (integer)

- zone4_min:

  Time in heart rate zone 4 in minutes, i.e. heart rate within
  \[90;100)% of configured maximum (182 bpm) = \[164;182) bpm (integer)

- above_zones_min:

  Time above heart rate zone 4 in minutes, i.e. heart rate \>= 182 bpm
  (integer)

- samples:

  Number of datapoints, i.e. for a given trip, `track_details` countains
  `samples` rows for that trip (integer)
