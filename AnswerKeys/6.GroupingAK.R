
# Practice 6: Grouping ----------------------------------------------------

## Load package ----
library(unvotes)

## Create vector of G8 cty codes ----
g8 <- c("FR","DE","IT","JP","GB","US","CA","RU")

## Count nr. of votes per country ----
un_g8 <- un_votes %>% 
  inner_join(un_roll_call_issues) %>% 
  filter(country_code %in% g8) %>% 
  group_by(country) %>% 
  summarize(Tot_votes = n())

## Compute abstention rate by country and issue area ----
un_g8_issue <- un_votes %>% 
  inner_join(un_roll_call_issues, relationship = "many-to-many") %>% 
  filter(country_code %in% g8) %>% 
  group_by(country, issue) %>% 
  summarize(Prop_Abstain = mean(vote=="abstain")) %>% 
  arrange(country, issue, desc(Prop_Abstain))
print(un_g8_issue, n = 48)
