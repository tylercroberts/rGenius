# rGenius

[![Build Status](https://travis-ci.org/tylercroberts/rGenius.svg?branch=master)](https://travis-ci.org/tylercroberts/rGenius)
[![Coverage status](https://codecov.io/gh/tylercroberts/rGenius/branch/master/graph/badge.svg)](https://codecov.io/github/tylercroberts/rGenius?branch=master)

## Overview

[Genius](http://genius.com/) is a website that allows users to provide annotations and interpretation of song lyrics, news stories, sources, poetry, and other documents.

This R package wraps the Genius API ([here](https://genius.com/)) and provides some interesting data extraction.



## Main Features

Below are some functions that has been developed in the package:

- `get_song()`
- `get_songs()`
- `search_song()`
- `get_artist()`
- `get_song_from_artists()`

## Dependencies

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



## Contributing to rGenius [![Open Source Helpers](https://camo.githubusercontent.com/6332f3d9633f4d7fac6d388358c971829b9c8aff/68747470733a2f2f7777772e636f64657472696167652e636f6d2f70616e6461732d6465762f70616e6461732f6261646765732f75736572732e737667)](https://www.codetriage.com/)

All contributions, bug reports, bug fixes, documentation improvements, enhancements and ideas are welcome.

A detailed overview on how to contribute can be found in the [**contributing guide.**](https://github.com/tylercroberts/rGenius/blob/master/CONTRIBUTING.md)

If you are simply looking to start working with the rGenius, navigate to the [GitHub “issues” tab](https://github.com/tylercroberts/rGenius/issues) and start looking through any issues.

Or maybe through using rGenius you have an idea of your own or are looking for something in the documentation and thinking ‘this can be improved’...you can do something about it!



## Project contributors:

1. [Tyler Roberts](https://github.com/tylercroberts/)
2. [Maud Boucherit](https://github.com/MaudBoucherit) 
3. [Duong Vu](https://github.com/DuongVu39)
4. [Tariq Hassan](https://github.com/TariqAHassan)
