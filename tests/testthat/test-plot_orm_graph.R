#READ THE TEST DATA
test_data_001 <- readRDS("../testdata/test_data_001.rds")

test_that("returns a ggplot object", {
  p <- orm_graph(test_data_001)
  expect_true(ggplot2::is.ggplot(p))
})

test_that("new row names are correctly alligned", {
  p <- orm_graph(test_data_001[1:4,], row.names.y = c("sons",
                                                     "odds 1",
                                                     "head",
                                                     "odds 2"))
  expect_true(ggplot2::is.ggplot(p))
  vdiffr::expect_doppelganger("orm_graph_4",p)
})

test_that("aborts when new row names are not the same length", {
  expect_error(orm_graph(test_data_001, row.names.y = c("A","B")),
               "The provided variable names are not covering all options:*")
})


