% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{to_linestrings}
\alias{to_linestrings}
\title{Create Linestrings from Points}
\usage{
to_linestrings(points)
}
\arguments{
\item{points}{A data.frame or tibble with (at least) a \code{date} and an sf geometry column containing a point for each observation}
}
\value{
A tibble with two columns: \code{date}, and an sf geometry column, containing a linestring for each observation
}
\description{
Converts a collection of points to a collection of linestrings, for faster plotting.
Points are grouped by \code{date}, and are assumed to be ordered.
Note that input data will be \code{\link[dplyr:summarise]{dplyr::summarize()}}'d by \code{date}, i.e. output will probably be
much shorter than input. Additionally, summarizing gets rid of all other information, i.e.
return value only contains dates and linestrings and will have to be joined with any additional
desired information.
}
\examples{
library(sf)
library(dplyr)
library(ggplot2)
points <- track_details |>
  filter(!is.na(latitude) & !is.na(longitude)) |>
  st_as_sf(coords = c("longitude", "latitude"), crs = "WGS84")
to_linestrings(points) |>
  ggplot() +
  geom_sf()
}
