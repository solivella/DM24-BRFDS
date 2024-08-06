
# Practice 3: Merging data -------------------------------------------------

## Install UN votes package ----
install.packages("unvotes") # once per R version

## Load package ----
library(unvotes)

## Merge datasets ----
un_joint <- inner_join(un_votes, un_roll_call_issues)

## Subsets by issue and country ----
un_arms <- filter(un_joint, issue == "Arms control and disarmament")
nrow(un_arms)

un_arms_usa <- filter(un_arms, country == "United States")
un_arms_col <- filter(un_arms, country == "Colombia")
un_arms_uru <- filter(un_arms, country == "Uruguay")

## Compute abstention rates ----
mean(un_arms_usa$vote == "abstain")
mean(un_arms_col$vote == "abstain")
mean(un_arms_uru$vote == "abstain")


