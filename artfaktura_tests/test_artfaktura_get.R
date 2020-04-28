source("../R/artfaktura_get.R", chdir = TRUE)
library(testthat)

test_that("basic get functionality works", {
  url <- 'https://api.artdatabanken.se/information/v1/speciesdataservice/v1/speciesdata/search?searchString=Ramaria%20primulina'
  ramaria <- getArtfaktaResults(url)
  expected <- list(6039941, '', 'Ramaria primulina')
  names(expected) <- c('taxonId', 'swedishName', 'scientificName')
  expected <- list(expected)
  expect_equal(ramaria, expected)
})

test_that("get functionality throws error if invalid resource", {
})

test_that("get functionality throws error if key invalid or nonexistent", {
})

test_that('url is constructed correctly with a query', {
  url = constructQueryURL('search', queryTerm='searchString', queryValue='Ramaria')
  expect_equal(url, 'https://api.artdatabanken.se/information/v1/speciesdataservice/v1/speciesdata/search?searchString=Ramaria')
})

test_that('url is constructed correctly with spaces in query', {
  url = constructQueryURL('search', queryTerm='searchString', queryValue='Ramaria primulina')
})

test_that('url is constructed correctly without a query', {
})

test_that("dataframe conversion works", {
  taxonId = c(6039941)
  swedishName = c('')
  scientificName = c('Ramaria primulina')
  expected = data.frame(taxonId, swedishName, scientificName)
})