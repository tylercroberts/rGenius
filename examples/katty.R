## Packages
library(rGenius)
library(tidyverse)

## Set the access token
access_token <- read_lines("access_token.txt")[1]

## Get all songs with the search Katty
katty <- get_song_from_artists("katty", access_token, 20)

## Filter several album versions to one version:
katty$album <- as.character(katty$album)
katty$album[katty$album == "Teenage Dream: The Complete Confection"] <- "Teenage Dream"
katty$album <- as.factor(katty$album)

## Bar plot of Katy Perry's album popularity over time

katty %>% 
  filter(artist == "Katy Perry") %>% 
  mutate(date = as.Date(date)) %>% 
  group_by(album) %>% 
  summarise(view = sum(views), date = max(date)) %>% 
  ggplot() +
  geom_bar(aes(x = reorder(album, date), y = view, fill = date), stat = "identity")+
  labs(x ="Albums", y = "Views", 
       title = "Katy Perry Album Results from API") +
  theme_light()





