
<!-- README.md is generated from README.Rmd. Please edit that file -->

# asds2024.nils.practical

<!-- badges: start -->

[![R-CMD-check](https://github.com/nils-s/cas-asds-practical/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/nils-s/cas-asds-practical/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

This module contains the final practical part for the Certificate of
Advanced Studies in Advanced Statistical Data Science ([CAS
ASDS](https://www.unibe.ch/weiterbildungsangebote/cas_advanced_statistical_data_science/index_ger.html))
at the [University of Berne](https://www.unibe.ch/index_eng.html) for
the class of 2024.

## Format

The practical module has been packaged as an R package, so everything
(data, scripts, reports, …) should be contained in a single bundle, and
analyses should be reproducible.

This setup follows suggestions from (Marwick, Boettiger, and Mullen
2018b, 2018a), (Flight 2014), and (Wickham and Bryan 2023) (which
provided more or less the instructions and toolchain recommendations
based on which this package has been created).

There are other opinions and tools (e.g. (Flight 2021) and (Landau 2024,
2021)) for a lighter-weight reproducible research approach, which I
might explore in the future.

For more inspiration and available tools, see (Blischak et al. 2024).

## Installation

You can install the development version of `asds2024.nils.practical`
from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools") # <- for `install_github` to be available uncomment this and run it (unless you've already installed it)

# Notes:
# - you probably want to install the suggested dependencies as well, since this package only uses suggested dependencies
# - when `install_github`-ing, you need to explicitly specify that you want the vignettes built as well
devtools::install_github(
  "nils-s/cas-asds-practical",
  dependencies = c("Depends", "Imports", "LinkingTo", "Suggests"),
  build_vignettes = TRUE)
```

Since not all documents are provided as vignettes, you probably want to
clone the package sources into a local directory as well:

``` bash
git clone https://github.com/nils-s/cas-asds-practical.git
```

From there, you can more directly explore the raw data, and read
documents that are not packaged as vignettes.

### Installation Troubleshooting

Assuming the `devtools` package is installed (and `install_github` is
available), this package by itself should not cause problems (simply
because it contains very little stuff that could cause problems).
However, it depends on a bunch of dependencies, which will be installed
when installing this package’s suggested dependencies as shown in the
code snippet above.

The main suspect in this regard is the `sf` package, which has a few
dependencies of its own (not all of which are R packages). The first
thing to try (after studying the error messages, of course) is to make
sure all prerequisites for `sf` are fulfilled (e.g. the
[GEOS](https://libgeos.org), [GDAL](https://gdal.org), and
[PROJ](https://proj.org/) libraries).

On a Fedora machine, the following should get you started:

``` bash
sudo dnf install gdal gdal-devel udunits2-devel proj proj-devel geos geos-devel
```

See [the `sf` documentation](https://r-spatial.github.io/sf/) for more
information.

## Example

``` r
library(asds2024.nils.practical)
vignette("get-started", package = "asds2024.nils.practical")
```

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-cran-view-rr" class="csl-entry">

Blischak, John, Alison Hill, Ben Marwick, Daniel Sjoberg, and Will
Landau. 2024. “CRAN Task View: Reproducible Research.” February 20,
2024. <https://cran.r-project.org/view=ReproducibleResearch>.

</div>

<div id="ref-mflight2014" class="csl-entry">

Flight, Robert M. 2014. “Analyses as Packages.” July 28, 2014.
<https://rmflight.github.io/posts/2014-07-28-analyses-as-packages>.

</div>

<div id="ref-mflight2021" class="csl-entry">

———. 2021. “Packages Don’t Work Well for Analyses in Practice.” March 2,
2021.
<https://rmflight.github.io/posts/2021-03-02-packages-dont-work-well-for-analyses-in-practice>.

</div>

<div id="ref-targets2021" class="csl-entry">

Landau, William Michael. 2021. “The <span class="nocase">targets</span>
R Package: A Dynamic Make-Like Function-Oriented Pipeline Toolkit for
Reproducibility and High-Performance Computing.” *Journal of Open Source
Software* 6 (57): 2959. <https://doi.org/10.21105/joss.02959>.

</div>

<div id="ref-R-targets" class="csl-entry">

———. 2024. *<span class="nocase">targets</span>: Dynamic
Function-Oriented Make-Like Declarative Pipelines*.
<https://docs.ropensci.org/targets/>.

</div>

<div id="ref-marwick2018-tas" class="csl-entry">

Marwick, Ben, Carl Boettiger, and Lincoln Mullen. 2018a. “Packaging Data
Analytical Work Reproducibly Using R (and Friends).” *The American
Statistician* 72 (1): 80–88.
<https://doi.org/10.1080/00031305.2017.1375986>.

</div>

<div id="ref-marwick2018-peerj" class="csl-entry">

———. 2018b. “Packaging Data Analytical Work Reproducibly Using R (and
Friends).” *PeerJ Preprints* 6 (March): e3192v2.
<https://doi.org/10.7287/peerj.preprints.3192v2>.

</div>

<div id="ref-rpackages2e" class="csl-entry">

Wickham, Hadley, and Jennifer Bryan. 2023. *R Packages*. 2. ed.
O’Reilly. <https://r-pkgs.org>.

</div>

</div>
