#' display calculations for sum in adjustment for autocorrelation (mainly for debugging)
#' 
#' @param x numeric, a time series
#' @param ..., optional arguments for acf
#' 
#' @return data frame showing terms in sum
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @examples
#' set.seed(457298)
#' xx=stats::arima.sim(list(ar=0.8),100) # posoitively autocorrelated, sample size ratio > 1
#' sum_df(xx)
#' 
#' @export
sum_df <-
function(x,...) { # same default as acf 
  x=detrend(x)
  y=rank(x)
  v=stats::acf(y,plot=F,...)
  data.frame(v=as.vector(v$acf),n=length(y),lags=as.vector(v$lag)) %>% # tibble appears not to work
    dplyr::mutate(sig=(abs(.data$v)>1.96/sqrt(.data$n))) %>% 
    dplyr::mutate(term=(.data$n-.data$lags)*(.data$n-.data$lags-1)*(.data$n-.data$lags-2)*.data$v) %>% 
    dplyr::mutate(cumul=cumsum(.data$term*.data$sig)-.data$term[1]) %>% 
    dplyr::mutate(scaled=1+2/.data$n/(.data$n-1)/(.data$n-2)*.data$cumul)
}
