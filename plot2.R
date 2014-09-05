#read the data from local file
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#Parse date fromt he text field
data$Date <- strptime(data$Date, format="%d/%m/%Y")
d1<- strptime("1/2/2007", format="%d/%m/%Y")
d2<- strptime("2/2/2007", format="%d/%m/%Y")

#SUbset only the required records
working_data <- data[(data$Date==d1),]
working_data<-rbind(working_data, data[(data$Date==d2),])

#Convert the power field to numeric
working_data$Global_active_power <- as.numeric(as.character(working_data$Global_active_power))

#Create a datetime field for plotting
working_data$DateTime <- as.POSIXct(strptime(paste(working_data$Date, working_data$Time),"%Y-%m-%d %H:%M:%S"))

#create a png file and plot
png(filename = "plot2.png",width = 480, height = 480, units = "px", bg="transparent")
plot(working_data$DateTime, working_data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()