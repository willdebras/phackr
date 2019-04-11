
<!-- README.md is generated from README.Rmd. Please edit that file -->
phackr
======

The goal of phackr is to produce excel sheets showing multivariate significance for several dependent variables across as many covariates as specified. The future plan for the package is to allow specification of several interchangeable covariates to output to multiple excel sheets.

Installation
------------

You can install the development version from github with:

``` r
library(devtools)
install_github("willdebras/phackr")
```

``` r
library(phackr)
library(tibble)
```

Example
-------

You can use the `phackr_setup()` function to setup a survey object

``` r
library(rio)
data <- import("full_data.dta")

survey_data <- phackr_setup(data = data, weight = "finalwt", caseid = "su_id")
```

Once it is setup, you can use the `phackr()` function to actually produce the tables.

``` r

sheet1 <- phackr(data = survey_data, dvs = c("factor(q41)", "factor(q42)"), demos = c("marital", "education", "gender", "empstatus", "agegrp"))

library(knitr)
kable(sheet1)
```

|           | factor(q41) | factor(q42) |
|-----------|:------------|:------------|
| marital   |             |             |
| education | -           |             |
| gender    |             |             |
| empstatus |             |             |
| agegrp    |             |             |
