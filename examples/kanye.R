## Packages
library(rGenius)
library(tidyverse)

## Set the access token
access_token <- read_lines("access_token.txt")[1]

## Get all songs with the search Kanye
kanye <- get_song_from_artists("kanye", access_token, 20)

## Filter
kanye$title <- as.character(kanye$title)
kanye$title[str_detect(kanye$title,"in Paris")] <- "N***** in Paris"
kanye$title <- as.factor(kanye$title)

## Scatter plot of the data
kanye %>% 
  mutate(date = as.Date(date)) %>% 
  ggplot() +
  geom_point(aes(x = reorder(title,desc(views)), y = date, size= views, colour = artist))+
  labs(x ="Song Title", y = "Time", 
       title = "Kanye West Song Results from API") +
  theme_light() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1) ) 






