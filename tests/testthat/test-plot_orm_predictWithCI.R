
#READ THE TEST DATA
test_model_001<-readRDS("../testdata/test_model_001.rds")

test_that("returns a ggplot object", {
  p <- plot.orm.predictwithCI(test_model_001,cran_rzs, Rural)
  expect_true(ggplot2::is.ggplot(p))
})

test_that("plotting test data generates the expected image", {
  p <- plot.orm.predictwithCI(test_model_001, cran_rzs, max_SEP_3,  Rural, sex)
  vdiffr::expect_doppelganger("prediction_ggplot_article", p)
})

test_that("plotting test data changes element names and order", {
  p <- plot.orm.predictwithCI(test_model_001, cran_rzs, Rural, max_SEP_3, sex,
                      plot_cols = c("max_SEP_3"),
                      plot_rows = c("Rural", "sex"),
                      xlab = "Cranial volume (residuals to age an birth date)",
                      facet_lables = list(Rural = c("Urban", "Rural"),
                                          sex=c("Boys","Girls"),
                                          max_SEP_3=c("Unskilled manual",
                                                      "Skilled manual",
                                                      "Non-manual"))
  )
  vdiffr::expect_doppelganger("prediction_ggplot_article_edited", p)
})
