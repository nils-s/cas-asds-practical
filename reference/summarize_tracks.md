# Summarize a Collection of Detailed Track Points Grouped by Date

Summarize a Collection of Detailed Track Points Grouped by Date

## Usage

``` r
summarize_tracks(tracks)
```

## Arguments

- tracks:

  A data.frame or tibble of track detail data points, e.g.
  [track_details](https://nils-s.github.io/cas-asds-practical/reference/track_details.md)

## Value

A tibble summarizing `tracks`, one row per date. Values (i.e. columns)
are:

- `date` the date of the trip

- `weekday` weekday corresponding to `date`; factor with English weekday
  names; computed from `date`, only included for convenience

- `distance_km` length of the track (in kilometers)

- `time_min` duration of the track (in minutes)

- `altitude_gain_m` total altitude gained during the track (in meters),
  without compensating for altitude lost

- `avg_inclination` average inclination of the track, calculated as
  altitude gain in meters / distance in m

- `temperature_c` median temperature of the track (in degrees Celsius)

- `speed_km_h` average speed of the track (in km/h)

- `avg_hr_bpm` average heart rate for the track (in beats per minute)

- `below_zones_min` time spent below heart rate zone 1 (i.e. \< 60% of
  max. hr / \< 109 bpm) (in minutes)

- `zone1_min` time spent in heart rate zone 1 (i.e. \[60;70)% of max. hr
  / \[109;127) bpm) (in minutes)

- `zone2_min` time spent in heart rate zone 2 (i.e. \[70;80)% of max. hr
  / \[127;145) bpm) (in minutes)

- `zone3_min` time spent in heart rate zone 3 (i.e. \[80;90)% of max. hr
  / \[145;164) bpm) (in minutes)

- `zone4_min` time spent in heart rate zone 4 (i.e. \[90;100)% of max.
  hr / \[164;182) bpm) (in minutes)

- `above_zones_min` time spent above heart rate zone 4 (i.e. \>= 100% of
  max. hr / 182 bpm) (in minutes)

- `samples` number of data point for the track, i.e. the number of data
  points which were aggregated for this row

## Examples

``` r
# summarize all detailed data points by date
summarize_tracks(track_details)
#> # A tibble: 157 × 16
#>    date       distance_km time_min altitude_gain_m avg_inclination temperature_c
#>    <date>           <dbl>    <dbl>           <dbl>           <dbl>         <dbl>
#>  1 2018-07-30        36.3     81.8             492         0.0135           30.3
#>  2 2018-07-31        79.3    163.              369         0.00466          21.2
#>  3 2018-08-03        23.9     55.9             344         0.0144           28  
#>  4 2018-08-04        30.2     63.3             249         0.00825          31.9
#>  5 2018-08-06        23.8     52.6             337         0.0142           26.3
#>  6 2018-08-10        21.5     47.8             246         0.0115           21.4
#>  7 2018-08-11        71.0    176.             1152         0.0162           22.4
#>  8 2018-10-12        25.3     58.1             372         0.0147           20.6
#>  9 2018-10-13        30.3     69.7             264         0.00870          23.4
#> 10 2019-05-23        19.0     41.8             242         0.0127           21.4
#> # ℹ 147 more rows
#> # ℹ 10 more variables: speed_km_h <dbl>, avg_hr_bpm <dbl>,
#> #   below_zones_min <dbl>, zone1_min <dbl>, zone2_min <dbl>, zone3_min <dbl>,
#> #   zone4_min <dbl>, above_zones_min <dbl>, samples <int>, weekday <fct>
# summarize only a specific date
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
track_details |>
  filter(date == "2020-06-01") |>
  summarize_tracks()
#> # A tibble: 1 × 16
#>   date       distance_km time_min altitude_gain_m avg_inclination temperature_c
#>   <date>           <dbl>    <dbl>           <dbl>           <dbl>         <dbl>
#> 1 2020-06-01        59.2     128.             719          0.0121          23.6
#> # ℹ 10 more variables: speed_km_h <dbl>, avg_hr_bpm <dbl>,
#> #   below_zones_min <dbl>, zone1_min <dbl>, zone2_min <dbl>, zone3_min <dbl>,
#> #   zone4_min <dbl>, above_zones_min <dbl>, samples <int>, weekday <fct>
```
