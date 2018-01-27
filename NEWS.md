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
