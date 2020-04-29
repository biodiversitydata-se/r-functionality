source("../R/artfaktura_get.R", chdir = TRUE)
library(testthat)

test_that("basic get functionality works", {
  ramaria <- GetArtfaktaResults('https://api.artdatabanken.se/information/v1/speciesdataservice/v1/speciesdata/search?searchString=Ramaria%20primulina')
  expected <- list('6039941', '', 'Ramaria primulina')
  names(expected) <- c('taxonId', 'swedishName', 'scientificName')
  expect_equal(str(ramaria), str(data.frame(expected)))
})

test_that("get functionality can returns 0 records", {
})

test_that("get functionality throws error if key invalid or nonexistent", {
})

test_that('url is constructed correctly with a query', {
  url = ConstructQueryURL('search', queryTerm='searchString', queryValue='Ramaria')
  expect_equal(url, 'https://api.artdatabanken.se/information/v1/speciesdataservice/v1/speciesdata/search?searchString=Ramaria')
})

test_that('url is constructed correctly with spaces in query', {
  url = ConstructQueryURL('search', queryTerm='searchString', queryValue='Ramaria primulina')
  expect_equal(url, 'https://api.artdatabanken.se/information/v1/speciesdataservice/v1/speciesdata/search?searchString=Ramaria%20primulina')
})

test_that('url is constructed correctly without a query', {
  expect_equal(ConstructQueryURL('search'), 'https://api.artdatabanken.se/information/v1/speciesdataservice/v1/speciesdata/search')
})

test_that('url is constructed correctly with two queries', {
  url = ConstructQueryURL(resource='redlist', queryTerm='taxa', queryValue='1001270', secondQueryTerm='period', secondQueryValue='100')
  expect_equal(url, 'https://api.artdatabanken.se/information/v1/speciesdataservice/v1/speciesdata/redlist?taxa=1001270&period=100')
})
