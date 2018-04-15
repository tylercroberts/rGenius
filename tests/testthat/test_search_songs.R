context("songs.R")

N <- 5

test_that(
  "search_song() output is the specified length", {
    expected <- N
    get <- search_song("Layla", access_token=Sys.getenv("GENIUS_SECRET"), n_per_page=5)
    actual <- nrow(get)
    expect_equal(actual, expected)
})
