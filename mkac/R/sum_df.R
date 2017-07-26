#' display calculations for sum in adjustment for autocorrelation (mainly for debugging)
#' 
#' @param x numeric, a time series
#' @param ..., optional arguments for acf
#' 
#' @return data frame showing terms in sum
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @exanples
#' library(forecast)
#' set.seed(457298)
#' xx=arima.sim(list(ar=0.8),100) # posoitively autocorrelated, sample size ratio > 1
#' sum_df(xx
#' 
#' @import tidyverse
#' @export
sum_df <-
function(x,...) { # same default as acf 
  x=detrend(x)
  y=rank(x)
  v=acf(y,plot=F,...)
  data.frame(v=as.vector(v$acf),n=length(y),lags=as.vector(v$lag)) %>%  # tibble appears not to work
    mutate(sig=(abs(v)>1.96/sqrt(n))) %>% 
    mutate(term=(n-lags)*(n-lags-1)*(n-lags-2)*v) %>% 
    mutate(cumul=cumsum(term*sig)-term[1]) %>% 
    mutate(scaled=1+2/n/(n-1)/(n-2)*cumul)
}
