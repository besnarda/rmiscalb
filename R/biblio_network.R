## Contains functions useful to work with bibliography and make networks.

##' Getting author names
##'
##' Get the number k author from a list in format "J. K. Rowling"
##' @param author_list the list of authors to be process (list of class person from RefManager)
##' @param k number of the author we want to extract (1 for example)
##' @return this function returns the name of the author (character format)
##' @author Alban Besnard [aut]
##' @export
extractName <- function( author_list, k){
  test <- c(author_list[k]$given,author_list[k]$family)
  author_name <- paste(
  	paste(unlist(substr( test[1 : length(test)-1], 0, 1)), collapse = ". "),
  	as.name( test[ length(test) ]) , sep = ". ")
  # special characters transformation (necessary?)
  # I may have a better way to do that with utf8 like function.
  author_name <- gsub("Ã©","é",author_name)
  author_name <- gsub("Ã§","ç",author_name)
  return(author_name)
}

##' Getting relations between authors
##'
##' Useful to plot a network
##' From a bibtex object (RefManager),
##' @param bibtex a bibtex object containing the bibliography you want to work with
##' @return this function will give you a data.frame of relations (one line per relation)
##' @author Alban Besnard [aut]
##' @export
makeRelations<- function(bibtex){

  relations <- data.frame(source = character(),target = character(), Value = numeric(),stringsAsFactors=FALSE)

  for (i  in 1:length(bibtex)) {
    author_list<-(bibtex[i]$author)
    n=length(author_list)

    # check if there is only one author then skip
    if (n == 1 | n == 0) next

    for (k in 1:(n-1)){
    	for (l in (k+1):n){


      		# on ne s'arrête que si les deux noms sont différents.
      		if (k != l) {
        	a=extractName(author_list,k);b=extractName(author_list,l)
        		if (paste(a,b) %in% c(paste(relations$source,relations$target),paste(relations$target,relations$source))) {

        			# a big distusting expression to add 1 to the Value parameter
          			relations$Value[paste(relations$source,relations$target) %in% paste(a,b) |paste(relations$target,relations$source) %in% paste(a,b)]<- relations$Value[paste(relations$source,relations$target) %in% paste(a,b) |paste(relations$target,relations$source) %in% paste(a,b)] +1

        		} else {
        		relations[nrow(relations)+1,] <- list(a,b,1)
        		}
      		}
    	}
    }
    # on parcourt les noms d'auteurs

  }
  return(relations)
}

##' Creating groups
##'
##' Calculating and assigning groups of researchers based on betweeness centrality.
##'
##' @param relations data.frame as created by the makeRelation function
##' @return a data.frame indicating the frequency of each author and his calculated group
##' @author Alban Besnard [aut]
##' @export
makeVertices<- function(relations){
  # Create vertices :
  temp<-table(unlist(relations[,c("source","target")]))
  vertices<-data.frame(temp) # node names
  names(vertices)<-c("name","freq")
  g = graph.data.frame(relations, directed=F, vertices=vertices) # raw graph
  vertices$group = edge.betweenness.community(g)$membership # betweeness centrality for each node for grouping

  return(vertices)
}

##' Adding indexes
##'
##' @param relations data.frame as created by the makeRelation function
##' @param vertices data.frame as created by the makeVertices function
##' @return a data.frame similar to relations updated with relation indexes
##' @author Alban Besnard [aut]
##' @export
updateRelations <- function(relations,vertices){
  # create indices for each name to fit forceNetwork data format
  relations$source.index = match(relations$source, vertices$name) - 1
  relations$target.index = match(relations$target, vertices$name) - 1
  return(relations)
}
