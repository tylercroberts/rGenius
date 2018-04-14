

<h1 align="center">
  <br>

![](img/genius.png)

rGenius
<br>
</h1>

<h5 align="center"><a>
Created by</a></h5>

<h4 align="center"><a>

[Tyler Roberts](https://github.com/tylercroberts/)  •  [Maud Boucherit](https://github.com/MaudBoucherit)  •  [Duong Vu](https://github.com/DuongVu39) &nbsp;&nbsp;•  [Tariq Hassan](https://github.com/TariqAHassan) &nbsp;  

</a></h4>

<br>

<h4 align="center"><a>

[![Build Status](https://travis-ci.org/tylercroberts/rGenius.svg?branch=master)](https://travis-ci.org/tylercroberts/rGenius)
[![Coverage status](https://codecov.io/gh/tylercroberts/rGenius/branch/master/graph/badge.svg)](https://codecov.io/github/tylercroberts/rGenius?branch=master)

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

</a></h4>

<h1></h1>

<h4 align="center">
  <a href="#main-features">Main Features</a> &nbsp;&nbsp;&nbsp;•  <a href="#Usage">Usage</a> &nbsp;&nbsp;&nbsp;•  <a href="#Dependencies">Dependencies</a> &nbsp;&nbsp;&nbsp;•  <a href="#Installation">Installation</a> &nbsp;&nbsp;&nbsp;&nbsp;

</h4>

## Overview

[Genius](http://genius.com/) is a website that allows users to provide annotations and interpretation of song lyrics, news stories, sources, poetry, and other documents.

This R package wraps the Genius API ([here](https://genius.com/)) and provides some interesting data extraction.

### Some examples of the package usage:

Popularity of some of Kanye West's songs:   
![](img/kanye.png)

Popularity of Karry Perry's albums over time:   
![](img/katty.png)

Number of contributors to the lyrics by number of views for some rock songs:   
![](img/rock.png)


## Main Features

Below are some functions that has been developed in the package:

- `get_song()`:

  - Search song by its ID number.
  - Return a dataframe including all information

- `get_songs()`

  - Search several songs by their ID number
  - Return a dataframe including all information

- `search_song()`

  - Search song by its title.
  - Return a dataframe including all information about songs with the same title

- `get_artist()`

  - Search artist by his/her ID number
  - Return a dataframe including all information

- `get_song_from_artists()`

  - Search all songs by a specified artist by his/her name

  - Return a dataframe including all information

    ​



## Usage

```
get_song_from_artists("taylor", access_token, 6)
taytay %>% 
  select(title, artist, date, views, album) %>% 
  head()
```

|      | title                      | artist                       | date       | views   | album                                 |
| ---- | -------------------------- | ---------------------------- | ---------- | ------- | ------------------------------------- |
| 1    | Look What You Made Me Do   | Taylor Swift                 | 2017-08-25 | 1275737 | reputation                            |
| 2    | End Game                   | Taylor Swift                 | 2017-11-10 | 1129164 | reputation                            |
| 3    | ...Ready for It?           | Taylor Swift                 | 2017-09-03 | 990569  | reputation                            |
| 4    | Bad Blood (Remix)          | NA                           | 2015-05-17 | 878209  | NA                                    |
| 5    | I Don't Wanna Live Forever | NOW That's What I Call Music | 2016-12-09 | 764165  | NOW That's What I Call Music, Vol. 62 |
| 6    | Blank Space                | Taylor Swift                 | 2014-11-10 | 778410  | 1989                                  |



## Dependencies

- [R](https://cran.r-project.org/) >= 3.4.3
- [dplyr](https://dplyr.tidyverse.org/): grammar of data manipulation
- [httr](https://github.com/r-lib/httr): a friendly http package for R
- [readr](https://github.com/tidyverse/readr): Read flat files (csv, tsv, fwf) into R
- [glue](https://github.com/tidyverse/glue): Glue strings to data in R.



## Installation from sources

To install the package, simply type the code below in the console:

```R
devtools::load_all()
devtools::install_github("tylercroberts/rGenius")
```



## Contributing to rGenius

All contributions, bug reports, bug fixes, documentation improvements, enhancements and ideas are welcome.

A detailed overview on how to contribute can be found in the [**contributing guide.**](https://github.com/tylercroberts/rGenius/blob/master/CONTRIBUTING.md)

If you are simply looking to start working with the [rGenius](https://github.com/tylercroberts/rGenius), navigate to the [GitHub “issues” tab](https://github.com/tylercroberts/rGenius/issues) and start looking through any issues.

Or maybe through using [rGenius](https://github.com/tylercroberts/rGenius) you have an idea of your own or are looking for something in the documentation and thinking ‘this can be improved’...you can do something about it!
