#' Kendall test statistic for testing time trend (no autocorrelation)
#' 
#' @param x numeric, a time series
#' @return test statistic
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @examples 
#' kendall_Z(c(2,3,5,4))
#' 
#' @export
#' 
kendall_Z <-
function(x) {
  kendall_S(x)/sqrt(var_kendall_S(x))
}
