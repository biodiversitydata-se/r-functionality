#' Check assertions in occurrences object
#'
#' This provides a data.frame detailing the assertions that are found in a dataset returned from \code{\link{occurrences}}.
#'
#' @references \url{https://api.nbnatlas.org/}, \samp{http://biocache.ala.org.au/ws/assertions/codes}
#'  
#' @param x list: an object returned from \code{\link{occurrences}}
#' 
#' @return A dataframe of assertions column names, descriptions and categories/error codes. If no assertions are in the dataset, NULL is returned.
#'
#' @examples
#' #download species data with all possible assertions
#' \dontrun{
#'  x <- occurrences(taxon="golden plover",download_reason_id=10,qa=nbn_fields("assertions")$name)
#'  asserts <- check_assertions(x) #data.frame of assertions, their description and column names
#'  asserts$description # List out descriptions of all (current) assertions
#'
#'  tmp <- x$data[,names(x$data) %in% asserts$name] ## assertion columns from data
#'  which(colSums(tmp)>0) ## discard those not seen in the data
#' }
#' @export
check_assertions <- function(x) {
  ALA4R::check_assertions(x)
}