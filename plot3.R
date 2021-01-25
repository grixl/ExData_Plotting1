# download the data set 
if (!file.exists("HouseholdPowerConsumption.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      "HouseholdPowerConsumption.zip",
                      method = "curl")
}

# unzip file
unzip("HouseholdPowerConsumption.zip", overwrite = TRUE)

pc_all <- read.csv2("household_power_consumption.txt",
                    dec = ".", na.strings = "?",
                    colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

# subset to get data for required date range
pc <- subset(pc_all, Date == "1/2/2007" | Date == "2/2/2007")

# convert date and time to Date/Time class and save as new column
pc$DateTime <- strptime(paste(pc$Date, pc$Time), "%d/%m/%Y %H:%M:%S")

png(filename = "plot3.png", width = 480, height = 480)

# plot line graph of Global Active Power
plot(pc$DateTime, pc$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(pc$DateTime, pc$Sub_metering_2, col = "red")
lines(pc$DateTime, pc$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
dev.off()
