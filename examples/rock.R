## Packages
library(rGenius)
library(tidyverse)

## Set the access token
access_token <- read_lines("access_token.txt")[1]

## Select some rock artists
artists <- c("AC/DC", "The Beattles", "Bob Dylan", "Chuck Berry", "The Clash", "Coldplay", "David Bowie", "Elton John", "Elvis Presley", "Eric Clapton", "Jimi Hendrix", "Kiss", "Led Zeppelin", "Phil Collins", "Pink Floyd", "The Rolling Stones")

## Get most famous songs from rock artists
rock_songs <- data.frame("song_id"=NULL,
                         "title"=NULL,
                         "artist"=NULL)
for (artist in utf8_to_html(artists)) {
  print(artist)
  rock_songs <- rbind(rock_songs, get_song_from_artists(artist, access_token))
}

## Filter the data
rock_songs <- rock_songs %>% 
  filter(views > 5000, artist %in% artists)

## Find the best relationship using Box-Cox and lm
MASS::boxcox(contributors ~ views, data = rock_songs)
summary(lm(contributors ~ log(views), data = rock_songs))
summary(lm(contributors ~ sqrt(views) - 1, data = rock_songs))

## Scatter plot of the data
ggplot(rock_songs, aes(views, contributors)) +
  geom_point() +
  geom_smooth(method = "lm", colour = "red") +
  scale_x_sqrt("Number of Views (sqrt scale)") + 
  ylab("Number of contributors to the lyrics") + 
  ggtitle("Number of contributors by number of views") + 
  theme_light()

ggsave("../img/rock.png")
