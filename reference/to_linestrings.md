# Create Linestrings from Points

Converts a collection of points to a collection of linestrings, for
faster plotting. Points are grouped by `date`, and are assumed to be
ordered. Note that input data will be
[`dplyr::summarize()`](https://dplyr.tidyverse.org/reference/summarise.html)'d
by `date`, i.e. output will probably be much shorter than input.
Additionally, summarizing gets rid of all other information, i.e. return
value only contains dates and linestrings and will have to be joined
with any additional desired information.

## Usage

``` r
to_linestrings(points)
```

## Arguments

- points:

  A data.frame or tibble with (at least) a `date` and an sf geometry
  column containing a point for each observation

## Value

A tibble with two columns: `date`, and an sf geometry column, containing
a linestring for each observation

## Examples

``` r
library(sf)
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE
library(dplyr)
library(ggplot2)
points <- track_details |>
  filter(!is.na(latitude) & !is.na(longitude)) |>
  st_as_sf(coords = c("longitude", "latitude"), crs = "WGS84")
to_linestrings(points) |>
  ggplot() +
  geom_sf()
```
