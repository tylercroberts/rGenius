context("songs.R")


source("../../api_key.R")

N <- 10


test_that(
  "get_song() returns a list", {
    expect_match(
      class(get_song(N, access_token)),
      "data.frame"
    )
})


test_that(
  "get_songs() output is the same length as song_ids", {
    song_ids <- seq(1, N)
    expected <- length(song_ids)
    actual <- length(get_songs(song_ids, access_token))
    expect_equal(actual, expected)
})


# ToDo: search_song()
