
# Practice 5: Piping ------------------------------------------------------

## Import data ----
race_wide <- read_tsv("https://bit.ly/DM24_BISGdata")

## Pre-process data to tidy up ----
race_tidy <- race_wide %>% 
  pivot_longer(cols = contains("BISG"),
               names_to = "ModelName",
               values_to = "ErrorValue") %>% 
  separate(ModelName,
           into = c("Model", "Name"),
           sep = "_") %>% 
  pivot_wider(names_from = Error,
              values_from = ErrorValue)

## Print new dataset ----
print(race_tidy, width=40)
