pollutantmean<- function(directory, pollutant, id = 1:332){
  setwd(file.path(getwd(),directory))
  s<- NA
  for(i in id){
    if(i <10){
      y<- read.csv(paste("0","0",as.character(i),".csv", sep=""))
      s<- c(s,y[[pollutant]])
    }
    
    else if(i < 100){
      y<- read.csv(paste("0",as.character(i),".csv",sep=""))
      s<- c(s,y[[pollutant]])
    }
    
    else {
      y<- read.csv(paste(as.character(i),".csv"))
      s<- c(s,y[[pollutant]])
    }
  }
  setwd("..")
  mean(s,na.rm=TRUE)
  
}

