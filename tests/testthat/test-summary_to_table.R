
#READ THE TEST DATA
test_data_001<-readRDS("../testdata/test_data_001.rds")

test_that("html table is produced using html type", {
  table<-orm.oddstable(test_data_001,type = "html")
  expect_s3_class(table,c('html','character'))

})

test_that("matrix is produced witho plain type",{
  expect_that(orm.oddstable(test_data_001,type = "plain"), is_a("matrix"))

})

test_that("matrix has the correct number of rows",{
  expect_that(nrow(orm.oddstable(test_data_001)), equals(9))

})
