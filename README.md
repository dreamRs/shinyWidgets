# shinyWidgets

> Extend widgets available in [shiny](https://github.com/rstudio/shiny)

<!-- badges: start -->
[![version](http://www.r-pkg.org/badges/version/shinyWidgets)](https://CRAN.R-project.org/package=shinyWidgets)
[![cranlogs](http://cranlogs.r-pkg.org/badges/shinyWidgets)](https://CRAN.R-project.org/package=shinyWidgets)
[![cran checks](https://badges.cranchecks.info/worst/shinyWidgets.svg)](https://cran.r-project.org/web/checks/check_results_shinyWidgets.html)
[![Coverage Status](https://img.shields.io/codecov/c/github/dreamRs/shinyWidgets/master.svg)](https://codecov.io/github/dreamRs/shinyWidgets?branch=master)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/dreamRs/shinyWidgets?branch=master&svg=true)](https://ci.appveyor.com/project/dreamRs/shinyWidgets)
[![R-CMD-check](https://github.com/dreamRs/shinyWidgets/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dreamRs/shinyWidgets/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->


## Overview

This package offers custom widgets and other components to enhance your shiny applications.

You can replace classical checkboxes with switch button, add colors to radio buttons and checkbox group, use buttons as radio or checkboxes.
Each widget has an `update` method to change the value of an input from the server.



## Installation

Install from [CRAN](https://CRAN.R-project.org/package=shinyWidgets) with:

```r
install.packages("shinyWidgets")
```

Or install the development version from [GitHub](https://github.com/dreamRs/shinyWidgets) with:

```r
# install.packages("remotes")
remotes::install_github("dreamRs/shinyWidgets")
```


## Demo

A gallery application is included in the package. Once installed, use the following command to launch it:

```r
shinyWidgets::shinyWidgetsGallery()
```

A live version is available here : http://shinyapps.dreamrs.fr/shinyWidgets



### Bootstrap switch

Turn checkboxes into toggle switches : 

![switchInput](man/figures/switchInput.png)

```r
switchInput(inputId = "id", value = TRUE)
```



### Material switch

Turn checkboxes into toggle switches :

![materialSwitch](man/figures/materialSwitch.png)

```r
materialSwitch(inputId = "id", label = "Primary switch", status = "danger")
```



### Pretty Checkbox

Checkbox and radio buttons with the beautiful CSS library [pretty-checkbox](https://lokesh-coder.github.io/pretty-checkbox/) :
![prettycheckbox](man/figures/pretty.png)


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

# ...

```


### Sweet Alert

Show an alert message to the user to provide some feedback, via [sweetalert2](https://sweetalert2.github.io/) library:

![sendSweetAlert](man/figures/show_alert.png)

See examples in `?show_alert`.


Request confirmation from the user :

![confirmSweetAlert](man/figures/ask_confirmation.png)

See examples in `?ask_confirmation`.



### Slider Text

Slider with strings, to pass whatever you want : <br>
![sliderText](man/figures/sliderText.png)

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


### Select picker

Dropdown menu with a lot of options : 

![pickerInput](man/figures/pickerInput.png)

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

Turn buttons into checkbox or radio : 

![checkboxGroupButtons](man/figures/checkboxGroupButtons.png)

```r
checkboxGroupButtons(
  inputId = "somevalue", label = "Make a choice :", 
  choices = c("Choice A", "Choice B", " Choice C", "Choice D"), 
  justified = TRUE, status = "primary",
  checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
)
```



### Search input

A text input only triggered by hitting 'Enter' or clicking search button : 

![search_input](man/figures/search_input.png)

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
![dropdown_off](man/figures/dropdown_btn_off.png)
![dropdown_on](man/figures/dropdown_btn_on.png)

```r
dropdownButton(
  tags$h3("List of Input"),
  selectInput(inputId = 'xcol', label = 'X Variable', choices = names(iris)),
  selectInput(inputId = 'ycol', label = 'Y Variable', choices = names(iris), selected = names(iris)[[2]]),
  sliderInput(inputId = 'clusters', label = 'Cluster count', value = 3, min = 1, max = 9),
  circle = TRUE,
  status = "danger", 
  icon = icon("gear"), width = "300px",
  tooltip = tooltipOptions(title = "Click to see inputs !")
)
```

See also `?dropMenu()`

