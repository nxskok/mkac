#' plot time series with smooth trend
#' 
#' @param x numeric, a time series
#' @param time numeric, the time points of the time series (default `1:n` where `n` is length of series)
#' @return a ggplot plot
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @examples
#' set.seed(457299)
#' x=rnorm(100) # uncorrelated
#' x=x+0.02*(1:100) # with trend
#' ts_plot(x)
#'
#' @import ggplot2 
#' 
#' @export

ts_plot <-
function(x,time=1:length(x)) {
  d=tibble::tibble(x=x,time=time)
  ggplot(d,aes(x=time,y=x))+geom_line()+geom_smooth()
}
