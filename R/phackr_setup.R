
phackr_setup <- function(data, weight, caseid) {

  data[, 2:ncol(data)][data[, 2:ncol(data)] == -99] <- NA
  data[, 2:ncol(data)][data[, 2:ncol(data)] == 77] <- NA
  data[, 2:ncol(data)][data[, 2:ncol(data)] == 98] <- NA
  data[, 2:ncol(data)][data[, 2:ncol(data)] == 99] <- NA

  #Setup the survey object
  survey_data <- data %>%
    as_survey_design(weights = weight, id = caseid)
}
