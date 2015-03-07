#######################################################
# plot4.R
#
# This R script reads from the file in the working 
# directory called "household_power_consumption.txt"
# and extracts the data for the days 1/feb/2007 and 2/feb/2007.
#
# A 2x2 mosaic of plots is produced
# in the file "plot4.png".
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

# PLOT 4

png(file = "plot4.png")  ## Open png device; 
par(mfcol=c(2,2))  # 2x2 plots, by column


#PLOT 4.1 (top left)

with(mydata, 
     plot(Global_active_power~ datetime
          , type="l"
          , main=""
          , xlab=""
          , ylab="Global Active Power"
         )
)

#PLOT 4.2 (bottom left)


with(mydata, {   
    plot(Sub_metering_1~ datetime
         , type="n"
         , main=""
         , xlab=""
         , ylab="Energy sub metering"
    )
    points(Sub_metering_1~ datetime, type="l", col="black"  )
    points(Sub_metering_2~ datetime, type="l", col="red"    )
    points(Sub_metering_3~ datetime, type="l", col="blue"   )     
})

legend("topright"
       , legend=c(  "Sub_metering_1"
                  , "Sub_metering_2"
                  , "Sub_metering_3"
       )
       , pch=" ", lty="solid"
       , col=c("black","red", "blue")
       , bty="n"
       , cex=0.9     
)

#PLOT 4.3 (top right)

with(mydata, 
     plot(Voltage~ datetime
          , type="l"
          , main=""          
     )
)


#PLOT 4.4 (bottom right)

with(mydata, 
     plot(Global_reactive_power~ datetime
          , type="l"
          , main=""          
     )
)

dev.off()  ## Close

