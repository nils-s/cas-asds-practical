#' Swiss cantons
#'
#' 2024 geographical borders of all 26 Swiss cantons as provided by the Swiss Federal Statistical Office (Bundesamt für Statistik, BfS).
#' This is a simple feature (sf) object with additional information.
#' It can be used directly with [ggplot2::geom_sf()] to draw a map of the borders of the cantons.
#' The coordinate reference system (CRS) is the Swiss LV95 system (EPSG 2056).
#'
#' @format ## `swiss_cantons`
#' A list with 26 rows and 15 columns:
#' \describe{
#'   \item{KTNR}{canton number}
#'   \item{KTNAME}{canton name}
#'   \item{GRNR}{number of the greater region the canton belongs to}
#'   \item{AREA_HA}{area in hectares (rounded to whole numbers)}
#'   \item{E_MIN}{canton's minimum eastern coordinate value}
#'   \item{E_MAX}{canton's maximum eastern coordinate value}
#'   \item{N_MIN}{canton's minimum northern coordinate value}
#'   \item{N_MAX}{canton's maximum northern coordinate value}
#'   \item{E_CNTR}{canton's centroid coordinate (east)}
#'   \item{N_CNTR}{canton's centroid coordinate (north)}
#'   \item{Z_MIN}{canton's minimum height coordinate value}
#'   \item{Z_MAX}{canton's maximum height coordinate value}
#'   \item{Z_AVG}{canton's average height coordinate value}
#'   \item{Z_MED}{canton's median height coordinate value}
#'   \item{geometry}{[sf::sfc_MULTIPOLYGON] tracing the canton's borders}
#' }
#' @source <https://www.bfs.admin.ch/bfs/de/home/dienstleistungen/geostat/geodaten-bundesstatistik/administrative-grenzen/generalisierte-gemeindegrenzen.assetdetail.30487000.html>
"swiss_cantons"

#' Swiss lakes
#'
#' 2024 map geometry of the 23 largest Swiss lakes as provided by the Swiss Federal Statistical Office (Bundesamt für Statistik, BfS).
#' This is a simple feature (sf) object with additional information.
#' It can be used directly with [ggplot2::geom_sf()] to draw a map of the Swiss lakes.
#' The coordinate reference system is the Swiss LV95 system (EPSG 2056).
#'
#' @format ## `swiss_lakes`
#' A list with 23 rows and 10 columns:
#' \describe{
#'   \item{GMDNR}{lake number}
#'   \item{GMDNAME}{lake name}
#'   \item{SEE_HA}{area in hectares (rounded to whole numbers)}
#'   \item{E_MIN}{lake's minimum eastern coordinate value}
#'   \item{E_MAX}{lake's maximum eastern coordinate value}
#'   \item{N_MIN}{lake's minimum northern coordinate value}
#'   \item{N_MAX}{lake's maximum northern coordinate value}
#'   \item{E_CNTR}{lake's centroid coordinate (east)}
#'   \item{N_CNTR}{lake's centroid coordinate (north)}
#'   \item{geometry}{[sf::sfc_MULTIPOLYGON] tracing the lakeshore}
#' }
#' @source <https://www.bfs.admin.ch/bfs/de/home/dienstleistungen/geostat/geodaten-bundesstatistik/administrative-grenzen/generalisierte-gemeindegrenzen.assetdetail.30487000.html>
"swiss_lakes"

#' Detailed road bike trip data from 2018 to 2023
#'
#' Track data for road bike trips from 2018 to 2023, including (among others) the GPS track coordinates,
#' altitude, heart rate, speed, ...
#' The data frame contains a series of data points for a number of trips, with data points for individual trips
#' measured approximately every five seconds.
#' The latitude/longitude coordinates were obtained using GPS, which means their coordinate reference system is WGS-84 (EPSG 4326).
#'
#' @format ## `track_details`
#' A data frame with 172,226 rows and 38 columns:
#' \describe{
#'   \item{year}{Year of the trip (integer)}
#'   \item{month}{Month of the trip (integer)}
#'   \item{day}{Day of the trip (integer)}
#'   \item{date}{Date of the trip (date)}
#'   \item{altitude_m}{Current altitude in meters (integer)}
#'   \item{altitude_differences_downhill_m}{Altitude gain in meters for this segment (integer)}
#'   \item{altitude_differences_uphill_m}{Altitude loss in meters for this segment (integer)}
#'   \item{cadence_rpm}{Pedaling frequency in rpm for this segment (integer)}
#'   \item{calories_kcal}{Energy consumed for this segment in kcal (integer)}
#'   \item{distance_m}{Distance travelled in meters for this segment (integer)}
#'   \item{distance_absolute_m}{Total distance travelled in meters for current track (integer)}
#'   \item{distance_downhill_m}{Distance travelled going downhill in meters for this segment (integer)}
#'   \item{distance_uphill_m}{Distance travelled going uphill in meters for this segment (integer)}
#'   \item{heartrate_bpm}{Heart rate in bpm for this segment (integer)}
#'   \item{incline_percent}{Current incline in percent (integer)}
#'   \item{latitude}{Latitude coordinate of current position in WGS-84 CRS (integer)}
#'   \item{longitude}{Longitude coordinate of current position in WGS-84 CRS (integer)}
#'   \item{power_watts}{Current power in watts (integer)}
#'   \item{power_to_weight_ratio_watts_kg}{Current power-to-weight ratio in watts per kg (integer)}
#'   \item{rise_rate_m_min}{Current rate of altitude gain in meters per minute (integer)}
#'   \item{speed_m_s}{Current speed in meters per second (integer)}
#'   \item{temperature_c}{Current temperature in °C (integer)}
#'   \item{training_time_s}{Length of current segment in 0.01 seconds (i.e. a 5 second segment has a training_time_s of 500) (integer)}
#'   \item{training_time_absolute_s}{Total cumulated training time of the current track in 0.01 seconds (integer)}
#'   \item{training_time_downhill_s}{Time spent going downhill during this segment in 0.01 seconds; always <= training_time_s (integer)}
#'   \item{training_time_uphill_s}{Time spent going uphill during this segment in 0.01 seconds; always <= training_time_s (integer)}
#'   \item{work_k_j}{Work done during this segment in kJ (integer)}
#'   \item{time_below_intensity_zones_s}{Time below heart rate zone 1 in seconds, i.e. heart rate < 109 bpm (integer)}
#'   \item{time_in_intensity_zone1_s}{Time in heart rate zone 1 in seconds, i.e. heart rate within [60;70)% of configured maximum (182 bpm) = [109;127) bpm (integer)}
#'   \item{time_in_intensity_zone2_s}{Time in heart rate zone 2 in seconds, i.e. heart rate within [70;80)% of configured maximum (182 bpm) = [127;145) bpm (integer)}
#'   \item{time_in_intensity_zone3_s}{Time in heart rate zone 3 in seconds, i.e. heart rate within [80;90)% of configured maximum (182 bpm) = [145;164) bpm (integer)}
#'   \item{time_in_intensity_zone4_s}{Time in heart rate zone 4 in seconds, i.e. heart rate within [90;100)% of configured maximum (182 bpm) = [164;182) bpm (integer)}
#'   \item{time_above_intensity_zones_s}{Time above heart rate zone 4 in seconds, i.e. heart rate >= 182 bpm (integer)}
#'   \item{normalized_power_watts}{Normalized power for this segment in watts (intensity-adjusted version of `power_watts`) (integer)}
#'   \item{right_balance}{? (integer)}
#'   \item{left_balance}{? (integer)}
#'   \item{pedaling_time_s}{Time spent pedalling during this segment in 0.01 seconds (integer)}
#'   \item{speed_time_min_km}{Current speed as time in seconds required per kilometer (basically the inverse of `speed_m_s`) (integer)}
#' }
"track_details"

#' Summary road bike trip data from 2018 to 2023
#'
#' Aggregated summary track data for road bike trips from 2018 to 2023, one row per trip.
#' Details for each trip are in `track_details`.
#'
#' @format ## `tracks`
#' A data frame with 157 rows and 15 columns:
#' \describe{
#'   \item{date}{Date of the trip (date)}
#'   \item{weekday}{Weekday of the trip; can be calculated from `date` using [base::weekdays()], but is included directly for convenience (factor)}
#'   \item{distance_km}{Length of the trip in kilometers (integer)}#'
#'   \item{time_min}{Trip duration in minutes (integer)}
#'   \item{altitude_gain_m}{Cumulated total altitude gain during the trip, only counting positive gains (all trips have same start and finish points, i.e. overall gain is 0 when including negative gains)  (integer)}
#'   \item{temperature_c}{Median temperature in °C (integer)}
#'   \item{speed_km_h}{Average speed in km/h (integer)}
#'   \item{avg_hr_bpm}{Average heart rate in beats per minute (integer)}
#'   \item{below_zones_min}{Time below heart rate zone 1 in minutes, i.e. heart rate < 109 bpm (integer)}
#'   \item{zone1_min}{Time in heart rate zone 1 in minutes, i.e. heart rate within [60;70)% of configured maximum (182 bpm) = [109;127) bpm (integer)}
#'   \item{zone2_min}{Time in heart rate zone 2 in minutes, i.e. heart rate within [70;80)% of configured maximum (182 bpm) = [127;145) bpm (integer)}
#'   \item{zone3_min}{Time in heart rate zone 3 in minutes, i.e. heart rate within [80;90)% of configured maximum (182 bpm) = [145;164) bpm (integer)}
#'   \item{zone4_min}{Time in heart rate zone 4 in minutes, i.e. heart rate within [90;100)% of configured maximum (182 bpm) = [164;182) bpm (integer)}
#'   \item{above_zones_min}{Time above heart rate zone 4 in minutes, i.e. heart rate >= 182 bpm (integer)}
#'   \item{samples}{Number of datapoints, i.e. for a given trip, `track_details` countains `samples` rows for that trip (integer)}
#' }
"tracks"
