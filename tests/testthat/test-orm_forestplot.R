
#READ THE TEST DATA
test_data_001<-readRDS("../testdata/test_data_001.rds")

test_that("Plotting produces 2 ggplots",{
  p <- orm.forestplot(test_data_001, return_ggplots = TRUE)
  expect_true(ggplot2::is.ggplot(p[[1]]))
  expect_true(ggplot2::is.ggplot(p[[2]]))
  vdiffr::expect_doppelganger("forestplot_left",p[[1]])
  vdiffr::expect_doppelganger("forestplot_right",p[[2]])
})

test_that("Plotting returns a grob",{
  p <- orm.forestplot(test_data_001)
  expect_true(grid::is.grob(p))

})

test_that("Plotting returns an aligned forestplot",{
  p <- orm.forestplot(test_data_001)
  grid::grid.newpage()
  vdiffr::expect_doppelganger("forestplot_full",grid::grid.draw(p))

})
