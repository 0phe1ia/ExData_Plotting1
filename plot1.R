plot1 <- function() 
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
      
      ##Export to plot1.png
      png(file="plot1.png", width = 480, height = 480, units = "px")
      
      ##Plot 1: Global Active Power
      hist(ftbl$Global_active_power, col="Red", main="Global Active Power",xlab="Global Active Power (kilowatts)")
      
      dev.off()
}

