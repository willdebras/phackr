#' extract_elements
#'
#' This is a backend helper function to interact with the phackr function.
#'
#' @param x
#'
#' @return a single column tibble indicating significance and directionality of an ordinal logit regression output
#' @export
#' @import dplyr
#' @importFrom purrr pluck
#' @import magrittr
#'
extract_elements_ologit_single <- function(dv_models, x) {

  data.frame(pluck(dv_models, x)) %>%
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
