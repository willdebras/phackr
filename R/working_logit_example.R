# library(survey)
# library(srvyr)
# library(purr)
# library(dplyr)
# library(broom)
# library(rio)
#
# data <- import("full_data.dta")
# survey_data <- phackr_setup(data = data, weight = "finalwt", caseid = "su_id")
#
# survey_data <- survey_data %>%
#   mutate(trade1a_r2 = ifelse(trade1a > 3,
#                              1,
#                              0),
#          trade1b_r2 = ifelse(trade1b > 3,
#                              1,
#                              0),
#          trade1c_r2 = ifelse(trade1c > 3,
#                              1,
#                              0),
#          trade1d_r2 = ifelse(trade1d > 3,
#                              1,
#                              0),
#          trade1e_r2 = ifelse(trade1e > 3,
#                              1,
#                              0),
#          trade1f_r2 = ifelse(trade1f > 3,
#                              1,
#                              0),
#          trade1g_r2 = ifelse(trade1g > 3,
#                              1,
#                              0)
#          )
#
# sheet1 <- phackr(data = survey_data,
#                  dvs = c("trade1a_r2", "trade1b_r2", "trade1c_r2", "trade1d_r2", "trade1e_r2", "trade1f_r2", "trade1g_r2"),
#                  demos = c("urban", "marital", "agegrp", "education", "hhincome", "empstatus", "gender"),
#                  logit = TRUE)
