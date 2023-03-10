# prqlr 0.2.1

## Bug fixes

- Thanks to new version of `extendr` and `libR-sys`, `prqlr` can now be installed on arm64 Linux. (#90)
- Now buildable with Rust version 1.60 again (#94)

# prqlr 0.2.0

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.5.1 (#71, #77, #86)
- The option name of `prql_compile()` for specifying the compile target has been changed from `dialect` to `target`.
  The following two changes have also been made as a result of this change.
  - SQL dialects must be specified with the `sql.` prefix if they are to be targeted
    (e.g. `"duckdb"` -> `"sql.duckdb"`). (#71)
  - `prql_available_dialects()` is renamed to `prql_get_targets()`. (#85)

## New features

- `{prqlr}` registers `prql` engine for `{knitr}` when loaded.
  See the vignette `vignette("knitr", "prqlr")` for details. (#53, #57, #62)
- New function `prql_version()` which returns built-in prql-compiler version. (#51)
- `prql_compile()`'s options can be set by `options()`. (#70)

## Other improvements

- `prql_compile()` no longer leaks memory when an error occurs. (Thanks @sorhawell, #46, #52)

# prqlr 0.1.0

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.4.1
- `prql_compile()` is implemented and `prql_to_sql()` is deprecated.
- `json_to_prql()` and `prql_to_json()` are removed.

## Other improvements

- Changes to the installation process
  - `CARGO_HOME` is now set to the temporary directory during installation
    if the environment variable `NOT_CRAN` is not set to `true`
    [to avoid writing in HOME](https://github.com/r-rust/faq). (#25, #27, #29)

# prqlr 0.0.4

## Enhancements

- Changes to the installation process
  - Change Rust toolchain for Windows from GNU to MSVC. (#22)

# prqlr 0.0.3

## Breaking changes

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.3.1
- The `format_prql()` function is removed.

# prqlr 0.0.2

## Enhancements

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.2.11

# prqlr 0.0.1

- Based on [`prql-compiler`](https://github.com/prql/prql) 0.2.9
