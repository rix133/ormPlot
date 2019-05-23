#READ THE TEST DATA
load("../testdata/test_model_001.rda")


test_that("object has the right class", {
  a<-summary(test_model_001)
  testthat::expect_s3_class(a,"summary.rms")
})
