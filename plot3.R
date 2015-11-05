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
#pol_data$Global_active_power <- as.numeric(gsub(",","",pol_data$Global_active_power))
#pol_data$Global_active_power <- as.numeric(pol_data$Global_active_power)

smalldata <- subset(pol_data, Date >= "2007-02-01" & Date <= "2007-02-02")

smalldata$Global_active_power <- as.numeric(gsub(",","",smalldata$Global_active_power))
smalldata$Global_active_power <- as.numeric(smalldata$Global_active_power)
#smalldata$Sub_metering_1 <- as.numeric(smalldata$Sub_metering_1)
#smalldata$Sub_metering_2 <- as.numeric(smalldata$Sub_metering_2)
#smalldata$Sub_metering_3 <- as.numeric(smalldata$Sub_metering_3)

#need to get the day from date, or replace date with Week day, or add a column
#install.packages("lubridate")
library(lubridate)
#wday(smalldata$Date,label = TRUE)

newds <- mutate(smalldata, day = wday(smalldata$Date,label = TRUE))

#Convert Sub Metering to numeric

newds$Sub_metering_1 <- as.numeric(gsub(",","",newds$Sub_metering_1))
newds$Sub_metering_1 <- as.numeric(newds$Sub_metering_1)

newds$Sub_metering_2 <- as.numeric(gsub(",","",newds$Sub_metering_2))
newds$Sub_metering_2 <- as.numeric(newds$Sub_metering_2)

dates <- smalldata$Date
times <- smalldata$Time
x <- paste(dates, times)
newds$Datetime <- strptime(x, "%Y-%m-%d %H:%M:%S")

#Plotting

xrange <- newds$Datetime
yrange <- newds$Sub_metering_1
yrange2 <- newds$Sub_metering_2
yrange3 <- newds$Sub_metering_3
plot(xrange,yrange,  typ='l',ylab = "Energy sub metering",xlab = "")

#Multiple series
points(xrange, yrange2, col='red', type='l', lwd=2)
points(xrange, yrange3, col='blue', type='l', lwd=2)

#Now we add the Legend
legend("topright", 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col=c('black', 'red', 'blue'), lwd=3, lty=c(1,1,2))

######Note copying to device, breaks rendering on the Legend
dev.copy(device = png, filename = 'plot3.png', width = 480, height = 480) 

dev.off()

