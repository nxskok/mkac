% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/theil_sen_slope.R
\name{theil_sen_slope}
\alias{theil_sen_slope}
\title{Theil-Sen slope with time}
\usage{
theil_sen_slope(y, x = 1:length(y))
}
\arguments{
\item{y}{numeric, a time series}

\item{x}{numeric, the time points of the time series (optional, defaults to 1, 2, ...)}
}
\value{
the Theil-Sen slope, a number
}
\description{
Theil-Sen slope with time
}
\examples{
theil_sen_slope(c(2,3,5,10))
theil_sen_slope(y = c(2,3,5,10), x = 1:4)
theil_sen_slope(y = c(2,3,5,10), x = c(1, 2, 3, 5))

}
\author{
Ken Butler, \email{butler@utsc.utoronto.ca}
}
