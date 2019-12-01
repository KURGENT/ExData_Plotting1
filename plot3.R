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
        
# to make #3 plotting

plot3 <- melt(hpc_TEST,id.vars = "DATE_TIME",measure.vars = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

View(plot3)
str(plot3)
unique(plot3$value)

par(mfrow=c(1,1))
plot(plot3$DATE_TIME,plot3$value,type = "n",xlab = "", ylab = "Energy sub metering")

with(subset(plot3,variable == "Sub_metering_1"),points(DATE_TIME,value,type = "l", col = "black"))
with(subset(plot3,variable == "Sub_metering_2"),points(DATE_TIME,value,type = "l", col = "red"))
with(subset(plot3,variable == "Sub_metering_3"),points(DATE_TIME,value,type = "l", col = "blue"))
legend("topright",pch = "-", col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.8)

dev.copy(png,file = "plot3.png")
dev.off()
