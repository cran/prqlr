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
select [cyl, mpg]
derive [mpg_int = round 0 mpg]
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
res_with_con <- knitr::knit_child(text = src_with_con, quiet = TRUE)
cat("````markdown", res_with_con, "````", sep = "")

## -----------------------------------------------------------------------------
src_without_con <- r"(
```{r}
#| echo: false

library(prqlr)
```

```{prql}
from mtcars
filter cyl > 6
select [cyl, mpg]
derive [mpg_int = round 0 mpg]
take 3
```
)"

cat("````markdown", src_without_con, "````", sep = "")

## -----------------------------------------------------------------------------
library(prqlr)

## -----------------------------------------------------------------------------
res_without_con <- knitr::knit_child(text = src_without_con, quiet = TRUE)
cat("````markdown", res_without_con, "````", sep = "")

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

