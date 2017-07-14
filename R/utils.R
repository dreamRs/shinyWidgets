

# Unexported usefull functions from shiny



# dropNulls
dropNulls <- function (x)
{
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}


# choicesWithNames
choicesWithNames <- function (choices)
{
  listify <- function(obj) {
    makeNamed <- function(x) {
      if (is.null(names(x)))
        names(x) <- character(length(x))
      x
    }
    res <- lapply(obj, function(val) {
      if (is.list(val))
        listify(val)
      else if (length(val) == 1 && is.null(names(val)))
        val
      else makeNamed(as.list(val))
    })
    makeNamed(res)
  }
  choices <- listify(choices)
  if (length(choices) == 0)
    return(choices)
  choices <- mapply(choices, names(choices), FUN = function(choice,
                                                            name) {
    if (!is.list(choice))
      return(choice)
    if (name == "")
      stop("All sub-lists in \"choices\" must be named.")
    choicesWithNames(choice)
  }, SIMPLIFY = FALSE)
  missing <- names(choices) == ""
  names(choices)[missing] <- as.character(choices)[missing]
  choices
}



# needOptgroup
needOptgroup <- function (choices)
{
  any(vapply(choices, is.list, logical(1)))
}

# validateSelected
validateSelected <- function (selected, choices, inputId)
{
  selected <- unname(selected)
  if (needOptgroup(choices))
    return(selected)
  if (is.list(choices))
    choices <- unlist(choices)
  nms <- names(choices)
  if (identical(nms, unname(choices)))
    return(selected)
  i <- (selected %in% nms) & !(selected %in% choices)
  if (any(i)) {
    warnFun <- if (all(i)) {
      selected <- unname(choices[selected])
      warning
    }
    else stop
    warnFun("'selected' must be the values instead of names of 'choices' ",
            "for the input '", inputId, "'")
  }
  selected
}


`%AND%` <- function (x, y)
{
  if (!is.null(x) && !is.na(x))
    if (!is.null(y) && !is.na(y))
      return(y)
  return(NULL)
}


`%||%` <- function(x, y) {
  if (!is.null(x)) x else y
}

escape_jquery <- function(string) {
  gsub(x = string, pattern = "(\\W)", replacement = "\\\\\\\\\\1")
}




firstChoice <- function (choices)
{
  if (length(choices) == 0L)
    return()
  choice <- choices[[1]]
  if (is.list(choice))
    firstChoice(choice)
  else choice
}

