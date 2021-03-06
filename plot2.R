#Load data from text file, each column as a character
data <- read.table("household_power_consumption.txt",
                   header=TRUE,
                   sep=";",
                   colClass="character")
#Concatenate date and time fields
date_time<-paste(data$Date,data$Time)

#Add date_time to data frame 
data<-cbind(date_time,data)

#Change date field from character to date type
data$Date <- as.Date(data$Date,format="%d/%m/%Y")

#Change Global active power field to numeric
data$Global_active_power <- suppressWarnings(as.numeric(
    data$Global_active_power))

#Subset data to approperitate days
data<-data[data$Date=="2007-02-01" | data$Date=="2007-02-02",]

#Change date_time field to date type
data$date_time<-as.POSIXct(strptime(data$date_time, "%d/%m/%Y %X"))

#Save plot to the current directory
png("plot2.png",width=480,height=480)

#Plot
with(data,plot(date_time,
               Global_active_power,
               ylab="Global Active Power (kilowatts)",
               xlab="",
               type="l"))
dev.off()