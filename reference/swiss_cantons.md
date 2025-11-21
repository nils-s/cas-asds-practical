# Swiss cantons

2024 geographical borders of all 26 Swiss cantons as provided by the
Swiss Federal Statistical Office (Bundesamt für Statistik, BfS). This is
a simple feature (sf) object with additional information. It can be used
directly with
[`ggplot2::geom_sf()`](https://ggplot2.tidyverse.org/reference/ggsf.html)
to draw a map of the borders of the cantons. The coordinate reference
system (CRS) is the Swiss LV95 system (EPSG 2056).

## Usage

``` r
swiss_cantons
```

## Format

### `swiss_cantons`

A list with 26 rows and 15 columns:

- KTNR:

  canton number

- KTNAME:

  canton name

- GRNR:

  number of the greater region the canton belongs to

- AREA_HA:

  area in hectares (rounded to whole numbers)

- E_MIN:

  canton's minimum eastern coordinate value

- E_MAX:

  canton's maximum eastern coordinate value

- N_MIN:

  canton's minimum northern coordinate value

- N_MAX:

  canton's maximum northern coordinate value

- E_CNTR:

  canton's centroid coordinate (east)

- N_CNTR:

  canton's centroid coordinate (north)

- Z_MIN:

  canton's minimum height coordinate value

- Z_MAX:

  canton's maximum height coordinate value

- Z_AVG:

  canton's average height coordinate value

- Z_MED:

  canton's median height coordinate value

- geometry:

  [sf::sfc_MULTIPOLYGON](https://r-spatial.github.io/sf/reference/sfc.html)
  tracing the canton's borders

## Source

<https://www.bfs.admin.ch/bfs/de/home/dienstleistungen/geostat/geodaten-bundesstatistik/administrative-grenzen/generalisierte-gemeindegrenzen.assetdetail.30487000.html>
