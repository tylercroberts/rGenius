context("artist.R")

test_that(
  "get_artist() returns a list", {
    expect_match(
      class(get_artist(1, access_token=Sys.getenv("GENIUS_SECRET"))),
      "data.frame"
    )
})

