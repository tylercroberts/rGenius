context("songs.R")

N <- 10

test_that(
  "search_song() output is the specified length", {
    expected <- N
    actual <- length(search_song("Layla", Sys.getenv("GENIUS_SECRET"), 10))
    expect_equal(actual, expected)
  })
