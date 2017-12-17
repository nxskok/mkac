#' ratio of actual to effective sample sizes for possibly autocorrelated time series
#' 
#' @param x numeric, a time series
#' @param ..., optional parameters for acf()
#' 
#' @return sample size ratio (a number)
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @examples
#' library(forecast)
#' set.seed(457298)
#' xx=arima.sim(list(ar=0.8),100) # positively autocorrelated, sample size ratio > 1
#' sample_size_ratio(xx)
#' 
#' @import forecast
#' @export
sample_size_ratio <-
function(x,...) {
  x=detrend(x)
  y=rank(x)
  v=acf(y,plot=F,...) # most likely lag.max will need to be added
  d=data.frame(v=as.vector(v$acf),n=length(y),lags=as.vector(v$lag)) %>%  
    mutate(sig=abs(v)>=1.96/sqrt(n)) %>% # 5% sig hard-coded for now
    mutate(term=(n-lags)*(n-lags-1)*(n-lags-2)*v*sig) 
  sum=with(d,sum(term)-term[1])
  nn=d$n[1]
  ratio=1+2/nn/(nn-1)/(nn-2)*sum
  ratio
}
