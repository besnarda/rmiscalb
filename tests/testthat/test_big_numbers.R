library(rmiscalb)
context("big_numbers")

test_that("f2si is working", {
  numbers <- c(0.1,0.2548,0.000025,25648)
  expect_equal(f2si(numbers[1]),"0.1")
  expect_equal(f2si(numbers[2]),"0.255")
  expect_equal(f2si(numbers[3]),"25µ")
  expect_equal(f2si(numbers[4]),"25.6K")
})
