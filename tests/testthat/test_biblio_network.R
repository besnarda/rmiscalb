library(rmiscalb)
library(RefManageR)
context("biblio_network")


test_that("extractName base is working", {
	bib <- c(BibEntry(bibtype = "misc", key = "test1", author = "Alban Besnard", title = "It's another great day", year = "2019"),
		BibEntry(bibtype = "misc", key = "test2", author = "Alban Besnard and Mathews John Hopkins", title = "A good collaboration", year = "2018"))
	expect_equal(extractName(bib[1]$author,1),"A. Besnard")
	expect_equal(extractName(bib[2]$author,1),"A. Besnard")
	expect_equal(extractName(bib[2]$author,2),"M. J. Hopkins")
})

test_that("extractName character correction is working", {
	bib <- BibEntry(bibtype = "misc", key = "test1", author = "SÃ©verin BÃ©nard and Jacques Benoît", title = "A bunch of old guys", year = "1821")
	expect_equal(extractName(bib[1]$author,1),"S. Bénard")
	expect_equal(extractName(bib[1]$author,2),"J. Benoît")
})

test_that("makeRelations base is working",{
	bib <- c(BibEntry(bibtype = "misc", key = "test1", author = "Alban Besnard and Yan Holtz", title = "It's another great day", year = "2019"),
		BibEntry(bibtype = "misc", key = "test2", author = "Alban Besnard", title = "A good collaboration", year = "2018"),
		BibEntry(bibtype = "misc", key ="test3", author = "Yan Holtz and Alban Besnard and Marylin Phillips", title = "I don't remember", year = NA))
	expected_result <- structure(list(source = c("A. Besnard", "Y. Holtz", "A. Besnard"), target = c("Y. Holtz", "M. Phillips", "M. Phillips"), Value = c(2, 1, 1)), row.names = c(NA,3L), class = "data.frame")
	expect_equal(makeRelations(bib),expected_result)	
})
