context("artist.R")

N <- 10

test_that(
  "get_artist() returns a list", {
    expect_match(
      class(get_artist(N, Sys.getenv("GENIUS_SECRET"))),
      "data.frame"
    )
})

