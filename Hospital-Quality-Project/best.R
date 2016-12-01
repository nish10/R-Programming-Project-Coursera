best<- function(state, outcome){
  data<- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  if(any(data$State==state)){
    copy<- outcome
    # for capitalizing the first letter of each word in outcome
    simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1,1)), substring(s, 2),
          sep="", collapse=" ")
  }
    outcome<- simpleCap(outcome) 
    outcome<- make.names(outcome)
    outcome<- paste("Hospital.30.Day.Death..Mortality..Rates.from.",outcome,sep="")
    if(any(names(data)==outcome)){
      data[,outcome]<- as.numeric(data[,outcome])
      data<- data[which(data$State==state),c("Hospital.Name",outcome)]
      od<- data[order(data[[outcome]],data$Hospital.Name,na.last=TRUE),]
      od[1,1]
    }
    else{
      cat(paste("Error in best(\"",state,"\"",", \"",copy,"\"",") : invalid outcome",sep=" "))
    }
  }
  else{
   cat(paste("Error in best(\"",state,"\"",", \"",outcome,"\"",") : invalid state",sep=" "))
  }
}

