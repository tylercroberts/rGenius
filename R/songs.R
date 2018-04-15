# Songs

source("R/utils.R")


#' Get songs.
#'
#' @description This function returns information from the Genius API
#' about a single song.
#'
#' @param song_id a song's ID on the Genius API
#'
#' @param access_token the user's (your) access token to the Genius API.
#' For more detail about how to get it, see section Details
#'
#' @return A DataFrame with information about a song. Columns:
#'
#' \describe{
#'   \item{id}{the song's ID on the Genius API}
#'   \item{title}{the song's title}
#'   \item{artist}{the song's main artist}
#'   \item{featured_artists}{a list of other artists who contributed to the song, if any}
#'   \item{album}{the song's album}
#'   \item{date}{the song's released date}
#'   \item{views}{the number of views for this song on the Genius website}
#'   \item{contributors}{the number of contibutors to the lyrics of this songs on the Genius website}
#'   \item{transcribers}{the number of transcribers to the lyrics of this songs on the Genius website}
#'   \item{concurrents}{the number of people looking at the page whenever the API was last updated}
#' }
#'
#'
#' @examples
#' \dontrun{
#' library(rGenius)
#'
#' ## A Single song IDs:
#' get_song(8439, access_token=YOUR_TOKEN_GOES_HERE)
#' }
#'
#' @seealso \code{\link{get_artist}}, \code{\link{search_song}}, \code{\link{get_songs_from_artist}}
#'
#' @export
get_song <- function(song_id, access_token) {
    song <- .get_payload(
      url=glue::glue("api.genius.com/songs/{song_id}"),
      access_token=access_token
    )

    res <- data.frame(
      "id" = song_id,
      "title" = get_field(song$response$song$title),
      "artist" = get_field(song$response$song$album$artist$name),
      # Black magic to add the list in as a
      # single column properly. `I()` treats the object 'as-is'.
      "featured_artists" = I(
        list(
          get_field(
            lapply(song$response$song$featured_artists,
               function(x) {return(x$name[1])})
            )
          )
      ),
      "album" = get_field(song$response$song$album$name),
      "date" = get_field(song$response$song$release_date),
      "views" = get_field(song$response$song$stats$pageviews),
      "contributors" = get_field(song$response$song$stats$contributors),
      "transcribers" = get_field(song$response$song$stats$transcribers),
      "concurrents" = get_field(song$response$song$stats$concurrents)
    )
    return(res)
}

#' Bulk Song Harvesting engine.
#'
#' @description Wrap \code{get_song()} to automate song harvesting. Internal
#' Function.
#'
#' @param res a res (result) DataFrame. Can be empty (i.e., will be populated here).
#'
#' @param itera song ids to iterate over and harvest
#'
#' @param access_token the user's (your) access token to the Genius API.
#' For more detail about how to get it, see section Details
#'
#' @param verbose If TRUE, then a progression bar of the execution of the
#' function is displayed on the console.
#'
#' @return a DataFrame populated with the output of \code{get_song()}
#' for all songs in itera.
#'
#' @keywords internal
#' @noRd
.fetch_engine <- function(res, itera, access_token, verbose){
    if (verbose){
        pb <- utils::txtProgressBar(min=0, max=length(itera), initial=0)
    }
    c <- 1
    for (i in itera) {
        res <- rbind(res, get_song(song_id=i, access_token=access_token))
        if (verbose){
            utils::setTxtProgressBar(pb, c)
            c <- c + 1
        }
    }
    return(res)
}


#' Get multiple songs.
#'
#' @description harvest information on multiple songs.
#'
#' @param res a res (result) DataFrame. Can be empty (i.e., will be populated here).
#'
#' @param itera song ids to iterate over and harvest
#'
#' @param access_token the user's (your) access token to the Genius API.
#' For more detail about how to get it, see section Details
#'
#' @param verbose If TRUE, then a progression bar of the execution of the
#' function is displayed on the console.
#'
#' @return a DataFrame populated with the output of \code{get_song()}
#' for all songs in song_ids. Columns:
#'
#' \describe{
#'   \item{id}{the song's ID on the Genius API}
#'   \item{title}{the song's title}
#'   \item{artist}{the song's main artist}
#'   \item{featured_artists}{a list of other artists who contributed to the song, if any}
#'   \item{album}{the song's album}
#'   \item{date}{the song's released date}
#'   \item{views}{the number of views for this song on the Genius website}
#'   \item{contributors}{the number of contibutors to the lyrics of this songs on the Genius website}
#'   \item{transcribers}{the number of transcribers to the lyrics of this songs on the Genius website}
#'   \item{concurrents}{the number of people looking at the page whenever the API was last updated}
#' }
#'
#' @examples
#' \dontrun{
#' library(rGenius)
#'
#' ## Multiple song IDs:
#' get_songs(c(3846, 9869, 2273), access_token=YOUR_TOKEN_GOES_HERE)
#' }
#'
#' @export
get_songs <- function(song_ids, access_token, verbose=TRUE) {
    # Expected columns: id, title, artist, featured_artists
    # album, date, views, contributors, transcribers, concurrents.
    res <- .fetch_engine(
        res=data.frame(), itera=song_ids,
        access_token=access_token, verbose=verbose
    )
    return(res)
}


#' Get results from the API for a given URL.
#'
#' @description Get results from the API for some
#' query (search?q=) URL. Internal Function.
#'
#' @param url an 'api.genius.com' url
#'
#' @param access_token the user's (your) access token to the Genius API.
#' For more detail about how to get it, see section Details
#'
#' @param verbose If TRUE, then a progression bar of the execution of the
#' function is displayed on the console.
#'
#' @return A DataFrame. Columns:
#'
#' \describe{
#'   \item{id}{the song's ID on the Genius API}
#'   \item{title}{the song's title}
#'   \item{artist}{the song's main artist}
#'   \item{featured_artists}{a list of other artists who contributed to the song, if any}
#'   \item{album}{the song's album}
#'   \item{date}{the song's released date}
#'   \item{views}{the number of views for this song on the Genius website}
#'   \item{contributors}{the number of contibutors to the lyrics of this songs on the Genius website}
#'   \item{transcribers}{the number of transcribers to the lyrics of this songs on the Genius website}
#'   \item{concurrents}{the number of people looking at the page whenever the API was last updated}
#' }
#'
#' @keywords internal
#' @noRd
.song_url_get <- function(url, access_token, verbose){
    # Get the query results form Genius' servers.
    songs <- .get_payload(url=url, access_token=access_token)
    # Harvest song ids from `song`.
    ids <- lapply(songs$response$hits, function(x) x$result$id)
    # Fetch information about those song ids.
    res <- .fetch_engine(
        res=data.frame(), itera=ids,
        access_token=access_token, verbose=verbose
    )
    return(res)
}


#' Search and Harvest Results (more than one possible) for a Song Title.
#'
#' @description Obtain information from the Genius API about an artist.
#' There can be several songs returned if the name appears in several
#' songs' title in the API.
#'
#' @param song_title the title of a song (will be searched for)
#'
#' @param access_token the user's (your) access token to the Genius API.
#' For more detail about how to get it, see section Details
#'
#' @param n_per_page the maximum number of songs that shoud be fetch by the API.
#' Defaults to 20.
#'
#' @param verbose If TRUE, then a progression bar of the execution of the
#' function is displayed on the console.
#'
#' @return A DataFrame. Columns:
#'
#' \describe{
#'   \item{id}{the song's ID on the Genius API}
#'   \item{title}{the song's title}
#'   \item{artist}{the song's main artist}
#'   \item{featured_artists}{a list of other artists who contributed to the song, if any}
#'   \item{album}{the song's album}
#'   \item{date}{the song's released date}
#'   \item{views}{the number of views for this song on the Genius website}
#'   \item{contributors}{the number of contibutors to the lyrics of this songs on the Genius website}
#'   \item{transcribers}{the number of transcribers to the lyrics of this songs on the Genius website}
#'   \item{concurrents}{the number of people looking at the page whenever the API was last updated}
#' }
#'
#' @examples
#' \dontrun{
#' library(rGenius)
#'
#' ## Search for the song Europa.
#' search_song("Europa", access_token=YOUR_TOKEN_GOES_HERE)
#' }
#'
#' @seealso \code{\link{get_artist}}, \code{\link{get_song}}, \code{\link{get_songs}}, \code{\link{get_songs_from_artist}}
#'
#' @export
search_song <- function(song_title, access_token,
                        n_per_page=20, verbose=FALSE) {
    res <- .song_url_get(
        url=glue::glue("api.genius.com/search?q={song_title}&per_page={n_per_page}"),
        access_token=access_token,
        verbose=verbose
    )
    return(res)
}


#' Get Songs for an Artist.
#'
#' @description This function returns information from the Genius API
#' about the top songs from an artist, given this artist name.
#'
#' @param artist_name the name of an artist (will be searched for)
#'
#' @param access_token the user's (your) access token to the Genius API.
#' For more detail about how to get it, see section Details
#'
#' @param n_per_page the maximum number of songs that shoud be fetch by the API.
#' Defaults to 20.
#'
#' @param verbose If TRUE, then a progression bar of the execution of the
#' function is displayed on the console.
#'
#' @return A DataFrame. Columns:
#'
#' \describe{
#'   \item{id}{the song's ID on the Genius API}
#'   \item{title}{the song's title}
#'   \item{artist}{the song's main artist}
#'   \item{featured_artists}{a list of other artists who contributed to the song, if any}
#'   \item{album}{the song's album}
#'   \item{date}{the song's released date}
#'   \item{views}{the number of views for this song on the Genius website}
#'   \item{contributors}{the number of contibutors to the lyrics of this songs on the Genius website}
#'   \item{transcribers}{the number of transcribers to the lyrics of this songs on the Genius website}
#'   \item{concurrents}{the number of people looking at the page whenever the API was last updated}
#' }
#'
#' @examples
#' \dontrun{
#' library(rGenius)
#'
#' ## Look up the band Metallica:
#' get_songs_from_artist("Metallica", access_token=YOUR_TOKEN_GOES_HERE)
#' }
#'
#' @seealso \code{\link{get_artist}}, \code{\link{search_song}}, \code{\link{get_song}}, \code{\link{get_songs}}
#'
#' @export
get_song_from_artists <- function(artist_name, access_token,
                                  n_per_page=20, verbose=FALSE){
    res <- .song_url_get(
        url=glue::glue("api.genius.com/search?q={artist_name}&per_page={n_per_page}"),
        access_token=access_token,
        verbose=verbose
    )
    return(res)
}
