get_song <- function(song_id){
  r <- GET(glue("api.genius.com/songs/{song_id}"), 
           add_headers("Accept" =  "application/json",
                       "Host" = "api.genius.com",
                       "Authorization" = glue("Bearer {access_token}")))
  song <- content(r, "parsed")
  
  get_field <- function(field) {
    if (is.null(field)) return(NaN)
    return(field)
  }
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
