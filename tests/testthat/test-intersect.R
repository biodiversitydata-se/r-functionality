context("Test intersection of points with environmental values")

## intersect_points
thischeck <- function() {
    test_that("intersect_points gives errors or warning for invalid field names", {
        skip_on_cran()
        layers <- c('clxx')
        pnts <- c(51.5074,0.1278)
        expect_warning(expect_error(intersect_points(pnts,layers))) ## gives both warning and error
        layers <- c('clxx','clzz')
        expect_warning(expect_error(intersect_points(pnts,layers))) ## gives both warning and error
        layers <- c('clxx','cl23')
        expect_warning(intersect_points(pnts,layers)) ## just a warning
    })
}
check_caching(thischeck)

thischeck <- function() {
    test_that("intersect_points gives some correct known answers", {
        skip_on_cran()
        temp <- intersect_points(pnts=data.frame(lat=c(51.5074,52.5074),lon=c(0.1278,0.1278)),layers="cl14")
        expect_true(all(temp$watsonianViceCounties==c("West Kent","Cambridgeshire")))
    })
}
check_caching(thischeck)

thischeck <- function() {
    test_that("intersect_points gives same answers for single-location and batch methods", {
        skip_on_cran()
        layers <- c('cl23','cl14')
        pnts <- c(51.5074,0.1278)
        out1<-intersect_points(pnts,layers)
        expect_that(out1$watsonianViceCounties,is_a("character")) 
        pnts <- c(51.5074,0.1278,52.5074,0.1278)
        out2 <- intersect_points(pnts,layers)
        expect_equal(out1,out2[1,])
    })
}
check_caching(thischeck)

thischeck <- function() {
    test_that("intersect_points works for largeish number of points", {
        skip_on_cran()
        layers <- c('cl23','cl14')
        pnts <- cbind(lat = runif(1000, 51, 56), long = runif(1000, -4, 0))
        out1 <- intersect_points(pnts,layers)
        expect_that(out1$watsonianViceCounties,is_a("character")) 
    })
}
check_caching(thischeck)

thischeck = function() {
  test_that("intersect_points arguments in SBDI4R package match arguments in ALA4R package", {
    expect_named(formals(intersect_points),names(formals(ALA4R::intersect_points)),ignore.order = TRUE)
  })
}
check_caching(thischeck)

