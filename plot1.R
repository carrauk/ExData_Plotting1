## Part of Project1 submission for Exploratory Data Analytics Course on Coursea.
## Data not included in repository. Details for the data are in the ReadMe file.
## The script assumes the data is downloaded, extracted and placed in a sub-folder called 'data'

# setwd("~/Documents/Data_Sci_Course/Exploritory Analysis/Project_1/Local_Repo")

library(readr)

# input-output varaibles for script
data_file_path <- "data/household_power_consumption.txt"
output_file_path <- "plot1.png"
#

## read the data file-in. Using the readr package.
hpc_data <- read_csv2(file=data_file_path,
                      col_names=TRUE,
                      na = c("?","NA"),
                      col_types = cols(
                                              Date = col_date(format="%d/%m/%Y"),
                                              Time = col_time(format = ""),
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

# set up device for output (file path varaible set at begining of script)
# get current device setup to revert back to when script is complete
bk.cur.dev <- dev.cur()
# setup device - png, this sets it to the current device
png(filename=output_file_path, width=480, height=480, units="px")

# Histogram - colour = red, with title  = "Global Active Power" and X-axis = "Global Active Power (kilowatts)"
with(ss_hpc_data, 
     hist(global_active_power/1000, 
          col="red", 
          main="Global Active Power", 
          xlab="Global Active Power (kilowatts)"
          )
     )

## and now lets close the png device
dev.off()

# and revert to device before script altered
dev.set(bk.cur.dev)




