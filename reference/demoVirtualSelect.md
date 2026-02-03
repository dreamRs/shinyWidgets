# Demo for [`virtualSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/virtualSelectInput.md)

Demo for
[`virtualSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/virtualSelectInput.md)

## Usage

``` r
demoVirtualSelect(
  name = c("default", "update", "choices-format", "prepare-choices", "bslib-theming")
)
```

## Arguments

- name:

  Name of the demo app to launch.

## Value

No value.

## Examples

``` r
if (FALSE) { # \dontrun{

# Default usage
demoVirtualSelect("default")

# Update widget from server
demoVirtualSelect("update")

# Differents ways of specifying choices
demoVirtualSelect("choices-format")

# Prepare choices from a data.frame
demoVirtualSelect("prepare-choices")

# Theming with bslib
demoVirtualSelect("bslib-theming")

} # }
```
