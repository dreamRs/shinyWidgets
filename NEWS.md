shinyWidgets 0.7.6
======================

* Updated virtual-select-plugin to 1.0.37.
* Updated air-datepicker to 3.3.3, fix [#553](https://github.com/dreamRs/shinyWidgets/issues/553).


### Bug fixes

* `verticalTabsetPanel()` does not work with bslib using Bootstrap 5 [#549](https://github.com/dreamRs/shinyWidgets/issues/549).



shinyWidgets 0.7.5
======================

* Updated virtual-select-plugin to 1.0.34.
* Updated air-datepicker to 3.3.1 with language support for japanese and korean.
* Updated `treeInput()` collapse and expand methods (in javascript).


### Bug fixes

* `multiInput()` is no longer renders HTML tags inside values [#545](https://github.com/dreamRs/shinyWidgets/issues/545).
* `awesomeCheckboxGroup()` errors when colon in choices [#543](https://github.com/dreamRs/shinyWidgets/issues/543).




shinyWidgets 0.7.4
======================

* New widget `treeInput()` based on [treejs](https://github.com/daweilv/treejs) library.
* Updated virtual-select-plugin to 1.0.33.
* `updateVirtualSelect()` has a new argument `disabledChoices` to disable some choices from the menu.
* It's now possible to use variable with space in their name in `selectizeGroup` module, thanks to [@evgeniyftw](https://github.com/evgeniyftw).


### Bug fixes

* `switchInput()` produced an error when using `bslib::bs_theme(version = "3")` [#528](https://github.com/dreamRs/shinyWidgets/issues/528).
* Fixed a bug in `pickerGroup` module when using `aggregate` [#491](https://github.com/dreamRs/shinyWidgets/issues/491).
* Fixed highlightedDates no longer works for `airDatePicker()` [#532](https://github.com/dreamRs/shinyWidgets/issues/532).




shinyWidgets 0.7.3
======================

* Updated [air-datepicker](https://github.com/t1m0n/air-datepicker) to 3.2.1 with language support for italian and arabic.
* Fixed `airDatepickerInput()` z-index and buttons.
* `dropdown()`: added `block` & `no_outline` arguments.
* `actionBttn()`: added ability to pass arguments to tag container.
* `autonumericInput()`: remove custom CSS styles


### Bug fixes

* `pickerInput`'s custom input to know if the menu is open or closed wasn't working anymore after using `updatePickerInput` [#522](https://github.com/dreamRs/shinyWidgets/issues/522)




shinyWidgets 0.7.2
======================

* Updated [air-datepicker](https://github.com/t1m0n/air-datepicker) library to latest version (3.2.0), updating bindings to use [dayjs](https://github.com/iamkun/dayjs/) to manipulate date.
* `updateNoUiSliderInput()`: new argument `label =` to update the widget's label.

## Breaking changes

* `airDatepickerInput()`: argument `dateFormat` has a new notation, default value changed from `yyyy-mm-dd` to `yyyy-MM-dd`. See https://air-datepicker.com/docs?scrollTo=dateFormat for potential alues.





shinyWidgets 0.7.1
======================

* Updated virtual-select-plugin to 1.0.30
* `pickerInput` bindings: fixed update method when using Bootstrap 5.
* `virtualSelectInput` state (opened or closed) is now available with `input$<inputId>_open`.



shinyWidgets 0.7.0
======================

* New widget `virtualSelectInput()`, a select dropdown widget that support a lot of choices, based on [virtual-select](https://github.com/sa-si-dev/virtual-select) JavaScript library.
* Updated bootstrap-select to v1.14.0-beta3, to make `pickerInput()` works with Bootstrap 5.
* Updated `alert()` and `panel()` Bootstrap utilities to work with Bootstrap 5.

### Bug fixes
* Removed `formula` argument from `aggregate()` to accomode to R 4.2.0 (fix [#491](https://github.com/dreamRs/shinyWidgets/issues/491))



shinyWidgets 0.6.4
======================

### Bug fixes
* Revert `bootstrap-switch-js` to 3.3.4 to fix bug when `value = TRUE`.
* Fixed a bug in `colorSelectorInput()` causing not returning an input value.



shinyWidgets 0.6.3
======================

*  Following functions are now compatible with Bootstrap 4 & 5, when using `bslib::bs_theme()` :
    + `radioGroupButtons()`
    + `checkboxGroupButtons()`
    + `textInputIcon()`
    + `numericInputIcon()`
* `checkboxGroupButtons()`/`radioGroupButtons()`: `status` argument now accept a vector, thanks to [@jassler](https://github.com/jassler) ([#440](https://github.com/dreamRs/shinyWidgets/pull/440))
* `downloadBttn()` now has a `icon` argument.
* `switchInput()` is now themable with {bslib}, thanks to [@AshesITR](https://github.com/AshesITR) ([#454](https://github.com/dreamRs/shinyWidgets/pull/454))

### Bug fixes
* `updateNumericRangeInput()` failed to correctly update `label` ([#441](https://github.com/dreamRs/shinyWidgets/issues/441))
* `verticalTabsetPanel()` didn't work inside `renderUI` and with more than one panel ([#446](https://github.com/dreamRs/shinyWidgets/issues/446))
* `statiCard()`: fixed rendering in `renderUI` and value not displayed if animation interrupted ([#406](https://github.com/dreamRs/shinyWidgets/issues/406), [#407](https://github.com/dreamRs/shinyWidgets/issues/407))
* `checkboxGroupButtons()`/`radioGroupButtons()` fixed `justified = TRUE` argument compatibility with Bootstrap 4 (fix [#423](https://github.com/dreamRs/shinyWidgets/issues/423))


shinyWidgets 0.6.2
======================

* `numericRangeInput()`: added `min`, `max`, `step` arguments.
* `shinyWidgetsGallery()`: switch to Font-Awesome 5 icon names (to accomodate with Shiny 1.7.0).



shinyWidgets 0.6.1
======================

* Add transparent border to `setSliderColor()`, thanks to [@shannonpileggi](https://github.com/shannonpileggi) ([#396](https://github.com/dreamRs/shinyWidgets/pull/396))
* Add commas in value and total of `progressBar()`, thanks to [@swsoyee](https://github.com/swsoyee) ([#388](https://github.com/dreamRs/shinyWidgets/pull/388))
* Add position absolute to `awesomeCheckboxGroup()`, thanks to [@MayaGans](https://github.com/MayaGans) ([#390](https://github.com/dreamRs/shinyWidgets/pull/390))
* `autonumericInput()`: distinguish between no input and input=0, see [#384](https://github.com/dreamRs/shinyWidgets/issues/384)
* Update of `disabledDates` argument's behavior in `updateAirDateInput()`, see [#379](https://github.com/dreamRs/shinyWidgets/issues/379)
* Updated [sweetalert2](https://sweetalert2.github.io/) dependencies to 11.1.4
* `inputSweetAlert()`: added email and url types.
* `inputSweetAlert()`: allow javascript code, for example to use argument `inputValidator` with a function.



shinyWidgets 0.6.0
======================

* [{bslib}](https://github.com/rstudio/bslib) support for `pretty***()` and `awesome***()` functions.
* Update to work with [{shinydashboardPlus}](https://github.com/RinteRface/shinydashboardPlus) 2.0.0
* `updateAirDateInput()` has new arguments `show` and `hide` to show/hide the picker from server.
* New `colorPickr()` function: a color picker based on https://github.com/Simonwep/pickr.
* Updated skins available in `chooseSliderSkin()`.



shinyWidgets 0.5.7
======================

* Fixed `chooseSliderSkin()` to work with shiny > 1.6.0
* Temporary fix for `pickerInput()` to work with shiny > 1.6.0 (this is fixed in dev version of shiny).
* `airDatepickerInput()` had a new argument `highlightedDates` to mark some dates in calendar as specific.
* Fixed timezone issues in `updateAirDateInput()` by [@ericnewkirk](https://github.com/ericnewkirk).



shinyWidgets 0.5.6
======================

* Fixed failing test with upcoming shiny release



shinyWidgets 0.5.5
======================

* `show_alert()`, `sendSweetAlert()` and `inputSweetAlert()` now accept parameters directly passed to JavaScript method.
* New function `statiCard()` to create minimal statistic cards.
* `airDatepicker()` now support italian, thanks to [@ClaudioZandonella](https://github.com/ClaudioZandonella).



shinyWidgets 0.5.4
======================

* New functions: `currencyInput()`, `formatNumericInput()` and `autonumericInput()` to enter numeric value with specified format like a currency, by [@srmatth](https://github.com/srmatth).
* Ability to update icons in `updateNumericInputIcon()` and `updateTextInputIcon()`.
* SweetAlert family: upgraded to 9.17.1 and added a polyfill to work in Internet Explorer (see `useSweetAlert()`).


### Bug fixes

* Disable `radioGroupButtons()` and `checkboxGroupButtons()` with checkIcon not working properly ([#311](https://github.com/dreamRs/shinyWidgets/issues/311))



shinyWidgets 0.5.3
======================

* Fixed `airDatepickerInput()` z-index issue (causing incorrect display in modal or sidebar).
* Fixed a bug in `downloadBttn()` causing download to be triggered twice.
* Added the ability to disable completely or partially `radioGroupButtons()` and `checkboxGroupButtons()` via respective update methods.
* UI validation in `numericInputIcon()` if min and/or max are provided and value is outside range.



shinyWidgets 0.5.2
======================

* New function `execute_safely()` to display a message in case of error and don't stop application.
* `airDatepickerInput()` has two new arguments: 
  + `onlyTimepicker`: to only display the time picker part of the widget.
  + `firstDay`: day index from which week will be started
* `knobInput()` has two new arguments : `pre` and `post` to add prefix/suffix to the value displayed.
* Updated `awesome*()` dependencies.
* Sweet alert family:
    + update dependencies to 9.10.13
    + New function `show_toast()` to display toast notification.
    + New functions `show_alert()` and `ask_confirmation()` aliases for `sendSweetAlert()` and `confirmSweetAlert()` with optional session argument.


### Bug fixes

* Changes in `dropMenu()` bindings to work with inputs updates.
* `downloadBttn()` worked only when clicking the label, now you can click the full button [#271](https://github.com/dreamRs/shinyWidgets/issues/271).



shinyWidgets 0.5.1
======================

* Added two new functions : `textInputIcon()` (as a replacement of `textInputAddon()`) and `numericInputIcon()` to display icon(s) along to text and numeric inputs.
* Internal rewrite of `airDatepickerInput`, no breaking change intended, if encounter some troubles please open an issue.
* `airDatepickerInput()` has a new argument `startView` to set the view displayed when date picker is openned.
* New function `dropMenu`, a more robust and customizable replacement for `dropdown()` or `dropdownMenu()`.
* Fixed encoding bug in `updatePickerInput()`.



shinyWidgets 0.5.0
======================

* `selectizeGroupServer() `(module `selectizeGroup`) now accept `reactive` data and `reactive` vars arguments, see examples for details `?selectizeGroupServer`.
* Internal optimization of `pickerInput` for large list of choices.
* `pickerInput()`'s `choicesOpt` argument now accept an element `tokens` that can be use to declare keywords for live-search.
* `pickerUpdate()` : updated dependencies & bindings, now live-search & multiple selection works fine together [#142](https://github.com/dreamRs/shinyWidgets/issues/142).
* `useSweetAlert()` now accept a `theme` argument to customize Sweet Alerts appearance (e.g. with `sendSweetAlert` for example).
* `updateMulti()` preserve character encoding [#232](https://github.com/dreamRs/shinyWidgets/issues/232).
* Fixed a bug in `verticalTabPanel()` preventing outputs to be displayed [#237](https://github.com/dreamRs/shinyWidgets/issues/237).



shinyWidgets 0.4.9
======================

* Update to SweetAlert2: more options available for `sendSweetAlert()`, `confirmSweetAlert()`, `inputSweetAlert()`.
* add `useTablerDash()` to import functions from [tablerDash](https://github.com/RinteRface/tablerDash).
* `updateProgressBar()`, `confirmSweetAlert()`, `inputSweetAlert()` are now module friendly, thanks to [@AshesITR](https://github.com/AshesITR).
* add `inline = TRUE/FALSE` argument to `dropdownButton()`: return either a span or a div element.
* You can now use a `DT::datatable()` with pagination inside a `dropdown()`.
* Removed extra margins (top and bottom, 3px each) in `radioGroupButtons()` and `checkboxGroupButtons()`.
* add `inline = TRUE/FALSE` argument to `pickerGroupUI()`: put pickers side-by-side (default) or one of top of each other.



shinyWidgets 0.4.8
======================

* Remove a unit test that was not compatible with an upcoming version of Shiny.



shinyWidgets 0.4.7
======================

* add `useArgonDash` to import functions from argonDash.
* add `useBs4Dash` to import functions from bs4Dash.
* Fix updating `searchInput` label & placeholder in modules.
* Fix issue with ghost sidebar in `useShinydashboard`.
* Fix issue updating `prettyRadio` & `prettyCheckbox` with icons.



shinyWidgets 0.4.5
======================

* Fix a bug with `awesome*` widgets due to FontAwesome upgrade in Shiny [@AshesITR](https://github.com/AshesITR).
* New methods for mutating vertical tabs (`appendVerticalTab`, `removeVerticalTab`, `reorderVerticalTabs`) by [@ifellows](https://github.com/ifellows)
* New widget `numericRangeInput` by [@wkdavis](https://github.com/wkdavis).



shinyWidgets 0.4.4
======================

* New function `updateMultiInput` for updating `multiInput`, thanks to [@ifellows](https://github.com/ifellows).
* New function `updateVerticalTabsetPanel` for updating `verticalTabsetPanel`.
* Update options for `knobInput` and `airDatepickerInput`.
* Custom unit & range in progress bars (arguments `unit_mark` & `range_value` in `progressBar`).
* Argument `update_on` to choose when trigger update server-side in `spectrumInput`.
* Vertical layout in `selectizeGroup`.
* New function `pickerOptions` to help using `pickerInput` options argument.
* Bug fix with size argument in `actionGroupButtons`.
* `dropdown` button act like an `actionButton` (same behavior as `dropdownButton`)
* Update Bootstrap-Select JavaScript library from 1.12.4 to 1.13.3 (used in `pickerInput`).



shinyWidgets 0.4.3
======================

* New functions to customize `sliderInput` : `chooseSliderSkin` and `setSliderColor` by [@DivadNojnarg](https://github.com/DivadNojnarg).
* New function `downloadBttn`, a `downloadButton` with custom appearance.
* New widget `airDatepickerInput`, to select single, multiple and range of dates. You can also select time. And two shortcuts to select months or years.
* New function to add spinners when outputs are recalculating.
* New function `useShinydashboard` to use functions from 'shinydashboard' into a classic 'shiny' app, specifically `valueBox`, `infoBox` and `box`.
* New functions `setBackgroundColor` and `setBackgroundImage` to change background color or use an image, by [@DivadNojnarg](https://github.com/DivadNojnarg).


shinyWidgets 0.4.2
======================

* New function `updateSearchInput` to update `searchInput` server-side [#52](https://github.com/dreamRs/shinyWidgets/issues/52).
* New argument `inline` to `prettySwitch`, `prettyToggle` and `prettyCheckbox` to position checkboxes side by side.
* New argument `html` to `confirmSweetAlert` and `sendSweetAlert` to pass HTML tags in alert window [#48](https://github.com/dreamRs/shinyWidgets/issues/48).
* New Shiny modules to create dependent select menu : `selectizeGroup` and `pickerGroup`.
* New widget : `noUiSlider`, a minimal slider range for numeric values.



shinyWidgets 0.4.1
======================

* New functions with Sweet Alert : `confirmSweetAlert` (confirmation dialog box), `inputSweetAlert` (text input dialog box), `progressSweetAlert` (progress bar in popup).
* Update Sweet Alert library to 2.O
* `sendSweetAlert` works without using `useSweetAlert` in UI.
* Update multi.js to 0.2.4
* Update bootstrap switch to 3.3.4
* Change minimal version of R to 3.3.1
* Function to toggle dropdown server-side : `toggleDropdownButton`.

Bug fixes :
* Fix logic on when btn-size class is added to button by [@coolbutuseless](https://github.com/coolbutuseless).
* Bug in dependencies between `pretty*` and `bttn`.




shinyWidgets 0.4.0
======================

* New widget : `spectrumInput` for choosing colors in palettes or custom one.
* New widgets : `prettyCheckbox`, `prettySwitch`, `prettyToggle`, `prettyCheckboxGroup` and `prettyRadioButtons` for create pretty checkboxes,
toggle switch, radio buttons with colors, icons and a lot of options.
* New widget : `knobInput` a round slider, thanks to @DivadNojnarg.

Bug fixes:
* Bug when initializing (in modal window or in `renderUI`) `pickerInput` and `switchInput`.
* `awesomeCheckboxGroup` not working when `inline = FALSE`, thanks to @meganhartwell-stemcell, @dStudio-git, @Nicolabo to report this.
* Weird behavior of inputs in `dropdown` reported by @markdumke.



shinyWidgets 0.3.6
==================

* New widget : `sliderTextInput` : a slider for character vector.
* New arguments `choiceNames` & `choiceValues` for `checkboxGroupButtons` & `radioGroupButtons` to easily pass HTML in the names displayed on the buttons.
* New argument `inline` to `materialSwitch`, thanks to @FrissAnalytics.


shinyWidgets 0.3.5
==================

* Support for bookmarking state.
* Support for tooltip from `bsplus`.
* Upgrade `pickerInput` to bootstrap-select 1.12.4.
* Upgrade `switchInput` to bootstrap-switch 3.3.4.
* Remove `receiveSweetAlert` for simpler use with `useSweetAlert`.
* Add inline argument to `materialSwitch` ([#17](https://github.com/dreamRs/shinyWidgets/issues/17)).
* Display code for dropdowns in gallery.



shinyWidgets 0.3.4
==================

This release fix a bug in the gallery and add tests.


### Bug fixes
* Fix a bug when in `checkboxGroupButtons` when `individual = TRUE`, causing `shinyWidgetsGallery` on launch.



shinyWidgets 0.3.3
==================

Several updates methods implemented.

### New features
* Add function `updateAwesomeCheckbox` for updating single awesome checkbox.
* New function `panel` to create similar panel than in shinydashboard.
* New arguments and examples for `updateSwitchInput`, `updateRadioGroupButtons`, `updateCheckboxGroupButtons`, `updateAwesomeRadio`, `updateAwesomeCheckboxGroup`

### Minor new features and improvements
* Buttons in `searchInput` are now `actionButton`, see #11



shinyWidgets 0.3.2
==================

Better documentation and examples. Alternative function to create a dropdown. New function `colorSelector`.
