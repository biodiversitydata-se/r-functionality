# Internal function used to download results to a file 
download_to_file <- function(url,outfile,binary_file=FALSE,caching=nbn_config()$caching,verbose=nbn_config()$verbose,on_redirect=NULL,on_client_error=NULL,on_server_error=NULL,...) {
 ALA4R:::download_to_file(url,outfile,binary_file,caching,verbose,on_redirect,on_client_error,on_server_error,...) 
}

get_diag_message <- function(jsonfile) {
 ALA4R:::get_diag_message(jsonfile) 
}
