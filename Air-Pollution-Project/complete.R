complete<- function(directory, id =1:332){
  setwd(file.path(getwd(),directory))
  nobs <- c(rep(NA, times = length(id)))
  s<- 1
  for(i in id){
    if(i<10){
      y<- read.csv(paste("0","0",as.numeric(i),".csv",sep=""))
      nobs[s]<- sum(complete.cases(y))
      s<- s+1
    }
    else if(i<100){
      y<- read.csv(paste("0",as.numeric(i),".csv",sep=""))
      nobs[s]<- sum(complete.cases(y))
      s<- s+1
    }
    else {
      y<- read.csv(paste(as.numeric(i),".csv",sep=""))
      nobs[s]<- sum(complete.cases(y))
      s<- s+1
    }
  }
  setwd("..")
  df<- data.frame(id,nobs)
  colnames(df)<- c("id","nobs")
  df

}