## -----------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(prqlr)

## -----------------------------------------------------------------------------
library(prqlr)

"
from mtcars
filter cyl > 6
select {cyl, mpg}
derive {mpg_int = round 0 mpg}
" |>
  prql_compile() |>
  cat()

## -----------------------------------------------------------------------------
library(DBI)

# Create an ephemeral in-memory SQLite database
con <- dbConnect(RSQLite::SQLite(), ":memory:")

# Create a table inclueds `mtcars` data
dbWriteTable(con, "mtcars", mtcars)

# Execute a PRQL query
"
from mtcars
filter cyl > 6
select {cyl, mpg}
derive {mpg_int = round 0 mpg}
take 3
" |>
  prql_compile("sql.sqlite") |>
  dbGetQuery(con, statement = _)

## -----------------------------------------------------------------------------
"
from mtcars
filter cyl > 6
select {cyl, mpg}
derive {mpg_int = round 0 mpg}
take 3
" |>
  prql_compile("sql.sqlite") |>
  sqldf::sqldf()

## -----------------------------------------------------------------------------
library(tidyquery)
library(nycflights13)

"
from flights
filter (distance | in 200..300)
filter air_time != null
group {origin, dest} (
  aggregate {
    num_flts = count this,
    avg_delay = (average arr_delay | round 0)
  }
)
sort {-origin, avg_delay}
take 2
" |>
  prql_compile() |>
  query()

## -----------------------------------------------------------------------------
library(dplyr, warn.conflicts = FALSE)
library(nycflights13)

flights |>
  filter(
    distance |> between(200, 300),
    !is.na(air_time)
  ) |>
  group_by(origin, dest) |>
  summarise(
    num_flts = n(),
    avg_delay = mean(arr_delay, na.rm = TRUE) |> round(0),
    .groups = "drop"
  ) |>
  arrange(desc(origin), avg_delay) |>
  head(2)

