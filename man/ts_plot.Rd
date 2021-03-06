% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ts_plot.R
\name{ts_plot}
\alias{ts_plot}
\title{plot time series with smooth trend}
\usage{
ts_plot(x, time = 1:length(x))
}
\arguments{
\item{x}{numeric, a time series}

\item{time}{numeric, the time points of the time series (default `1:n` where `n` is length of series)}
}
\value{
a ggplot plot
}
\description{
plot time series with smooth trend
}
\examples{
set.seed(457299)
x=rnorm(100) # uncorrelated
x=x+0.02*(1:100) # with trend
ts_plot(x)

}
\author{
Ken Butler, \email{butler@utsc.utoronto.ca}
}
