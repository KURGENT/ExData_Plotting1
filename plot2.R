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

# to make #2 plotting

plot(hpc_TEST$DATE_TIME,hpc_TEST$Global_active_power,xlab = "", ylab = "Global Active Power (kilowatts)",type = "l", xlim = NULL, ylim= NULL)
dev.copy(png,file = "plot2.png")
dev.off()
