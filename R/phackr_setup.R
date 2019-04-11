#' phackr_setup
#'
#' This function quickly sets up a survey object and transforms -99s, 77s, 98s, and 99s to NA.
#'
#'
#' @param data A dataframe, usually read from a dta file
#' @param weight The column name in the dataframe that would be the survey weight
#' @param caseid The column name in the dataframe that indicates caseid
#'
#' @return Returns a survey object
#' @export
#'
#' @examples
#' survey_data <- phackr_setup(data = "omnibus18", weight = "finalweight", caseid = "caseid")
#'
phackr_setup <- function(data, weight, caseid) {

  data[, 2:ncol(data)][data[, 2:ncol(data)] == -99] <- NA
  data[, 2:ncol(data)][data[, 2:ncol(data)] == 77] <- NA
  data[, 2:ncol(data)][data[, 2:ncol(data)] == 98] <- NA
  data[, 2:ncol(data)][data[, 2:ncol(data)] == 99] <- NA

  #Setup the survey object
  survey_data <- data %>%
    as_survey_design(weights = weight, id = caseid)
}
