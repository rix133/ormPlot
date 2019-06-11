# ormPlot

<!-- badges: start -->
[![Build Status](https://travis-ci.com/rix133/ormPlot.svg?branch=master)](https://travis-ci.com/rix133/ormPlot)
[![Codecov test coverage](https://codecov.io/gh/rix133/ormPlot/branch/master/graph/badge.svg)](https://codecov.io/gh/rix133/ormPlot?branch=master)
<!-- badges: end -->

# Plotting ordinal regression models from R package rms


The goal of ormPlot is to to extend the plotting capabilties of rms package. 
In particular it aims to provide convenient ways of getting ggplot2 plots 
from orm and lrm models of the rms package.
It provides:
 * prediction plots of orm models together with coeficent intervals
 * forrest plots of orm/lrm model summaries
 * data about schoolchildren body measurments (residuals) and their family 
   socioeconomic status and size

## Installation

You can install the CRAN release of ormPlot from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("ormPlot")
```

To install the latest version do:

``` r
install.packages("remotes")
remotes::install_github("rix133/ormPlot")
```

## Example

See the vigentte and/or help files:

``` r
vignette("ormPlot")
help("ormPlot")
```



