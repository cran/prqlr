
<!-- README.md is generated from README.Rmd. Please edit that file -->

# prqlr <img src="man/figures/logo.png" align="right" width="150"/>

<!-- badges: start -->

[![prqlr status
badge](https://eitsupi.r-universe.dev/badges/prqlr)](https://eitsupi.r-universe.dev)
[![CRAN
status](https://www.r-pkg.org/badges/version/prqlr)](https://CRAN.R-project.org/package=prqlr)
<!-- badges: end -->

R bindings for [the `prql-compiler` Rust
library](https://github.com/prql/prql), powered by [the `extendr`
framework](https://extendr.github.io/).

This version supports PRQL 0.9.3.

## Installation

Requires R 4.2.0 or later.

This package can be installed from CRAN or
[R-universe](https://eitsupi.r-universe.dev/prqlr). If available, a
binary package will be installed.

``` r
# Install from CRAN
install.packages("prqlr")
```

``` r
# Install from R-universe
install.packages("prqlr", repos = "https://eitsupi.r-universe.dev")
```

For source installation, the Rust toolchain (Rust 1.65 or later) must be
configured. Please check the <https://github.com/r-rust/hellorust>
repository for about Rust code in R packages.

## Examples

``` r
library(prqlr)
"from mtcars | filter cyl > 6 | select {cyl, mpg}" |>
  prql_compile() |>
  cat()
#> SELECT
#>   cyl,
#>   mpg
#> FROM
#>   mtcars
#> WHERE
#>   cyl > 6
#> 
#> -- Generated by PRQL compiler version:0.9.3 (https://prql-lang.org)
```

PRQL’s pipelines can be joined by the newline character (`\n`), or
actual newlines in addition to `|`.

``` r
"from mtcars \n filter cyl > 6 \n select {cyl, mpg}" |>
  prql_compile() |>
  cat()
#> SELECT
#>   cyl,
#>   mpg
#> FROM
#>   mtcars
#> WHERE
#>   cyl > 6
#> 
#> -- Generated by PRQL compiler version:0.9.3 (https://prql-lang.org)
```

``` r
"from mtcars
filter cyl > 6
select {cyl, mpg}" |>
  prql_compile() |>
  cat()
#> SELECT
#>   cyl,
#>   mpg
#> FROM
#>   mtcars
#> WHERE
#>   cyl > 6
#> 
#> -- Generated by PRQL compiler version:0.9.3 (https://prql-lang.org)
```

Thanks to the `{tidyquery}` package, we can even convert a PRQL query to
a SQL query and then to a `{dplyr}` query!

``` r
"from mtcars
filter cyl > 6
select {cyl, mpg}" |>
  prql_compile() |>
  tidyquery::show_dplyr()
#> mtcars %>%
#>   filter(cyl > 6) %>%
#>   select(cyl, mpg)
```

## `{knitr}` integration

Using `{prqlr}` with `{knitr}` makes it easy to create documents that
lists PRQL queries and a translated SQL queries, or documents that lists
PRQL queries and tables of data retrieved by PRQL queries.

Please check the vignette `vignette("knitr", "prqlr")` for details.

## Development

Use the `rextendr::document()` function to generate R source code from
Rust source code in the `src` directory.
