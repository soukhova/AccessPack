#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL

#' AccessPack: A package with a function to calculate _spatial availability_, an
#'  accessibility measure which proportionally allocates (singly-constraints) opportunity
#'  supply to available opportunity seekers, and two sample datasets related to workers and jobs.
#'  One dataset is a hypothetical toy example and the other dataset is trip data for workers and jobs
#'  retained from the Transportation Tomorrow Survey (TTS) 2016 in the Greater Toronto and Hamilton Area (GTHA).
#'
#' @docType package
#' @name AccessPack-package
#' @author Antonio Paez, School of Earth, Environment and Society, McMaster University \email{paezha@@mcmaster.ca}
#' @author Anastasia Soukhov, School of Earth, Environment and Society, McMaster University \email{soukhoa@@mcmaster.ca}
#' @references \url{https://github.com/soukhova/Spatial-Availability-Measures-Package}
NULL

#' gtha_taz
#'
#' This object contains traffic analysis zones (TAZ) sourced from the 2016 Transportation Tomorrow Survey (TTS) for the entire Greater Toronto and Hamilton Area (GTHA).
#'
#' @format A simple feature class (sf) polygon object containing 3764 rows and 5 variables; each row represents a unique TAZ with associated features.
#' \describe{
#'   \item{GTA06}{Unique ID of the traffic analysis zone (TAZ).}
#'   \item{AREA}{Area of TAZ in units of km^2.}
#'   \item{workers}{The number of full-time workers within each TAZ.}
#'   \item{jobs}{The number of jobs within each TAZd. }
#'   \item{geometry}{The sfc polygon geometry (boundaries) of the TAZ.}
#'}
#' @docType data
#' @keywords Jobs Workers TTS 2016 GTHA Toronto Hamilton
#' @name gtha_taz
#' @usage data(gtha_taz)
#' @source "2016 Transportation Tomorrow Survey" from [data management group]() accessed November 14 2021.
"gtha_taz"

#' hamilton_cma
#'
#'This object defines the spatial boundary of the City of Hamilton.
#'
#' @format A simple feature class (sfc) multipolygon object containing 1 row.
#'
#' @docType data
#' @keywords Hamilton CMA boundary
#' @name hamilton_cma
#' @usage data(hamilton_cma)
#' @source "City boundary" from [Hamilton Open Data](https://open.hamilton.ca/datasets/489f656072f44f34b07bf53efa0d8e4f_13/about) accessed November 8 2021.
"hamilton_cma"

#' od_ft_tt
#'
#' This object contains the trips made from origin (TAZ) to destination (TAZ) by full-time workers to work destinations; it is sourced from the 2016 Transportation Tomorrow Survey (TTS) for the entire Greater Toronto and Hamilton Area (GTHA). Also contained within is the calculated car travel time for each trip assuming a 7:00 am departure from the centroid of the TAZ on Oct. 20 2021.

#' @format A dataframe containing 103076 rows and 4 variables; each row represents a unique trip from origin TAZ to destination TAZ with associated features.
#' \describe{
#'   \item{Origin}{The unique ID of the origin traffic analysis zone (TAZ).}
#'   \item{Destination}{The unique ID of the destination traffic analysis zone (TAZ).}
#'   \item{Persons]{The number of people making this trip.}
#'   \item{travel_time}{The car travel time from origin to destination assuming a 7:00 am departure from and to the TAZ centroids on Oct. 20 2021.]
#'}
#' @docType data
#' @keywords Origin Destination Trips Jobs Workers TTS 2016 GTHA Toronto Hamilton
#' @name od_ft_tt
#' @usage data(od_ft_tt)
#' @source "2016 Transportation Tomorrow Survey" from [data management group]() accessed November 14 2021.
#' @source travel times calculated using [`r5r`](https://cran.r-project.org/web/packages/r5r/vignettes/intro_to_r5r.html)
"od_ft_tt"

#' toronto_muni_bound
#'
#'This object defines the spatial boundary of the City of Toronto
#'
#' @format A simple feature class (sfc) multipolygon object containing 1 row.
#'
#' @docType data
#' @keywords Toronto Municipal boundary
#' @name toronto_muni_bound
#' @usage data(toronto_muni_bound)
#' @source "Regional Municipal boundary" from [Toronto Open Data](https://open.toronto.ca/dataset/regional-municipal-boundary/) accessed November 20 2021.
"toronto_muni_bound"

#' toy_od_table
#'
#' This object contains a hypothetical toy example of Population, Jobs, Distance, and Catchment for each Origin-Destination trip. Randomly generated.

#' @format A dataframe containing 27 rows and 6 variables; each row represents a unique trip from "Population" to "Employment Center" with associated features.
#' \describe{
#'   \item{Origin}{The unique ID for each "Population" from 1 to 9 }
#'   \item{Destination}{The unique ID for each "Employment Center" from 1 to 3}
#'   \item{Population]{The population corresponding to the "Population" ID.}
#'   \item{Jobs]{The number of jobs corresponding to the "Employment Center" ID.}
#'   \item{distance}{The distance between origin to destination (unitless).}
#'   \item{catchments}{A binary code indicating if the origin-destination trip is eligible or not (details on how this can be used within the vignette)).]
#'}
#' @docType data
#' @keywords Origin Destination Trips Jobs Workers Toy
#' @name toy_od_table
#' @usage data(toy_od_table)
"toy_od_table"

#' toy_sim_zones
#'
#' This object contains the geometries of the hypothetical toy example Origin and Destination trip zones. Randomly generated.

#' @format A simple feature class (sfc) multipolygon object containing 12 rows and 5 variables; each row represents a unique "Population" or "Employment Center" zone with associated features.
#' \describe{
#'   \item{id}{The unique ID for each "Population" (from 1 to 9) or "Employment Center" (from 1 to 3) }
#'   \item{id_short}{A short unique ID}
#'   \item{number]{The population corresponding to the ID.}
#'   \item{type]{The number of jobs corresponding the ID.}
#'   \item{geometry}{The sfc polygon geometry (boundaries) of each ID.}]
#'}
#' @docType data
#' @keywords Origin Destination Jobs Workers Toy
#' @name toy_sim_zones
#' @usage data(toy_sim_zones)
"toy_sim_zones"

#' toy_trips
#'
#' This object contains a hypothetical toy example of the number of trips for each Origin-Destination combination. Randomly generated.

#' @format A dataframe containing 27 rows and 3 variables; each row represents the number of trips from "Population" to "Employment Center" with associated features.
#' \describe{
#'   \item{Origin}{The unique ID for each "Population" from 1 to 9 }
#'   \item{Destination}{The unique ID for each "Employment Center" from 1 to 3}
#'   \item{Population]{The population corresponding to the "Population" ID.}
#'   \item{trips]{The number of trips made from origin to destination.}]
#'}
#' @docType data
#' @keywords Origin Destination Trips Jobs Workers Toy
#' @name toy_trips
#' @usage data(toy_trips)
"toy_trips"
