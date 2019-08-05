library(dplyr)

# Set your working directory and make sure the data file is locted here.
setwd("C:\\Users\\nayak\\Desktop\\Johns_Hopkins_DS\\Exploratory Data Analysis\\Week1\\Assignment1")

# By trial and error and some common sense (i.e. in one day there are 1440 minutes) figure out 
# the position where you want to read from and where upto...
dSet = read.csv("household_power_consumption.txt", sep = ";",header = TRUE, na.strings = "?", skip = 66636, nrows = 2880)
namedSet = read.csv("household_power_consumption.txt", sep = ";", header = TRUE,nrows = 1)
colnames(dSet) = colnames(namedSet)

# Check for NA values present in our dataset
colSums(is.na(dSet))

# Looking at the colSums, it could be said that there aren't any NA values in our data.
# Hence proceed with the plots given the dataframe dSet

# Open the png Graphics device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Constructing a plot for Global Active Power.
# Draw/Make the plot and annotate title to it simultaneously
par(mfrow = c(1,1))
hist(dSet$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

# Exit/Release the graphics device
dev.off()


