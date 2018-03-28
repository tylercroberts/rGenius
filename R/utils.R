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