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

#export
export(full_data, "full_data.rds")
export(full_data, "full_data.dta")

#survey setup
survey_data <- full_data %>%
  mutate(q41_binary = ifelse(q41 > 2,
                             1,
                             0)) %>%
  as_survey_design(weights = finalwt, id = su_id)

#test2
covariates <- list("census_region", "gender", "q42")
results <- list()
for (i in covariates) {
  olr_models <- svyolr(paste("factor(q41) ~ factor(politics) + urban + agegrp + education + hhincome +", i[[1]]), survey_data)
  results[[i]] <- tidy(olr_models[[i]])
}


#Ordinal Logit
m <- svyolr(factor(q41) ~ factor(politics) + urban + agegrp + education + hhincome + gender , survey_data)
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
survey_data$variables$q41_binary
glm <- svyglm(q41_binary ~ urban + agegrp + education + hhincome + gender, family = binomial, survey_data)
tidyglm <- tidy(glm) %>%
  mutate(mvr = ifelse(p.value > 0.05,
                      "",
                      ifelse(estimate > 0,
                             "+",
                             "-")
                      )
  )

