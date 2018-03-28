source("R/utils.R")

#' @export
get_artist <- function(artist_id){
  r <- GET(glue("api.genius.com/artists/{artist_id}"),
           add_headers("Accept" = "application/json", "Host" = "api.genius.com",
                       "Authorization" = glue("Bearer {access_token}")))
  artist <- content(r, "parsed")

  res <- data.frame("id" = artist_id,
                    "alternate_name" = get_field(artist$response$artist$alternate_names[[1]]),
                    "facebook_name" = get_field(artist$response$artist$facebook_name),
                    "instagram_name" = get_field(artist$response$artist$instagram_name),
                    "twitter_name" = get_field(artist$response$artist$twitter_name),
                    "description" = get_field(artist$response$artist$description$dom$children[[1]][[2]][[1]])
  )
  return(res)
}
