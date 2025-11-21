# Swiss lakes

2024 map geometry of the 23 largest Swiss lakes as provided by the Swiss
Federal Statistical Office (Bundesamt für Statistik, BfS). This is a
simple feature (sf) object with additional information. It can be used
directly with
[`ggplot2::geom_sf()`](https://ggplot2.tidyverse.org/reference/ggsf.html)
to draw a map of the Swiss lakes. The coordinate reference system is the
Swiss LV95 system (EPSG 2056).

## Usage

``` r
swiss_lakes
```

## Format

### `swiss_lakes`

A list with 23 rows and 10 columns:

- GMDNR:

  lake number

- GMDNAME:

  lake name

- SEE_HA:

  area in hectares (rounded to whole numbers)

- E_MIN:

  lake's minimum eastern coordinate value

- E_MAX:

  lake's maximum eastern coordinate value

- N_MIN:

  lake's minimum northern coordinate value

- N_MAX:

  lake's maximum northern coordinate value

- E_CNTR:

  lake's centroid coordinate (east)

- N_CNTR:

  lake's centroid coordinate (north)

- geometry:

  [sf::sfc_MULTIPOLYGON](https://r-spatial.github.io/sf/reference/sfc.html)
  tracing the lakeshore

## Source

<https://www.bfs.admin.ch/bfs/de/home/dienstleistungen/geostat/geodaten-bundesstatistik/administrative-grenzen/generalisierte-gemeindegrenzen.assetdetail.30487000.html>
