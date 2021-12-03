#' Third version of function with tidy evaluation. The input are the same:  an OD-table with Origins, Destinations, Population, Jobs, and a pre-calculated impedance function f
#'
#' @param x A data frame with origin-destination information, including identifiers for origins, destinations, population, opportunities, and a pre-calculated impedance function
#' @param o_id  The name of the column in data frame x that contains the unique origin identifiers
#' @param d_id  The name of the column in data frame x that contains the unique destination identifiers
#' @param pop   The name of the column in data frame x that contains the population
#' @param opp   The name of the column in data frame x that contains the opportunities
#' @param f     The name of the column in data frame x that contains the values of the impedance function
#' @param alpha A number string with the name of the column in data frame x that contains the values of the impedance function
#' @return A vector with the number of opportunities available to o_id from d_id
#' @export sp_avail3

sp_avail3 <- function(x, o_id, d_id, pop, opp, f, alpha = 1){

  o_id <- enquo(o_id)
  d_id <- enquo(d_id)
  pop <- enquo(pop)
  opp <- enquo(opp)
  f <- enquo(f)

  sum_pop <- x %>%
    dplyr::distinct(!!o_id,
                    .keep_all = TRUE) %>%
    dplyr::mutate(sum_pop = (!!pop)^alpha) %>%
    dplyr::pull(sum_pop) %>%
    sum()

  x <- x %>%
    dplyr::mutate(f_p = (!!pop)^alpha / sum_pop)

  sum_impedance <- x %>%
    dplyr::group_by(!!d_id) %>%
    dplyr::summarize(sum_impedance = sum(!!f))

  x <- x %>%
    dplyr::left_join(sum_impedance,
                     by = rlang::as_name(d_id))

  x <- x %>%
    dplyr::mutate(f_c = !!f / sum_impedance)

  sum_pa <- x %>%
    dplyr::group_by(!!d_id) %>%
    dplyr::summarize(sum_pa= sum(f_p * f_c))

  x <- x %>%
    dplyr::left_join(sum_pa,
                     by = rlang::quo_text(d_id))

  x <- x %>%
    dplyr::mutate(f_t = (f_p * f_c) / sum_pa)

  x <- x %>%
    dplyr::mutate(v_ij = !!opp * f_t)

  return(x$v_ij)
}
