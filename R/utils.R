#' Visually Evaluate Model
#'
#' Plot values (in black) and their corresponding fitted values (in red),
#' according to `model`.
#'
#' @param model A fitted model for which to plot its data vs its fitted values. Needs to be [broom::augment()]-able.
#' @param ... Params passed to [ggplot2::aes()]. Should be the variables to plot, e.g. something like `x = var1, y = var2`.
#'
#' @return
#' A [ggplot2::ggplot()] with two layers (points jittered in x-direction,
#' representing original values (in black) and fitted values (in red))
#'
#' @export
#'
#' @examples
#' plot_data_vs_fitted(lm(mpg ~ disp, data = mtcars), x = disp, y = mpg)
#' plot_data_vs_fitted(lm(mpg ~ disp + cyl + hp + wt, data = mtcars), x = wt, y = mpg)
plot_data_vs_fitted <- function(model, ...) {
  jitter_width <- 0.25
  jitter_height <- 0
  model |>
    broom::augment() |>
    ggplot2::ggplot(ggplot2::aes(...)) +
    ggplot2::geom_jitter(width = jitter_width, height = jitter_height) +
    ggplot2::geom_jitter(ggplot2::aes(y = .fitted), color = "red", width = jitter_width, height = jitter_height)
}

#' Create Linestrings from Points
#'
#' Converts a collection of points to a collection of linestrings, for faster plotting.
#' Points are grouped by `date`, and are assumed to be ordered.
#' Note that input data will be [dplyr::summarize()]'d by `date`, i.e. output will probably be
#' much shorter than input. Additionally, summarizing gets rid of all other information, i.e.
#' return value only contains dates and linestrings and will have to be joined with any additional
#' desired information.
#'
#' @param points A data.frame or tibble with (at least) a `date` and an sf geometry column containing a point for each observation
#'
#' @return A tibble with two columns: `date`, and an sf geometry column, containing a linestring for each observation
#'
#' @export
#'
#' @examples
#' library(sf)
#' library(dplyr)
#' library(ggplot2)
#' points <- track_details |>
#'   filter(!is.na(latitude) & !is.na(longitude)) |>
#'   st_as_sf(coords = c("longitude", "latitude"), crs = "WGS84")
#' to_linestrings(points) |>
#'   ggplot() +
#'   geom_sf()
to_linestrings <- function(points) {
  points |>
    dplyr::group_by(date) |>
    dplyr::summarize(do_union = FALSE) |> # `do_union = FALSE` -> see https://github.com/r-spatial/sf/issues/321#issuecomment-342065386
    sf::st_cast("LINESTRING")
}

#' Summarize a Collection of Detailed Track Points Grouped by Date
#'
#' @param tracks A data.frame or tibble of track detail data points, e.g. [track_details]
#'
#' @return
#' A tibble summarizing `tracks`, one row per date. Values (i.e. columns) are:
#' - `date` the date of the trip
#' - `weekday` weekday corresponding to `date`; factor with English weekday names; computed from `date`, only included for convenience
#' - `distance_km` length of the track (in kilometers)
#' - `time_min` duration of the track (in minutes)
#' - `altitude_gain_m` total altitude gained during the track (in meters), without compensating for altitude lost
#' - `avg_inclination` average inclination of the track, calculated as altitude gain in meters / distance in m
#' - `temperature_c` median temperature of the track (in degrees Celsius)
#' - `speed_km_h` average speed of the track (in km/h)
#' - `avg_hr_bpm` average heart rate for the track (in beats per minute)
#' - `below_zones_min` time spent below heart rate zone 1 (i.e. < 60% of max. hr / < 109 bpm) (in minutes)
#' - `zone1_min` time spent in heart rate zone 1 (i.e. [60;70)% of max. hr / [109;127) bpm) (in minutes)
#' - `zone2_min` time spent in heart rate zone 2 (i.e. [70;80)% of max. hr / [127;145) bpm) (in minutes)
#' - `zone3_min` time spent in heart rate zone 3 (i.e. [80;90)% of max. hr / [145;164) bpm) (in minutes)
#' - `zone4_min` time spent in heart rate zone 4 (i.e. [90;100)% of max. hr / [164;182) bpm) (in minutes)
#' - `above_zones_min` time spent above heart rate zone 4 (i.e. >= 100% of max. hr / 182 bpm) (in minutes)
#' - `samples` number of data point for the track, i.e. the number of data points which were aggregated for this row
#'
#' @export
#'
#' @examples
#' # summarize all detailed data points by date
#' summarize_tracks(track_details)
#' # summarize only a specific date
#' library(dplyr)
#' track_details |>
#'   filter(date == "2020-06-01") |>
#'   summarize_tracks()
summarize_tracks <- function(tracks) {
  tracks |>
    dplyr::group_by(date) |>
    dplyr::mutate(uphill_m = cumsum(altitude_differences_uphill_m)) |>
    dplyr::summarize(
      distance_km = max(distance_absolute_m) / 1000,
      time_min = max(training_time_absolute_s) / (100 * 60),
      altitude_gain_m = max(uphill_m),
      avg_inclination = altitude_gain_m / (distance_km * 1000),
      temperature_c = stats::median(temperature_c),
      speed_km_h = mean(speed_m_s) * 3.6,
      avg_hr_bpm = mean(heartrate_bpm),
      below_zones_min = max(cumsum(time_below_intensity_zones_s)) / (100 * 60),
      zone1_min = max(cumsum(time_in_intensity_zone1_s)) / (100 * 60),
      zone2_min = max(cumsum(time_in_intensity_zone2_s)) / (100 * 60),
      zone3_min = max(cumsum(time_in_intensity_zone3_s)) / (100 * 60),
      zone4_min = max(cumsum(time_in_intensity_zone4_s)) / (100 * 60),
      above_zones_min = max(cumsum(time_above_intensity_zones_s)) / (100 * 60),
      samples = dplyr::n()
    ) |>
    dplyr::mutate(
      # temporarily use en_US locale, so weekdays() gives English day names regardless of user's locale
      # note: this is for Linux, the locale string might be different on other OSs
      weekday = forcats::fct(withr::with_locale(c("LC_TIME" = "en_US.UTF-8"), weekdays(date)))
    )
}

#' Plot a Single Track with a Given Date
#'
#' Takes a date, and a collection of points, then plots a track of all points which have the same
#' date as the one specified.
#' Points with `NA` values for latitude and/or longitude will be filtered out.
#' Remaining points will be converted [to_linestrings()] before plotting.
#' Return value is the plot object, i.e. additional plot layers can be added in the usual ggplot way.
#'
#' @param track_date the date for which to plot the track
#' @param points A data.frame or tibble with (at least) a `date` and an sf geometry column containing a point for each observation
#'
#' @return a basic [ggplot2::ggplot()] with a [ggplot2::geom_sf()] layer for the track
#'
#' @export
#'
#' @examples
#' plot_track(lubridate::ymd("2020-05-20"), track_details)
plot_track <- function(track_date, points) {
  points |>
    dplyr::filter(date == track_date) |>
    dplyr::filter(!is.na(latitude) & !is.na(longitude)) |>
    sf::st_as_sf(coords = c("longitude", "latitude"), crs = "WGS84") |>
    sf::st_transform(crs = 2056) |>
    to_linestrings() |>
    ggplot2::ggplot() +
    ggplot2::geom_sf()
}
