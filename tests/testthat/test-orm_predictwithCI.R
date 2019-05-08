#READ THE TEST DATA
test_model_001<-readRDS("../testdata/test_model_001.rds")

test_that("result is a data frame", {
  p <- orm.predictwithCI(test_model_001, cran_rzs, Rural, max_SEP_3, sex)
  expect_true(is.data.frame(p))
})
