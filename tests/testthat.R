library(testthat)
library(NBN4R)

## run each test with and without caching
check_caching=function(f) {
    nbn_config(caching="off")
    f()
    nbn_config(caching="on")
    f()
    f()
}

test_check("NBN4R",reporter="summary")
