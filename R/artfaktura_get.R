library(httr)
library(keyring)

## https://api-portal.artdatabanken.se/
# Reference https://api-portal.artdatabanken.se/docs/services/sandbox-species-observations---read/operations/59fb25717ec10608d0167c91?

GetSpeciesData <- function(taxon_ids) { 
  return(GetArtfaktaResults(ConstructQueryURL('', queryTerm='taxa', queryValue=taxon_ids))) 
}
GetAssessments <- function(taxon_ids) { 
  return(GetArtfaktaResults(ConstructQueryURL('assessments', queryTerm='taxa', queryValue=taxon_ids))) 
}
GetBiotopes <- function(taxon_ids) { 
  return(GetArtfaktaResults(ConstructQueryURL('biotopes', queryTerm='taxa', queryValue=taxon_ids))) 
}
GetLandscapeTypes <- function(taxon_ids) { 
  return(GetArtfaktaResults(ConstructQueryURL('landscapetypes', queryTerm='taxa', queryValue=taxon_ids))) 
}
GetNatureConservation <- function(taxon_ids) { 
  return(GetArtfaktaResults(ConstructQueryURL('natureconservation', queryTerm='taxa', queryValue=taxon_ids))) 
}
GetPeriods <- function() { 
  return(GetArtfaktaResults(ConstructQueryURL('periods'))) 
}
GetPeriodsCurrent <- function() { 
  return(GetArtfaktaResults(ConstructQueryURL('periods/current'))) 
}
GetRedlist <- function(taxon_ids, period_index=FALSE) {
  if(period_index) {
    url <- ConstructQueryURL('redlist', queryTerm='taxa', queryValue=taxon_ids, secondQueryTerm='period', secondQueryValue=period_index)
  } else {
    url <- ConstructQueryURL('redlist', queryTerm='taxa', queryValue=taxon_ids)
  }
  return(GetArtfaktaResults(url))
}
GetSearch <- function(taxon_ids_or_free_text) {
  return(GetArtfaktaResults(ConstructQueryURL('search', queryTerm='searchString', queryValue=taxon_ids_or_free_text)))
}
GetSubstrates <- function(taxon_ids) { 
  return(GetArtfaktaResults(ConstructQueryURL('substrates', queryTerm='taxa', queryValue=taxon_ids))) 
}
GetTaxonomy <- function(taxon_ids) { 
  return(GetArtfaktaResults(ConstructQueryURL('taxonomy', queryTerm='taxa', queryValue=taxon_ids))) 
}
GetTexts <- function(taxon_ids) { 
  return(GetArtfaktaResults(ConstructQueryURL('texts', queryTerm='taxa', queryValue=taxon_ids))) 
}

ConstructQueryURL <- function(resource, queryTerm='', queryValue='', secondQueryTerm='', secondQueryValue='') {
  baseURL <- "https://api.artdatabanken.se/information/v1/speciesdataservice/v1/speciesdata/"
  url <- paste0(baseURL, resource)
  if(queryTerm != '') {
    url <- paste0(url, '?', queryTerm, '=', URLencode(queryValue))
  }
  if(secondQueryTerm != '') {
    url <- paste0(url, '&', secondQueryTerm, '=', URLencode(secondQueryValue))
  }
  return(url)
}

GetArtfaktaResults <- function(url) {
  key <- key_get(service="ArtdataAPI", username="r.s.johaadien@nhm.uio.no")
  get <- GET(url=url, add_headers("Ocp-Apim-Subscription-Key"=key))
  return(.ConvertResultsToDataFrame(content(get, as="parsed")))
}

.ConvertResultsToDataFrame <- function(data) {
  names <- names(unlist(data[[1]]))
  DataMatrix <- matrix(unlist(data), ncol = length(names), byrow = T, dimnames = list(1:length(data), names))
  DF <- data.frame(DataMatrix, stringsAsFactors = FALSE)
  return(DF)
}

# Examples
ramaria <- GetSearch(taxon_ids_or_free_text = 'Ramaria')


