
#READ THE TEST DATA
test_data_001<-readRDS("../testdata/test_data_001.rds")


test_that("table plotting works", {
  p <- plot.oddstable(test_data_001)
  expect_true(ggplot2::is.ggplot(p))
  expect_error(print(p), NA)
})
