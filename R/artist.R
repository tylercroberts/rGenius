# Artists

source("R/utils.R")


#' Get Artist Information
#'
#' @description This function returns information from the
#' Genius API about an artist, given this artist's ID on the API.
#'
#' @param artist_id an artist's ID on the Genius API
#'
#' @param access_token the user's (your) access token to the Genius API. For more detail about how to get it, see section Details
#'
#' @return a DataFrame of information about an Artist. Columns:
#'
#' \describe{
#'  \item{id}{the artist's ID on the Genius API}
#'  \item{alternate_name}{the artist's name}
#'  \item{facebook_name}{the artist's name on facebook, if provided on the API}
#'  \item{instagram_name}{the artist's name on instagram, if provided on the API}
#'  \item{twitter_name}{the artist's name on twitter, if provided on the API}
#'  \item{description}{a descriptioon of the artist}
#' }
#'
#' @examples
#' \dontrun{
#' library(rGenius)
#'
#' ## Get Carlos Santana's information
#' get_artist(8439, access_token=YOUR_TOKEN_GOES_HERE)
#'
#' }
#'
#' @seealso \code{\link{get_song}}, \code{\link{get_songs}}, \code{\link{search_song}}, \code{\link{get_songs_from_artist}}.
#'
#' @export
get_artist <- function(artist_id, access_token) {
    artist <- .get_payload(
      url=glue::glue("api.genius.com/artists/{artist_id}"),
      access_token=access_token
    )

    res <- data.frame(
      "id" = artist_id,
      "alternate_name" = get_field(artist$response$artist$alternate_names[[1]]),
      "facebook_name" = get_field(artist$response$artist$facebook_name),
      "instagram_name" = get_field(artist$response$artist$instagram_name),
      "twitter_name" = get_field(artist$response$artist$twitter_name),
      "description" = get_field(artist$response$artist$description$dom$children[[1]][[2]][[1]])
    )
    return(res)
}
