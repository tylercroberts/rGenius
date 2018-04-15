## Packages
library(rGenius)
library(tidyverse)


## Set the access token
access_token <- read_lines("access_token.txt")[1]


## Get all songs with the search 'drake'
drake <- get_song_from_artists(
  artist_name="drake",
  access_token=access_token,
  n_per_page=20
)


## Scatter plot of the data
drake_plot <-
    drake %>%
    mutate(
      date = as.Date(date),
      title = as.character(title),
      title = ifelse(str_detect(title, pattern = "Cake /"), "Pound Cake", title),
      title = as.factor(title)
    ) %>%
    ggplot() +
    geom_point(aes(x = reorder(title, desc(views)),
                   y = date, size= views, colour = artist)) +
    labs(x ="Song Title", y = "Time", color="Artist",
         size="Views") +
    ggtitle("Drake Song Results from the Genius API") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save to a directory 'imgs'.
ggsave("imgs/drake.png", plot=drake_plot, dpi=300)