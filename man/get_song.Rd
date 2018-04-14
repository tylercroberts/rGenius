\name{get_song}
\alias{get_songs}
\title{Get Song Information}
\description{
This function returns information from the Genius API about one or several songs, given these songs' IDs on the API.
}
\usage{
get_song(song_id, access_token)
get_songs(song_ids, access_token, verbose=TRUE)
}
\arguments{
\item{song_id}{a song's ID on the Genius API.}
\item{song_ids}{a list of songs' IDs on the Genius API.}
\item{access_token}{the user's (your) access token to the Genius API. For more detail about how to get it, see section Details.}
\item{verbose}{If TRUE, then a progression bar of the execution of the function is displayed on the console. Default is TRUE.}
}

\value{
A data frame containing:
\item{id}{the song's ID on the Genius API,}
\item{title}{the song's title,}
\item{artist}{the song's main artist,}
\item{featured_artists}{a list of other artists who contributed to the song, if any.}
\item{album}{the song's album,}
\item{date}{the song's released date,}
\item{views}{the number of views for this song on the Genius website,}
\item{contributors}{the number of contibutors to the lyrics of this songs on the Genius website,}
\item{transcribers}{the number of transcribers to the lyrics of this songs on the Genius website,}
\item{concurrents}{the number of people looking at the page whenever the API was last updated.}
}

\details{
To get an access token to the Genius API, go to this link: https://genius.com/api-clients/new, and fill out the form. You only need to name your app and give an app website. The app website can be https://example.com. After saving, you can get the access token by clicking on "Generate Access Token". Save the string in a .txt file named `access_token.txt` in your script's folder.   

You can then read your access token in a variable.
}
\seealso{\code{\link{get_artist}}, \code{\link{search_song}}, \code{\link{get_songs_from_artist}}}
\examples{
library(rGenius)

## Read your access token to the API
access_token <- read_lines("access_token.txt")[1]

get_song(8439, access_token)
get_songs(c(3846, 9869, 2273), access_token)
}