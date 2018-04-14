\name{get_artist}
\alias{get_artist}
\title{Get Artist Information}
\description{
This function returns information from the Genius API about an artist, given tthis artist's ID on the API.
}
\usage{get_artist(artist_id, access_token)}

\arguments{
\item{artist_id}{an artist's ID on the Genius API,}
\item{access_token}{the user's (your) access token to the Genius API. For more detail about how to get it, see section Details}
}

\value{
A data frame containing:
\item{id}{the artist's ID on the Genius API,}
\item{alternate_name}{the artist's name,}
\item{facebook_name}{the artist's name on facebook, if provided on the API,}
\item{instagram_name}{the artist's name on instagram, if provided on the API,}
\item{twitter_name}{the artist's name on twitter, if provided on the API,}
\item{description}{a descriptioon of the artist.}
}

\details{
To get an access token to the Genius API, go to this link: https://genius.com/api-clients/new, and fill out the form. You only need to name your app and give an app website. The app website can be https://example.com. After saving, you can get the access token by clicking on "Generate Access Token". Save the string in a .txt file named `access_token.txt` in your script's folder.   

You can then read your access token in a variable.
}
\seealso{\code{\link{get_song}}, \code{\link{get_songs}}, \code{\link{search_song}}, \code{\link{get_songs_from_artist}}}
\examples{
library(rGenius)

## Read your access token to the API
access_token <- read_lines("access_token.txt")[1]

## Get Carlos Santana's information
get_artist(8439, access_token)
}