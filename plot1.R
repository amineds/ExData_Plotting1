# Get the data from the text file (heavy loading - 127MB!!)
# Load the data only if necessary - avoid reloading when sourcing

if (!exists("conso_data")) {
    message("loading data....")
    conso_data <- read.table(file='household_power_consumption.txt',
                             sep=';',
                             header=TRUE,
                             na.strings='?',
                             colClasses = c('character', 
                                            'character', 
                                            'numeric',
                                            'numeric', 
                                            'numeric', 
                                            'numeric',
                                            'numeric',
                                            'numeric',
                                            'numeric'
                             )
    )
    message("data loaded....")
}




# Create a new column that combines date & time
conso_data$DateTime <- strptime(paste(conso_data$Date, conso_data$Time), 
                                "%d/%m/%Y %H:%M:%S"
)

# Keep the two requested days
conso_data <- subset(conso_data, as.Date(DateTime) >= as.Date("2007-02-01") & 
                         as.Date(DateTime) <= as.Date("2007-02-02")
)



# Initiate the png file (device)
png("plot1.png", height=480, width=480)

message("device open")
#do the plotting
hist(conso_data$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",   
     col="red"
)

# Close the device
dev.off()
message("device closed")