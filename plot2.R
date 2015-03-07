#######################################################
# plot2.R
#
# This R script reads from the file in the working 
# directory called "household_power_consumption.txt"
# and extracts the data for the days 1/feb/2007 and 2/feb/2007.
#
# A plot of Global_active_power versus datetime is produced
# in the file "plot2.png".
#
#######################################################

#preamble

library(plyr)
library(dplyr)
library(data.table)
library(lubridate)

#######################################################
#  1. Read and tidy the data
#
# Read the file. Extract the days 1/2/2007, 2/2/2007.
# Add a column called datetime giving the datetime in
# POSIXct format.
#######################################################

#read the file
myfile<-"household_power_consumption.txt"
mydata<-read.table(myfile
                   , header=TRUE
                   , sep=";"
                   , dec="."
                   , na.strings=c("?")
                   , stringsAsFactors=FALSE
                   ,nrow=200000                # only need the 1st part
)

# filter out all the days 1/2/2007 and 2/2/2007
mydata<-filter(mydata
                , Date=="1/2/2007" | Date=="2/2/2007"
                )

#create a datetime column.
datetime <- dmy_hms(paste(mydata$Date," ",mydata$Time))
mydata<- cbind(datetime, mydata)

#######################################################
#  2. Create the plot
#
#######################################################

# PLOT 2

png(file = "plot2.png")  ## Open png device; 


with(mydata, 
     plot(Global_active_power~ datetime
          , type="l"
          , main=""
          , xlab=""
          , ylab="Global Active Power (kilowatts)"
          
     )
)

dev.off()  ## Close

