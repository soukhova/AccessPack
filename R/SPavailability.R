# The input is an OD-table with Origins, Destinations, Population, Jobs, and a pre-calculated impedance function f
#
#' @param x A data frame with origin-destination information, including identifiers for origins, destinations, population, opportunities, and a pre-calculated impedance function
#' @param o_id  A character string with the name of the column in data frame x that contains the unique origin identifiers
#' @param d_id  A character string with the name of the column in data frame x that contains the unique destination identifiers
#' @param pop   A character string with the name of the column in data frame x that contains the population
#' @param opp   A character string with the name of the column in data frame x that contains the opportunities
#' @param f     A character string with the name of the column in data frame x that contains the values of the impedance function
#' @param alpha A number string with the name of the column in data frame x that contains the values of the impedance function
#' @return A vector with the number of opportunities available to o_id from d_id
#' @export

p_allocation <- function(x, o_id, d_id, pop, opp, f, alpha = 1){
  x <- x %>%
    rename(o = as.name(o_id),
           d = as.name(d_id),
           p = as.name(pop),
           w = as.name(opp),
           f = as.name(f))

  sum_pop <- x %>%
    distinct(o,
             .keep_all = TRUE) %>%
    mutate(sum_pop = p^alpha) %>%
    pull(sum_pop) %>%
    sum()

  x <- x %>%
    mutate(f_p = p^alpha / sum_pop)

  sum_impedance <- x %>%
    group_by(d) %>%
    summarize(sum_impedance = sum(f))

  x <- x %>%
    left_join(sum_impedance,
              by = "d")

  x <- x %>%
    mutate(f_c = f / sum_impedance)

  sum_pa <- x %>%
    group_by(d) %>%
    summarize(sum_pa= sum(f_p * f_c))

  x <- x %>%
    left_join(sum_pa,
              by = "d")

  x <- x %>%
    mutate(f_t = (f_p * f_c) / sum_pa)

  x <- x %>%
    mutate(v_ij = w * f_t)

  return(x$v_ij)
}
