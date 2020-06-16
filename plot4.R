setwd("~/R Studio personal projects/Curso Johns Hopkins/Exploratory Data Analysis with R/Week 1")

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/ProjectDataset.zip",method="curl")

unzip(zipfile="./data/ProjectDataset.zip",exdir="./data")
datapath <- file.path("./data")
EPC<- read.table(file.path(datapath,"household_power_consumption.txt" ),header = T, sep = ";", na.strings = "?")


EPC$Date <- paste(EPC$Date, EPC$Time, sep = " ")

EPC$Date <- strptime(EPC$Date, format = "%d/%m/%Y %H:%M:%S")
class(EPC$Date)


EPC <- subset(EPC, EPC$Date >= as.POSIXct("2007-2-1") & Date <= as.POSIXct("2007-2-2 23:59:00"))
par(mfcol=c(2,2))
plot(EPC$Date,EPC$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
plot(EPC$Date,EPC$Sub_metering_1, type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(EPC$Date, EPC$Sub_metering_1)
lines(EPC$Date, EPC$Sub_metering_2, col="red")
lines(EPC$Date, EPC$Sub_metering_3,col="blue")
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(EPC$Date,EPC$Voltage, type="l", ylab="Voltage (Volt)", xlab="")
plot(EPC$Date,EPC$Global_reactive_power, type="l", ylab="Global Rective Power (Kilowatts)", xlab="")
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
