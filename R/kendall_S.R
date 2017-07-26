#' Calculate S statistic for Kendall correlation with time (+1 for concordance, -1 for discordance)
#' 
#' @param x numeric, a time series
#' @return number of concordances minus number of discordances
#' 
#' @author Ken Butler, \email{butler@utsc.utoronto.ca}
#' 
#' @examples
#' 
#' kendall_S(c(2,3,5,4))
#' 
#' @export
#' 
kendall_S <-
function(x) {
  m=outer(x,x,"-")
  sum(sign(m)*lower.tri(m))
}
