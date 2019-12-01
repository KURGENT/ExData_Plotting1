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

# to make #1 plotting
hist(hpc_DT2$Global_active_power,col = "red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png,file = "plot1.png")
dev.off()
