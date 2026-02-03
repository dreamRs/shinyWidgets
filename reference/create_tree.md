# Create choice structure for [`treeInput()`](https://dreamrs.github.io/shinyWidgets/reference/treeInput.md)

Create choice structure for
[`treeInput()`](https://dreamrs.github.io/shinyWidgets/reference/treeInput.md)

## Usage

``` r
create_tree(data, levels = names(data), levels_id = NULL, ...)
```

## Arguments

- data:

  A `data.frame`.

- levels:

  Variables identifying hierarchical levels, values of those variables
  will be used as text displayed.

- levels_id:

  Variable to use as ID for nodes. Careful! Spaces are not allowed in
  IDs.

- ...:

  Addtional arguments.

## Value

a `list` that can be used in
[`treeInput()`](https://dreamrs.github.io/shinyWidgets/reference/treeInput.md).
