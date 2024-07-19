library(tidyverse)
library(sf)
library(asds2024.nils.practical)

#' Save every track as an image, for manual classification
#'
#' Take a collection of track points, group them by date, and plot them.
#' Plots are then saved as png images (one image per track).
#' The track plots are a linestring, with some additional colored points, the
#' linestring representing the detailed track. The additional points are
#' colored using a rainbow gradient, with points at the start of the track
#' having a green color, and changing to red for points towards the end of the
#' track.
#'
#' The main purpose of these images is to manually classify the tracks, with
#' the colored points aiding in discerning the same tracks driven in different
#' directions (i.e. a track driven in clockwise direction can be told
#' apart from the same track driven in counter-clockwise direction by looking
#' at the color of the additional points).
#'
#' @param points a data.frame with at least a `date` and geometry column; will be passed to [asds2024.nils.practical::to_linestrings()]
#' @param path path at which the generated image files will be stored; relative to package top-level directory; must include trailing "/"
#'
#' @examples
#' save_track_plots(track_details, "data-raw/tracks/categorized/")
save_track_plots <- function(points, path) {
  num_points <- 50
  colors <- rainbow(num_points, start = 0.3)
  indices <- points |>
    group_by(date) |>
    summarize(n = n()) |>
    pull(n) |>
    map(\(x) seq(1, x, length.out = num_points))
  linestrings <- points |>
    filter(!is.na(latitude) & !is.na(longitude)) |>
    st_as_sf(coords = c("longitude", "latitude"), crs = "WGS84") |> # EPSG 4326 = WGS-84
    st_transform(crs = 2056) |> # EPSG 2056 = CH-1903+/LV95
    to_linestrings()
  for(i in 1:nrow(linestrings)) {
    detail_points <- points |>
      filter(date == linestrings[i,]$date) |>
      filter(!is.na(latitude) & !is.na(longitude)) |>
      filter(row_number() %in% round(indices[[i]])) |>
      st_as_sf(coords = c("longitude", "latitude"), crs = "WGS84") |> # EPSG 4326 = WGS-84
      st_transform(crs = 2056) # |> # EPSG 2056 = CH-1903+/LV95
    track_plot <- linestrings[i,] |>
      ggplot() +
      geom_sf() +
      geom_sf(data = detail_points, color = colors)
    ggsave(paste0(path, linestrings[i,]$date, ".png"))
  }
}

#' Categorize tracks based on file path
#'
#' Search a given path (including sub-folders) for png images, and categorize
#' images based on sub-folders they are in.
#'
#' Intended for use in conjunction with `save_track_plots()`: generate track
#' plots, manually group them into folders, then categorize the grouped images.
#'
#' Classification is based on folder names:
#' - first-level folders should be numeric (i.e. folders named "1", "2", "3", ...)
#'   and represent the track route, i.e. all images in a folder should be
#'   the same route (although with possibly different travel directions)
#' - second-level folders (if present) must be named "cw" and "ccw", representing
#'   the direction in which the route was travelled (clockwise or counter-clockwise,
#'   respectively)
#' - images that are not stored in sub-folders (i.e. stored directly in `path`)
#'   are not given an id; they are considered to be unique (i.e. assumed to have
#'   only been driven once)
#'
#' Image names should be the same as produced by `save_track_plots()`, i.e. of
#' the form "YYYY-MM-DD.png".
#'
#' @param path the path under which the categorized images will be searched
#'
#' @return
#' a data.frame containing three columns:
#' - `date` as parsed from the filenames, to identify the individual tracks
#' - `track` the route of the track, i.e. a class label (numeric, as parsed from first-level subfolder names; might be `NA` for tracks not stored in sub-folders)
#' - `direction` a factor with the two levels `cw` and `ccw`, representing clockwise and counter-clockwise; might be `NA` for tracks that were not categorized accordingly
#'
#' @examples
#' generate_track_ids("data-raw/tracks/categorized/")
generate_track_ids <- function(path) {
  files <- as_tibble(list.files(path, pattern = "*.png", recursive = T)) |> rename(filename = value)
  track_ids <- files |>
    separate_wider_regex(
      cols = filename,
      patterns = c(track = "\\d*", "/?", direction = "(?i:cw|ccw)?", "/?", date = "\\d{4}-\\d{2}-\\d{2}", "\\.png")
    ) |>
    mutate(
      track = parse_integer(track),
      date = parse_date(date),
      direction = fct(direction, na = "")
    )
  # max_group_id <- max(track_ids$track, na.rm = T)
  # track_ids |>
  #   filter(is.na(track)) |>
  #   mutate(track = row_number() + max_group_id)
  track_ids
}

categorized_tracks_path <- "data-raw/tracks/categorized/"

# step 1: create track plots
#save_track_plots(track_details, categorized_tracks_path)

# step 2 (manual): sort tracks into folders:
#  - track (first-level sub-folders, with numeric names)
#  - direction (optional; clockwise vs counter-clockwise, "cw" and "ccw" second-level sub-folders)
# categorized structure should look like this:
#
# base_path                            | the base folder used for categorization
#  |                                   |
#  +-- 1                               | folder for tracks categorized as class 1
#  |   |                               |
#  |   +-- 2020-01-01.png              | -+
#  |   +-- 2020-01-02.png              |  +-- tracks with class 1 (and direction 'NA')
#  |   +-- ...                         | -+
#  |
#  +-- 2                               | folder for tracks categorized as class 2
#  |   |                               |
#  |   +-- 2020-02-01.png              | -+
#  |   +-- 2020-02-02.png              |  +-- tracks with class 2 (and direction 'NA')
#  |   +-- ...                         | -+
#  |                                   |
#  +-- 3                               | folder for tracks categorized as class 3
#  |   |                               |
#  |   +-- cw                          | sub-folder for tracks with class 3, in clockwise direction
#  |   |    |                          |
#  |   |    +-- 2020-03-01.png         | -+
#  |   |    +-- 2020-03-02.png         |  +-- tracks with class 3 and clockwise direction
#  |   |    +-- ...                    | -+
#  |   |                               |
#  |   |-- ccw                         | sub-folder for tracks with class 3, in counter-clockwise direction
#  |        |                          |
#  |        +-- 2020-03-03.png         | -+
#  |        +-- 2020-03-04.png         |  +-- tracks with class 3 and counter-clockwise direction
#  |        +-- ...                    | -+
#  |                                   |
#  |-- ...                             |
#  |                                   |
#  +-- 2020-04-01.png                  | -+
#  +-- 2020-04-02.png                  |  +-- uncategorized tracks (i.e. class 'NA' and direction 'NA')
#  +-- ...                             | -+

# step 3: scan file/folder structure to determine track classes
track_classes <- generate_track_ids(categorized_tracks_path)

# step 4: store data
usethis::use_data(track_classes, overwrite = TRUE)
