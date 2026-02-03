# Change the value of a no ui slider input on the client

Change the value of a no ui slider input on the client

## Usage

``` r
updateNoUiSliderInput(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  value = NULL,
  range = NULL,
  disable = NULL,
  disableHandlers = NULL,
  enableHandlers = NULL
)
```

## Arguments

- session:

  The `session` object passed to function given to `shinyServer`.

- inputId:

  The id of the input object.

- label:

  The new label.

- value:

  The new value.

- range:

  The new range, must be of length 2 with `c(min, max)`.

- disable:

  logical, disable or not the slider, if disabled the user can no longer
  modify the slider value.

- disableHandlers, enableHandlers:

  Enable or disable specific handlers, use a numeric indicating the
  position of the handler.

## See also

[`noUiSliderInput()`](https://dreamrs.github.io/shinyWidgets/reference/noUiSliderInput.md)

## Examples

``` r
if (interactive()) {

 demoNoUiSlider("update")

}
```
