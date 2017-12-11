#' Detrend a time series by subtracting Theil-Sen slope
#' 
#' @param x numeric, a time series
#' return time series detrended
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @examples 
#' y=c(2,3,5,6)
#' detrend(y)
#' 
#' @export
#' 
detrend <-
function(x) {
  slope=theil_sen_slope(x)
  subt=(1:length(x))*slope
  x-subt
}
