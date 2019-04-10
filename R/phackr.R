

phackr <- function(data, dvs, demos, covs) {

  ###create empty lists to fill
  dv_models <- list()
  covariates_models <- list()

  dv <- as.list(dvs)
  covariates <- as.list(covs)

  demos_list <- paste(demos, collapse = " + ")
  demos_input <- paste("~ ", demos_list, " +")


  for (i in covariates) {

    for (j in dv) {

      dv_models[[j]] <- tidy(svyolr(paste(j[[1]], demos_input, i[[1]]), survey_data))

    }

    covariates_models[[i]] <- dv_models

  }



}
