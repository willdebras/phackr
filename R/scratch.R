#packages
library(tidyverse)
library(survey)
library(srvyr)
library(rio)
library(mitools)
library(broom)

options(scipen=10)

#import
full_data <- import("T:\\saved_downloads\\apnorc_thanksgiving_nov2017.dta")
full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == -99] <- NA
full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == 77] <- NA
full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == 98] <- NA
full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == 99] <- NA

#survey setup
survey_data <- full_data %>%
  as_survey_design(weights = finalwt, id = su_id)

m <- svyolr(factor(q41) ~ politics + factor(raceth), survey_data)
tidym <- tidy(m)
tidym$p <- round((pnorm(abs(tidym$statistic), lower.tail = FALSE) * 2), digits = 5)
