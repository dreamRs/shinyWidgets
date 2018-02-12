# shinyWidgets


> Extend widgets available in shiny

[![Travis-CI Build Status](https://travis-ci.org/dreamRs/shinyWidgets.svg?branch=master)](https://travis-ci.org/dreamRs/shinyWidgets)
[![version](http://www.r-pkg.org/badges/version/shinyWidgets)](https://CRAN.R-project.org/package=shinyWidgets)
[![cranlogs](http://cranlogs.r-pkg.org/badges/shinyWidgets)](http://cran.rstudio.com/web/packages/shinyWidgets/index.html)
[![Coverage Status](https://img.shields.io/codecov/c/github/dreamRs/shinyWidgets/master.svg)](https://codecov.io/github/dreamRs/shinyWidgets?branch=master)

## Overview

This package provide some custom widgets to pimp your shiny apps !


You can replace classical checkboxes with switch button, add colors to radio buttons and checkbox group, use buttons as radio or checkboxes.
Each widget has an `update` method to change the value of an input from the server.


Installation :
```r
# From CRAN
install.packages("shinyWidgets")

# From Github
# install.packages("devtools")
devtools::install_github("dreamRs/shinyWidgets")
```

Demo :
```r
shinyWidgets::shinyWidgetsGallery()
```

Or see the live version here : https://dreamrs-vic.shinyapps.io/shinyWidgets/

You can find an introduction (in french) [here](https://dreamrs.github.io/shinyWidgets/articles/intro_shinyWidgets_fr.html).

And how to construct a palette color picker [here](https://dreamrs.github.io/shinyWidgets/articles/palette_picker.html).


## Widgets available :


  - [Bootstrap switch](#bootstrap-switch)
  - [Material switch](#material-switch)
  - [Pretty Checkbox](#pretty-checkbox)
  - [Sweet Alert](#sweet-alert)
  - [Slider Text](#slider-text)
  - [Knob Input](#knob-input)
  - [Select picker](#select-picker)
  - [Checkbox and radio buttons](#checkbox-and-radio-buttons)
  - [Search bar](#search-bar)
  - [Dropdown button](#dropdown-button)


### Bootstrap switch

Turn checkboxes into toggle switches : <br>
![switchInput](inst/images/switchInput.png)

```r
switchInput(inputId = "id", value = TRUE)
```



### Material switch

Turn checkboxes into toggle switches (again) : <br>
![materialSwitch](inst/images/materialSwitch.png)

```r
materialSwitch(inputId = "id", label = "Primary switch", status = "danger")
```



### Pretty Checkbox

Checkbox and radio buttons with the beautiful CSS library [pretty-checkbox](https://lokesh-coder.github.io/pretty-checkbox/) :
![prettycheckbox](inst/images/pretty.png)


```r
prettyCheckbox(
  inputId = "pretty_1", label = "Check me!", icon = icon("check")
),
prettyCheckbox(
  inputId = "pretty_2", label = "Check me!", icon = icon("thumbs-up"), 
  status = "default", shape = "curve", animation = "pulse"
),
prettyCheckbox(
  inputId = "pretty_3", label = "Check me!", icon = icon("users"), 
  animation = "pulse", plain = TRUE, outline = TRUE
),
prettyCheckbox(
  inputId = "pretty_4", label = "Check me!",
  status = "success", outline = TRUE
),
prettyCheckbox(
  inputId = "pretty_5", label = "Check me!",
  shape = "round", outline = TRUE, status = "info"
),

...

```


### Sweet Alert

Displays a message to the user :

![sendSweetAlert](inst/images/sendSweetAlert.gif)

See examples in `?sendSweetAlert`.


Request confirmation from the user :

![confirmSweetAlert](inst/images/confirmSweetAlert.gif)

See examples in `?confirmSweetAlert`.



### Slider Text

Slider with strings, to pass whatever you want : <br>
![sliderText](inst/images/sliderText.png)

```r
sliderTextInput(
  inputId = "mySliderText", 
  label = "Your choice:", 
  grid = TRUE, 
  force_edges = TRUE,
  choices = c("Strongly disagree",
              "Disagree", "Neither agree nor disagree", 
              "Agree", "Strongly agree")
)
```


### Knob Input

A [jQuery](https://github.com/aterrien/jQuery-Knob) based knob, similar to sliderInput or sliderTextInput: <br>
![knobInput](inst/images/knob.gif)

```r
knobInput(
  inputId = "knob6", 
  label = "Cursor mode:", 
  value = 50, 
  thickness = 0.3, 
  cursor = TRUE, 
  width = 150,
  height = 150
)

...

```

### Select picker

Dropdown menu with a lot of options : <br>
![pickerInput](inst/images/pickerInput.png)

```r
pickerInput(
  inputId = "myPicker", 
  label = "Select/deselect all + format selected", 
  choices = LETTERS, 
  options = list(
    `actions-box` = TRUE, 
    size = 10,
    `selected-text-format` = "count > 3"
  ), 
  multiple = TRUE
)
```



### Checkbox and radio buttons

Turn buttons into checkbox or radio : <br>
![checkboxGroupButtons](inst/images/checkboxGroupButtons.png)

```r
checkboxGroupButtons(
  inputId = "somevalue", label = "Make a choice :", 
  choices = c("Choice A", "Choice B", " Choice C", "Choice D"), 
  justified = TRUE, status = "primary",
  checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
)
```



### Search bar

A text input only triggered by hitting 'Enter' or clicking search button : <br>
![search_input](inst/images/search_input.png)

```r
searchInput(
  inputId = "id", 
  label = "Enter your search :", 
  placeholder = "This is a placeholder", 
  btnSearch = icon("search"), 
  btnReset = icon("remove"), 
  width = "100%"
)
```



### Dropdown button

Hide input in a button : <br>
![dropdown_off](inst/images/dropdown_btn_off.png)
![dropdown_on](inst/images/dropdown_btn_on.png)

```r
dropdownButton(
  tags$h3("List of Input"),
  selectInput(inputId = 'xcol', label = 'X Variable', choices = names(iris)),
  selectInput(inputId = 'ycol', label = 'Y Variable', choices = names(iris), selected = names(iris)[[2]]),
  sliderInput(inputId = 'clusters', label = 'Cluster count', value = 3, min = 1, max = 9),
  circle = TRUE, status = "danger", icon = icon("gear"), width = "300px",
  tooltip = tooltipOptions(title = "Click to see inputs !")
)
```


And others !

