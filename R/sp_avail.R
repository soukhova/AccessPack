#' Input OD-table with Origins, Destinations, Population, Jobs, Catchment binary identification, and a pre-calculated impedance function f
#'
#' @param x A data frame with origin-destination information, including identifiers for origins, destinations, population, opportunities, and a pre-calculated impedance function
#' @param o_id  The name of the column in data frame x that contains the unique origin identifiers
#' @param d_id  The name of the column in data frame x that contains the unique destination identifiers
#' @param pop   The name of the column in data frame x that contains the population
#' @param opp   The name of the column in data frame x that contains the opportunities
#' @param r     The name of the column in data frame x that contains catchment restrictions, or a column of 1s if there are none
#' @param f     The name of the column in data frame x that contains the values of the impedance function
#' @param alpha A number string with the name of the column in data frame x that contains the values of the impedance function
#' @return A vector with the number of opportunities available to o_id from d_id
#' @importFrom rlang .data
#' @export

sp_avail <- function(x, o_id, d_id, pop, opp, r, f, alpha = 1){

  o_id <- rlang::enquo(o_id)
  d_id <- rlang::enquo(d_id)
  pop <- rlang::enquo(pop)
  opp <- rlang::enquo(opp)
  r <- rlang::enquo(r)
  f <- rlang::enquo(f)

  sum_pop <- x %>%
    dplyr::distinct(!!o_id,
                    .keep_all = TRUE) %>%
    dplyr::mutate(sum_pop = !!r*(!!pop)^alpha) %>%
    dplyr::pull(sum_pop) %>%
    sum()

  f_p <- dplyr::pull(x, !!r) * dplyr::pull(x, !!pop)^alpha / sum_pop

  sum_impedance <- x %>%
    dplyr::group_by(!!d_id) %>%
    dplyr::summarize(sum_impedance = sum(!!f))

  x <- x %>%
    dplyr::left_join(sum_impedance,
                     by = rlang::as_name(d_id))

  f_c <- dplyr::pull(x, !!f) / x$sum_impedance

  x$f_c <- f_c
  x$f_p <- f_p

  sum_pa <- x %>%
    dplyr::group_by(!!d_id) %>%
    dplyr::summarize(sum_pa= sum(f_p * f_c))

  x <- x %>%
    dplyr::left_join(sum_pa,
                     by = rlang::as_name(d_id))
  f_t <- (f_p * f_c) / dplyr::pull(x, sum_pa)

  dplyr::pull(x, !!opp) * f_t
}

# sp_avail <- function(x, o_id, d_id, pop, opp, r=NULL, f, alpha = 1){
#
#   o_id <- rlang::enquo(o_id)
#   d_id <- rlang::enquo(d_id)
#   pop <- rlang::enquo(pop)
#   opp <- rlang::enquo(opp)
#   f <- rlang::enquo(f)
#
#   if(!missing(r)){
#     r <- rlang::enquo(r)
#   }else{
#     r = 1
#   }
#
#   sum_pop <- x %>%
#     dplyr::distinct(!!o_id,
#                     .keep_all = TRUE) %>%
#     dplyr::mutate(sum_pop = !!r*(!!pop)^alpha) %>%
#     dplyr::pull(sum_pop) %>%
#     sum()
#
#   #x <- x %>%
#   #  dplyr::mutate(f_p = !!r*(!!pop)^alpha / sum_pop)
#   f_p <- pull(x, !!r) * pull(x, !!pop)^alpha / sum_pop
#
#
#   sum_impedance <- x %>%
#     dplyr::group_by(!!d_id) %>%
#     dplyr::summarize(sum_impedance = sum(!!f))
#
#   x <- x %>%
#     dplyr::left_join(sum_impedance,
#                      by = rlang::as_name(d_id))
#
#   #x <- x %>%
#   #  dplyr::mutate(f_c = !!f / sum_impedance)
#   f_c <- pull(x, !!f) / sum_impedance
#
#   sum_pa <- x %>%
#     dplyr::group_by(!!d_id) %>%
#     dplyr::summarize(sum_pa= sum(f_p * f_c))
#
#   x <- x %>%
#     dplyr::left_join(sum_pa,
#                      by = rlang::as_name(d_id))
#
#   x <- x %>%
#     dplyr::mutate(f_t = (f_p * f_c) / sum_pa)
#
#   x <- x %>%
#     dplyr::mutate(v_ij = !!opp * f_t)
#
#   return(x$v_ij)
# }
