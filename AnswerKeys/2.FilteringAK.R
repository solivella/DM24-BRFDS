
# Practice 2: Filtering data ----------------------------------------------

## Load data ----
hotel <- read_csv("https://bit.ly/DM24_Hotels")


## Compute proportion of short notice bookings  ----
short_notice <- filter(hotel, 
                       lead_time <= 1)
nrow(short_notice)/nrow(hotel) # ~8\% of all bookings are short notice


## Compute proportion in the USA and outside----
## Short notice in the USA
short_notice_usa <- filter(hotel, 
                           lead_time <= 1,
                           country == "USA")
all_book_usa <- filter(hotel, 
                       country == "USA")
prop_in_usa <- nrow(short_notice_usa)/nrow(all_book_usa) # ~11.5\% of all USA bookings are short notice
## Short notice not in the USA
short_notice_nusa <- filter(hotel, 
                            lead_time <= 1,
                            country != "USA")
all_book_nusa <- filter(hotel, 
                        country != "USA")
prop_in_nusa <- nrow(short_notice_nusa)/nrow(all_book_nusa) # ~8.1\% of all non-USA bookings are short notice
## Are Americans more whimsical?
prop_in_usa > prop_in_nusa

## Bookings with children ----

## Proportion of reservations at resort with any children
child_resort <- filter(hotel,
                       hotel == "Resort Hotel",
                       children > 0)
resort <- filter(hotel,
                 hotel == "Resort Hotel")

## Proportion of reservations at city hotel with any children
child_city <- filter(hotel,
                     hotel == "City Hotel",
                     children > 0)
city <- filter(hotel,
               hotel == "City Hotel")

## Pr(children | resort) = 8.7%
nrow(child_resort)/nrow(resort) 

## Pr(children | city) = 6.4%
nrow(child_city)/nrow(city)
## Its is more likely to find bookings with children in resorts than in 
## city hotels. 

## Compute Nr. of children and babies per adult ----
hotel_new <- mutate(filter(hotel, adults > 0), #Filter out zero-adult bookings
                    tot_kids = (children + babies)/adults)

##Average in the US
mean(select(filter(hotel_new, country=="USA"), tot_kids)$tot_kids, na.rm=TRUE)
##Average not in the US
mean(select(filter(hotel_new, country!="USA"), tot_kids)$tot_kids, na.rm=TRUE)

## Generate a frequency table per country ----
table(select(filter(hotel, country %in% c("COL","VEN","PER","ECU","BOL")), 
             country)$country)
## Colombia has the most travelers.

