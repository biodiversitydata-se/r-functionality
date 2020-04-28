library(httr)
library(keyring)

## https://api-portal.artdatabanken.se/
# Reference https://api-portal.artdatabanken.se/docs/services/sandbox-species-observations---read/operations/59fb25717ec10608d0167c91?

# Ocp-Apim-Subscription-Key: 
key<-key_get(service = "ArtdataAPI", username = "r.s.johaadien@nhm.uio.no")

###### GET artfakta
GETartfakta<-function(url="https://api.artdatabanken.se/information/v1/speciesdataservice/v1/speciesdata/", 
                      resource, 
                      query="", 
                      key){
  
  content(GET(url = paste0(url, resource, query),
              add_headers("Ocp-Apim-Subscription-Key" = key)#,
              #             "Authorization" = auth
              # )
  ), as = "parsed")
}

fakta2DF<-function(list){
  ### Check legths()
  ### lengths(list) if all lengths the same....
  data<-list
  names<-names(unlist(data[[1]]))
  DataMatrix<-matrix(unlist(data), ncol=length(names), byrow=T, dimnames = list(1:length(data), names))
  DF<-data.frame(DataMatrix, stringsAsFactors=FALSE)
  return(DF)
}

ramaria<-GETartfakta(resource = "search", query = "?searchString=Ramaria", key=key)
taxaRamaria<-fakta2DF(ramaria)

substRamaria<-GETartfakta(resource = "substrates", query=paste0("?taxa=",
                                                                paste0(taxaRamaria$taxonId, collapse = ",")),
                          key=key)

substRamaria[[1]]$speciesData
subst<-lapply(substRamaria, function(x)x$speciesData)
lengths(substRamaria)
lengths(subst)

