# Utils

#' @keywords internal
utf8_to_html <- function(string) {
  #' Encode a URI `string` that has
  #' declared marked encodings to UTF-8.
  #'
  #' @param string : a string
  #'
  #' @return : `out`: `string` encoded.
  #'
  out <- stri_enc_toutf8(string) %>%
    url_encode() %>%
    toupper()
  return(out)
}


#' @keywords internal
get_field <- function(field) {
  #' Check that `field` is not None,
  #' otherwise return `field`
  #'
  #' @param field : character string
  #'
  #' @return : field or NaN if `Field` is `NULL`.
  #'
  if (is.null(field)){
    return(NaN)
  }
  return(field)
}

#' @keywords internal
.get_payload <- function(url){
    #' Get Payload from the Genius API.
    #'
    #' @param url : API URL for Genius.
    #'
    r <- GET(
      url,
      add_headers(
        "Accept" = "application/json",
        "Host" = "api.genius.com",
        "Authorization" = glue("Bearer {access_token}")
      )
    )
    out <- content(r, "parsed")
    return(out)
}
