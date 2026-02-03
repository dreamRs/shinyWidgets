# Change the value of [`airDatepickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md) on the client

Change the value of
[`airDatepickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md)
on the client

## Usage

``` r
updateAirDateInput(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  value = NULL,
  tz = NULL,
  clear = FALSE,
  options = NULL,
  show = FALSE,
  hide = FALSE
)
```

## Arguments

- session:

  The `session` object passed to function given to `shinyServer`.

- inputId:

  The id of the input object.

- label:

  The label to set for the input object.

- value:

  The value to set for the input object.

- tz:

  The timezone.

- clear:

  Logical, clear all previous selected dates.

- options:

  Options to update, see available ones in [JavaScript
  documentation](https://air-datepicker.com/docs)

- show, hide:

  Show / hide datepicker.

## Examples

``` r
if (interactive()) {

  demoAirDatepicker("update")

}
```
