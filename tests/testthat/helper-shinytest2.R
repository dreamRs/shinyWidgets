# I do this in a helper (rather than in testthat.R) so that it loads when
# testing locally.

if (rlang::is_installed("shinytest2", version = "0.4.1")) {
  library(shinytest2)
  options(chromote.headless = "new")
}
