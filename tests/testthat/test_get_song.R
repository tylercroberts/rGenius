library(dplyr)
library(glue)
library(httr)
library(rGenius)


test_that("get_song() returns a list", {
  expect_match(class(get_song(10, access_token)), "data.frame")
})

test_that("get_songs() output is the same length as song_ids"{
  song_ids = seq(1:10)
  expect_match(length(get_songs(song_ids, access_token)), length(song_ids))
})
