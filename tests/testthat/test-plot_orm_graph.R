#READ THE TEST DATA
test_data_001 <- readRDS("../testdata/test_data_001.rds")

test_that("returns a ggplot object", {
  p <- plot.orm.graph(test_data_001)
  expect_true(ggplot2::is.ggplot(p))
})
