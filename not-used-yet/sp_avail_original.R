#' The input is an OD-table with Origins, Destinations, Population, Jobs, and a pre-calculated impedance function f
#'
#' @param x A data frame with origin-destination information, including identifiers for origins, destinations, population, opportunities, and a pre-calculated impedance function
#' @param o_id  A character string with the name of the column in data frame x that contains the unique origin identifiers
#' @param d_id  A character string with the name of the column in data frame x that contains the unique destination identifiers
#' @param pop   A character string with the name of the column in data frame x that contains the population
#' @param opp   A character string with the name of the column in data frame x that contains the opportunities
#' @param f     A character string with the name of the column in data frame x that contains the values of the impedance function
#' @param alpha A number string with the name of the column in data frame x that contains the values of the impedance function
#' @return A vector with the number of opportunities available to o_id from d_id
#' @export sp_avail

sp_avail <- function(x, o_id, d_id, pop, opp, f, alpha = 1){

   x <- x %>%
    dplyr::rename(#o = as.name(o_id),
           d = as.name(d_id))#,
           #p = as.name(pop),
           #w = as.name(opp),
           #f = as.name(f))

  sum_pop <- x %>%
    dplyr::distinct({{o_id}},
             .keep_all = TRUE) %>%
    dplyr::mutate(sum_pop = {{pop}}^alpha) %>%
    dplyr::pull(sum_pop) %>%
    sum()

  x <- x %>%
    dplyr::mutate(f_p = {{pop}}^alpha / sum_pop)

  sum_impedance <- x %>%
    dplyr::group_by(d) %>%
    dplyr::summarize(sum_impedance = sum({{f}}))

  x <- x %>%
    dplyr::left_join(sum_impedance,
              by = "d")

  x <- x %>%
    dplyr::mutate(f_c = {{f}} / sum_impedance)

  sum_pa <- x %>%
    dplyr::group_by(d) %>%
    dplyr::summarize(sum_pa= sum(f_p * f_c))

  x <- x %>%
    dplyr::left_join(sum_pa,
              by = "d")

  x <- x %>%
    dplyr::mutate(f_t = (f_p * f_c) / sum_pa)

  x <- x %>%
    dplyr::mutate(v_ij = {{opp}} * f_t)

  return(x$v_ij)
}
