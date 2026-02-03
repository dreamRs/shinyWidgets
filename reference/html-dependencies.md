# HTML dependencies

These functions are used internally to load dependencies for widgets.
Not all of them are exported. Below are the ones needed for package
[fresh](https://github.com/dreamRs/fresh).

## Usage

``` r
html_dependency_awesome()

html_dependency_bttn()

html_dependency_pretty()

html_dependency_bsswitch()

html_dependency_sweetalert2(
  theme = c("sweetalert2", "minimal", "dark", "bootstrap-4", "material-ui", "bulma",
    "borderless")
)
```

## Arguments

- theme:

  SweetAlert theme to use.

## Value

an
[`htmlDependency`](https://rstudio.github.io/htmltools/reference/htmlDependency.html).

## Examples

``` r
# Use in UI or tags function

library(shiny)
fluidPage(
  html_dependency_awesome()
)
#> <div class="container-fluid"></div>
```
