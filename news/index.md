# Changelog

## shinyWidgets 0.9.1

CRAN release: 2026-03-09

- New widget
  [`quercusInput()`](https://dreamrs.github.io/shinyWidgets/reference/quercusInput.md),
  hierarchical treeview component based on JavaScript library
  [quercus.js](https://github.com/stefaneichert/quercus.js).
- Updated virtual-select to 1.1.0, see
  <https://github.com/sa-si-dev/virtual-select/releases>.
- Updated air-datepicker to 3.6.0, see
  <https://github.com/t1m0n/air-datepicker?tab=readme-ov-file#v360>
- Updated vanilla-calendar-pro to 3.1.0, see
  <https://github.com/uvarov-frontend/vanilla-calendar-pro/releases>

## shinyWidgets 0.9.0

CRAN release: 2025-02-21

- New widget
  [`calendarProInput()`](https://dreamrs.github.io/shinyWidgets/reference/calendarProInput.md),
  a date and time picker component based on JavaScript library
  [vanilla-calendar-pro](https://github.com/uvarov-frontend/vanilla-calendar-pro).
- [`virtualSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/virtualSelectInput.md):
  ability to set a JavaScript function as callback for
  `selectedLabelRenderer`.
- New argument `inputType` in
  [`searchInput()`](https://dreamrs.github.io/shinyWidgets/reference/searchInput.md)
  and
  [`textInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/textInputIcon.md)
  to specify the input’s type, for example `"password"`.
- [`knobInput()`](https://dreamrs.github.io/shinyWidgets/reference/knobInput.md)
  and
  [`switchInput()`](https://dreamrs.github.io/shinyWidgets/reference/switchInput.md)
  are softly deprecated, since the JavaScript libraries used by those
  widgets are no longer actively maintained.
- Updated virtual-select to 1.0.47 (fix focus issue), see
  <https://github.com/sa-si-dev/virtual-select/releases>.
- Updated [@simonwep](https://github.com/simonwep)/pickr to 1.9.1, see
  <https://github.com/simonwep/pickr/releases>.

## shinyWidgets 0.8.7

CRAN release: 2024-09-23

- New widget :
  [`slimSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/slimSelectInput.md),
  an alternative select menu.
- Updated virtual-select to 1.0.45, see
  <https://github.com/sa-si-dev/virtual-select/releases>.
- [`airDatepickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md)
  &
  [`updateAirDateInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateAirDateInput.md):
  added a `tz` argument to specify timezone.
- [`checkboxGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/checkboxGroupButtons.md)
  &
  [`radioGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/radioGroupButtons.md):
  fixed justified layout when using individual buttons.

## shinyWidgets 0.8.6

CRAN release: 2024-04-24

- Fixed a bug in
  [`updateAirDateInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateAirDateInput.md)
  when updating selected value with no options.
- Updated virtual-select to 1.0.43, see
  <https://github.com/sa-si-dev/virtual-select/releases>.

## shinyWidgets 0.8.5

CRAN release: 2024-04-17

- [`WinBox()`](https://dreamrs.github.io/shinyWidgets/reference/WinBox.md):
  added `auto_index` argument to automatically open window above all
  others.
- Added
  [`applyWinBox()`](https://dreamrs.github.io/shinyWidgets/reference/WinBox.md)
  to apply arbitrary method on an existing window.

## shinyWidgets 0.8.4

CRAN release: 2024-04-04

- Fixed a bug in
  [`updateAirDateInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateAirDateInput.md)
  when updating selected value and options at the same time
  [\#684](https://github.com/dreamRs/shinyWidgets/issues/684).
- New widget
  [`WinBox()`](https://dreamrs.github.io/shinyWidgets/reference/WinBox.md)
  to manage multiple windows in an app,
  <https://nextapps-de.github.io/winbox/>.

## shinyWidgets 0.8.3

CRAN release: 2024-03-21

- Updated virtual-select-plugin to 1.0.42 and inclued tooltip plugin,
  [\#674](https://github.com/dreamRs/shinyWidgets/pull/674) by
  [@stla](https://github.com/stla).
- Updated air-datepicker to 3.5.0.
- Updated noUiSlider to 15.7.1.
- [`updateNoUiSliderInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateNoUiSliderInput.md):
  added `disableHandlers` and `enableHandlers` to disable/enable
  specific handlers.
- [`updateVirtualSelect()`](https://dreamrs.github.io/shinyWidgets/reference/updateVirtualSelect.md)
  : added `open` argument to open/close the dropdown.
- [`virtualSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/virtualSelectInput.md)
  added `updateOn` argument to to set when input is updated: on change
  or on close.
- New widget
  [`timeInput()`](https://dreamrs.github.io/shinyWidgets/reference/time-input.md)
  to select time using browser input.

## shinyWidgets 0.8.2

CRAN release: 2024-03-01

- New feature for
  [`virtualSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/virtualSelectInput.md)
  : ability to use JavaScript functions for `onServerSearch` or
  `labelRenderer` parameters, by
  [@MichalLauer](https://github.com/MichalLauer).
- New feature for
  [`virtualSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/virtualSelectInput.md)
  /
  [`prepare_choices()`](https://dreamrs.github.io/shinyWidgets/reference/prepare_choices.md)
  : added classNames as optional argument, by
  [@SverreFL](https://github.com/SverreFL).
- Updated air-datepicker to 3.4.0 (with croatian and bulgarian locale),
  fix [\#668](https://github.com/dreamRs/shinyWidgets/issues/668).
- [`updatePickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/updatePickerInput.md)
  : fix max option group, fix
  [\#670](https://github.com/dreamRs/shinyWidgets/issues/670).
- Fix JavaScript errors generated by
  [`updateProgressBar()`](https://dreamrs.github.io/shinyWidgets/reference/progress-bar.md),
  fix [\#656](https://github.com/dreamRs/shinyWidgets/issues/656).

## shinyWidgets 0.8.1

CRAN release: 2024-01-10

- [`searchInput()`](https://dreamrs.github.io/shinyWidgets/reference/searchInput.md)
  : added `btnClass` argument to set class of search and reset buttons.
- Addition of autocomplete parameter for
  [`pickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/pickerInput.md)
  and
  [`multiInput()`](https://dreamrs.github.io/shinyWidgets/reference/multiInput.md),
  [\#652](https://github.com/dreamRs/shinyWidgets/pull/652) by
  [@MichalLauer](https://github.com/MichalLauer).

#### Bug fixes

- [`pickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/pickerInput.md)
  : fix choicesOpts with grouped choices
  [\#650](https://github.com/dreamRs/shinyWidgets/issues/650)
- [`updateProgressBar()`](https://dreamrs.github.io/shinyWidgets/reference/progress-bar.md)
  : accept HTML in title
  [\#651](https://github.com/dreamRs/shinyWidgets/issues/651)
- don’t use system.file for packer htmldependencies
- [`searchInput()`](https://dreamrs.github.io/shinyWidgets/reference/searchInput.md)
  : remove inline CSS and `!important` use
  [\#637](https://github.com/dreamRs/shinyWidgets/issues/637)

## shinyWidgets 0.8.0

CRAN release: 2023-08-30

- [`shinyWidgetsGallery()`](https://dreamrs.github.io/shinyWidgets/reference/shinyWidgetsGallery.md)
  new look for the gallery and two new tabs (for
  [`airDatepickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md)
  and
  [`virtualSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/virtualSelectInput.md)).
- [`airDatepickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md)
  : added arguments :
  - `disabledDaysOfWeek` to disable day(s) of the week.
  - `readonly` to prevent edit in the input field.
  - `onkeydown` to add onkeydown attribute on the input field.
- [`materialSwitch()`](https://dreamrs.github.io/shinyWidgets/reference/materialSwitch.md)
  : click on the label now toggle the switch
  [\#582](https://github.com/dreamRs/shinyWidgets/issues/582).
- [`pickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/pickerInput.md)
  : added argument `stateInput` to activate or deactivate the special
  input value `input$<inputId>_open` allowing to know if the menu is
  opened or not.
- [`updateColorPickr()`](https://dreamrs.github.io/shinyWidgets/reference/updateColorPickr.md)
  : added argument `swatches` to update swatches from server.
- Updated virtual-select-plugin to 1.0.39 (fix
  [\#601](https://github.com/dreamRs/shinyWidgets/issues/601)).
- Updated sweetalert2 to v11.7.27.
- Updated air-datepicker to 3.3.5.

#### Bug fixes

- [`verticalTabsetPanel()`](https://dreamrs.github.io/shinyWidgets/reference/vertical-tab.md)
  does not render output content when using Bootstrap 5
  [\#570](https://github.com/dreamRs/shinyWidgets/issues/570).
- `virtualSelectInput` : fixed crash with choices=list()
  [\#571](https://github.com/dreamRs/shinyWidgets/issues/571).

#### Deprecated functions

- [`useShinydashboard()`](https://dreamrs.github.io/shinyWidgets/reference/deprecated.md),
  [`useShinydashboardPlus()`](https://dreamrs.github.io/shinyWidgets/reference/deprecated.md),
  [`useTablerDash()`](https://dreamrs.github.io/shinyWidgets/reference/deprecated.md),
  [`useArgonDash()`](https://dreamrs.github.io/shinyWidgets/reference/deprecated.md),
  [`useBs4Dash()`](https://dreamrs.github.io/shinyWidgets/reference/deprecated.md),
  [`setShadow()`](https://dreamrs.github.io/shinyWidgets/reference/deprecated.md),
  [`setSliderColor()`](https://dreamrs.github.io/shinyWidgets/reference/deprecated.md)
  are deprecated and will be removed in a future release.
- `selectizeGroupUI/selectizeGroupServer` module is deprecated, use
  equivalent [Select Group Input
  Module](https://dreamrs.github.io/datamods/reference/select-group.html)
  in package [datamods](https://github.com/dreamRs/datamods/)

## shinyWidgets 0.7.6

CRAN release: 2023-01-08

- Updated virtual-select-plugin to 1.0.37.
- Updated air-datepicker to 3.3.3, fix
  [\#553](https://github.com/dreamRs/shinyWidgets/issues/553).

#### Bug fixes

- [`verticalTabsetPanel()`](https://dreamrs.github.io/shinyWidgets/reference/vertical-tab.md)
  does not work with bslib using Bootstrap 5
  [\#549](https://github.com/dreamRs/shinyWidgets/issues/549).

## shinyWidgets 0.7.5

CRAN release: 2022-11-17

- Updated virtual-select-plugin to 1.0.34.
- Updated air-datepicker to 3.3.1 with language support for japanese and
  korean.
- Updated
  [`treeInput()`](https://dreamrs.github.io/shinyWidgets/reference/treeInput.md)
  collapse and expand methods (in javascript).

#### Bug fixes

- [`multiInput()`](https://dreamrs.github.io/shinyWidgets/reference/multiInput.md)
  is no longer renders HTML tags inside values
  [\#545](https://github.com/dreamRs/shinyWidgets/issues/545).
- [`awesomeCheckboxGroup()`](https://dreamrs.github.io/shinyWidgets/reference/awesomeCheckboxGroup.md)
  errors when colon in choices
  [\#543](https://github.com/dreamRs/shinyWidgets/issues/543).

## shinyWidgets 0.7.4

CRAN release: 2022-10-05

- New widget
  [`treeInput()`](https://dreamrs.github.io/shinyWidgets/reference/treeInput.md)
  based on [treejs](https://github.com/daweilv/treejs) library.
- Updated virtual-select-plugin to 1.0.33.
- [`updateVirtualSelect()`](https://dreamrs.github.io/shinyWidgets/reference/updateVirtualSelect.md)
  has a new argument `disabledChoices` to disable some choices from the
  menu.
- It’s now possible to use variable with space in their name in
  `selectizeGroup` module, thanks to
  [@evgeniyftw](https://github.com/evgeniyftw).

#### Bug fixes

- [`switchInput()`](https://dreamrs.github.io/shinyWidgets/reference/switchInput.md)
  produced an error when using `bslib::bs_theme(version = "3")`
  [\#528](https://github.com/dreamRs/shinyWidgets/issues/528).
- Fixed a bug in `pickerGroup` module when using `aggregate`
  [\#491](https://github.com/dreamRs/shinyWidgets/issues/491).
- Fixed highlightedDates no longer works for `airDatePicker()`
  [\#532](https://github.com/dreamRs/shinyWidgets/issues/532).

## shinyWidgets 0.7.3

CRAN release: 2022-08-31

- Updated [air-datepicker](https://github.com/t1m0n/air-datepicker) to
  3.2.1 with language support for italian and arabic.
- Fixed
  [`airDatepickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md)
  z-index and buttons.
- [`dropdown()`](https://dreamrs.github.io/shinyWidgets/reference/dropdown.md):
  added `block` & `no_outline` arguments.
- [`actionBttn()`](https://dreamrs.github.io/shinyWidgets/reference/actionBttn.md):
  added ability to pass arguments to tag container.
- [`autonumericInput()`](https://dreamrs.github.io/shinyWidgets/reference/autonumericInput.md):
  remove custom CSS styles

#### Bug fixes

- `pickerInput`’s custom input to know if the menu is open or closed
  wasn’t working anymore after using `updatePickerInput`
  [\#522](https://github.com/dreamRs/shinyWidgets/issues/522)

## shinyWidgets 0.7.2

CRAN release: 2022-08-07

- Updated [air-datepicker](https://github.com/t1m0n/air-datepicker)
  library to latest version (3.2.0), updating bindings to use
  [dayjs](https://github.com/iamkun/dayjs/) to manipulate date.
- [`updateNoUiSliderInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateNoUiSliderInput.md):
  new argument `label =` to update the widget’s label.

### Breaking changes

- [`airDatepickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md):
  argument `dateFormat` has a new notation, default value changed from
  `yyyy-mm-dd` to `yyyy-MM-dd`. See
  <https://air-datepicker.com/docs?scrollTo=dateFormat> for potential
  alues.

## shinyWidgets 0.7.1

CRAN release: 2022-07-13

- Updated virtual-select-plugin to 1.0.30
- `pickerInput` bindings: fixed update method when using Bootstrap 5.
- `virtualSelectInput` state (opened or closed) is now available with
  `input$<inputId>_open`.

## shinyWidgets 0.7.0

CRAN release: 2022-05-11

- New widget
  [`virtualSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/virtualSelectInput.md),
  a select dropdown widget that support a lot of choices, based on
  [virtual-select](https://github.com/sa-si-dev/virtual-select)
  JavaScript library.
- Updated bootstrap-select to v1.14.0-beta3, to make
  [`pickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/pickerInput.md)
  works with Bootstrap 5.
- Updated
  [`alert()`](https://dreamrs.github.io/shinyWidgets/reference/bootstrap-utils.md)
  and
  [`panel()`](https://dreamrs.github.io/shinyWidgets/reference/bootstrap-utils.md)
  Bootstrap utilities to work with Bootstrap 5.

#### Bug fixes

- Removed `formula` argument from
  [`aggregate()`](https://rdrr.io/r/stats/aggregate.html) to accomode to
  R 4.2.0 (fix
  [\#491](https://github.com/dreamRs/shinyWidgets/issues/491))

## shinyWidgets 0.6.4

CRAN release: 2022-02-06

#### Bug fixes

- Revert `bootstrap-switch-js` to 3.3.4 to fix bug when `value = TRUE`.
- Fixed a bug in
  [`colorSelectorInput()`](https://dreamrs.github.io/shinyWidgets/reference/colorSelectorInput.md)
  causing not returning an input value.

## shinyWidgets 0.6.3

CRAN release: 2022-01-10

- Following functions are now compatible with Bootstrap 4 & 5, when
  using
  [`bslib::bs_theme()`](https://rstudio.github.io/bslib/reference/bs_theme.html)
  :
  - [`radioGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/radioGroupButtons.md)
  - [`checkboxGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/checkboxGroupButtons.md)
  - [`textInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/textInputIcon.md)
  - [`numericInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/numericInputIcon.md)
- [`checkboxGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/checkboxGroupButtons.md)/[`radioGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/radioGroupButtons.md):
  `status` argument now accept a vector, thanks to
  [@jassler](https://github.com/jassler)
  ([\#440](https://github.com/dreamRs/shinyWidgets/pull/440))
- [`downloadBttn()`](https://dreamrs.github.io/shinyWidgets/reference/downloadBttn.md)
  now has a `icon` argument.
- [`switchInput()`](https://dreamrs.github.io/shinyWidgets/reference/switchInput.md)
  is now themable with {bslib}, thanks to
  [@AshesITR](https://github.com/AshesITR)
  ([\#454](https://github.com/dreamRs/shinyWidgets/pull/454))

#### Bug fixes

- [`updateNumericRangeInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateNumericRangeInput.md)
  failed to correctly update `label`
  ([\#441](https://github.com/dreamRs/shinyWidgets/issues/441))
- [`verticalTabsetPanel()`](https://dreamrs.github.io/shinyWidgets/reference/vertical-tab.md)
  didn’t work inside `renderUI` and with more than one panel
  ([\#446](https://github.com/dreamRs/shinyWidgets/issues/446))
- [`statiCard()`](https://dreamrs.github.io/shinyWidgets/reference/stati-card.md):
  fixed rendering in `renderUI` and value not displayed if animation
  interrupted
  ([\#406](https://github.com/dreamRs/shinyWidgets/issues/406),
  [\#407](https://github.com/dreamRs/shinyWidgets/issues/407))
- [`checkboxGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/checkboxGroupButtons.md)/[`radioGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/radioGroupButtons.md)
  fixed `justified = TRUE` argument compatibility with Bootstrap 4 (fix
  [\#423](https://github.com/dreamRs/shinyWidgets/issues/423))

## shinyWidgets 0.6.2

CRAN release: 2021-09-17

- [`numericRangeInput()`](https://dreamrs.github.io/shinyWidgets/reference/numericRangeInput.md):
  added `min`, `max`, `step` arguments.
- [`shinyWidgetsGallery()`](https://dreamrs.github.io/shinyWidgets/reference/shinyWidgetsGallery.md):
  switch to Font-Awesome 5 icon names (to accomodate with Shiny 1.7.0).

## shinyWidgets 0.6.1

CRAN release: 2021-09-06

- Add transparent border to
  [`setSliderColor()`](https://dreamrs.github.io/shinyWidgets/reference/deprecated.md),
  thanks to [@shannonpileggi](https://github.com/shannonpileggi)
  ([\#396](https://github.com/dreamRs/shinyWidgets/pull/396))
- Add commas in value and total of
  [`progressBar()`](https://dreamrs.github.io/shinyWidgets/reference/progress-bar.md),
  thanks to [@swsoyee](https://github.com/swsoyee)
  ([\#388](https://github.com/dreamRs/shinyWidgets/pull/388))
- Add position absolute to
  [`awesomeCheckboxGroup()`](https://dreamrs.github.io/shinyWidgets/reference/awesomeCheckboxGroup.md),
  thanks to [@MayaGans](https://github.com/MayaGans)
  ([\#390](https://github.com/dreamRs/shinyWidgets/pull/390))
- [`autonumericInput()`](https://dreamrs.github.io/shinyWidgets/reference/autonumericInput.md):
  distinguish between no input and input=0, see
  [\#384](https://github.com/dreamRs/shinyWidgets/issues/384)
- Update of `disabledDates` argument’s behavior in
  [`updateAirDateInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateAirDateInput.md),
  see [\#379](https://github.com/dreamRs/shinyWidgets/issues/379)
- Updated [sweetalert2](https://sweetalert2.github.io/) dependencies to
  11.1.4
- [`inputSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/inputSweetAlert.md):
  added email and url types.
- [`inputSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/inputSweetAlert.md):
  allow javascript code, for example to use argument `inputValidator`
  with a function.

## shinyWidgets 0.6.0

CRAN release: 2021-03-15

- [{bslib}](https://github.com/rstudio/bslib) support for `pretty***()`
  and `awesome***()` functions.
- Update to work with
  [{shinydashboardPlus}](https://github.com/RinteRface/shinydashboardPlus)
  2.0.0
- [`updateAirDateInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateAirDateInput.md)
  has new arguments `show` and `hide` to show/hide the picker from
  server.
- New
  [`colorPickr()`](https://dreamrs.github.io/shinyWidgets/reference/colorPickr.md)
  function: a color picker based on <https://github.com/Simonwep/pickr>.
- Updated skins available in
  [`chooseSliderSkin()`](https://dreamrs.github.io/shinyWidgets/reference/chooseSliderSkin.md).

## shinyWidgets 0.5.7

CRAN release: 2021-02-03

- Fixed
  [`chooseSliderSkin()`](https://dreamrs.github.io/shinyWidgets/reference/chooseSliderSkin.md)
  to work with shiny \> 1.6.0
- Temporary fix for
  [`pickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/pickerInput.md)
  to work with shiny \> 1.6.0 (this is fixed in dev version of shiny).
- [`airDatepickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md)
  had a new argument `highlightedDates` to mark some dates in calendar
  as specific.
- Fixed timezone issues in
  [`updateAirDateInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateAirDateInput.md)
  by [@ericnewkirk](https://github.com/ericnewkirk).

## shinyWidgets 0.5.6

CRAN release: 2021-01-20

- Fixed failing test with upcoming shiny release

## shinyWidgets 0.5.5

CRAN release: 2021-01-13

- [`show_alert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert.md),
  [`sendSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert.md)
  and
  [`inputSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/inputSweetAlert.md)
  now accept parameters directly passed to JavaScript method.
- New function
  [`statiCard()`](https://dreamrs.github.io/shinyWidgets/reference/stati-card.md)
  to create minimal statistic cards.
- [`airDatepicker()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md)
  now support italian, thanks to
  [@ClaudioZandonella](https://github.com/ClaudioZandonella).

## shinyWidgets 0.5.4

CRAN release: 2020-10-06

- New functions:
  [`currencyInput()`](https://dreamrs.github.io/shinyWidgets/reference/formatNumericInput.md),
  [`formatNumericInput()`](https://dreamrs.github.io/shinyWidgets/reference/formatNumericInput.md)
  and
  [`autonumericInput()`](https://dreamrs.github.io/shinyWidgets/reference/autonumericInput.md)
  to enter numeric value with specified format like a currency, by
  [@srmatth](https://github.com/srmatth).
- Ability to update icons in
  [`updateNumericInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/updateNumericInputIcon.md)
  and
  [`updateTextInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/updateTextInputIcon.md).
- SweetAlert family: upgraded to 9.17.1 and added a polyfill to work in
  Internet Explorer (see
  [`useSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/useSweetAlert.md)).

#### Bug fixes

- Disable
  [`radioGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/radioGroupButtons.md)
  and
  [`checkboxGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/checkboxGroupButtons.md)
  with checkIcon not working properly
  ([\#311](https://github.com/dreamRs/shinyWidgets/issues/311))

## shinyWidgets 0.5.3

CRAN release: 2020-06-01

- Fixed
  [`airDatepickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md)
  z-index issue (causing incorrect display in modal or sidebar).
- Fixed a bug in
  [`downloadBttn()`](https://dreamrs.github.io/shinyWidgets/reference/downloadBttn.md)
  causing download to be triggered twice.
- Added the ability to disable completely or partially
  [`radioGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/radioGroupButtons.md)
  and
  [`checkboxGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/checkboxGroupButtons.md)
  via respective update methods.
- UI validation in
  [`numericInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/numericInputIcon.md)
  if min and/or max are provided and value is outside range.

## shinyWidgets 0.5.2

CRAN release: 2020-05-14

- New function
  [`execute_safely()`](https://dreamrs.github.io/shinyWidgets/reference/execute_safely.md)
  to display a message in case of error and don’t stop application.
- [`airDatepickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md)
  has two new arguments:
  - `onlyTimepicker`: to only display the time picker part of the
    widget.
  - `firstDay`: day index from which week will be started
- [`knobInput()`](https://dreamrs.github.io/shinyWidgets/reference/knobInput.md)
  has two new arguments : `pre` and `post` to add prefix/suffix to the
  value displayed.
- Updated `awesome*()` dependencies.
- Sweet alert family:
  - update dependencies to 9.10.13
  - New function
    [`show_toast()`](https://dreamrs.github.io/shinyWidgets/reference/show_toast.md)
    to display toast notification.
  - New functions
    [`show_alert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert.md)
    and
    [`ask_confirmation()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert-confirmation.md)
    aliases for
    [`sendSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert.md)
    and
    [`confirmSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert-confirmation.md)
    with optional session argument.

#### Bug fixes

- Changes in
  [`dropMenu()`](https://dreamrs.github.io/shinyWidgets/reference/dropMenu.md)
  bindings to work with inputs updates.
- [`downloadBttn()`](https://dreamrs.github.io/shinyWidgets/reference/downloadBttn.md)
  worked only when clicking the label, now you can click the full button
  [\#271](https://github.com/dreamRs/shinyWidgets/issues/271).

## shinyWidgets 0.5.1

CRAN release: 2020-03-04

- Added two new functions :
  [`textInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/textInputIcon.md)
  (as a replacement of
  [`textInputAddon()`](https://dreamrs.github.io/shinyWidgets/reference/textInputAddon.md))
  and
  [`numericInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/numericInputIcon.md)
  to display icon(s) along to text and numeric inputs.
- Internal rewrite of `airDatepickerInput`, no breaking change intended,
  if encounter some troubles please open an issue.
- [`airDatepickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/airDatepicker.md)
  has a new argument `startView` to set the view displayed when date
  picker is openned.
- New function `dropMenu`, a more robust and customizable replacement
  for
  [`dropdown()`](https://dreamrs.github.io/shinyWidgets/reference/dropdown.md)
  or `dropdownMenu()`.
- Fixed encoding bug in
  [`updatePickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/updatePickerInput.md).

## shinyWidgets 0.5.0

CRAN release: 2019-11-18

- [`selectizeGroupServer()`](https://dreamrs.github.io/shinyWidgets/reference/selectizeGroup-module.md)(module
  `selectizeGroup`) now accept `reactive` data and `reactive` vars
  arguments, see examples for details
  [`?selectizeGroupServer`](https://dreamrs.github.io/shinyWidgets/reference/selectizeGroup-module.md).
- Internal optimization of `pickerInput` for large list of choices.
- [`pickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/pickerInput.md)’s
  `choicesOpt` argument now accept an element `tokens` that can be use
  to declare keywords for live-search.
- `pickerUpdate()` : updated dependencies & bindings, now live-search &
  multiple selection works fine together
  [\#142](https://github.com/dreamRs/shinyWidgets/issues/142).
- [`useSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/useSweetAlert.md)
  now accept a `theme` argument to customize Sweet Alerts appearance
  (e.g. with `sendSweetAlert` for example).
- `updateMulti()` preserve character encoding
  [\#232](https://github.com/dreamRs/shinyWidgets/issues/232).
- Fixed a bug in
  [`verticalTabPanel()`](https://dreamrs.github.io/shinyWidgets/reference/vertical-tab.md)
  preventing outputs to be displayed
  [\#237](https://github.com/dreamRs/shinyWidgets/issues/237).

## shinyWidgets 0.4.9

CRAN release: 2019-09-10

- Update to SweetAlert2: more options available for
  [`sendSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert.md),
  [`confirmSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert-confirmation.md),
  [`inputSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/inputSweetAlert.md).
- add
  [`useTablerDash()`](https://dreamrs.github.io/shinyWidgets/reference/deprecated.md)
  to import functions from
  [tablerDash](https://github.com/RinteRface/tablerDash).
- [`updateProgressBar()`](https://dreamrs.github.io/shinyWidgets/reference/progress-bar.md),
  [`confirmSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert-confirmation.md),
  [`inputSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/inputSweetAlert.md)
  are now module friendly, thanks to
  [@AshesITR](https://github.com/AshesITR).
- add `inline = TRUE/FALSE` argument to
  [`dropdownButton()`](https://dreamrs.github.io/shinyWidgets/reference/dropdownButton.md):
  return either a span or a div element.
- You can now use a
  [`DT::datatable()`](https://rdrr.io/pkg/DT/man/datatable.html) with
  pagination inside a
  [`dropdown()`](https://dreamrs.github.io/shinyWidgets/reference/dropdown.md).
- Removed extra margins (top and bottom, 3px each) in
  [`radioGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/radioGroupButtons.md)
  and
  [`checkboxGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/checkboxGroupButtons.md).
- add `inline = TRUE/FALSE` argument to
  [`pickerGroupUI()`](https://dreamrs.github.io/shinyWidgets/reference/pickerGroup-module.md):
  put pickers side-by-side (default) or one of top of each other.

## shinyWidgets 0.4.8

CRAN release: 2019-03-18

- Remove a unit test that was not compatible with an upcoming version of
  Shiny.

## shinyWidgets 0.4.7

CRAN release: 2019-03-12

- add `useArgonDash` to import functions from argonDash.
- add `useBs4Dash` to import functions from bs4Dash.
- Fix updating `searchInput` label & placeholder in modules.
- Fix issue with ghost sidebar in `useShinydashboard`.
- Fix issue updating `prettyRadio` & `prettyCheckbox` with icons.

## shinyWidgets 0.4.5

CRAN release: 2019-02-18

- Fix a bug with `awesome*` widgets due to FontAwesome upgrade in Shiny
  [@AshesITR](https://github.com/AshesITR).
- New methods for mutating vertical tabs (`appendVerticalTab`,
  `removeVerticalTab`, `reorderVerticalTabs`) by
  [@ifellows](https://github.com/ifellows)
- New widget `numericRangeInput` by
  [@wkdavis](https://github.com/wkdavis).

## shinyWidgets 0.4.4

CRAN release: 2018-11-05

- New function `updateMultiInput` for updating `multiInput`, thanks to
  [@ifellows](https://github.com/ifellows).
- New function `updateVerticalTabsetPanel` for updating
  `verticalTabsetPanel`.
- Update options for `knobInput` and `airDatepickerInput`.
- Custom unit & range in progress bars (arguments `unit_mark` &
  `range_value` in `progressBar`).
- Argument `update_on` to choose when trigger update server-side in
  `spectrumInput`.
- Vertical layout in `selectizeGroup`.
- New function `pickerOptions` to help using `pickerInput` options
  argument.
- Bug fix with size argument in `actionGroupButtons`.
- `dropdown` button act like an `actionButton` (same behavior as
  `dropdownButton`)
- Update Bootstrap-Select JavaScript library from 1.12.4 to 1.13.3 (used
  in `pickerInput`).

## shinyWidgets 0.4.3

CRAN release: 2018-05-30

- New functions to customize `sliderInput` : `chooseSliderSkin` and
  `setSliderColor` by [@DivadNojnarg](https://github.com/DivadNojnarg).
- New function `downloadBttn`, a `downloadButton` with custom
  appearance.
- New widget `airDatepickerInput`, to select single, multiple and range
  of dates. You can also select time. And two shortcuts to select months
  or years.
- New function to add spinners when outputs are recalculating.
- New function `useShinydashboard` to use functions from
  ‘shinydashboard’ into a classic ‘shiny’ app, specifically `valueBox`,
  `infoBox` and `box`.
- New functions `setBackgroundColor` and `setBackgroundImage` to change
  background color or use an image, by
  [@DivadNojnarg](https://github.com/DivadNojnarg).

## shinyWidgets 0.4.2

CRAN release: 2018-03-30

- New function `updateSearchInput` to update `searchInput` server-side
  [\#52](https://github.com/dreamRs/shinyWidgets/issues/52).
- New argument `inline` to `prettySwitch`, `prettyToggle` and
  `prettyCheckbox` to position checkboxes side by side.
- New argument `html` to `confirmSweetAlert` and `sendSweetAlert` to
  pass HTML tags in alert window
  [\#48](https://github.com/dreamRs/shinyWidgets/issues/48).
- New Shiny modules to create dependent select menu : `selectizeGroup`
  and `pickerGroup`.
- New widget : `noUiSlider`, a minimal slider range for numeric values.

## shinyWidgets 0.4.1

CRAN release: 2018-01-28

- New functions with Sweet Alert : `confirmSweetAlert` (confirmation
  dialog box), `inputSweetAlert` (text input dialog box),
  `progressSweetAlert` (progress bar in popup).
- Update Sweet Alert library to 2.O
- `sendSweetAlert` works without using `useSweetAlert` in UI.
- Update multi.js to 0.2.4
- Update bootstrap switch to 3.3.4
- Change minimal version of R to 3.3.1
- Function to toggle dropdown server-side : `toggleDropdownButton`.

Bug fixes : \* Fix logic on when btn-size class is added to button by
[@coolbutuseless](https://github.com/coolbutuseless). \* Bug in
dependencies between `pretty*` and `bttn`.

## shinyWidgets 0.4.0

CRAN release: 2017-11-16

- New widget : `spectrumInput` for choosing colors in palettes or custom
  one.
- New widgets : `prettyCheckbox`, `prettySwitch`, `prettyToggle`,
  `prettyCheckboxGroup` and `prettyRadioButtons` for create pretty
  checkboxes, toggle switch, radio buttons with colors, icons and a lot
  of options.
- New widget : `knobInput` a round slider, thanks to
  [@DivadNojnarg](https://github.com/DivadNojnarg).

Bug fixes: \* Bug when initializing (in modal window or in `renderUI`)
`pickerInput` and `switchInput`. \* `awesomeCheckboxGroup` not working
when `inline = FALSE`, thanks to
[@meganhartwell-stemcell](https://github.com/meganhartwell-stemcell),
[@dStudio-git](https://github.com/dStudio-git),
[@Nicolabo](https://github.com/Nicolabo) to report this. \* Weird
behavior of inputs in `dropdown` reported by
[@markdumke](https://github.com/markdumke).

## shinyWidgets 0.3.6

CRAN release: 2017-10-19

- New widget : `sliderTextInput` : a slider for character vector.
- New arguments `choiceNames` & `choiceValues` for
  `checkboxGroupButtons` & `radioGroupButtons` to easily pass HTML in
  the names displayed on the buttons.
- New argument `inline` to `materialSwitch`, thanks to
  [@FrissAnalytics](https://github.com/FrissAnalytics).

## shinyWidgets 0.3.5

CRAN release: 2017-10-06

- Support for bookmarking state.
- Support for tooltip from `bsplus`.
- Upgrade `pickerInput` to bootstrap-select 1.12.4.
- Upgrade `switchInput` to bootstrap-switch 3.3.4.
- Remove `receiveSweetAlert` for simpler use with `useSweetAlert`.
- Add inline argument to `materialSwitch`
  ([\#17](https://github.com/dreamRs/shinyWidgets/issues/17)).
- Display code for dropdowns in gallery.

## shinyWidgets 0.3.4

CRAN release: 2017-08-15

This release fix a bug in the gallery and add tests.

#### Bug fixes

- Fix a bug when in `checkboxGroupButtons` when `individual = TRUE`,
  causing `shinyWidgetsGallery` on launch.

## shinyWidgets 0.3.3

CRAN release: 2017-08-07

Several updates methods implemented.

#### New features

- Add function `updateAwesomeCheckbox` for updating single awesome
  checkbox.
- New function `panel` to create similar panel than in shinydashboard.
- New arguments and examples for `updateSwitchInput`,
  `updateRadioGroupButtons`, `updateCheckboxGroupButtons`,
  `updateAwesomeRadio`, `updateAwesomeCheckboxGroup`

#### Minor new features and improvements

- Buttons in `searchInput` are now `actionButton`, see
  [\#11](https://github.com/dreamRs/shinyWidgets/issues/11)

## shinyWidgets 0.3.2

CRAN release: 2017-07-24

Better documentation and examples. Alternative function to create a
dropdown. New function `colorSelector`.
