

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

dvs <- c("factor(q41)", "factor(q42)", "factor(raceth)", "factor(census_region)", "factor(politics)", "factor(marital)")
demos <- c("hhincome", "urban", "agegrp", "education")

sheet1 <- phackr(data = survey_data, dvs = dvs, demos = demos)
