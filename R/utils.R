# Utils


#' URL Encoder.
#'
#' @description Encode a character string URI that has
#' declared marked encodings to a URL.
#'
#' @param string any string
#'
#' @return the input encoded as a URL.
#'
#' @keywords internal
#' @noRd
utf8_to_html <- function(string) {
    out <- stringi::stri_enc_toutf8(string) %>%
      urltools::url_encode() %>%
      toupper()
    return(out)
}


#' Field Object Check.
#'
#' @description Check that the input is not NULL.
#' If so, return NaN, otherwise return the input 'as is'.
#' In other words, this just converts NULLs to NaNs, otherwise
#' the input is returned unaltered.
#'
#' @param field the attribute from the yield of \code{.get_payload()}.
#'
#' @return NaN if the input is NULL, otherwise the input.
#'
#' @keywords internal
#' @noRd
get_field <- function(field) {
    if (is.null(field)){
      return(NaN)
    }
    return(field)
}


#' Get a data payload from the Genius API.
#'
#' @description get the contents of a request to the
#' genius API using a given url and access_token.
#'
#' @param url a formated request for the Genius API.
#'
#' @param access_token the user's (your) access token to the Genius API.
#' For more detail about how to get it, see section Details
#'
#' @return the cotents of the request.
#'
#' @keywords internal
#' @noRd
.get_payload <- function(url, access_token){
    r <- httr::GET(
      url,
      httr::add_headers(
        "Accept" = "application/json",
        "Host" = "api.genius.com",
        "Authorization" = glue::glue("Bearer {access_token}")
      )
    )
    out <- httr::content(r, "parsed")
    return(out)
}
