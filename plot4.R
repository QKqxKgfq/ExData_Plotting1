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
### Plot 4
#######

png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

### Top left plot
plot(x=epc$datetime,
     y=epc$Global_active_power,
     xlab="",
     ylab="Global Active Power (kilowatts)",
     type="l")

### Top right plot
plot(x=epc$datetime,
     y=epc$Voltage,
     xlab="datetime",
     ylab="Voltage",
     type="l")

### Bottom left plot
plot(x=epc$datetime,
     y=epc$Sub_metering_1,
     xlab="",
     ylab="Energy sub metering",
     type="l", col="black",
     ylim=range(epc[,c("Sub_metering_1","Sub_metering_2","Sub_metering_3")])
     )

lines(x=epc$datetime,
      y=epc$Sub_metering_2,
      col="red")

lines(x=epc$datetime,
      y=epc$Sub_metering_3,
      col="blue")

legend("topright",
       legend=paste("Sub_metering",1:3,sep="_"),
       col=c("black","red","blue"),
       lty=1,
       bty="n"
       )

### Bottom right plot
plot(x=epc$datetime,
     y=epc$Global_reactive_power,
     xlab="datetime",
     ylab="Global_reactive_power",
     type="l")

dev.off()
