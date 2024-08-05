
# Practice 1: Loading data ------------------------------------------------

## Load libraries (only once per session)
library(tidyverse)

## Load hotel bookings data ----
hotels <- read_csv("https://bit.ly/HotelsDM23")

## Establish the number of bookings ----
nrow(hotels)

## Nr. of variables and their classes ----
print(hotels)

## Average amount of lead time ----
mean(hotels$lead_time) #in days!
