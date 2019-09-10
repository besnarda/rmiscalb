## Contains functions useful to work with bibliogrpahy and make networks.

##' Getting author names
##'
##' Get the number k author from a list 
##' @param author_list the list of authors to be process
##' @param k number of the author we want to extract (1 for example)
##' @return this function returns the name of the author (character format)
##' @author Alban Besnard [aut]
##' @export
extractName <- function(author_list,k){
  test <- paste0(unlist(author_list[k],use.names=TRUE))
  author_name <- paste0(substr(as.name(test[1]),0,1),". ",as.name(test[length(test)]))
  # special characters transformation
  author_name <- gsub("Ã©","é",author_name)
  author_name <- gsub("Ã§","ç",author_name)
  return(author_name)
}
