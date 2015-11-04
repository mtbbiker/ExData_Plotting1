#Add code here
library(data.table)
datafile <- "household_power_consumption.txt"
# Get the Training Data
pol_data <- read.table(datafile,sep=";",header = TRUE)

library(dplyr)
#x <- filter(pol_data, Date >= "2007-02-01" , Date  <= "2007-02-02")
#Convert to POSIX Date and format
pol_data$Date <- as.Date(strptime(pol_data$Date,"%d/%m/%Y"),"%Y-%m-%d" )
#pol_data$Date <- strptime(pol_data$Date,"%d/%m/%Y")

#Format text to be coerced to numerics later
pol_data$Global_active_power <- as.numeric(gsub(",","",pol_data$Global_active_power))
#pol_data$Global_active_power <- as.numeric(pol_data$Global_active_power)

smalldata <- subset(pol_data, Date >= "2007-02-01" & Date <= "2007-02-02")
smalldata$Global_active_power <- as.numeric(smalldata$Global_active_power)

#hist(as.numeric(smalldata$Global_active_power), col = "orange",breaks = 100)
hist(smalldata$Global_active_power, col = "orange",main = "Global Active Power",xlab = "Global Active Power(kilowatts)")