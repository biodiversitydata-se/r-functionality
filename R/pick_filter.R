#' List and pick existing filters
#' 
#' Lists and lets the user interactivelly pick a filter from lists.  
#' 
#' @param type string: (optional) type of filter to create query string for. 
#'  Options are \code{c(resource", "specieslist" , "layer")} . Species lists 
#'  are waiting development from the API side. 
#' 
#' @return a string ready to be places in the argument \sQuote{fq} in function 
#' \code{\link{occurrences}}. 

#' @seealso \code{\link{occurrences}} for download reasons; \code{\link{sbdi_config}}
#' @examples
#' \dontrun{
#' fq_str<-pick_filter("resource") #data_resource_uid:dr5
#' x <- occurrences(taxon="genus:Accipiter", 
#'                   download_reason_id=10,
#'                   fq=fq_str,
#'                   fields="all")
#' }
#' @importFrom httr get content
#' @importFrom jsonlite fromJSON
#' @export pick_filter

#A messy function to get a vector of filter queries to use in functions asking for fq=. 
#TODO integrate with specieslists, search_layers, and create search_resources
pick_filter<-function(type = NULL){
  continue <- TRUE
  res <- c()
  
  while(continue){
    
    if(is.null(type)){
      type <- readline('What type do you want to filter by? Choose: "resource", "specieslist" or "layer". ')
    }
    
    type <- tolower(type)
    
    if(type=="resource"){
      
      this_url <- SBDI4R:::build_url_from_parts(getOption("ALA4R_server_config")$base_url_collections, 
                                                c("institution.json"))
      
      
      institutions <- fromJSON(content(GET(this_url), "text"))
      institutions <- institutions[,c("uid","name", "uri")]
      
      message("Which institution do you want to get data from? Press enter to get list or answer by uid.")
      r <- readline()
      
      if(r==""){
        print(institutions[,c("uid","name")])
        message("By what recource do you want to filter? Answer by uid:")
        r <- readline()
      }
      
      if(r %in% institutions$uid){
        ruid <- r
        uri <- institutions$uri[institutions$uid==ruid]
        
        dataResource <- jsonlite::fromJSON(httr::content(httr::GET(uri), "text"))
        dataResource <- dataResource$collections
        # dataResource <- dataResource$linkedRecordConsumers[,c(3,1,2)]
        print(dataResource)
        print("By what object do you want to filter? Answer by uid:")
        r <- readline()
        
        if(r %in% objectResource$uid){
          res <- c(res, paste0("institution_uid",":",r))
          
          if(continue("Filter added. Do you want to continue? Type y for yes. ")){
            type <- NULL
          }else{
            continue <- FALSE
          }
          
        }else{
          if(continue("No object with uid found. Do you want to start over? Type y for yes. ")){
            type <- NULL
          }else{
            continue <- FALSE
          }
        }
        
      }else{
        if(continue("No object with uid found. Do you want to start over? Type y for yes. ")){
          type <- NULL
        }else{
          continue <- FALSE
        }
      }
    }else{
      if(continue("Type not correct specified. Do you want to start over? Type y for yes. ")){
        type <- NULL
      }else{
        continue <- FALSE
      }
    }
  }
  
  return(res)
}
  
#' auxiliary function  
  continue <- function(msg){
    print(msg)
    r <- readline()
    r <- tolower(r)
    return(any(c("yes", "y") %in% r))
  }
  