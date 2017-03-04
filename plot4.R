# Download and unzip the data
# (Included for completeness, but comment this out if data file already on disk)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "power.zip")
unzip("power.zip")

# Read in and subset the data
powerData <- read.csv2("household_power_consumption.txt",
                      stringsAsFactors=FALSE, nrows=100000)
p <- powerData[powerData$Date=="1/2/2007"|powerData$Date=="2/2/2007",]

# Convert dates and times to standard representation
datetimec <- paste(p$Date, p$Time)
p$datetime <- strptime( datetimec, "%d/%m/%Y %H:%M:%S")

# Convert data for plots to numeric
p$pow <- as.numeric(p$Global_active_power)
p$Sub_metering_1 <- as.numeric(p$Sub_metering_1)
p$Sub_metering_2 <- as.numeric(p$Sub_metering_2)
p$Sub_metering_3 <- as.numeric(p$Sub_metering_3)

# Prepare legend options for sub metering plot
seriesNames <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colors <- c("black","red","blue")
linetypes=c(1,1,1)

# Display 4-panel plot on screen (not quite correctly)
par( mfrow = c(2,2) )
with( p, { 
           plot(datetime, pow, pch="", ylab="Global Active Power (kilowatts)", xlab="");
           lines(datetime, pow);
           plot(datetime, Voltage, pch=""); 
           lines(datetime, Voltage);
           plot(datetime, Sub_metering_1, pch="", xlab="", ylab="Energy sub metering");
           lines(datetime, Sub_metering_1, col="black");
           lines(datetime, Sub_metering_2, col="red");
           lines(datetime, Sub_metering_3, col="blue");
#          legend doesn't work on screen, not worth the trouble to fix
#          legend("topright",, seriesNames, lty=linetypes, col=colors);
           plot(datetime, Global_reactive_power, pch=""); 
           lines(datetime, Global_reactive_power) 
         } )

# Save 4-panel plot to file
png( "plot4.png" )
par( mfrow = c(2,2) )
with( p, { 
  plot(datetime, pow, pch="", ylab="Global Active Power (kilowatts)", xlab="");
  lines(datetime, pow);
  plot(datetime, Voltage, pch=""); 
  lines(datetime, Voltage);
  plot(datetime, Sub_metering_1, pch="", xlab="", ylab="Energy sub metering");
  lines(datetime, Sub_metering_1, col="black");
  lines(datetime, Sub_metering_2, col="red");
  lines(datetime, Sub_metering_3, col="blue");
  legend("topright",, seriesNames, lty=linetypes, col=colors, bty="n");
  plot(datetime, Global_reactive_power, pch=""); 
  lines(datetime, Global_reactive_power) 
} )
dev.off()

