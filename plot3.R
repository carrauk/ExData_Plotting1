## Part of Project1 submission for Exploratory Data Analytics Course on Coursea.
## Data not included in repository. Details for the data are in the ReadMe file.
## The script assumes the data is downloaded, extracted and placed in a sub-folder called 'data'

# setwd("~/Documents/Data_Sci_Course/Exploritory Analysis/Project_1/Local_Repo")

library(readr)
library(dplyr)
library(lubridate)

# input-output varaibles for script
data_file_path <- "data/household_power_consumption.txt"
output_file_path <- "plot3.png"
#

## read the data file-in. Using the readr package.
hpc_data <- read_csv2(file=data_file_path,
                      col_names=TRUE,
                      na = c("?","NA"),
                      col_types = cols(
                                              Date = col_date(format="%d/%m/%Y"),
                                              Time = col_time(format = "%H:%M:%S"),
                                              Global_active_power = col_number(),
                                              Global_reactive_power = col_number(),
                                              Voltage = col_number(),
                                              Global_intensity = col_number(),
                                              Sub_metering_1 = col_number(),
                                              Sub_metering_2 = col_number(),
                                              Sub_metering_3 = col_number()
                                      )
                      )
# converting names to lower-case to make it easier for me to reference.
names(hpc_data) <- tolower(names(hpc_data))

# subset the data to get data related to 01/02/2007 and 02/02/2007
ss_hpc_data <- subset(hpc_data, 
                      date == as.Date("01/02/2007", "%d/%m/%Y")
                      | date == as.Date("02/02/2007", "%d/%m/%Y")
                      )

## ok - now lets generate the graphic required and output to PNG file

# some work to append a new column that brings the date and time columns into a single column
# using the dplyr and lubridate packages
ss_hpc_data <- ss_hpc_data %>% mutate(date_time=as.POSIXct(date + hours(hour(time)) + minutes(minute(time))))
                                      
# set up device for output (file path varaible set at begining of script)
# get current device setup to revert back to when script is complete
bk.cur.dev <- dev.cur()
# setup device - png, this sets it to the current device
png(filename=output_file_path, width=480, height=480, units="px")

# Plot x=date, y=sub-metering , type="l"(line), 
with(ss_hpc_data, 
     {
             plot(x=date_time,
                  y=sub_metering_1/1000, 
                  type="l",
                  col="black", 
                  xlab="",
                  ylab="Energy sub metering"
                  )
             # additional lines
             lines(x=date_time,
                   y=sub_metering_2/1000, 
                   type="l",
                   col="red", 
                   xlab="",
                   ylab="Energy sub metering"
                  )
             lines(x=date_time,
                   y=sub_metering_3/1000, 
                   type="l",
                   col="blue", 
                   xlab="",
                   ylab="Energy sub metering"
             )
             # and Legend
             legend("topright", 
                    col=c("black", "red", "blue"),
                    lty=1,
                    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

     })


## and now lets close the png device
dev.off()

# and revert to device before script altered
dev.set(bk.cur.dev)




