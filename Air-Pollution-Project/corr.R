corr<- function(directory, threshold= 0){
  data<- complete(directory, id = 1:332)
  setwd(file.path(getwd(),directory))
  good<- data$nobs > threshold
  index<- which(good)
  cr<- c(rep(NA, times= length(index)))
  if(length(cr)>0){
  for(p in 1:length(index)){
  if(index[p]<10){
    y<- read.csv(paste("0","0",as.numeric(index[p]),".csv",sep=""))
    cr[p]<- cor(y$sulfate, y$nitrate, use ="na.or.complete")
    p<- p+1
  }
  else if(index[p]<100){
    y<- read.csv(paste("0",as.numeric(index[p]),".csv",sep=""))
    cr[p]<- cor(y$sulfate, y$nitrate, use ="na.or.complete")
    p<- p+1
  }
  else{
    y<- read.csv(paste(as.numeric(index[p]),".csv",sep=""))
    cr[p]<- cor(y$sulfate, y$nitrate, use ="na.or.complete")
    p<- p+1
  }
  }
   setwd("..")
   cr
  }
  else{
    setwd("..")
    index
  }
}