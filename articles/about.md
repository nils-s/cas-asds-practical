# About

This R package contains data, code, and vignettes for the final,
practical module (“Praxismodul”) of the Certificate of Advanced Studies
in Advanced Statistical Data Science ([CAS
ASDS](https://www.unibe.ch/weiterbildungsangebote/cas_advanced_statistical_data_science/index_ger.html))
at the [University of Berne](https://www.unibe.ch/index_eng.html) for
the class of 2024.

The primary objective of the module was a statistical analysis of real
data, using techniques learned during the course of the CAS.

Additionally, to get more acquainted with R, I tried to improve my
knowledge of R, and incorporate some tools and techniques related to R
that I had not used during previous classes, but which could prove
useful in future projects. For this reason, the main part of the work is
packaged as an R module, containing all relevant data, and including the
analysis part (i.e. the main part of the course module) as vignettes.
This is an attempt to package the main components in a reproducible
research style, as suggested e.g. in (Marwick, Boettiger, and Mullen
2018b, 2018a).

The documents used for the mid-term presentation and final submission
are not packaged as vignettes, since the main objective was to get
decent slides and a good-looking final paper, which meant using some
LaTeX features that do not necessarily work well for vignettes. The
files are still available in the package’s sources, though, in the
*articles* subfolder of the *vignettes* folder. For learning purposes,
the final paper is available in triplicate, once as a basic
`pdf_document` file, and (in the respective subfolders) using `rticles`
document templates for Elsevier and Springer journal papers (which
require specific yaml front matter, and for which the content was
slightly adjusted layout-wise).

## Reproducible Research

Using R packages in order to bundle all necessary resources to make a
data analysis project reproducible has been suggested by multiple
sources (e.g. (Wickham and Bryan 2023; Flight 2014; Marwick, Boettiger,
and Mullen 2018b, 2018a)), with other sources (e.g. (Flight 2021))
suggesting lighter-weight approaches like (Landau 2024, 2021). Since one
of my goals was to learn more about R and the R ecosystem, the more
complex setup using an R package was chosen, mostly for the learning
experience. The CRAN task view for reproducible research (Blischak et
al. 2024) contains many other possibilities for future exploration.

If you want to cite this package for some reason, you can use e.g.

``` r
citation("asds2024.nils.practical")
#> To cite asds2024.nils.practical use:
#> 
#>   S. N (2024). _CAS ASDS Practical Project: Exploratory Analysis of
#>   Road Bike Trip Data_. R package version 0.2.0.9000,
#>   <https://github.com/nils-s/cas-asds-practical>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {CAS ASDS Practical Project: Exploratory Analysis of Road Bike Trip Data},
#>     author = {Nils S.},
#>     year = {2024},
#>     note = {R package version 0.2.0.9000},
#>     url = {https://github.com/nils-s/cas-asds-practical},
#>   }
```

## References

Blischak, John, Alison Hill, Ben Marwick, Daniel Sjoberg, and Will
Landau. 2024. “CRAN Task View: Reproducible Research.” February 20,
2024. <https://cran.r-project.org/view=ReproducibleResearch>.

Flight, Robert M. 2014. “Analyses as Packages.” July 28, 2014.
<https://rmflight.github.io/posts/2014-07-28-analyses-as-packages>.

———. 2021. “Packages Don’t Work Well for Analyses in Practice.” March 2,
2021.
<https://rmflight.github.io/posts/2021-03-02-packages-dont-work-well-for-analyses-in-practice>.

Landau, William Michael. 2021. “The targets R Package: A Dynamic
Make-Like Function-Oriented Pipeline Toolkit for Reproducibility and
High-Performance Computing.” *Journal of Open Source Software* 6 (57):
2959. <https://doi.org/10.21105/joss.02959>.

———. 2024. *targets: Dynamic Function-Oriented Make-Like Declarative
Pipelines*. <https://docs.ropensci.org/targets/>.

Marwick, Ben, Carl Boettiger, and Lincoln Mullen. 2018a. “Packaging Data
Analytical Work Reproducibly Using R (and Friends).” *The American
Statistician* 72 (1): 80–88.
<https://doi.org/10.1080/00031305.2017.1375986>.

———. 2018b. “Packaging Data Analytical Work Reproducibly Using R (and
Friends).” *PeerJ Preprints* 6 (March): e3192v2.
<https://doi.org/10.7287/peerj.preprints.3192v2>.

Wickham, Hadley, and Jennifer Bryan. 2023. *R Packages*. 2. ed.
O’Reilly. <https://r-pkgs.org>.
