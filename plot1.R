library(dplyr)

##setwd("D:/Coursera/ExData_Plotting1")

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

##plot 1
hist(power_subset$Global_active_power, col="Red", main="Global Active Power", 
     xlab="Global Active Power (kilowwats)")

## copy plot to PNG
dev.copy(png,file="plot1.png",width=480, height=480)
dev.off()
