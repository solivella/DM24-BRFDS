
library(tidyverse)



## ------------------------------------------------------------------
mpg %>% ggplot(mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth() +
  labs(x = "Engine Size (in liters)", y = "Highway MPG") + 
  theme_bw()


## -------------------------------------------------------------------------------------


library(unvotes)
undata <- un_votes %>% 
  inner_join(un_roll_call_issues)

## ----fig.align='center'---------------------------------------------------------------
ggplot(undata, aes(x = vote, fill = issue)) +
  geom_bar(position = "dodge") +
  theme_bw()


## ----fig.align='center'---------------------------------------------------------------
ggplot(undata, aes(x = vote, fill = issue)) +
  geom_bar(position = "dodge") +
  scale_fill_brewer(palette="Set1") +
  theme_bw()


## ----fig.align='center'---------------------------------------------------------------
undata %>% 
  filter(country %in% c("Bolivia","Colombia","Ecuador", "Peru", "Venezuela")) %>% 
ggplot(aes(x = vote, fill = issue)) +
  geom_bar(position = "dodge") +
  facet_wrap(vars(country), nrow=1) +
  theme_bw()





## -------------------------------------------------------------------------------------
## Load package
library(tidymodels)

## Define logistic regression model
logit_model <- logistic_reg() %>% 
  set_engine("glm") %>% 
  set_mode("classification") # glm can also do regression!

## Create data
un_data <- un_votes %>% 
  inner_join(un_roll_call_issues, relationship = "many-to-many") %>% 
  inner_join(un_roll_calls) %>% 
  mutate(abstained = as.factor(vote=="abstain"))

## Fit model's parameters
logit_fit <- logit_model %>% 
  fit(abstained ~ issue + importantvote,
      data = un_data)




## -------------------------------------------------------------------------------------

## Define new logistic regression model
logit_model_ridge <- logistic_reg(penalty = tune(), #notice the tuning!
                                  mixture = 0) %>% 
  set_engine("glmnet") %>% 
  set_mode("classification") 

## Fit new model's parameters
logit_fit_ridge <- logit_model_ridge %>% 
  fit(abstained ~ issue * importantvote,
      data = un_data)


## -------------------------------------------------------------------------------------
## Create new data and append predictions
pred_data <- un_data %>% 
  filter(!is.na(importantvote)) %>% 
  distinct(issue, importantvote) %>% 
  bind_cols(predict(logit_fit, . , type = "prob")) %>% 
  bind_cols(predict(logit_fit, . , type = "conf_int"))




## Plot predictions
pred_data %>% 
  mutate(imp = case_when(importantvote == 0 ~ "Important",
                         TRUE ~ "Unimportant")) %>% 
  ggplot(aes(x = .pred_TRUE, y = fct_reorder(issue, .pred_TRUE),
             col=imp)) +
  geom_point() +
  geom_errorbarh(aes(xmin = .pred_lower_TRUE,
                     xmax = .pred_upper_TRUE),
                 height=.3) +
  labs(x="Predicted Probability of Abstaining",
         y="Issue Area",
         color = "Importance of Vote") +
  theme_bw()



## ----eval = FALSE---------------------------------------------------------------------
## knitr::kable(mtcars[1:5, 1:5], "markdown")

