#This code assumes that the Rscript is in the same directory as the ExData_Plotting1 repo 
#and uses the package lubridate

library(lubridate)

#downlaod file
electric_fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(electric_fileURL, destfile="power_consumption.zip", method="curl")
unzip("power_consumption.zip")

#load in files needed
tab5rows <- read.delim(file='household_power_consumption.txt', sep=";", header=T, nrows=5)
classes <- sapply(tab5rows, class)
power <- read.delim(file='household_power_consumption.txt', sep=";", header=T, colClasses = classes, na.strings="?")

#combine date and time into single element
date_time <- dmy_hms(paste(power[,"Date"], power[,"Time"], sep=" "))
power[,"Date"] <- dmy(power[,"Date"])
power[,"Time"] <- hms(power[,"Time"])
power <- cbind(power, "Date_Time" = date_time)

#subset the data for the 2007-02-01 and 2007-02-02 dates
date_index <- which(power[,"Date"] == ymd("2007-02-01") | power[,"Date"] == ymd("2007-02-02"))
power_subset <- power[date_index,]

#plot 2
png(file="plot2.png", width=480, height=480)
plot(x=power_subset[,'Date_Time'], y=power_subset[,'Global_active_power'], type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()