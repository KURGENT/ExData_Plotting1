library(dplyr)
library(lubridate)
library(reshape2)

hpc <- read.table("household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?")
dim(hpc)
View(hpc)
str(hpc)
names(hpc)


#filter the datafame only for 2007-02-01 and 2007-02-02
filtered <- filter(hpc,Date == "1/2/2007" | Date =="2/2/2007")
str(filtered)     
tail(filtered)

#combine Date and Time columns and change the format to POSIXct for plotting
hpc_TEST <- filtered %>%
        mutate(DATE_TIME = as.POSIXct(paste(filtered$Date, filtered$Time), format="%d/%m/%Y %H:%M:%S"))

####plot #4

par(mfcol=c(2,2),mar = c(4,4,1,1),oma = c(0,0,0,0),cex.axis = 0.8,cex.lab = 0.8)

plot(hpc_TEST$DATE_TIME,hpc_TEST$Global_active_power,xlab = "", ylab = "Global Active Power (kilowatts)",type = "l", xlim = NULL, ylim= NULL)

plot(plot3$DATE_TIME,plot3$value,type = "n",xlab = "", ylab = "Energy sub metering")
with(subset(plot3,variable == "Sub_metering_1"),points(DATE_TIME,value,type = "l", col = "black"))
with(subset(plot3,variable == "Sub_metering_2"),points(DATE_TIME,value,type = "l", col = "red"))
with(subset(plot3,variable == "Sub_metering_3"),points(DATE_TIME,value,type = "l", col = "blue"))
legend("topright",pch = "-", col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.4)

plot(hpc_TEST$DATE_TIME,hpc_TEST$Voltage,type = "l",xlab = "datetime",ylab = "Voltage")

plot(hpc_TEST$DATE_TIME,hpc_TEST$Global_reactive_power,type = "l",xlab = "datetime",ylab = "Global_reactive_power")

dev.copy(png,file = "plot4.png")
dev.off()
