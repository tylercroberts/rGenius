# Songs

source("R/utils.R")


#' @export
get_song <- function(song_id, access_token) {
    #' Get songs.
    #'
    #' @param song_id :
    #' @param access_token :
    #'
    song <- .get_payload(
      url=glue("api.genius.com/songs/{song_id}")
    )

    res <- data.frame(
      "id" = song_id,
      "title" = get_field(song$response$song$title),
      "artist" = get_field(song$response$song$album$artist$name),
      "featured_artists" = I(
        list(
          get_field(
            lapply(song$response$song$featured_artists,
               function(x) {return(x$name[1])})
            )
          )
      ),
      # Black magic to add the list in as a
      # single column properly. I() treats the object "as-is".
      "album" = get_field(song$response$song$album$name),
      "date" = get_field(song$response$song$release_date),
      "views" = get_field(song$response$song$stats$pageviews),
      "contributors" = get_field(song$response$song$stats$contributors),
      "transcribers" = get_field(song$response$song$stats$transcribers),
      "concurrents" = get_field(song$response$song$stats$concurrents)
    )
    return(res)
}


.fetch_engine <- function(res, itera, access_token, verbose){
    #' Wrap `get_song()` to automate song harvesting.
    #'
    #' @param res :
    #' @param itera :
    #' @param access_token :
    #' @param verbose :
    #'
    if (verbose){
        pb <- txtProgressBar(min = 0, max = length(itera), initial = 0)
    }
    c <- 1
    for (i in itera) {
        res <- rbind(res, get_song(i, access_token))
        if (verbose){
            setTxtProgressBar(pb, c)
            c <- c + 1
        }
    }
    return(res)
}


#' @export
get_songs <- function(song_ids, access_token, verbose=TRUE) {
    #' Get songs.
    #'
    #' @param song_ids
    #' @param access_token
    #' @param verbose
    #'
    # Expected columns: id, title, artist, featured_artists
    # album, date, views, contributors, transcribers, concurrents.
    res <- .fetch_engine(
        res=data.frame(), itera=song_ids,
        access_token=access_token, verbose=verbose
    )
    return(res)
}


#' @keywords internal
.extract_ids <- function(songs){
    #' Harvest song ids from the yeild of
    #' `content(r, "parsed")`, where R is a GET response.
    ids <- lapply(songs$response$hits, function(x) x$result$id)
    return(ids)
}


#' @keywords internal
.song_get <- function(url, access_token, verbose){
    #'
    #'
    #' @param url :
    #' @param access_token :
    #' @param verbose :
    #'
    songs <- .get_payload(url=url)
    # Expected columns: song_id, title, artist_id, artist.
    res <- .fetch_engine(
        res=data.frame(), itera=.extract_ids(songs),
        access_token=access_token, verbose=verbose
    )
    return(res)
}


#' @export
search_song <- function(song_title, access_token,
                        n_per_page=20, verbose=FALSE) {
    #' Search for a song (`song_title`).
    #'
    #' @param song_title :
    #' @param access_token :
    #' @param n_per_page :
    #' @param verbose :
    #'
    # Expected columns: song_id, title, artist_id, artist.
    res <- .song_get(
        url=glue("api.genius.com/search?q={song_title}&per_page={n_per_page}"),
        access_token=access_token,
        verbose=verbose
    )
    return(res)
}


#' @export
get_song_from_artists <- function(artist_name,
                                  access_token,
                                  n_per_page=20,
                                  verbose=FALSE) {
    #' Get songs for an individual Artist.
    #'
    #' @param artist_name :
    #' @param access_token :
    #' @param n_per_page :
    #' @param verbose :
    #'
    res <- .song_get(
        url=glue("api.genius.com/search?q={artist_name}&per_page={n_per_page}"),
        access_token=access_token,
        verbose=verbose
    )
    return(res)
}
