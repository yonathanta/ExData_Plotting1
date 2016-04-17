# This program downloads the zipped file into temporary folder, unzipped it and 
# opens the relevant data. As the zipped file is big in size 
# the downloading may take some time.

library(sqldf)

# get the file url

url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# create a temporary directory
tdir = tempdir()
# create the placeholder file
tfile = tempfile(tmpdir=tdir, fileext=".zip")

if(!file.exists(fpath)){
# download into the placeholder file
download.file(url, tfile)
# get the name of the file 
fname = unzip(tfile, list=TRUE)$Name[1]
# unzip the file 
unzip(tfile, files=fname, exdir=tdir, overwrite=TRUE)
# fpath is the full path to the extracted file
fpath = file.path(tdir, fname)}

# read the requared data 
data <- read.csv.sql(fpath, sep=";",sql = "select * from file where Date = '1/2/2007' OR Date = '2/2/2007' ", header = TRUE)

#create a variable combining Date and Time
data$mydate<-paste(data$Date, data$Time)

#plot 4


par(mfrow=c(2,2))

plot(strptime(data$mydate,"%d/%m/%Y %H:%M:%S"),as.numeric(data$Global_active_power), type="l", xlab="", ylab="Global Active Power")
plot(strptime(data$mydate,"%d/%m/%Y %H:%M:%S"),as.numeric(data$Voltage), type="l", xlab= "datetime", ylab="Voltage")
plot(strptime(data$mydate,"%d/%m/%Y %H:%M:%S"), as.numeric(data$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering")
lines(strptime(data$mydate,"%d/%m/%Y %H:%M:%S"), as.numeric(data$Sub_metering_2),col="red")
lines(strptime(data$mydate,"%d/%m/%Y %H:%M:%S"), as.numeric(data$Sub_metering_3), col="blue")
legend(x="top",c("Sub_metring_1","Sub_metring_2","Sub_metring_3"), lty=c(1,1,1), col=c("black","red", "blue"))
plot(strptime(data$mydate,"%d/%m/%Y %H:%M:%S"), as.numeric(data$Global_reactive_power), type="l", xlab= "datetime", ylab="Global_reactive_power")

#saving the file to the current working folder (directory)
dev.copy(png,file="plot4.png")
dev.off()
