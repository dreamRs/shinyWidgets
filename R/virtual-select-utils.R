
#' @importFrom rlang is_list is_named has_name
is_formatted <- function(x) {
  is_list(x) && !is_named(x) && is_list(x[[1]]) && is_named(x[[1]]) && has_name(x[[1]], "label")
}

#' @importFrom rlang is_list is_named
is_grouped <- function(x) {
  is_list(x) && any(vapply(x, function(y) {
    is_list(y) || is_named(y) || length(y) >  1 || length(y) == 0
  }, logical(1)))
}

#' @importFrom rlang is_bare_atomic is_named %||%
process_choices <- function(choices) {
  if (length(choices) < 1)
    choices <- NULL
  if (inherits(choices, "vs_choices"))
    return(choices)
  if (is_bare_atomic(choices) && !is_named(choices)) {
    output <- list(type = "vector", choices = choices)
  } else if (is_formatted(choices)) {
    output <- list(type = "formatted", choices = choices)
  } else {
    if (is_grouped(choices)) {
      output <- list(
        type = "transpose_group",
        choices = lapply(
          X = seq_along(choices),
          FUN = function(i) {
            this <- choices[[i]]
            values <- unname(unlist(this, use.names = FALSE))
            values <- as.character(values)
            list(
              label = names(choices)[i],
              options = list(
                label = names(this) %||% values,
                value = values
              )
            )
          }
        )
      )
    } else {
      values <- unname(unlist(choices, use.names = FALSE))
      values <- as.character(values)
      output <- list(
        type = "transpose",
        choices = list(
          label = names(choices) %||% values,
          value = values
        )
      )
    }
  }
  return(output)
}
