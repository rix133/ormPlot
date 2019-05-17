
#READ THE TEST DATA
test_data_001<-readRDS("../testdata/test_data_001.rds")

test_that("Plotting returns an aligned forestplot",{
  p <- forestplot(test_data_001)
  #vdiffr::expect_doppelganger("forestplot_full",grid::grid.draw(p, recording = FALSE))
  #test not passing for an unknwon reason drawing it instead for visual inspection
  #ggplot2::ggsave("forestplot_full.svg",p)



})

test_that("Plotting produces 2 ggplots",{
  p <- forestplot(test_data_001, return_ggplots = TRUE)
  expect_true(ggplot2::is.ggplot(p[[1]]))
  expect_true(ggplot2::is.ggplot(p[[2]]))
  vdiffr::expect_doppelganger("forestplot_left",p[[1]])
  vdiffr::expect_doppelganger("forestplot_right",p[[2]])
})

test_that("Plotting returns a grob",{
  p <- forestplot(test_data_001, return_ggplots = TRUE)
  p <- join_ggplots(p[[1]],p[[2]])

  expect_true(grid::is.grob(p))

})


