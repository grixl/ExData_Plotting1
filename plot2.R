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

png(filename = "plot2.png", width = 480, height = 480)
# draw plot
plot(pc$DateTime, pc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()