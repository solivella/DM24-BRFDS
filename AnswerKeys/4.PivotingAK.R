
# Practice 4: Pivoting data ----------------------------------------------

## Import data ----
race_wide <- read_tsv("https://bit.ly/DM24_BISGdata")

## Pivot to long ----
race_long <- pivot_longer(race_wide, 
               cols = contains("BISG"),
               names_to = "ModelName",
               values_to = "ErrorValue")

## Separate model names ----
race_long <-  separate(race_long,
                       ModelName,
                       into = c("Model", "Name"),
                       sep = "_")

## Pivot to wide %>% 
race_tidy <- pivot_wider(race_long, 
                         names_from = Error,
                         values_from = ErrorValue)

print(race_tidy, width=40)

