# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.5.1 (2018-07-02) |
|system   |x86_64, mingw32              |
|ui       |RStudio (1.1.456)            |
|language |(EN)                         |
|collate  |French_France.1252           |
|tz       |Europe/Berlin                |
|date     |2018-11-05                   |

## Packages

|package      |*  |version |date       |source         |
|:------------|:--|:-------|:----------|:--------------|
|shinyWidgets |   |0.4.3   |2018-05-30 |CRAN (R 3.5.1) |

# Check results

1 packages with problems

|package  |version | errors| warnings| notes|
|:--------|:-------|------:|--------:|-----:|
|getTBinR |0.5.5   |      1|        0|     0|

## getTBinR (0.5.5)
Maintainer: Sam Abbott <contact@samabbott.co.uk>  
Bug reports: https://github.com/seabbs/getTBinR/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
  Running 'testthat.R' [34s]
Running the tests in 'tests/testthat.R' failed.
Last 13 lines of output:
  > library(getTBinR)
  > 
  > test_check("getTBinR")
  [31m--[39m [31m1. Failure: map_tb_burden can have a custom legend specified. (@test-map_tb_burden.R#62) [39m [31m---------------------------------------------------------------[39m
  plot$labels$fill not equal to `test_label`.
  1/1 mismatches
  x[1]: "`test (test - test)`"
  y[1]: "test (test - test)"
  
  == testthat results  =======================================================================================================================================
  OK: 75 SKIPPED: 29 FAILED: 1
  1. Failure: map_tb_burden can have a custom legend specified. (@test-map_tb_burden.R#62) 
  
  Error: testthat unit tests failed
  Execution halted
```

