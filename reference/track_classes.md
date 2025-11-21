# Categorized road bike trips from 2018 to 2023

Tracks categorized by route and direction. Routes that were only driven
in one direction have no direction information (`direction` == NA),
routes that were only driven once might not have their own class
(`track` == NA).

## Usage

``` r
track_classes
```

## Format

### `track_classes`

A data frame with 157 rows and 3 columns:

- date:

  Date of the trip (date)

- track:

  Classification of the track (by route taken) (integer)

- direction:

  Direction in which the route was driven; only available for `track` ==
  3 (factor)

## Details

Tracks are identified by `date`. Only contains track class (`track`) and
direction (`direction`), for more information regarding tracks use
`tracks` data, or `track_details`.
