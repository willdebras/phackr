#' extract_elements
#'
#' This is a backend helper function to interact with the phackr function.
#'
#' @param x
#'
#' @return a single column tibble indicating significance and directionality of a logistic regression output
#' @export
#' @import dplyr
#' @importFrom purrr pluck
#' @import magrittr
#'
extract_elements_logit_single <- function(dv_models, x) {

  data.frame(pluck(dv_models, x)) %>%
    slice(-1) %>%
    mutate(mvr = ifelse(p.value > 0.05,
                        "",
                        ifelse(estimate > 0,
                               "+",
                               "-")
                        )
    ) %>%
    select(mvr)

}
