#' Theil-Sen slope with time
#' 
#' @param x numeric, a time series
#' 
#' @return the Theil-Sen slope, a number
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @examples 
#' theil_sen_slope(c(2,3,5,10))
#' 
#' @export
#' 
theil_sen_slope <-
function(x) {
  m1=outer(x,x,"-")
  nn=1:length(x)
  m2=outer(nn,nn,"-")
  # elementwise division is almost right, except 0/0 on diag
  m3=m1/m2
  x=m3[lower.tri(m3)]
  median(x)
}
