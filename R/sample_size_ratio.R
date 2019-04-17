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
#' set.seed(457298)
#' xx=stats::arima.sim(list(ar=0.8),100) # posoitively autocorrelated, sample size ratio > 1
#' sample_size_ratio(xx)
#' 
#' @export
sample_size_ratio <-
function(x,...) {
  x=detrend(x)
  y=rank(x)
  v=stats::acf(y,plot=F,...) # most likely lag.max will need to be added
  data.frame(v=as.vector(v$acf),n=length(y),lags=as.vector(v$lag)) %>%  
    dplyr::mutate(sig=abs(.data$v)>=1.96/sqrt(.data$n)) %>% # 5% sig hard-coded for now
    dplyr::mutate(term=(.data$n-.data$lags)*(.data$n-.data$lags-1)*(.data$n-.data$lags-2)*.data$v*.data$sig) -> d
  sum=with(d,sum(term)-term[1])
  nn=d$n[1]
  ratio=1+2/nn/(nn-1)/(nn-2)*sum
  ratio
}
