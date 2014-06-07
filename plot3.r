library("sqldf")
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,temp)
unzip(temp,exdir=getwd())
powerdata <- read.csv.sql("household_power_consumption.txt",sep=";",sql='select * from file where Date ="1/2/2007" or Date = "2/2/2007"')
unlink(temp)
datetimecontact <- paste(as.Date(powerdata$Date,format="%d/%m/%Y") , powerdata$Time)
concat <- strptime(datetimecontact,format = "%Y-%m-%d %H:%M:%S")
powerdata$finalDateTime <- concat
png(file="plot3.png",width=480,height=480)
with(powerdata, plot(finalDateTime, Sub_metering_1,type="l",ylab="",xlab=""))
with(powerdata, lines(finalDateTime,  Sub_metering_2,type="l", col="red",xlab="",ylab=""))
with(powerdata, lines(finalDateTime,  Sub_metering_3,type="l", col="blue",xlab="",ylab=""))
title(xlab="",ylab="Energy sub metering")
legend("topright", lty=1,lwd=2, col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()
detach("package:sqldf", unload=TRUE)
