## Packages
library(rGenius)
library(tidyverse)


## Set the access token
access_token <- read_lines("access_token.txt")[1]


## Select some rock artists
artists <- c(
    "AC/DC", "The Beattles", "Bob Dylan",
    "Chuck Berry", "The Clash", "Coldplay",
    "David Bowie", "Elton John", "Elvis Presley",
    "Eric Clapton", "Jimi Hendrix", "Kiss", "Led Zeppelin",
    "Phil Collins", "Pink Floyd", "The Rolling Stones"
)


## Get most famous songs from rock artists
rock_songs <- data.frame("song_id"=NULL, "title"=NULL, "artist"=NULL)
for (artist in utf8_to_html(artists)) {
    print(artist)
    rock_songs <- rbind(
        rock_songs,
        get_song_from_artists(artist, access_token=access_token)
    )
}


## Filter the data
rock_songs <- rock_songs %>%
    filter(views > 5000, artist %in% artists)


## Find the best relationship using Box-Cox and lm
MASS::boxcox(contributors ~ views, data = rock_songs)
summary(lm(contributors ~ log(views), data = rock_songs))
summary(lm(contributors ~ sqrt(views) - 1, data = rock_songs))


## Scatter plot of the data
rock_plot <-
    rock_songs %>%
    ggplot(aes(views, y=contributors)) +
    geom_point(size=1.25, shape=1) +
    geom_smooth(method = "lm", colour = "blue") +
    scale_x_sqrt("Number of Views (sqrt scale)") +
    ylab("Number of contributors to the lyrics") +
    ggtitle("Number of contributors by number of views") +
    theme_minimal(base_size = 8)


## Save
ggsave(
    "rock.png", plot=rock_plot,
    dpi=225, width=5.5, height=4, units="in"
)
