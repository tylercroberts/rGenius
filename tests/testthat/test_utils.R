# Utils Test

context("utils.R")

test_that("utf8_to_html() returns the correct string", {
    expect_match(utf8_to_html("éèàÀ"), "%C3%A9%C3%A8%C3%A0%C3%80")
})


test_that("get_field() returns NaN when passed NULL", {
    expect_true(is.nan(get_field(NULL)))
})


# Note: `.get_payload()` put through its paces
# by the functions in `R/artist.R` and `R/songs.R`.
