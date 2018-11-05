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

10 packages

|package            |version | errors| warnings| notes|
|:------------------|:-------|------:|--------:|-----:|
|bs4Dash            |0.2.0   |      0|        0|     0|
|dplyrAssist        |0.1.0   |      0|        0|     0|
|esquisse           |0.1.6   |      0|        0|     0|
|getTBinR           |0.5.5   |      1|        0|     0|
|ggplotAssist       |0.1.3   |      0|        0|     0|
|gimmeTools         |0.1     |      0|        0|     0|
|MtreeRing          |1.1     |      0|        0|     0|
|rpostgisLT         |0.6.0   |      0|        0|     0|
|shinydashboardPlus |0.6.0   |      0|        0|     0|
|visNetwork         |2.0.4   |      0|        0|     1|

## bs4Dash (0.2.0)
Maintainer: David Granjon <dgranjon@ymail.com>  
Bug reports: https://github.com/DivadNojnarg/bs4Dash/issues

0 errors | 0 warnings | 0 notes

## dplyrAssist (0.1.0)
Maintainer: Keon-Woong Moon <cardiomoon@gmail.com>  
Bug reports: https://github.com/cardiomoon/dplyrAssist/issues

0 errors | 0 warnings | 0 notes

## esquisse (0.1.6)
Maintainer: Victor Perrier <victor.perrier@dreamrs.fr>  
Bug reports: https://github.com/dreamRs/esquisse/issues

0 errors | 0 warnings | 0 notes

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

## ggplotAssist (0.1.3)
Maintainer: Keon-Woong Moon <cardiomoon@gmail.com>  
Bug reports: https://github.com/cardiomoon/ggplotAssist/issues

0 errors | 0 warnings | 0 notes

## gimmeTools (0.1)
Maintainer: Stephanie Lane <lane.stephanie.t@gmail.com>

0 errors | 0 warnings | 0 notes

## MtreeRing (1.1)
Maintainer: Jingning Shi <snow940220@bjfu.edu.cn>

0 errors | 0 warnings | 0 notes

## rpostgisLT (0.6.0)
Maintainer: Balázs Dukai <balazs.dukai@gmail.com>  
Bug reports: https://github.com/mablab/rpostgisLT/issues

0 errors | 0 warnings | 0 notes

## shinydashboardPlus (0.6.0)
Maintainer: David Granjon <dgranjon@ymail.com>  
Bug reports: https://github.com/DivadNojnarg/shinydashboardPlus/issues

0 errors | 0 warnings | 0 notes

## visNetwork (2.0.4)
Maintainer: Benoit Thieurmel <benoit.thieurmel@datastorm.fr>  
Bug reports: https://github.com/datastorm-open/visNetwork/issues

0 errors | 0 warnings | 1 note 

```
checking installed package size ... NOTE
  installed size is 10.9Mb
  sub-directories of 1Mb or more:
    doc           5.6Mb
    htmlwidgets   3.9Mb
```

