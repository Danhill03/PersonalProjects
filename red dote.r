# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load your data (replace 'your_data.csv' with the path to your data file)
df <- read.csv("C:/Users/danhe/OneDrive/Documents/2/South_Korea.csv")

# Set the threshold (replace 'your_threshold' with your actual threshold)
threshold <- 50

# Filter the data that surpass the threshold
df_threshold <- df %>%
  filter(Ozone.level > 50)

# Print the data that surpasses the threshold
print(df_threshold)

# Plot the data, highlighting points above the threshold
ggplot(data = df, aes(Date, Ozone.level )) +
  geom_point(aes(color = Ozone.level > 50)) +
  scale_color_manual(values = c("FALSE" = "black", "TRUE" = "red")) +
  theme_minimal()