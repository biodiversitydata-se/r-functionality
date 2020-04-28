#' Summarize, filter and subset occurrence data
#' 
#' Set of S3 methods to summarize, filter and get unique occurrence data retrieved using \code{\link{occurrences}}.
#' This uses information based on selections of assertions (quality assurance issues NBN has identified), spatial and temporal data.
#' 
#' @references \url{https://api.nbnatlas.org/}
#' @references \url{http://stat.ethz.ch/R-manual/R-devel/library/methods/html/Methods.html}
#' 
#' @param object list: an 'occurrence' object that has been downloaded using \code{\link{occurrences}}
#' @param x list: an 'occurrence' object that has been downloaded using \code{\link{occurrences}}
#' @param incomparables logical/numeric: currently ignored, but needed for S3 method consistency
#' @param spatial numeric: specifies a rounding value in decimal degrees used to to create a unique subset of the data. Value of 0 means no rounding and use values as is. Values <0 mean ignore spatial unique parameter
#' @param temporal character: specifies the temporal unit for which to keep unique records; this can be by "year", "month", "yearmonth" or "full" date. NULL means ignore temporal unique parameter
#' @param na.rm logical: keep (FALSE) or remove (TRUE) missing spatial or temporal data
#' @param remove.fatal logical: remove flagged assertion issues that are considered "fatal"; see \code{\link{check_assertions}} 
#' @param exclude.spatial character vector: defining flagged spatial assertion issues to be removed. Values can include 'warnings','error','missing','none'; see \code{\link{check_assertions}}
#' @param exclude.temporal character vector: defining flagged temporal assertion issues to be removed. Values can include 'warnings','error','missing','none'; see \code{\link{check_assertions}}
#' @param exclude.taxonomic character vector: defining flagged taxonomic assertion issues to be removed. Values can include 'warnings','error','missing','none'; see \code{\link{check_assertions}}
#' @param max.spatial.uncertainty numeric: number defining the maximum spatial uncertainty (in meters) one is willing to accept. 
#' @param keep.missing.spatial.uncertainty logical: keep (FALSE) or remove (TRUE) information missing spatial uncertainty data.
#' @param \dots not currently used
#'
#' @details
#' \code{unique} will give the min value for all columns that are not used in the aggregation.
#' 
#' @examples
#' \dontrun{
#' #download some observations
#' x <- occurrences(taxon="Leuctra geniculata",download_reason_id=10)
#' 
#' #summarize the occurrences
#' summary(x)
#' 
#' #keep spatially unique data at 0.01 degrees (latitude and longitude)
#' tt <- unique(x,spatial=0.01)
#' summary(tt)
#'
#' #keep spatially unique data that is also unique year/month for the collection date
#' tt <- unique(x,spatial=0,temporal='yearmonth')
#' summary(tt)
#'
#' #keep only information for which fatal or "error" assertions do not exist
#' tt <- subset(x)
#' summary(tt)
#' }
#' @name occurrences_s3
NULL

#' @rdname occurrences_s3
#' @method summary occurrences
#' @export

"summary.occurrences" <- function(object, ...) {
  
 ALA4R:::summary.occurrences(object, ...) 
}

#' @rdname occurrences_s3
#' @method unique occurrences
#' @export
"unique.occurrences" <- function(x, incomparables=FALSE, spatial=0, temporal=NULL, na.rm=FALSE, ...) {
  ALA4R:::unique.occurrences(x, incomparables, spatial, temporal, na.rm, ...)
  
}


#' @rdname occurrences_s3
#' @method subset occurrences
#' @export
"subset.occurrences" <- function(x, remove.fatal=TRUE, exclude.spatial='error', exclude.temporal='error', exclude.taxonomic='error', max.spatial.uncertainty, keep.missing.spatial.uncertainty=TRUE, ...) {
  
  ALA4R:::subset.occurrences(x, remove.fatal, exclude.spatial, exclude.temporal, exclude.taxonomic, max.spatial.uncertainty, keep.missing.spatial.uncertainty, ...)
  
}