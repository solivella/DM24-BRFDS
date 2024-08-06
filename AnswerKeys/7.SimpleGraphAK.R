
# Practice Graphing 1 -----------------------------------------------------
## Load tidyverse
library(tidyverse)

## Load the data
hotels <- read_csv("https://bit.ly/DM24_Hotels")

## Reorder levels of arrival month using month.name
hotels <- hotels %>% 
  mutate(arrival_date_month = fct_relevel(arrival_date_month, month.name))
  

## Plot histogram of arrival months 
hotels %>% 
  ggplot(aes(x=arrival_date_month)) +
  geom_histogram(stat="count") +
  labs(x="Arrival Month", y="Nr. of Bookings") +
  theme_bw() 
