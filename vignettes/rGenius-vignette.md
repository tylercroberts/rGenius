rGenius
================
Duong Vu, Maud Boucherit, Tariq Hassan, Tyler Roberts
2018-04-15

``` r
library(knitr)
library(stringr)
library(rGenius)
library(lubridate)
library(tidyverse)
```

## Introduction

[Genius](https://genius.com) is a website that allows users to provide
annotations and interpretation of song lyrics, news stories, sources,
poetry, and other documents.

This R package, `rGenius`, wraps the [Genius
API](https://docs.genius.com), facilitating the extraction of some
rather interesting data. This vignette is intended to give a short, but
nevertheless thorough, overview of how to use this software.

Before we proceed any further, it should be noted that while the Genius
API is free to use, it does require that you first obtain an API Key. To
do so (as noted in this projects README.md), you can go to this link:
[genius.com/api-clients/new](https://genius.com/api-clients/new), and
fill out the form. You only need to provide the name of your app and an
app website (the app website can even be [https://example.com]()). After
saving, you can get the access token by clicking on “Generate Access
Token”.

If you’d like follow along, this tutorial assumes that you have saved
your access token (a character string) to an objected entitled
`access_token`. That is,

``` r
access_token <- "YOU ACCESS TOKEN HERE"
```

Alternatively, you can create a simple `access_token.txt` file that
contains your access token and place it somewhere safe. Below you’ll
find an example:

``` r
access_token <- read_lines("../access_token.txt")[1]
```

With those technicalities out of the way, let’s jump in.

-----

## Starting Small

To begin, we can examine the most elemental, but perhaps most important,
function exposed by `rGenius`: `get_song()`. This function allows us to
harvest information from the Genius API about a song by it’s ID number.

### `get_song()`

**Parameters**:

  - `song_id`: ID of the song from Genius API

  - `access_token`: access\_token from the Genius API

**Return**:

  - A `data.frame` complete with the following columns:
      - id: the song’s ID on the Genius API
      - title: the song’s title
      - artist: the song’s main artist
      - featured\_artists: a list of other artists who contributed to
        the song, if any
      - album: the song’s album
      - date: the song’s released date
      - views: the number of views for this song on the Genius website
      - contributors: the number of contributors to the lyrics of this
        songs on the Genius website
      - transcribers: the number of transcribers to the lyrics of this
        songs on the Genius website
      - concurrents: the number of people looking at the page whenever
        the API was last updated

#### Example

Below we’ll explore how we can learn song IDs for music we’re interested
in. For now, we can simply pick a number we like – how about 12?

``` r
song_12_data <- get_song(song_id=12, access_token=access_token)
```

Let’s explore what we’ve got here.

``` r
(class(song_12_data))
#> [1] "data.frame"
(dim(song_12_data))
#> [1]  1 10
```

As promised, we’ve obtained a DataFrame, with one row (Song ID \#12).
Let’s print what it contains:

| Column Name       | Value            |
| :---------------- | :--------------- |
| id                | 12               |
| title             | Money on My Mind |
| artist            | Lil Wayne        |
| featured\_artists | list()           |
| album             | Tha Carter II    |
| date              | 2005-12-06       |
| views             | 89590            |
| contributors      | 34               |
| transcribers      | 0                |
| concurrents       | NaN              |

The table above shows the transpose of the `song_12_data`. *It has be
transposed for one, and only one, reason*: so that it fits on the page\!
Leaving that inconvenience aside, there is something that should be
explained here.

Namely, you’ll notice that `'featured_artists'` is actually a `list()`.
This is for programming convenience, allowing this element in the
dataframe to contain many artists. The alternative here would have been
to collapse this information into a single character string which, while
easier on the eyes requires some extra work to manipulate
programmatically.

### `get_songs()`

If you have a lot of song IDs you’d like to harvest, doing this
one-by-one with `get_song()` can be tedious. Thus, we built
`get_songs()`, which can accept multiple song IDs in the form of a vect

**Parameters**:

  - `song_ids`: song IDs from the Genius API

  - `access_token`: `access_token` from the Genius API

  - `verbose`: show progress bar if
`TRUE`

#### Example

``` r
songs_12_to_14 <- get_songs(c(12, 13, 14), access_token=access_token, verbose=TRUE)
#> ===========================================================================
```

``` r
(dim(songs_12_to_14))
#> [1]  3 10
```

Here we can see that the number of columns we’ve obtained is the same as
above, but we now have three rows: one for each song ID padded to
`get_songs()`. Apart from this, this data frame is essentially identical
to what we saw above.

## Human-Friendly

### `search_song()`

So a major point of frustration above is that we had to know the song
IDs. For this reason, we build `search_song()`, which allows us to
search for song names in a human-friendly way.

**Parameters**:

  - `song_title`: Name of the song

  - `access_token`: access\_token from the Genius API

  - `n_per_page`: Number of returned result page

  - `verbose`: show progress bar if `TRUE`

**Return**: This returns all of the same columns as `get_song()` and
`get_songs()`.

#### Example

Let’s suppose we want to search for five song songs with “Dance” in
their title. We can run this search as follows:

``` r
query_df <-
  search_song(
      song_title="Dance",  ## query
      access_token=access_token,
      n_per_page=5,  ## ask for five search results for our query.
      verbose=TRUE
)
#> ===========================================================================
```

In the interest of formatting (i.e., page width), we can select a few
salient columns from this result and print them:

``` r
query_df %>% 
    ## Subset of key columns.
    select(id, title, artist, date, views) %>% 
    kable()
```

|      id | title                          | artist             | date       |   views |
| ------: | :----------------------------- | :----------------- | :--------- | ------: |
| 2450584 | One Dance                      | Drake              | 2016-04-05 | 5499193 |
|   56737 | Dance (A$$) \[Remix\]          | Big Sean           | 2011-06-28 | 1306678 |
|     700 | Dance with the Devil           | Immortal Technique | 2001-09-14 |  702094 |
|   83812 | Bandz A Make Her Dance (Remix) | Juicy J            | 2012-09-11 |  531489 |
|   74912 | Bandz A Make Her Dance         | Juicy J            | 2012-09-09 |  411801 |

## Name Recognition

### `get_artist()`

`rGenius` also exposes functions to collect data about artists directly,
such as aliases they use (if any), their ID in the Genius database as
well as their user names on social media platforms.

**Parameters:**

  - `artist_id`: ID from API Genius of the artist.

  - `access_token`: access\_token from the Genius API.

**Return**:

  - A dataframe including all information of the artist social media
    info:
      - `'id'`: the artist’s ID on the Genius API
      - `'alternate_name'`: the artist’s name
      - `'facebook_name'`: the artist’s name on facebook, if provided on
        the API
      - `'instagram_name'`: the artist’s name on instagram, if provided
        on the API
      - `'twitter_name'`: the artist’s name on twitter, if provided on
        the API

#### Example

``` r
get_artist(1, access_token=access_token) %>% 
    select(id:twitter_name) %>%
    kable()
```

| id | alternate\_name     | facebook\_name  | instagram\_name | twitter\_name |
| -: | :------------------ | :-------------- | :-------------- | :------------ |
|  1 | Cameron Ezike Giles | 273941499453015 |                 | mr\_camron    |

### `get_song_from_artists()`

Finally, you may wish to search for song from a given artist. `rGenius`
makes this straightforward to do with `get_song_from_artists()`.

**Parameters:**

  - `artist_name`: Artist name

  - `access_token`: access\_token from the Genius API

  - `n_per_page`: Number of returned result page

  - `verbose`: show progress bar if `TRUE`

**Return**: the same columns as `get_song()` and `get_songs()`.

#### Example

``` r
get_song_from_artists(
  artist_name="drake",
  access_token=access_token,
  n_per_page=5,  ## ask for five songs by Drake.
  verbose=TRUE) %>%
  ## Again, take a subset of key columns.
  select(id, title, artist, date, views) %>% 
  ## Pretty Print the Result
  knitr::kable()
#> ===========================================================================
```

|      id | title                     | artist | date       |   views |
| ------: | :------------------------ | :----- | :--------- | ------: |
| 2263723 | Hotline Bling             | Drake  | 2015-07-25 | 6123388 |
| 3315890 | God’s Plan                | Drake  | 2018-01-20 | 5993176 |
| 2450584 | One Dance                 | Drake  | 2016-04-05 | 5499193 |
|  200546 | Hold On, We’re Going Home | Drake  | 2013-08-07 | 5118739 |
|  703654 | Know Yourself             | Drake  | 2015-02-13 | 4672591 |

## Fast Forward

Above we’ve explored the basics of how to use `rGenius`. Here we’ll take
a bigger step and use this package to build a visualization of Katy
Perry album popularity over time.

To begin, we can run a search for some songs by Katy Perry.

``` r
katy <- get_song_from_artists(
    artist_name="katy%20perry",
    access_token=access_token,
    n_per_page=50,
    verbose=TRUE) %>% 
    ## `get_song_from_artists()` faithfully returns us the results
    ## from the Genius API. We'll have to filter The data to ensure
    ## we only get songs where the *main* artist was Katy Pery.
    filter(artist=="Katy Perry")
#> ===========================================================================
```

Next, we can clean up the data types to meet our plotting needs and
shorten some one of the album names so they fit neatly on one our graph.

``` r
katy <-
    katy %>% 
    mutate(
        date = as.Date(date),
        album = str_trim(as.character(album))
    )
```

In our last step before plotting, let’s say that we’re only interested
in three of her albums (our collective favorites): *Prism* and
*Witness*.

``` r
katy_p_favs <- c("Prism", "Witness")

katy <- 
    katy %>% 
    filter(album %in% katy_p_favs) %>% 
    mutate(album = as.factor(album))
```

Now, at last, let’s build our plot and take a look:

``` r
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
```

<img src="rGenius-vignette_files/figure-gfm/unnamed-chunk-16-1.png" style="display: block; margin: auto;" />

## Wrap-Up

In this vignette we’ve explored the `rGenius` package for R, which wraps
the [Genius API](https://docs.genius.com). Specifically, we have walked
through most of the major use cases and have even used this package to
generate a visualization for a contemporary pop artist.

<center>

<img style="border:0px" src="../img/genius.png"/>

</center>
