library(glue)
library(dplyr)
library(httr)
library(readr)
source("R/utils.R")

access_token <- read_lines("access_token.txt")[1]

#' @export
get_song <- function(song_id, access_token){
  r <- GET(glue("api.genius.com/songs/{song_id}"),
           add_headers("Accept" =  "application/json",
                       "Host" = "api.genius.com",
                       "Authorization" = glue("Bearer {access_token}")))
  song <- content(r, "parsed")

  res <- data.frame("id" = song_id,
                    "title" = get_field(song$response$song$title),
                    "artist" = get_field(song$response$song$album$artist$name),
                    "album" = get_field(song$response$song$album$name),
                    "date" = get_field(song$response$song$release_date),
                    "views" = get_field(song$response$song$stats$pageviews),
                    "contributors" = get_field(song$response$song$stats$contributors),
                    "transcribers" = get_field(song$response$song$stats$transcribers),
                    "concurrents" = get_field(song$response$song$stats$concurrents))

  return(res)
}


#' @export
search_song <- function(song_title, access_token, n_per_page = 20){
  r <- GET(glue("api.genius.com/search?q={song_title}&per_page={n_per_page}"),
           add_headers("Accept" =  "application/json",
                       "Host" = "api.genius.com",
                       "Authorization" = glue("Bearer {access_token}")))
  songs <- content(r, "parsed")

  res <- data.frame("song_id"=NULL,
                    "title"=NULL,
                    "artist_id"=NULL,
                    "artist"=NULL)

  ids <- lapply(songs$response$hits, function(x) x$result$id)

  for (id in ids) {
    res <- rbind(res, get_song(id))
  }
  return(res)
}


#' @export
get_song_from_artists <- function(artist_name, access_token, n_per_page = 20){
  r <- GET(glue("api.genius.com/search?q={artist_name}&per_page={n_per_page}"),
           add_headers("Accept" =  "application/json",
                       "Host" = "api.genius.com",
                       "Authorization" = glue("Bearer {access_token}")))
  songs <- content(r, "parsed")

  res <- data.frame("song_id"=NULL,
                    "title"=NULL,
                    "artist"=NULL)

  ids <- lapply(songs$response$hits, function(x) x$result$id)

  for (id in ids) {
    res <- rbind(res, get_song(id))
  }
  return(res)
}
