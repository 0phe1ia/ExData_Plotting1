plot4 <- function() 
{
      ##Checks if the data.table package is installed, if not it installs it.
      if("data.table" %in% rownames(installed.packages()) == FALSE)
      {
            install.packages("data.table")
            library(data.table) 
      }

      ##Read the data from the file
      tbl <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
      
      ##Convert factors to appropriate data types
      tbl$Date <- as.Date(tbl$Date, format="%d/%m/%Y")                  ##to date
      tbl$Global_active_power <- as.numeric(tbl$Global_active_power)    ##to numeric
      tbl$Sub_metering_1 <- as.numeric(tbl$Sub_metering_1) 
      tbl$Sub_metering_2 <- as.numeric(tbl$Sub_metering_2) 
      tbl$Sub_metering_3 <- as.numeric(tbl$Sub_metering_3) 
      
      ##Filter the data down to 2 dates
      ftbl <- tbl[tbl$Date %in% as.Date(c('2007-02-01','2007-02-02')),]
      
      ##concantenante the date and time
      ftbl$dttime <- as.POSIXct(paste(ftbl$Date, ftbl$Time), format="%Y-%m-%d %H:%M:%S")

      
      ##Export to plot4.png
      png(file="plot4.png", width = 480, height = 480, units = "px")
      
      ##Output plots to a 2x2 matrix with the specfied margins below
      par(mfrow=c(2,2))
      par(mar = c(4,4,2,2))
      
      ##Plot 4
      ##Global Active Power
      plot(ftbl$dttime, ftbl$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
      lines(ftbl$dttime, ftbl$Global_active_power, type="l")
      
      ##Voltage
      plot(ftbl$dttime, ftbl$Voltage, type="n", xlab="datetime", ylab="Voltage")
      lines(ftbl$dttime, ftbl$Voltage, type="l")
      
      ##Sub metering
      plot(ftbl$dttime,ftbl$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
      lines(ftbl$dttime,ftbl$Sub_metering_1, type="l", col="Black") ##Sub_metering_1
      lines(ftbl$dttime,ftbl$Sub_metering_2, type="l", col="Red")   ##Sub_metering_2
      lines(ftbl$dttime,ftbl$Sub_metering_3, type="l", col="Blue")  ##Sub_metering_3
      legend('topright', c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)
      
      ##Global Reactive Power
      plot(ftbl$dttime,ftbl$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
      lines(ftbl$dttime,ftbl$Global_reactive_power, type="l")
      
      dev.off()
}

