#' Mann-Kendall correlation test, unadjusted and adjusted for autocorrelation, with P-values
#' 
#' @param x numeric, a time series
#' @param ... optional arguments to "acf", eg. lag.max (see sample_size_ratio)
#' 
#' @return list: unadjusted and adjusted Z statistics, effective sample size ratio, unadjusted and adjusted P-values
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @examples 
#' set.seed(457299)
#' x=rnorm(100) # uncorrelated (no adjustment needed)
#' x=x+0.02*(1:100) # with trend
#' kendall_Z_adjusted(x)
#' 
#' # ar(1) data
#' set.seed(457298)
#' xx=stats::arima.sim(list(ar=0.8),100) # autocorrelated, needs adjusting
#' kendall_Z_adjusted(xx)
#' # P-value adjusted is much less significant
#' 
#' @export
#' 
kendall_Z_adjusted <-
function(x,...) {
  S=kendall_S(x)
  V=var_kendall_S(x)
  Z=S/sqrt(V)
  r=sample_size_ratio(x,...)
  V_star=V*r
  Z_star=S/sqrt(V_star)
  P_orig=2*(1-stats::pnorm(abs(Z)))
  P_adj=2*(1-stats::pnorm(abs(Z_star)))
  list(z=Z,z_star=Z_star,ratio=r,P_value=P_orig,P_value_adj=P_adj)
}
