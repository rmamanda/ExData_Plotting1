library(dplyr)

##setwd("D:/Coursera/ExData_Plotting1")
##Sys.setlocale("LC_TIME", "English")

## load household power consumption zip file and extract it
if(!file.exists("household_power_consumption.zip")){
    fileURL="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL,destfile="household_power_consumption.zip")
}

if(!file.exists("household_power_consumption.txt")){
    unzip("household_power_consumption.zip", overwrite=TRUE)
}

## load data and subset days 
power <- read.csv("household_power_consumption.txt",na.strings = "?",sep=";")
power_subset <- filter(power, power$Date == "1/2/2007" | 
                              power$Date == "2/2/2007")

## cast datetime
power_subset$datetime <- as.POSIXlt(paste(power_subset$Date, power_subset$Time, 
                                          sep=" "),format="%d/%m/%Y %H:%M:%S")

# Setup view 2 rows 2 columns
par(mfrow=c(2,2))

##plot 1.1
with(power_subset,plot(datetime, Global_active_power, type="l", 
                       ylab="Global Active Power",
                       xlab=""))

## plot 1.2
with(power_subset,plot(datetime, Voltage, type="l", 
                       ylab="Voltage"))

##plot 2.1
with(power_subset,plot(datetime, Sub_metering_1, type="l", 
                       ylab="Energy sub metering",
                       xlab=""))
lines(power_subset$datetime, power_subset$Sub_metering_1)
lines(power_subset$datetime, power_subset$Sub_metering_2, col="red")
lines(power_subset$datetime, power_subset$Sub_metering_3, col="blue")

legend("topright",           # x-y coordinates for location of the legend  
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), # Labels  
       col=c("black", "red", "blue"),   # Color of points or lines  
       lty=c(1,1,1),         # Line type  
       lwd=c(1,1,1)          # Line width 
       bty = "n"
)

##plot 2.2
with(power_subset,plot(datetime, Global_reactive_power, type="l", 
                       ylab="Global_reactive_power"))

## copy plot to PNG
dev.copy(png,file="plot4.png",width=480, height=480)
dev.off()
