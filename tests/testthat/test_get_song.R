library(dplyr)
library(glue)
library(httr)
library(rGenius)


test_that("get_song() returns a list", {
  expect_match(class(get_song(10)), "data.frame")
})
