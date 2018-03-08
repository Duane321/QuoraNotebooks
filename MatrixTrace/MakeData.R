library(plyr)
library(dplyr)

library(ggplot2)

n <- 70
x <- seq(1,n)/100
setwd('C:/Users/Duane/Dropbox/Quora/MatrixTrace')

slope <- 3 #Slope of average line
freq <- 2
y_true <- x*slope + sin(x*2*pi*freq)
noise_std <- 1.1
n_streams <- 1000

make_vec <- function(){
  y_true + rnorm(n,0,noise_std)
}

smooth.matrix <-  function(df){
  n = length(x);
  A = matrix(0, n, n);
  for(i in 1:n){
    y = rep(0, n); y[i]=1;
    yi = smooth.spline(x, y, df=df)$y;
    A[,i]= yi;
  }
  (A+t(A))/2;
}

y_stream <- matrix(nrow=n,ncol=n_streams)

for (i in seq(n_streams)){
  y_stream[,i] <- make_vec()
}

df_A <- 5
df_B <- 23

S_mat_A <- smooth.matrix(df_A)
S_mat_B <- smooth.matrix(df_B)

write.csv(y_stream,file='y_stream.csv', row.names=FALSE)

write.csv(S_mat_A,file='S_mat_A.csv', row.names=FALSE)
write.csv(S_mat_B,file='S_mat_B.csv', row.names=FALSE)


# S_mat_A <- matrix(runif(n^2,-100,100),nrow=n,ncol=n)

y_hat_A <- S_mat_A %*% y_stream
y_hat_B <- S_mat_B %*% y_stream

i <- 50

to_plot <- data.frame(y_i_in=y_stream[i,],y_i_out = y_hat_A[i,])
g <- ggplot(to_plot,aes(x=y_i_in,y=y_i_out)) + geom_point(alpha=.1)
print(g)

to_plot <- data.frame(y_i_in=y_stream[i,],y_i_out = y_hat_B[i,])
g <- ggplot(to_plot,aes(x=y_i_in,y=y_i_out)) + geom_point(alpha=.1)
print(g)
# y_i_in <- S_mat_A[i,]
# y_i_out <- y_hat_A[i,]



