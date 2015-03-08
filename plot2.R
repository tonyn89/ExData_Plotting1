maindata<- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                    nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
maindata$Date <- as.Date(maindata$Date, format="%d/%m/%Y")

data <- subset(maindata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## convert dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## plot1
plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="datetime")

## save the plot
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()