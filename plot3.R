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
### Plot 3
#######

png(filename="plot3.png", width=480, height=480)

### Plot sub metering 1
plot(x=epc$datetime,
     y=epc$Sub_metering_1,
     xlab="",
     ylab="Energy sub metering",
     type="l", col="black",
     ylim=range(epc[,c("Sub_metering_1","Sub_metering_2","Sub_metering_3")])
     )

### Add sub metering 2 to plot
lines(x=epc$datetime,
      y=epc$Sub_metering_2,
      col="red")

### Add sub metering 3 to plot
lines(x=epc$datetime,
      y=epc$Sub_metering_3,
      col="blue")

### Add legend
legend("topright",
       legend=paste("Sub_metering",1:3,sep="_"),
       col=c("black","red","blue"),
       lty=1
       )

dev.off()
