## Contains basic formatting function

##' Transform a numerical value in a readable text string with K, M, G notations
##'
##' @param number the number you want to transform
##' @param rounding TRUE will round the value (no decimal), default is FALSE
##' @param digits exact number of digits that will be displayed, default is 3
##' @return this function returns a string with SI format
##' @author Alban Besnard [aut]
##' @export
f2si<-function (number, rounding=F, digits=ifelse(rounding, NA, 3))
{
  lut <- c(1e-24, 1e-21, 1e-18, 1e-15, 1e-12, 1e-09, 1e-06,
           0.001, 1, 1000, 1e+06, 1e+09, 1e+12, 1e+15, 1e+18, 1e+21,
           1e+24, 1e+27)
  pre <- c("y", "z", "a", "f", "p", "n", "µ", "m", "", "K",
           "M", "G", "T", "P", "E", "Z", "Y", NA)
  ix <- findInterval(number, lut)
  if (ix>0 && ix<length(lut) && lut[ix]!=0.001) {
    if (rounding==T && !is.numeric(digits)) {
      sistring <- paste0(round(number/lut[ix]), pre[ix])
    }
    else if (rounding == T || is.numeric(digits)) {
      sistring <- paste0(signif(number/lut[ix], digits), pre[ix])
    }
    else {
      sistring <- paste0(number/lut[ix], pre[ix])
    }
  }
  else {
    sistring <- as.character(signif(number,digits))
  }
  return(sistring)
}
