library(tidyverse)
library(janitor) # cleanup functions, e.g. to auto-rename columns
library(clock) # lubridate alternative; part of tidyverse
library(sf) # simple features geo data; for working with track GPS coordinates
library(units) # to work e.g. with distances (for censoring)

#--- track data locations -----------------------------------------------------

tracks_folder <- "data-raw/tracks/"
original_tracks_folder <- paste0(tracks_folder, "original")
censored_tracks_folder <- paste0(tracks_folder, "censored")
censored_file_prefix <- "censored_"

#--- censoring ----------------------------------------------------------------

# Generating censored versions of original files is only necessary if (or when)
# new tracks are added. Since that does not happen very often, we don't usually
# need to perform the censoring (which takes some time), so it is disabled by
# default.
# If additional tracks have been added (to the "data-raw/tracks/original" folder),
# set to TRUE and run (at least) once, so censored versions of the new tracks
# are generated.
perform_censoring <- FALSE
# Whether to censor all files in original_tracks_folder, or just the ones that
# do not yet have a corresponding censored version in censored_tracks_folder.
# Only censoring new files avoids potential problems with censoring of
# distance_absolute_m values: since the added noise is Gaussian, repeatedly
# censoring the same original file risks leaking the true values of
# distance_absolute_m over the course of multiple versions of the censored files.
only_new <- TRUE

if (perform_censoring) {

  # --- step 1: find original (i.e. uncensored) track files
  # tracks are spread out over multiple files, one file per track => gather all the files
  # working directory is assumed to be top-level package directory
  original_track_files <- list.files(original_tracks_folder, pattern = "*.csv", full.names = TRUE)

  # --- step 2: determine which files need to be censored (all, or only new ones)
  if (only_new) {
    existing_censored_files <- list.files(censored_tracks_folder, pattern = "*.csv") |>
      map(\(s) str_remove(s, str_glue("^{censored_file_prefix}")))

    original_track_files <- original_track_files[!(basename(original_track_files) %in% existing_censored_files)]
  }

  #--- step 3: prepare some data for censoring

  # Somewhat arbitrary point close to the start- and end-point of all tracks
  # around which all data points will be censored (up to a certain distance).
  # Used to slightly obscure my exact address :)
  censoring_centroid <- st_sfc(st_point(c(46.941361672470045, 7.392649303321667)), crs = "WGS84")
  censoring_distance <- set_units(1000, "m")

  # when the computer has no GPS lock, it will record lat/long as 0/0
  # => might happen especially right after starting a track, so we might want to also censor those values
  no_data_coordinates <- st_sfc(st_point(c(0,0)), crs = "WGS84")

  # for a given point, determine whether it should be censored, based on distance from censoring_centroid;
  # also censor points that represent a "no data" value, i.e. 0/0 coordinates (conservative approach, to prevent
  # leaking data especially during the initial phase of the track, when the GPS might not yet have a lock)
  is_in_censoring_region <- function(point) {
    (st_distance(point, censoring_centroid) < censoring_distance) |
      (st_distance(point, no_data_coordinates) < censoring_distance)
  }

  # first and last 10 minutes of a track are timeframe for potential censoring:
  # data points in the censoring region during this time should be removed; however,
  # if the censoring region is crossed in the middle of the track, those data points
  # should not be censored
  censoring_timeframe <- 10 * 60 * 100
  is_during_censoring_timeframe <- function(time) {
    (time < censoring_timeframe) | (time > max(time) - censoring_timeframe)
  }

  #--- step 4: read data from files, and remove data points in the censoring region during the censoring timeframe
  censored_tracks <- original_track_files |>
    set_names(basename) |>
    map(read_delim) |>
    map(\(x) st_as_sf(x, coords = c("Latitude", "Longitude"), crs = "WGS84", remove = FALSE)) |>
    map(\(x) x |> filter(!(is_in_censoring_region(geometry) & is_during_censoring_timeframe(`TrainingTimeAbsolute [s]`))) |> st_drop_geometry())

  #--- step 5: censor totals (distance and time)

  # find the minimum values for absolute training time and distance (per track),
  # so we can subtract them from all data points of the corresponding tracks
  # => should make it impossible to reconstruct starting point by looking at absolute time/distance values
  #    of the uncensored data points
  offsets <- censored_tracks |>
    map(\(x) list(
      time_offset = min(x$`TrainingTimeAbsolute [s]`),
      dist_offset = min(x$`DistanceAbsolute [m]`)))

  # subtract offsets from data points
  # remaining imperfection: the first point of each track has a time/distance value for the last
  # segment, but absolute time/distance value of 0 (i.e. at the first point of each track, the absolute
  # values indicate that nothing has happened yet, while the per-segment time/distance values show that
  # approximately 5 seconds have already passed, and some meters of distance were already travelled).
  censored_tracks <- map2(
    censored_tracks,
    offsets,
    \(t, o) t |> mutate(
      `DistanceAbsolute [m]` = `DistanceAbsolute [m]` - o$dist_offset,
      `TrainingTimeAbsolute [s]` = `TrainingTimeAbsolute [s]` - o$time_offset))

  #--- step 6: store censored data in the same format as the original files
  walk2(
    names(censored_tracks),
    censored_tracks,
    \(filename, data) write_delim(data, str_glue("{censored_tracks_folder}/{censored_file_prefix}{filename}"), delim = ";"))

}

#--- tidying ------------------------------------------------------------------

censored_track_files <- list.files(censored_tracks_folder, pattern = str_glue("{censored_file_prefix}.*\\.csv"), full.names = TRUE)

# load detailed track information from all the files and put them in a single tibble
track_details <- censored_track_files |>
  # read files into tibble, add column for filename
  read_delim(id = "filepath") |>
  # extract year/month/day values from filename column into separate columns
  separate_wider_regex(
    cols = filepath,
    patterns = c(
      censored_tracks_folder,
      str_glue("/{censored_file_prefix}"),
      year = "\\d{4}",
      "_",
      month = "\\d{2}",
      "_",
      day = "\\d{2}",
      ".*"
    )
  ) |>
  # convert year/month/day columns to numbers, add date column
  mutate(
    year = parse_number(year),
    month = parse_number(month),
    day = parse_number(day),
    date = date_build(year, month, day)
  ) |>
  # clean up column names (remove spaces, special chars, convert to snake_case)
  clean_names() |>
  # clean latitude/longitude coordinates for datapoints where the GPS lock was lost
  mutate(
    latitude = ifelse(latitude < 1, NA, latitude),
    longitude = ifelse(longitude < 1, NA, longitude)
  ) |>
  # device hiccup @ 2023-10-13 after around 54 Minutes:
  # multiple entries with same training_time_absolute_s and corrupt data, e.g. multiple thousand km of altitude gain
  # => filter them out; filter criteria: training_time_absolute_s of successive data points must be different
  # `default = -1` is to keep first data point for which the lag is NA if no default is given (which would remove it)
  # -> since all training_time_absolute_s values are >= 0, a lag of -1 is a safe default which will not filter out anything
  filter(training_time_absolute_s != lag(training_time_absolute_s, default = -1)) |>
  # remove power zone columns; power zones are not properly calibrated, so they contain no useful data
  select(-starts_with("time_in_power_zone"))

# aggregated track information; summarize detailed info into one entry per track
tracks <- track_details |>
  group_by(date) |>
  mutate(uphill_m = cumsum(altitude_differences_uphill_m)) |>
  summarize(
    distance_km = max(distance_absolute_m) / 1000,
    time_min = max(training_time_absolute_s) / (100 * 60),
    altitude_gain_m = max(uphill_m),
    temperature_c = median(temperature_c),
    speed_km_h = mean(speed_m_s) * 3.6,
    avg_hr_bpm = mean(heartrate_bpm),
    below_zones_min = max(cumsum(time_below_intensity_zones_s)) / (100 * 60),
    zone1_min = max(cumsum(time_in_intensity_zone1_s)) / (100 * 60),
    zone2_min = max(cumsum(time_in_intensity_zone2_s)) / (100 * 60),
    zone3_min = max(cumsum(time_in_intensity_zone3_s)) / (100 * 60),
    zone4_min = max(cumsum(time_in_intensity_zone4_s)) / (100 * 60),
    above_zones_min = max(cumsum(time_above_intensity_zones_s)) / (100 * 60),
    samples = n()
  ) |>
  mutate(
    # temporarily use en_US locale, so weekdays() gives English day names
    # note: this is for Linux, the locale string might be different on other OSs
    weekday = fct(withr::with_locale(c("LC_TIME" = "en_US.UTF-8"), weekdays(date)))
  )

# store cleaned data in package's data-folder
# xz compression was determined to be optimal by tools::resaveRdaFiles(...)
usethis::use_data(tracks, overwrite = TRUE, compress = "xz")
usethis::use_data(track_details, overwrite = TRUE, compress = "xz")
