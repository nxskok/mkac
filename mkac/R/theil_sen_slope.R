#' Theil-Sen slope with time
#' 
#' @param x numeric, a time series
#' @param tt numeric, optional vector of times (if omitted, defaults to `1:length(x)`)
#' 
#' @return the Theil-Sen slope, a number
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @details Assumes no missing values in `x`.
#' 
#' @examples 
#' theil_sen_slope(c(2,3,5,10))
#' 
#' @export
#' 
theil_sen_slope <-
function(x,tt=seq_along(x)) {
  stopifnot(length(x)==length(tt))
  m1=outer(x,x,"-")
  m2=outer(tt,tt,"-")
  # elementwise division is almost right, except 0/0 on diag
  m3=m1/m2
  x=m3[lower.tri(m3)]
  median(x)
}
