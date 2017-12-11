# mann kendall with autocorrelation
# following Hamed and Rao:

#'  @article{hamed1998modified,
#'   title={A modified Mann-Kendall trend test for autocorrelated data},
#'   author={Hamed, Khaled H and Rao, A Ramachandra},
#'   journal={Journal of Hydrology},
#'   volume={204},
#'   number={1-4},
#'   pages={182--196},
#'   year={1998},
#'   publisher={Elsevier}
#' }
#' 

# home-made Mann-Kendall correlation and significance

library(tidyverse)
library(forecast)

# generate some data

set.seed(457299)
# uncorrelated
x=rnorm(100)
x=x+0.02*(1:100)
ts_plot(x)

# ar(1) data
set.seed(457298)
xx=arima.sim(list(ar=0.8),100)
ts_plot(xx)

# ma(1) data
set.seed(457299)
xxx=arima.sim(list(ma=0.5),100)+0.02*(1:100) # add a trend
ts_plot(xxx)

# trying Mann-Kendall stat

y=c(2,3,5,4)
m=outer(y,y,"-")
m
sign(m)
upper.tri(m)
sum(sign(m)*lower.tri(m))

kendall_S(xxx)

ll=list(x,xx,xxx)
map_dbl(ll,kendall_Z) # checks

theil_sen_slope(xx)

kendall_Z_adjusted(x)


################ functions below here

ts_plot=function(x,time=1:length(x)) {
  d=tibble(x=x,time=time)
  ggplot(d,aes(x=time,y=x))+geom_line()+geom_smooth()
}

kendall_S=function(x) {
  m=outer(x,x,"-")
  sum(sign(m)*lower.tri(m))
}

var_kendall_S=function(x) {
  n=length(x)
  n*(n-1)*(2*n+5)/18
}

kendall_Z=function(x) {
  kendall_S(x)/sqrt(var_kendall_S(x))
}

# series has to be de-trended first by subtracting off theil-sen slope, for which I need a function

theil_sen_slope=function(x) {
  m1=outer(x,x,"-")
  nn=1:length(x)
  m2=outer(nn,nn,"-")
  # elementwise division is almost right, except 0/0 on diag
  m3=m1/m2
  x=m3[lower.tri(m3)]
  median(x)
}

detrend=function(x) {
  slope=theil_sen_slope(x)
  subt=(1:length(x))*slope
  x-subt
}

sum_df=function(x,...) { # same default as acf 
  x=detrend(x)
  y=rank(x)
  v=acf(y,plot=F,...)
  data.frame(v=as.vector(v$acf),n=length(y),lags=as.vector(v$lag)) %>%  # tibble appears not to work
    mutate(sig=(abs(v)>1.96/sqrt(n))) %>% 
    mutate(term=(n-lags)*(n-lags-1)*(n-lags-2)*v) %>% 
    mutate(cumul=cumsum(term*sig)-term[1]) %>% 
    mutate(scaled=1+2/n/(n-1)/(n-2)*cumul)
}

sample_size_ratio=function(x,...) {
  x=detrend(x)
  y=rank(x)
  v=acf(y,plot=F,...)
  d=data.frame(v=as.vector(v$acf),n=length(y),lags=as.vector(v$lag)) %>%  
    mutate(sig=abs(v)>=1.96/sqrt(n)) %>% # 5% sig hard-coded for now
    mutate(term=(n-lags)*(n-lags-1)*(n-lags-2)*v*sig) 
  sum=with(d,sum(term)-term[1])
  nn=d$n[1]
  ratio=1+2/nn/(nn-1)/(nn-2)*sum
  ratio
}

kendall_Z_adjusted=function(x,...) {
  S=kendall_S(x)
  V=var_kendall_S(x)
  Z=S/sqrt(V)
  r=sample_size_ratio(x,...)
  V_star=V*r
  Z_star=S/sqrt(V_star)
  P_orig=2*(1-pnorm(abs(Z)))
  P_adj=2*(1-pnorm(abs(Z_star)))
  list(z=Z,z_star=Z_star,ratio=r,P_value=P_orig,P_value_adj=P_adj)
}
