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

# Clean up earlier setting in case I'm re-running this
par( mfrow = c(1,1) )

# Plot global active power over time to screen
with(p, plot(datetime, pow, pch="", ylab="Global Active Power (kilowatts)", xlab=""))
with(p, lines(datetime, pow))

# Plot global active power over time to file
png("plot2.png")
with(p, plot(datetime, pow, pch="", ylab="Global Active Power (kilowatts)", xlab=""))
with(p, lines(datetime, pow))
dev.off()
