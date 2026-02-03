# Animate options

Animate options

## Usage

``` r
animateOptions(enter = "fadeInDown", exit = "fadeOutUp", duration = 1)
```

## Arguments

- enter:

  Animation name on appearance

- exit:

  Animation name on disappearance

- duration:

  Duration of the animation

## Value

a list

## See also

[`animations`](https://dreamrs.github.io/shinyWidgets/reference/animations.md)

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {

dropdown(
 "Your contents goes here ! You can pass several elements",
 circle = TRUE, status = "danger", icon = icon("gear"), width = "300px",
 animate = animateOptions(enter = "fadeInDown", exit = "fadeOutUp", duration = 3)
)

}
```
