context("songs.R")

N <- 10
ARTIST_NAME <- "elton"


test_that(
  "get_song() returns a d", {
    get <- get_song(N, access_token=Sys.getenv("GENIUS_SECRET"))
    expect_match(class(get), "data.frame")
})


test_that(
  "get_songs() output is the same length as song_ids", {
    song_ids <- seq(1, N)
    expected <- length(song_ids)
    get <- get_songs(song_ids, access_token=Sys.getenv("GENIUS_SECRET"), verbose=FALSE)
    actual <- length(get)
    expect_equal(actual, expected)
})


test_that(
  "get_song_from_artists() output is a DataFrame", {
    get <- get_song_from_artists(
        ARTIST_NAME, access_token=Sys.getenv("GENIUS_SECRET"),
        n_per_page=1, verbose=FALSE
    )
    expect_match(class(get), "data.frame")
})
