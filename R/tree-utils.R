
#' Create choice structure for [treeInput()]
#'
#' @param data A `data.frame`.
#' @param levels Variables identifying hierarchical levels,
#'  values of those variables will be used as text displayed.
#' @param levels_id Variable to use as ID for nodes. Careful! Spaces are not allowed in IDs.
#' @param ... Addtional arguments.
#'
#' @return a `list` that can be used in [treeInput()].
#' @export
create_tree <- function(data, levels = names(data), levels_id = NULL, ...) {
  args <- list(...)
  data <- as.data.frame(data)
  if (!all(levels %in% names(data)))
    stop("All levels must be valid variables in data", call. = FALSE)
  data[levels] <- lapply(data[levels], as.character)
  data <- unique(x = data)
  if (is.null(levels_id)) {
    lapply(
      X = unique(data[[levels[1]]][!is.na(data[[levels[1]]])]),
      FUN = function(var) {
        dat <- data[data[[levels[1]]] == var, , drop = FALSE]
        args_level <- args[[levels[1]]]
        if (length(levels) == 1) {
          dropNullsOrEmpty(c(list(text = var, id = paste0("tree", sample.int(1e7, 1))), args_level))
        } else {
          c(
            dropNullsOrEmpty(list(
              text = var,
              id = paste0("tree", sample.int(1e7, 1)),
              children = create_tree(
                data = dat,
                levels = levels[-1],
                ...
              )
            )),
            args_level
          )
        }
      }
    )
  } else {
    stopifnot(
      "levels and levels_id must be of same length" = length(levels) == length(levels_id)
    )
    if (!all(levels_id %in% names(data)))
      stop("All levels_id must be valid variables in data", call. = FALSE)
    mapply(
      SIMPLIFY = FALSE,
      USE.NAMES = FALSE,
      text = unique(data[[levels[1]]][!is.na(data[[levels[1]]])]),
      id = unique(data[[levels_id[1]]][!is.na(data[[levels_id[1]]])]),
      FUN = function(text, id) {
        dat <- data[data[[levels[1]]] == text, , drop = FALSE]
        args_level <- args[[levels[1]]]
        if (length(levels) == 1) {
          dropNullsOrEmpty(c(list(text = text, id = id), args_level))
        } else {
          c(
            dropNullsOrEmpty(list(
              text = text,
              id = as.character(id),
              children = create_tree(
                data = dat,
                levels = levels[-1],
                levels_id = levels_id[-1],
                ...
              )
            )),
            args_level
          )
        }
      }
    )
  }
}


