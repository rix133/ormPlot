##  Proto library for accessing sub-components of the ggplot2 plot objects
library(proto)

#READ THE TEST DATA
test_data_001<-readRDS("../testdata/test_data_001.rds")

test_that("Plotting actually works",{
  p <- orm.forestplot(test_data_001)
  #expect_true(ggplot2::is.ggplot(p))
  expect_error(print(p), NA)
})

test_that("Plotting returns a grob",{
  p <- orm.forestplot(test_data_001)
  expect_true(grid::is.grob(p))

})
