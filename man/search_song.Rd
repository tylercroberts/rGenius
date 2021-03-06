% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/songs.R
\name{search_song}
\alias{search_song}
\title{Search and Harvest Results (more than one possible) for a Song Title.}
\usage{
search_song(song_title, access_token, n_per_page = 20, verbose = FALSE)
}
\arguments{
\item{song_title}{the title of a song (will be searched for)}

\item{access_token}{the user's (your) access token to the Genius API.
For more detail about how to get it, see section Details}

\item{n_per_page}{the maximum number of songs that shoud be fetch by the API.
Defaults to 20.}

\item{verbose}{If TRUE, then a progression bar of the execution of the
function is displayed on the console.}
}
\value{
A DataFrame. Columns:

\describe{
  \item{id}{the song's ID on the Genius API}
  \item{title}{the song's title}
  \item{artist}{the song's main artist}
  \item{featured_artists}{a list of other artists who contributed to the song, if any}
  \item{album}{the song's album}
  \item{date}{the song's released date}
  \item{views}{the number of views for this song on the Genius website}
  \item{contributors}{the number of contributors to the lyrics of this songs on the Genius website}
  \item{transcribers}{the number of transcribers to the lyrics of this songs on the Genius website}
  \item{concurrents}{the number of people looking at the page whenever the API was last updated}
}
}
\description{
Obtain information from the Genius API about an artist.
There can be several songs returned if the name appears in several
songs' title in the API.
}
\examples{
\dontrun{
library(rGenius)

## Search for the song Europa.
search_song("Europa", access_token=YOUR_TOKEN_GOES_HERE)
}

}
\seealso{
\code{\link{get_artist}}, \code{\link{get_song}}, \code{\link{get_songs}}, \code{\link{get_songs_from_artist}}
}
