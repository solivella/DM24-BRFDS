## Load packages
library(tidyverse)
## Load data
data(mpg)
## Inspect data
mpg %>% 
  print(n=4, width=70)


## Generate plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  labs(x = "Engine Size", y = "Highway MPG") + 
  theme_bw()


## ----------------------------------------------------------------------
# Scalar
vec_one <- 4
vec_one[1] # 1-indexed!
# Vectors 
num_vec  <- c(1, 9, 8)
int_vec  <- c(1L, 9L, 8L)
chr_vec  <- c("S","Oli","S")
bool_vec <- c(TRUE, FALSE)


## ----------------------------------------------------------------------
# Matrix (column major ordering!)
small_mat <- matrix(c(1:6), ncol = 2)
small_mat
num_vec %*% small_mat


## ----------------------------------------------------------------------
# Array
small_array <- array(c(1:12), dim = c(3, 2, 2))
small_array[1,2,1]
num_vec %*% small_array[,,1]
# num_vec %*% small_array[,,1, drop=FALSE] (Error!)


## ----------------------------------------------------------------------
# List
small_list <- list(first  = 1:3, 
                   second = letters[1:4])
small_list[[1]] # small_list[["first"]] also works
small_list$second


## ----------------------------------------------------------------------
# Data Frame
small_df <- data.frame(list(Name    = c("John", "Jane"),
                            Age     = c(36, 38),
                            Student = c(TRUE, FALSE)))
summary(small_df)


## ----------------------------------------------------------------------
small_tbl <- as_tibble(small_df)
small_tbl


## ----------------------------------------------------------------------
# Read data in (after loading tidyverse package!)
turnout <- read_csv("https://bit.ly/DM24_ANESTurnout")


## ----------------------------------------------------------------------
# Quick view of data set
glimpse(turnout, width=70)


## ----------------------------------------------------------------------
# Filter data to only midterm elections between 1984 and 2000
anes_sub <- filter(turnout,
                   (year %in% seq(1984, 2000, by = 4)))
glimpse(anes_sub)


## ----------------------------------------------------------------------
# Arrange data by TO estimate, then descending by year
(anes_ord <- arrange(turnout, # Notice that tibble name always comes first!
                     ANES, desc(year)))


## ----------------------------------------------------------------------
(anes_sub2 <- select(turnout,
                     matches("V.P"), year, felons:overseas))


## ----------------------------------------------------------------------
turnout <- mutate(turnout,
                  TO_VEP = total/VEP,
                  TO_VEP = TO_VEP * 100)




## ----------------------------------------------------------------------
# Load data
print(dates <- read_csv("https://bit.ly/DM24_dates"), n = 4)
print(works <- read_csv("https://bit.ly/DM24_works"), n = 4)


## ----------------------------------------------------------------------
# Do inner join
dates_works <- inner_join(dates, works) 
dates_works


## ----------------------------------------------------------------------
dates_someworks <- left_join(dates, works) 
dates_someworks


## ----------------------------------------------------------------------
dates_allworks <- right_join(dates, works) 
print(dates_allworks, width = 70)


## ----------------------------------------------------------------------
alldates_allworks <- full_join(dates, works) 
print(alldates_allworks, width = 70)


## ----------------------------------------------------------------------
table4a


## ----------------------------------------------------------------------
new_tab_long <- pivot_longer(table4a,
                             cols      = c(`1999`, `2000`),
                             names_to  = "year",
                             values_to = "cases")
new_tab_long


## ----------------------------------------------------------------------
print(table2, n = 8)



## ----------------------------------------------------------------------
new_tab_wide <- pivot_wider(table2, 
                            names_from  = type,
                            values_from = count)
new_tab_wide


## ----------------------------------------------------------------------


race_wide <- read_tsv("https://bit.ly/DM24_BISGdata")
race_tidy <- race_wide %>% 
  pivot_longer(cols      = contains("BISG"),
               names_to  = "ModelName",
               values_to = "ErrorValue") %>% 
  separate(ModelName,
           into = c("Model", "Name"),
           sep  = "_") %>% 
  pivot_wider(names_from  = Error,
              values_from = ErrorValue)

print(race_tidy, width = 40)
              
    


## ----------------------------------------------------------------------
new_tab_wide <- table2 %>% 
  pivot_wider(names_from  = type,
              values_from = count) %>% 
  filter(country %in% c("Brazil", "China"))

new_tab_wide


## ----------------------------------------------------------------------
# Load packages and data
library(tidyverse)
bookings <- read_csv("https://bit.ly/DM24_Hotels") 

# Obtain frequency table by hotel type
bookings %>% 
  group_by(hotel) %>% 
  select(hotel) %>% 
  table()


## ----------------------------------------------------------------------
# Summarize across all obs
bookings %>% 
  summarize(avg_lead_time = mean(lead_time)/30,
            sd_lead_time  = sd(lead_time)/30)

# Summarize within groups
bookings %>% 
  group_by(hotel) %>% 
  summarize(avg_lead_time = mean(lead_time)/30,
            sd_lead_time  = sd(lead_time)/30)

