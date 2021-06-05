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

##Now to look at spending

spending

# take spending data from wide to long
spending <- spending %>%
  pivot_longer(-Location, 
               names_to = "year", 
               values_to = "tot_spending")

# separate year and name columns
spending <- spending %>% 
  separate(year, sep="__", 
           into = c("year", "name"), 
           convert = TRUE) %>% 
  select(-name) #select all columns except select....called negative indexing

# look at the data
spending

hc <- inner_join(coverage, spending, 
                 by = c("Location", "year"))

hc

hc <- hc %>% 
  filter(Location != "United States") # remove the United states aggregate

table(hc$type) #problem is the different types of coverage

pop <- hc %>% 
  filter(type == "Total") %>%              #The “Total” type is not really a formal type of healthcare coverage. It really represents just the total number of people in the state.
  select(Location, year, tot_coverage)

pop

# ad population level information
hc <- hc %>% 
  filter(type != "Total") %>% 
  left_join(pop, by = c("Location", "year")) %>% 
  rename(tot_coverage = tot_coverage.x, 
         tot_pop = tot_coverage.y)

hc

#calculate proportion of coverage
#add proportion covered
hc <- hc %>% 
  mutate(prop_coverage = tot_coverage/tot_pop) 

hc

# get spending capita in dollars
hc <- hc %>% 
  mutate(spending_capita = (tot_spending*1e6) / tot_pop)

hc
#save to tidy data folder
save(hc, file = here::here("data", "tidy_data", "case_study_1_tidy.rda"))

