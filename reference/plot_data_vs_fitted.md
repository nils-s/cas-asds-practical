# Visually Evaluate Model

Plot values (in black) and their corresponding fitted values (in red),
according to `model`.

## Usage

``` r
plot_data_vs_fitted(model, ...)
```

## Arguments

- model:

  A fitted model for which to plot its data vs its fitted values. Needs
  to be
  [`broom::augment()`](https://broom.tidymodels.org/reference/reexports.html)-able.

- ...:

  Params passed to
  [`ggplot2::aes()`](https://ggplot2.tidyverse.org/reference/aes.html).
  Should be the variables to plot, e.g. something like
  `x = var1, y = var2`.

## Value

A
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html)
with two layers (points jittered in x-direction, representing original
values (in black) and fitted values (in red))

## Examples

``` r
plot_data_vs_fitted(lm(mpg ~ disp, data = mtcars), x = disp, y = mpg)

plot_data_vs_fitted(lm(mpg ~ disp + cyl + hp + wt, data = mtcars), x = wt, y = mpg)
```
