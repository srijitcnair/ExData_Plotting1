#read the data from local file
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#Parse date fromt he text field
data$Date <- strptime(data$Date, format="%d/%m/%Y")
d1<- strptime("1/2/2007", format="%d/%m/%Y")
d2<- strptime("2/2/2007", format="%d/%m/%Y")

#SUbset only the required records
working_data <- data[(data$Date==d1),]
working_data<-rbind(working_data, data[(data$Date==d2),])

#Convert the necessary fields to numeric
working_data$Global_active_power <- as.numeric(as.character(working_data$Global_active_power))
working_data$Global_reactive_power <- as.numeric(as.character(working_data$Global_reactive_power))
working_data$Voltage <- as.numeric(as.character(working_data$Voltage))
working_data$Sub_metering_1 <- as.numeric(as.character(working_data$Sub_metering_1))
working_data$Sub_metering_2 <- as.numeric(as.character(working_data$Sub_metering_2))
working_data$Sub_metering_3 <- as.numeric(as.character(working_data$Sub_metering_3))


#Create a datetime field for plotting
working_data$DateTime <- as.POSIXct(strptime(paste(working_data$Date, working_data$Time),"%Y-%m-%d %H:%M:%S"))

#create a png file and plot
png(filename = "plot4.png",width = 480, height = 480, units = "px", bg="transparent")

par(mfrow=c(2,2))

with(working_data, {
  plot(working_data$DateTime, working_data$Global_active_power, type="l", ylab="Global Active Power", xlab="")
  
  plot(working_data$DateTime, working_data$Voltage, type="l", ylab="Voltage", xlab="") 
  
  plot(working_data$DateTime, working_data$Sub_metering_1, type="l",ylab="Energy sub metering", xlab="")
  lines(working_data$DateTime, working_data$Sub_metering_2,col='Red')
  lines(working_data$DateTime, working_data$Sub_metering_3,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(working_data$DateTime, working_data$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime") 
})



dev.off()