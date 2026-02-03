# Drop menu options

Those options will passed to the underlying JavaScript library powering
`dropMenu` : tippy.js. See all available options here
<https://atomiks.github.io/tippyjs/all-props/>.

## Usage

``` r
dropMenuOptions(duration = c(275, 250), animation = "fade", flip = FALSE, ...)
```

## Arguments

- duration:

  Duration of the CSS transition animation in ms.

- animation:

  The type of transition animation.

- flip:

  Determines if the tippy flips so that it is placed within the viewport
  as best it can be if there is not enough space.

- ...:

  Additional arguments.

## Value

a `list` of options to be used in
[`dropMenu`](https://dreamrs.github.io/shinyWidgets/reference/dropMenu.md).
