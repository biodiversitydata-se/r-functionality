context("Test occurrence_details function")

is_empty_list=function(z) is.list(z) && length(z)<1

thischeck=function(){
    test_that("empty list returned for null inputs", {
        skip_on_cran()
        ## null (empty string) input
        empty_result=occurrence_details("")
        expect_is(empty_result,"list")
        expect_equal(length(empty_result),1)
        expect_true(is_empty_list(empty_result[[1]]))
        ## one null and one invalid input
        ## skipped 4-May-2017: servers now throw 500 errors for invalid IDs
        ##empty_result=occurrence_details(c("","invalid-id"))
        ##expect_is(empty_result,"list")
        ##expect_equal(length(empty_result),2)
        ##expect_true(is_empty_list(empty_result[[1]]))
        ##expect_true(is_empty_list(empty_result[[2]]))
        ## one valid, one null, one invalid input
        ##mixed_result=occurrence_details(c("ba9dfe7f-77f8-4486-b77e-3ae366d3c2ae","","invalid-id"))
        ##expect_is(mixed_result,"list")
        ##expect_equal(length(mixed_result),3)        
        ##expect_false(is_empty_list(mixed_result[[1]]))
        ##expect_true(is_empty_list(mixed_result[[2]]))
        ##expect_true(is_empty_list(mixed_result[[3]]))
        mixed_result=occurrence_details(c("4fce3968-c4b0-4083-8896-78d8f213d517",""))
        expect_is(mixed_result,"list")
        expect_equal(length(mixed_result),2)        
        expect_false(is_empty_list(mixed_result[[1]]))
        expect_true(is_empty_list(mixed_result[[2]]))
    })
}
check_caching(thischeck)

thischeck=function() {
    test_that("occurrence_details result has the expected fields", {
        skip_on_cran()
        ## names are a bit changeable, but expect to see at least "processed", "raw", "userAssertions", "systemAssertions", "consensus"
        core_names=c("processed","raw","userAssertions","systemAssertions","consensus")
        ## no images
        result=occurrence_details("4fce3968-c4b0-4083-8896-78d8f213d517")
        expect_true(all(core_names %in% names(result[[1]])))
        expect_false("images" %in% names(result[[1]]))
        skip("need to find record with image")
        ## this one has images, so also images in the names
        expect_true(all(c("images",core_names) %in% names(occurrence_details("4fce3968-c4b0-4083-8896-78d8f213d517")[[1]])))
    })
}
check_caching(thischeck)

thischeck = function() {
  test_that("occurrence_details arguments in NBN4R package match arguments in ALA4R package", {
    expect_named(formals(occurrence_details),names(formals(ALA4R::occurrence_details)),ignore.order = TRUE)
  })
}
check_caching(thischeck)
