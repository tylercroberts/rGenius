## Packages
library(rGenius)
library(tidyverse)

## Set the access token
access_token <- read_lines("access_token.txt")[1]

## Search and Download results for Katy Pery
katy <- get_song_from_artists(
    artist_name="katy%20perry",
    access_token=access_token,
    n_per_page=50,
    verbose=TRUE) %>%
    ## `get_song_from_artists()` faithfully returns us the results
    ## from the Genius API. We'll have to filter The data to ensure
    ## we only get songs where the *main* artist was Katy Pery.
    filter(artist=="Katy Perry")

## Clean Data Types
katy <-
  katy %>%
  mutate(
    date = as.Date(date),
    album = str_trim(as.character(album))
)

## Filter
katy_p_favs <- c("Prism", "Witness")

katy <-
  katy %>%
  filter(album %in% katy_p_favs) %>%
  mutate(album = as.factor(album))

## Build Plot.
katy_plot <-
    katy %>%
    mutate(views=views/1e6) %>%
    ggplot(aes(x=date, y=views, color=album)) +
    geom_line() +
    facet_grid(~album, scales="free_x") +
    scale_y_continuous(labels = scales::comma) +
    ## Standardize Date Format.
    ## See: https://stackoverflow.com/a/48510303
    scale_x_date(date_labels = "%b-%Y") +
    labs(x="\nDate", y="Views (Millions)") +
    ggtitle("Our Favorite Katy Perry Albums", subtitle="Rise and Fall") +
    theme_minimal() +
    theme(legend.position="none")


ggsave("imgs/katy.png", plot=katy_plot, dpi=300)
