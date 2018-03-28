library(dplyr)
library(glue)
library(httr)
library(rGenius)


test_that("utf8_to_html() returns the correct string", {
  expect_match(utf8_to_html("éèàÀ"), "%C3%A9%C3%A8%C3%A0%C3%80")
})
