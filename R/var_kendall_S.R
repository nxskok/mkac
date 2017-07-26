#' Variance of Kendall correlation S statistic under null hypothesis of no trend and assuming independence
#' 
#' @param x numeric, a time series (only its length is used)
#' @result the variance (a number)
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @examples
#' var_kendall_S(rnorm(100))
#' 
#' @export
#' 
var_kendall_S <-
function(x) {
  n=length(x)
  n*(n-1)*(2*n+5)/18
}
