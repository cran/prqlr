## -----------------------------------------------------------------------------
# Override the default SQL print function to avoid inserting '<div class="knitsql-table">'
# https://github.com/yihui/xaringan/issues/307
knitr::opts_knit$set(sql.print = \(x) paste(knitr::kable(x, format = "markdown"), collapse = "\n"))

src_with_con <- r"(
```{r}
#| echo: false

library(DBI)
library(prqlr)
con <- dbConnect(RSQLite::SQLite(), ":memory:")
dbWriteTable(con, "mtcars", mtcars)
```

```{prql}
#| connection: con

from mtcars
filter cyl > 6
select {cyl, mpg}
derive {mpg_int = math.round 0 mpg}
take 3
```
)"

cat("````markdown", src_with_con, "````", sep = "")

## -----------------------------------------------------------------------------
library(DBI)
library(prqlr)
con <- dbConnect(RSQLite::SQLite(), ":memory:")
dbWriteTable(con, "mtcars", mtcars)

## -----------------------------------------------------------------------------
cat(
  "````markdown",
  knitr::knit_child(text = src_with_con, quiet = TRUE),
  "````",
  sep = ""
)

## -----------------------------------------------------------------------------
src_without_con <- r"(
```{r}
#| echo: false

library(prqlr)
```

```{prql}
from mtcars
filter cyl > 6
select {cyl, mpg}
derive {mpg_int = math.round 0 mpg}
take 3
```
)"

cat("````markdown", src_without_con, "````", sep = "")

## -----------------------------------------------------------------------------
library(prqlr)

## -----------------------------------------------------------------------------
cat(
  "````markdown",
  knitr::knit_child(text = src_without_con, quiet = TRUE),
  "````",
  sep = ""
)

## -----------------------------------------------------------------------------
library(prqlr)

## -----------------------------------------------------------------------------
src_engine_opts <- r"(
```{r}
#| echo: false

library(prqlr)
```

## YAML-style

```{prql}
#| engine-opts:
#|   target: sql.mssql
#|   signature_comment: false

from mtcars
take 3
```

## R-style

```{prql engine.opts=list(target="sql.mssql", signature_comment=FALSE)}
from mtcars
take 3
```
)"

# Check if it can be rendered
invisible(knitr::knit_child(text = src_engine_opts, quiet = TRUE))

cat("````markdown", src_engine_opts, "````", sep = "")

## -----------------------------------------------------------------------------
src_glue <- r"(
```{r}
#| echo: false

library(prqlr)

cyl_min <- 6
derive_or_select <- "derive"
```

```{prql}
#| engine-opts:
#|   use_glue: true

from mtcars
filter cyl > {{cyl_min}}
select {cyl, mpg}
{{derive_or_select}} {mpg_int = math.round 0 mpg}
take 3
```
)"

cat("````markdown", src_glue, "````", sep = "")

## -----------------------------------------------------------------------------
library(prqlr)

cyl_min <- 6
derive_or_select <- "derive"

## -----------------------------------------------------------------------------
cat(
  "````markdown",
  knitr::knit_child(text = src_glue, quiet = TRUE),
  "````",
  sep = ""
)

## -----------------------------------------------------------------------------
src_query_from_r <- r"(
```{r}
#| echo: false

library(prqlr)

prql_query <- "from mtcars
select cyl"
```

```{prql}
#| engine-opts:
#|   use_glue: true

{{prql_query}}
```
)"

cat("````markdown", src_query_from_r, "````", sep = "")

## -----------------------------------------------------------------------------
library(prqlr)

prql_query <- "from mtcars
select cyl"

## -----------------------------------------------------------------------------
cat(
  "````markdown",
  knitr::knit_child(text = src_query_from_r, quiet = TRUE),
  "````",
  sep = ""
)

## -----------------------------------------------------------------------------
src_info_string <- r"(
```{r}
#| echo: false

library(prqlr)
```

```{prql}
#| engine-opts:
#|   info_string: '{.sql filename="SQL"}'
from mtcars
take 3
```
)"

cat("````markdown", src_info_string, "````", sep = "")

## -----------------------------------------------------------------------------
library(prqlr)

## -----------------------------------------------------------------------------
cat(
  "````markdown",
  knitr::knit_child(text = src_info_string, quiet = TRUE),
  "````",
  sep = ""
)

