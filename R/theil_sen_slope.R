#' Theil-Sen slope with time
#' 
#' @param y numeric, a time series
#' @param x numeric, the time points of the time series (optional, defaults to 1, 2, ...)
#' 
#' @return the Theil-Sen slope, a number
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @examples 
#' theil_sen_slope(c(2,3,5,10))
#' theil_sen_slope(y = c(2,3,5,10), x = 1:4)
#' theil_sen_slope(y = c(2,3,5,10), x = c(1, 2, 3, 5))
#' 
#' @export
#' 
theil_sen_slope <-
function(y, x = 1:length(y)) {
  m1=outer(y,y,"-")
  nn=1:length(x)
  m2=outer(x,x,"-")
  # elementwise division is almost right, except 0/0 on diag
  m3=m1/m2
  x=m3[lower.tri(m3)]
  stats::median(x)
}
