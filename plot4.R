#Load data from text file, each column as a character

columns<-c("character",
           "character",
           rep("numeric",7))
data <- read.table("household_power_consumption.txt",
                   header=TRUE,
                   sep=";",
                   colClass=columns,
                   na.strings="?")

#Concatenate date and time fields
date_time<-paste(data$Date,data$Time)

#Add date_time to data frame 
data<-cbind(date_time,data)

#Change date_time field to date type
data$date_time<-as.POSIXct(strptime(data$date_time, "%d/%m/%Y %X"))

#Subset data to appropriate days
data<-subset(data,data$date_time>=as.POSIXct("2007-02-01 00:00:00")
             & data$date_time<as.POSIXct("2007-02-03 00:00:00"))

#Save plot to the current directory
png("plot4.png",width=480,height=480)

#2 x 2 grid for plots:
par(mfrow=c(2,2))

#Plot 1
with(data,plot(date_time,
               Global_active_power,
               ylab="Global Active Power",
               xlab="",
               type="l"))

#Plot 2
with(data,plot(date_time,
               Voltage,
               ylab="Voltage",
               xlab="datetime",
               type="l"))

#Plot 3, dataset 1
with(data,plot(date_time,
               Sub_metering_1,
               ylab="Energy sub metering",
               xlab="",
               type="l"))
#Plot 3, dataset 2
lines(data$date_time,data$Sub_metering_2,type="l",col="red")

#Plot 3, dataset 3
lines(data$date_time,data$Sub_metering_3,type="l",col="blue")

#Legend
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),
       col=c("black","red","blue"))

#Plot 4
with(data,plot(date_time,
               Global_reactive_power,
               xlab="datetime",
               type="l"))
dev.off()