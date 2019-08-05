library(dplyr)
library(lubridate)

# Set your working directory and make sure the data file is locted here.
setwd("C:\\Users\\nayak\\Desktop\\Johns_Hopkins_DS\\Exploratory Data Analysis\\Week1\\Assignment1")

# By trial and error and some common sense (i.e. in one day there are 1440 minutes) figure out 
# the position where you want to read from and where upto...
dSet = read.csv("household_power_consumption.txt", sep = ";",header = TRUE, na.strings = "?", skip = 66636, nrows = 2880)
namedSet = read.csv("household_power_consumption.txt", sep = ";", header = TRUE,nrows = 1)
colnames(dSet) = colnames(namedSet)

# Check for NA values present in our dataset
colSums(is.na(dSet))
head(dSet)

# Looking at the colSums, it could be said that there aren't any NA values in our data.
# Convert the date and time into a datetime object and storing it into the dataframe
for(i in seq(1,nrow(dSet))){
    dSet$DateTime[i] = dmy_hms(paste(dSet$Date[i], dSet$Time[i], collapse = " "))
}

# Open the png Graphics device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Since we want 4 plots in one canvas, use par to specify that.
par(mfcol = c(2,2), cex = 0.8, mar = c(4,4,2,2))

# Save the positions on X-Axis which correspond to start of a new day
v1 = c(1170288000,1170374400,1170460740)

# Make a vector of corresponding days
v2 = c("Thu", "Fri", "Sat")


#Plot 1 - Global Active Power vs days
# Draw a plot without the x-ticks
plot(dSet$DateTime, dSet$Global_active_power,  xlab = "", 
     ylab = "Global Active Power (kilowatts)", type = "l", xaxt = "n")

# Introduce x-ticks from above based on v1 and v2
axis(side = 1, at = v1, labels = v2, tck = -0.02)

# Plot 2 - Submetering vs days
# Draw a plot without the x-ticks
plot(dSet$DateTime, dSet$Global_active_power,  xlab = "", 
     ylab = "Energy Sub-metering", type = "n", xaxt = "n", ylim = c(0,40))

# Put sub-metering 1,2,3 in the plot
points(dSet$DateTime, dSet$Sub_metering_1, col = "black", type = "l")
points(dSet$DateTime, dSet$Sub_metering_2, col = "red", type = "l")
points(dSet$DateTime, dSet$Sub_metering_3, col = "blue", type = "l")

# Write the legends on the top left corner
# Specify cex = 0.5 to reduce the size of legend, else, it occupies entire space
# Meant for the plot.

legend("topright", legend = c("Sub-metering 1", "Sub-metering 2", "Sub-metering 3")
       ,col = c("black","red","blue"),cex = 0.8, y.intersp = 1, lty = c(1,1,1), pch = c(NA,NA,NA))

# Introduce x-ticks from above based on v1 and v2
axis(side = 1, at = v1, labels = v2, tck = -0.02)


# Plot 3 Voltage vs days
# Draw a plot of Voltage vs days without the x-ticks
plot(dSet$DateTime, dSet$Voltage,  xlab = "datetime", 
     ylab = "Global Active Power (kilowatts)", type = "l", xaxt = "n")

# Introduce x-ticks from above based on v1 and v2
axis(side = 1, at = v1, labels = v2, tck = -0.02)

# Plot 3 Global Reactive Power vs days
# Draw a plot of Global Reactive Power vs days without the x-ticks
plot(dSet$DateTime, dSet$Global_reactive_power,  xlab = "datetime", 
     ylab = "Global Reactive Power", type = "l", xaxt = "n")

# Introduce x-ticks from above based on v1 and v2
axis(side = 1, at = v1, labels = v2, tck = -0.02)


# Exit/Release the graphics device
dev.off()

