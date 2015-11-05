#Add code here
#install.packages("data.table")

library(data.table)
datafile <- "household_power_consumption.txt"
# Get the Training Data
pol_data <- read.table(datafile,sep=";",header = TRUE)

#install.packages("dplyr")
library(dplyr)#Add code here

#Convert to POSIX Date and format,
pol_data$Date <- as.Date(strptime(pol_data$Date,"%d/%m/%Y"),"%Y-%m-%d" )


#Format text to be coerced to numerics later
pol_data$Global_active_power <- as.numeric(gsub(",","",pol_data$Global_active_power))
#pol_data$Global_active_power <- as.numeric(pol_data$Global_active_power)

smalldata <- subset(pol_data, Date >= "2007-02-01" & Date <= "2007-02-02")
smalldata$Global_active_power <- as.numeric(smalldata$Global_active_power)

#need to get the day from date, or replace date with Week day, or add a column
#install.packages("lubridate")
library(lubridate)
#wday(smalldata$Date,label = TRUE)

newds <- mutate(smalldata, day = wday(smalldata$Date,label = TRUE))

dates <- smalldata$Date
times <- smalldata$Time
x <- paste(dates, times)
newds$Datetime <- strptime(x, "%Y-%m-%d %H:%M:%S")

yrange <- newds$Global_active_power
xrange <- newds$Datetime


plot(xrange,yrange,  typ='l',ylab = "Global Active Power(kilowatts)",xlab = "")

dev.copy(device = png, filename = 'plot2.png', width = 480, height = 480) 

dev.off()

