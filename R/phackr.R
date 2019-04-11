#' phackr
#'
#'The phackr function takes a dataset, a vector of dependent variables, and a vector of demographic variables and creates a tibble of multivariate significance from ordinal logit models.
#'
#' @param data A survey data object. This can be created with the phackr_setup function
#' @param dvs A vector of dependent variables to run the same model across.
#' @param demos A vector of demographic variables and covariates to include in the ologit model.
#'
#' @return Returns a tibble that can quickly be written to an excel sheet
#' @export
#' @importFrom survey svyolr
#' @importFrom broom tidy
#' @importFrom tibble tibble
#' @importFrom tibble add_column
#' @import magrittr
#'
#' @examples
#' sheet1 <- phackr(data = survey_data, dvs = c("q2", "q3", "q4"), demos = c("race", "partyid", "gender"))
#'
phackr <- function(data, dvs, demos) {

  ###create empty lists to fill
  dv_models <- list()

  dv <- as.list(dvs)

  for (i in dv) {

    dv_models[[i]] <- tidy(svyolr(paste(i[[1]], paste("~ ", paste(demos, collapse = " + "))), data))

  }
  sheet <- tibble(rows = demos)

  for (i in 1:length(dv_models)) {

    sheet[(i+1)] <- add_column(extract_elements(i))

  }

  sheet <- sheet %>%
    remove_rownames %>%
    column_to_rownames(var="rows") %>%
    `colnames<-`(unlist(dv, use.names = FALSE))


}

