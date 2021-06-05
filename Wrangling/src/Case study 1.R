#warngling data case study.
library(tidyverse)
#install.packages('janitor')
library(janitor)
#install.packages('skimr')
library(skimr)
library(here)
## here() starts at /Users/rdpeng/books/tidyversecourse

load(here::here("data","raw_data", "case_study_1.rda"))
load(here::here("data", "raw_data", "case_study_2.rda"))
#This loads all the data objects that we previously saved in our raw_data directory. Recall that this

coverage

library(datasets)
data(state)
state.name

state.abb <- c(state.abb, "DC")
state.region <- as.factor(c(as.character(state.region), "South"))
state.name <- c(state.name, "District of Columbia")
state_data <- tibble(Location = state.name,
                     abb = state.abb,
                     region = state.region)
state_data

names(coverage)

#Put coverage into long format instead of wide, better for tidy data
coverage <- coverage %>%
  mutate(across(starts_with("20"), 
                as.integer)) %>%  ## Convert all year-based columns to integer
  pivot_longer(-Location,         ## Use all columns BUT 'Location'
               names_to = "year_type", 
               values_to = "tot_coverage")

#Seperate out year column
coverage <- coverage %>% 
  separate(year_type, sep="__", 
           into = c("year", "type"), 
           convert = TRUE)

coverage

#join to state_data that we created earlier
coverage <- coverage %>%
  left_join(state_data, by = "Location")

coverage