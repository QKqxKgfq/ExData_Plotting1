#######
### Load and prepare data
#######

### Load electric power consumption data
epc <- read.table(file="household_power_consumption.txt",
                  sep=";",
                  header=TRUE,
                  colClasses=c(
                    "character",
                    "character",
                    "numeric",
                    "numeric",
                    "numeric",
                    "numeric",
                    "numeric",
                    "numeric",
                    "numeric"
                    ),
                  na.strings="?"
                  )

### Filter days of interest
epc <- epc[epc$Date %in% c("1/2/2007","2/2/2007"),]

### Transform date and time columns to Date format
epc$datetime <- strptime(
                  paste(epc$Date, epc$Time, sep=" "),
                  format="%d/%m/%Y %H:%M:%S",
                  tz="GMT"
                  )



#######
### Plot 2
#######

png(filename="plot2.png", width=480, height=480)
plot(x=epc$datetime,
     y=epc$Global_active_power,
     xlab="",
     ylab="Global Active Power (kilowatts)",
     type="l")
dev.off()
