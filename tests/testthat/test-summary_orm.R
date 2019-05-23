#READ THE TEST DATA
test_model_001<-readRDS("../testdata/test_model_001.rds")


test_that("object has the right class", {
  a<-summary(test_model_001)
  testthat::expect_s3_class(a,"summary.rms")
})
