plot3 <- function() 
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
      
      ##Filter the data down to 2 dates
      ftbl <- tbl[tbl$Date %in% as.Date(c('2007-02-01','2007-02-02')),]
      
      ##concantenante the date and time
      ftbl$dttime <- as.POSIXct(paste(ftbl$Date, ftbl$Time), format="%Y-%m-%d %H:%M:%S")
      
      ##Export to plot1.png
      png(file="plot3.png", width = 480, height = 480, units = "px")
      
      ##Plot 3
      x <- ftbl$dttime
      
      plot(x,ftbl$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
      lines(x,ftbl$Sub_metering_1, type="l", col="Black") ##Sub_metering_1
      lines(x,ftbl$Sub_metering_2, type="l", col="Red")   ##Sub_metering_2
      lines(x,ftbl$Sub_metering_3, type="l", col="Blue")  ##Sub_metering_3
      
      legend('topright', c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)
      ##draw the legend
      
      dev.off()
}

