#Load data from text file, each column as a character
data <- read.table("household_power_consumption.txt",
                   header=TRUE,
                   sep=";",
                   colClass="character")

#Change date field from character to date type
data$Date <- as.Date(data$Date,format="%d/%m/%Y")

#Change Global active power field to numeric
data$Global_active_power <- suppressWarnings(as.numeric(
                            data$Global_active_power))
#subset data
data<-with(data,subset(Global_active_power,Date>="2007-02-01" & Date<="2007-02-02"))
#save plot as png to directory
png("plot1.png",width=480,height=480)
#plot histogram
hist(data, 
     #Main Title
     main="Global Active Power", 
     #X-axis Label
     xlab="Global Active Power (Kilowatts)",
     #Color fill
     col="red",
     #X-axis range
     xlim=c(0,6),
     #suppress y-axis
     yaxt="n"
     )
#Location for tick marks
x<-seq(from=0,to=1200,by=200)
axis(2,las=2,at=x)
dev.off()