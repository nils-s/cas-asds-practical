# Plot a Single Track with a Given Date

Takes a date, and a collection of points, then plots a track of all
points which have the same date as the one specified. Points with `NA`
values for latitude and/or longitude will be filtered out. Remaining
points will be converted
[`to_linestrings()`](https://nils-s.github.io/cas-asds-practical/reference/to_linestrings.md)
before plotting. Return value is the plot object, i.e. additional plot
layers can be added in the usual ggplot way.

## Usage

``` r
plot_track(track_date, points)
```

## Arguments

- track_date:

  the date for which to plot the track

- points:

  A data.frame or tibble with (at least) a `date` and an sf geometry
  column containing a point for each observation

## Value

a basic
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html)
with a
[`ggplot2::geom_sf()`](https://ggplot2.tidyverse.org/reference/ggsf.html)
layer for the track

## Examples

``` r
plot_track(lubridate::ymd("2020-05-20"), track_details)
```
