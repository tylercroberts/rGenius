context("artist.R")

N <- 10

test_that(
  "get_artist() returns a list", {
    expect_match(
      class(get_artist(N, access_token=Sys.getenv("GENIUS_SECRET"))),
      "data.frame"
    )
})

