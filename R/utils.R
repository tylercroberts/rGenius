utf8_to_html <- function(string){
  #'
  #'
  #'
  #'
  out <- stri_enc_toutf8(string) %>%
    url_encode() %>%
    toupper()

  return(out)
}


#' @keywords internal
get_field <- function(field) {
  if (is.null(field)) return(NaN)
  return(field)
}
