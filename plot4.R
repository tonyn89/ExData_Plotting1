maindata<- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                    nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
maindata$Date <- as.Date(maindata$Date, format="%d/%m/%Y")

data <- subset(maindata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## convert dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

par(mfrow = c(2,2), mar=c(4,4,2,1), omar=c(0,0,0,0))
##plot1
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
##plot2
plot(data$Voltage~data$Datetime, type="l",
     ylab="Voltage", xlab="datetime")
##plot3
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime, col="Red")
  lines(Sub_metering_3~Datetime, col="Blue")
})

legend("topright", col=c("Black", "Red", "Blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
##plot4
plot(data$Global_reactive_power~data$Datetime, type="l",
     ylab="Global_reactive_power", xlab="datetime")

##save the plot
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

