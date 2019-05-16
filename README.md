
<!-- README.md is generated from README.Rmd. Please edit that file -->

# phackr

The goal of phackr is to produce excel sheets showing multivariate
significance for several dependent variables across as many covariates
as specified. The function currently only supports ordered logistic regression models. The future plan for the package is to allow specification
of several interchangeable covariates to output to multiple excel
sheets.

## Installation

You can install the development version from github with:

``` r
library(devtools)
install_github("willdebras/phackr")
```

``` r
library(phackr)
library(tibble)
```

## Example

You can use the `phackr_setup()` function to setup a survey object

``` r
library(rio)
data <- import("full_data.dta")

survey_data <- phackr_setup(data = data, weight = "finalwt", caseid = "su_id")
```

Once it is setup, you can use the `phackr()` function to actually
produce the tables.

``` r

sheet1 <- phackr(data = survey_data, 
                 dvs = c("factor(trade1a)", "factor(trade1b)", "factor(trade1c)", "factor(trade1d)", "factor(trade1e)", "factor(trade1f)", "factor(trade1g)", "factor(trade2)", "factor(trade3a)", "factor(trade3b)", "factor(trade3c)"), 
                 demos = c("urban", "marital", "agegrp", "education", "hhincome", "empstatus", "gender"))

library(knitr)
kable(sheet1)
```

|           | factor(trade1a) | factor(trade1b) | factor(trade1c) | factor(trade1d) | factor(trade1e) | factor(trade1f) | factor(trade1g) | factor(trade2) | factor(trade3a) | factor(trade3b) | factor(trade3c) |
| --------- | :-------------- | :-------------- | :-------------- | :-------------- | :-------------- | :-------------- | :-------------- | :------------- | :-------------- | :-------------- | :-------------- |
| urban     |                 |                 |                 |                 |                 |                 |                 | \-             |                 | \+              |                 |
| marital   |                 |                 |                 | \-              | \-              |                 |                 |                |                 |                 | \+              |
| agegrp    |                 |                 |                 |                 |                 |                 |                 |                |                 |                 |                 |
| education |                 |                 | \-              |                 |                 |                 |                 | \+             | \+              | \-              |                 |
| hhincome  |                 | \-              |                 |                 |                 |                 |                 |                |                 |                 |                 |
| empstatus |                 |                 |                 |                 |                 |                 |                 |                |                 |                 |                 |
| gender    |                 |                 |                 |                 | \-              | \+              |                 | \+             |                 |                 |                 |
