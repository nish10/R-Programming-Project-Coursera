rankall<- function(outcome, num = "best"){
  data<- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    #for using in else error output
    copy<- outcome
    # function for capitalizing the first letter of each word in outcome
    simpleCap <- function(x) {
      s <- strsplit(x, " ")[[1]]
      paste(toupper(substring(s, 1,1)), substring(s, 2),
            sep="", collapse=" ")
    }
    #capitalizing the first letter of each word in outcome
    outcome<- simpleCap(outcome) 
    # make.names function replaces spaces in outcome with "."(dot)
    outcome<- make.names(outcome)
    # for finding the name of data that matches with outcome
    outcome<- paste("Hospital.30.Day.Death..Mortality..Rates.from.",outcome,sep="")
    if(any(names(data)==outcome)){
      # since all columns are taken as character in colClasses argument of read.csv
      data[,outcome]<- as.numeric(data[,outcome])
      # idea from lapply matrix example video of coursera as we can't use rankhopital.R function
      # splitting data w.r.t state 
      sp<- split(data,data$State)
      # subsetting two required columns from sp
      da<- lapply(sp,function(x){ x[,c("Hospital.Name",outcome)]})
      # ordering the Hospital w.r.t to lowest mortality rate
      od<- lapply(da,function(x){x[order(x[[outcome]],x$Hospital.Name,na.last=TRUE),]})
      # removing NA
      od<- lapply(od,function(x){x[which(!is.na(x[[outcome]])),]})
      # finding len as the length of each element of the list od varies 
      len<- lapply(od, function(x){dim(x)[1]})
      if(num == "best"){
        nd<- mapply(function(x,y){x[1,1]},od,num)
      }
      else if(num=="worst"){
        nd<- mapply(function(x,y) {x[y,1]},od,len)
      }
      else{
        nd<- mapply(function(x,y){x[y,1]},od,num)
      }
      data.frame("hospital"=nd,"state"=names(nd))
    }
    else{
      cat(paste("Error in rankhospital(\"",state,"\"",", \"",copy,"\"",",\"",num,"\"",") : invalid outcome",sep=" "))
    }
}
