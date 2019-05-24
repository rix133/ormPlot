load("../testdata/test_model_001.rda")
load("../testdata/test_model_002.rda")

test_that("result is a data frame", {
  p <- orm.predict_with_ci(test_model_001, cran_rzs, Rural, max_SEP_3, sex)
  expect_true(is.data.frame(p))
  p <- orm.predict_with_ci(test_model_002, cran_rzs, Rural, sex)
  expect_true(is.data.frame(p))
})

test_that("result has expected prediction data in it", {
  n = 10
  df <- orm.predict_with_ci(test_model_001, cran_rzs, Rural, max_SEP_3, sex, np = n)

  ocran_pred_frame<-rms::Predict(test_model_001, cran_rzs, Rural, max_SEP_3, sex, type = "model.frame",np=n)

  #generate the probabilties for each level of education using a built in function that deos not give CI's
  df_fitted<-rms:::predict.orm(test_model_001,ocran_pred_frame, type="fitted.ind")


  for(i in 1:length(df_fitted)){
    expect_equal(0, (df$Propability[i]-df_fitted[i]), tolerance = 0.00000001)
  }

})

test_that("result has expected column names", {
  p <- orm.predict_with_ci(test_model_001, cran_rzs, Rural, sex)
  pcols<- colnames(p[(ncol(p)-3):ncol(p)])
  expcols<-c("Propability","lower","upper","dependent")
  expect_equal(pcols, expcols)

  p <- orm.predict_with_ci(test_model_002, cran_rzs, Rural, sex)
  pcols<- colnames(p[(ncol(p)-3):ncol(p)])
  expect_equal(pcols, expcols)

})
