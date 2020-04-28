#' Returns the name of the cache file associated with the given URL. Note that this file 
#' may not actually exist, this function just provides the mapping from URL to filename
#' 
#' @references \url{https://api.nbnatlas.org/}
#' @seealso \code{nbn_config} for cache settings, particularly the cache directory
#'  
#' @param url string: the URL
#' @return string: the file path and name
#' 
#' @examples
#' nbn_cache_filename("https://records-ws.nbnatlas.org/index/fields")
#' 
#' @export nbn_cache_filename
nbn_cache_filename <- function(url){
  
  ALA4R::ala_cache_filename(url)
} 
