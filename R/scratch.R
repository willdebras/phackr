#Necessary packages
library(tidyverse)
library(survey)
library(srvyr)
library(rio)
library(mitools)
library(broom)
library(purrr)

#Stop the war crime of scientific notation
options(scipen=10)

#Import dataset
full_data <- import("T:\\saved_downloads\\apnorc_thanksgiving_nov2017.dta")
full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == -99] <- NA
full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == 77] <- NA
full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == 98] <- NA
full_data[, 2:ncol(full_data)][full_data[, 2:ncol(full_data)] == 99] <- NA

#Setup the survey object
survey_data <- full_data %>%
  mutate(q41_binary = ifelse(q41 > 2,
                             1,
                             0)) %>%
  as_survey_design(weights = finalwt, id = su_id)

#Create list of list of regression outputs
demographics <- "~ factor(politics) + urban + agegrp + education + hhincome +"
dv <- list("factor(q41)", "factor(q42)")
covariates <- list("census_region", "gender")
dv_models <- list()
covariates_models <- list()

for (i in covariates) {

  for (j in dv) {

    dv_models[[j]] <- tidy(svyolr(paste(j[[1]], demographics, i[[1]]), survey_data))

  }

 covariates_models[[i]] <- dv_models

}

#Extract elements

results <- data.frame(pluck(covariates_models, 1, 1)) %>%
  filter(coefficient_type == "coefficient") %>%
  mutate(p = round((pnorm(abs(statistic), lower.tail = FALSE) * 2), digits = 5),
         mvr = ifelse(p > 0.05,
                      "",
                      ifelse(estimate > 0,
                             "+",
                             "-")
         )
  ) %>%
  select(mvr)

#Function to extract all elements of list

extract_elements <- function(x, y) {

  data.frame(pluck(covariates_models, x, y)) %>%
    filter(coefficient_type == "coefficient") %>%
    mutate(p = round((pnorm(abs(statistic), lower.tail = FALSE) * 2), digits = 5),
           mvr = ifelse(p > 0.05,
                        "",
                        ifelse(estimate > 0,
                               "+",
                               "-")
           )
    ) %>%
    select(mvr)

}

extract_elements(1, 2)

##########################
#Working Ologit and Logit#
##########################

#Ordinal Logit
m <- svyolr(factor(q42) ~ factor(politics) + urban + agegrp + education + hhincome + gender, survey_data)
tidy(m)
tidym <- tidy(m)
tidym$p <- round((pnorm(abs(tidym$statistic), lower.tail = FALSE) * 2), digits = 5)

tidym <- tidym %>%
  mutate(mvr = ifelse(p > 0.05,
                      "",
                      ifelse(estimate > 0,
                             "+",
                             "-")
                      )
         ) %>%
  filter(coefficient_type == "coefficient")

#Logit
glm <- svyglm(q41_binary ~ urban + agegrp + education + hhincome + gender, family = binomial, survey_data)

tidyglm <- tidy(glm) %>%
  mutate(mvr = ifelse(p.value > 0.05,
                      "",
                      ifelse(estimate > 0,
                             "+",
                             "-")
                      )
  )

