# #Necessary packages
# library(tidyverse)
# library(survey)
# library(srvyr)
# library(rio)
# library(mitools)
# library(broom)
# library(purrr)
# test
#
# #Stop the war crime of scientific notation
# options(scipen=10)
#
# #Import dataset
# full_data <- import("T:\\Programs\\r_projects\\phackr\\full_data.dta")
# full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == -99] <- NA
# full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == 77] <- NA
# full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == 98] <- NA
# full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == 99] <- NA
#
# #Setup the survey object
# survey_data <- full_data %>%
#   mutate(q41_binary = ifelse(q41 > 2,
#                              1,
#                              0)) %>%
#   as_survey_design(weights = finalwt, id = su_id)
#
#
# demos <- c("hhincome", "urban", "agegrp", "education")
# dv <- list("factor(q41)", "factor(q42)", "factor(raceth)", "factor(census_region)", "factor(politics)", "factor(marital)")
#
# #Create list of list of regression outputs
# dv_models <- list()
#
# for (i in dv) {
#
#   dv_models[[i]] <- tidy(svyolr(paste(i[[1]], paste("~ ", paste(demos, collapse = " + "))), survey_data))
#
# }
#
# #Function to extract all elements of list
#
# extract_elements <- function(x) {
#
#   data.frame(pluck(dv_models, x)) %>%
#     filter(coefficient_type == "coefficient") %>%
#     mutate(p = round((pnorm(abs(statistic), lower.tail = FALSE) * 2), digits = 5),
#            mvr = ifelse(p > 0.05,
#                         "",
#                         ifelse(estimate > 0,
#                                "+",
#                                "-")
#            )
#     ) %>%
#     select(mvr)
#
# }
#
# #Function to create dataframe of mvr results
#
# sheet <- tibble(rows = demos)
#
# for (i in 1:length(dv_models)) {
#
#   sheet[(i+1)] <- add_column(extract_elements(i))
#
# }
#
# sheet <- sheet %>%
#   remove_rownames %>%
#   column_to_rownames(var="rows") %>%
#   `colnames<-`(unlist(dv, use.names = FALSE))
#
