context("songs.R")

N <- 10

test_that(
  "get_song() returns a list", {
    expect_match(
      class(get_song(N, Sys.getenv("GENIUS_SECRET"))),
      "data.frame"
    )
})


test_that(
  "get_songs() output is the same length as song_ids", {
    song_ids <- seq(1, N)
    expected <- length(song_ids)
    actual <- length(get_songs(song_ids, Sys.getenv("GENIUS_SECRET")))
    expect_equal(actual, expected)
})


# ToDo: search_song()

name <- "elton"

test_that(
  "get_song_from_artists() output is a list", {
    expect_match(
      class(get_song_from_artists(name, Sys.getenv("GENIUS_SECRET"))),
      "data.frame"
    )
  })

