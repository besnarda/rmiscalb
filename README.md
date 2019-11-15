# rmiscalb

This package is a collection of my R functions for professional and personal project.

## To install the package

```
library("devtools")
install_github("besnarda/rmiscalb")
library("rmiscalb")
```

## Project biblio_network

This is a personal project aiming at vizualising relations betweeen researchers in the bibliography element. you will find multiple functions helping to do convert a bibliography to a network.

Feel free to give feedbacks.

## To modify package

Modify functions into the R folder following good practices: one .R file per thematic.

After loading the project into R:
You can use testthat pacakge to verify use.
```
testthat::auto_test_package()
```
You can recreate documentation (in "man" folder) using roxygen2 package. Don't edit by hand!
```
roxygen2::roxygenise()
```
