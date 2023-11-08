# Required Packages
install.packages("ggplot2")
install.packages("lubridate")
install.packages("dplyr")

library(ggplot2)
library(lubridate)
library(dplyr)

# Read the CSV file into a data frame
data <- read.csv("C:/Users/danhe/OneDrive/Documents/2/Nottingham_United Kingdom.csv", header = FALSE)

file_path <- "C:/Users/danhe/OneDrive/Documents/2/Nottingham_United Kingdom.csv"
data <- read.csv("C:/Users/danhe/OneDrive/Documents/2/Nottingham_United Kingdom.csv")

# Convert the date column to Date type
data$Date <- as.Date(data$Date, "%m/%d/%Y")

# Removing NA values
data <- data[!is.na(data$Ozone),]

# Plotting
ggplot(data, aes(x = Date, y = Ozone.level)) +
  geom_line() +
  ggtitle("Ozone Levels in Nottingham United Kingdom (2014-2023)") +
  xlab("Date") +
  ylab("Ozone.level")