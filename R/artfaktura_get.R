library(httr)
library(keyring)

## https://api-portal.artdatabanken.se/
# Reference https://api-portal.artdatabanken.se/docs/services/sandbox-species-observations---read/operations/59fb25717ec10608d0167c91?

getArtfakturaResources <- function() {
  resourceNames <- c("assessments", "biotopes", "landscapetypes", "natureconservation", "periods", "redlist", "search", "substrates", "taxonomy", "texts")
  return(resourceNames)
}

constructQueryURL <- function(resource, queryTerm='', queryValue='') {
  baseURL <- "https://api.artdatabanken.se/information/v1/speciesdataservice/v1/speciesdata/"
  url <- paste(baseURL, 'resource')
  if(query != '') {
    url <- paste(url, '?', queryTerm, '=', queryValue)
  }
  return(url)
}

getArtfaktaResults <- function(url) {
  key <- key_get(service="ArtdataAPI", username="r.s.johaadien@nhm.uio.no")
  return(content(GET(url=url, add_headers("Ocp-Apim-Subscription-Key"=key)), as="parsed"))
}

convertResultsToDataFrame <- function(list) {
  data <- list
  names <- names(unlist(data[[1]]))
  DataMatrix <- matrix(unlist(data), ncol=length(names), byrow=T, dimnames = list(1:length(data), names))
  DF <- data.frame(DataMatrix, stringsAsFactors=FALSE)
  return(DF)
}

# Examples
ramaria <- GETartfakta(resource = "search", query = "?searchString=Ramaria", key=key)
taxaRamaria <- fakta2DF(ramaria)

substRamaria<-GETartfakta(resource = "substrates", query=paste0("?taxa=",
                                                                paste0(taxaRamaria$taxonId, collapse = ",")),
                          key=key)

substRamaria[[1]]$speciesData
subst<-lapply(substRamaria, function(x)x$speciesData)
lengths(substRamaria)
lengths(subst)

