
# Practice 8: More graphing ----------------------------------------------------

## Load package ----
library(unvotes)

## Create vector of G8 cty codes ----
g8 <- c("FR","DE","IT","JP","GB","US","CA","RU")

## Create dataset of abstention proportions by country, issue, and year
un_g8 <- un_votes %>% 
  inner_join(un_roll_call_issues, relationship = "many-to-many") %>% 
  inner_join(un_roll_calls) %>% 
  filter(country_code %in% g8) %>%
  mutate(year = year(date)) %>% 
  group_by(country, issue, year) %>% 
  summarize(Prop_Abstain = mean(vote=="abstain")) 

## Create plot of trend lines
un_g8 %>% 
  ggplot(aes(x=year, y=Prop_Abstain, col=issue)) +
  facet_wrap(vars(country), nrow=2) +
  geom_line(lwd=1) +
  scale_color_brewer(type="qual", palette=1) +
  labs(x="Year", y="Proportion of Abstentions", color="Issue")+
  theme_bw()
