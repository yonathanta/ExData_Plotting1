# This program downloads the zipped file into temporary folder, unzipped it and 
# opens the relevant data. As the zipped file is big in size 
# the downloading may take some time.

library(sqldf)

# get the file from the url

url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# create a temp directory
tdir = tempdir()
# create placeholder file
tfile = tempfile(tmpdir=tdir, fileext=".zip")

if(!file.exists(fpath)){
# download into the placeholder file
download.file(url, tfile)
# get the name of the file 
fname = unzip(tfile, list=TRUE)$Name[1]
# unzip the file to the temp directory
unzip(tfile, files=fname, exdir=tdir, overwrite=TRUE)
# fpath is the full path to the extracted file
fpath = file.path(tdir, fname)}

# read the requared data 
data <- read.csv.sql(fpath, sep=";",sql = "select * from file where Date = '1/2/2007' OR Date = '2/2/2007' ", header = TRUE)

#create a variable combining Date and Time
data$mydate<-paste(data$Date, data$Time)
     
##Plot 2
par(mfrow=c(1,1))

plot(strptime(data$mydate,"%d/%m/%Y %H:%M:%S"), as.numeric(data$Global_active_power), type="l", xlab="", ylab="Global Active Power (kilowatts)")
#saving the file to the current working folder (directory)

dev.copy(png,file="plot2.png")
dev.off()