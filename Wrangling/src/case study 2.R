#case study 2: firearms

library(tidyverse)
#install.packages('janitor')
library(janitor)
#install.packages('skimr')
library(skimr)
library(here)
library(readxl)

census

#summarize by ethnicity

census_stats <- census %>%
  filter(ORIGIN == 0, SEX == 0) %>%
  group_by(NAME) %>%
  summarize(white = sum(POPESTIMATE2015[RACE == 1])/sum(POPESTIMATE2015)*100,
            black = sum(POPESTIMATE2015[RACE == 2])/sum(POPESTIMATE2015)*100)
## `summarise()` ungrouping output (override with `.groups` argument)
# add hispanic information
census_stats$hispanic <- census %>%
  filter(SEX == 0) %>% 
  group_by(NAME) %>%
  summarize(x = sum(POPESTIMATE2015[ORIGIN == 2])/sum(POPESTIMATE2015[ORIGIN == 0])*100) %>%
  pull(x)
## `summarise()` ungrouping output (override with `.groups` argument)
# add male information
census_stats$male <- census %>%
  filter(ORIGIN == 0) %>%
  group_by(NAME) %>%
  summarize(x = sum(POPESTIMATE2015[SEX == 1])/sum(POPESTIMATE2015[SEX == 0])*100) %>%
  pull(x)
## `summarise()` ungrouping output (override with `.groups` argument)
# add total population information
census_stats$total_pop <- census %>%
  filter(ORIGIN == 0, SEX == 0 ) %>%
  group_by(NAME) %>%
  summarize(total = sum(POPESTIMATE2015)) %>%
  pull(total)
## `summarise()` ungrouping output (override with `.groups` argument)
# lowercase state name for consistency
census_stats$NAME <- tolower(census_stats$NAME)

census_stats

#same way to look at age

age_stats <- census %>%
  filter(ORIGIN == 0, SEX == 0) %>%
  group_by(NAME, AGE) %>%
  summarize(sum_ages = sum(POPESTIMATE2015))
## `summarise()` regrouping output by 'NAME' (override with `.groups` argument)
age_stats

#put into wide format
age_stats <- age_stats %>%
  pivot_wider(names_from = "NAME",
              values_from = "sum_ages")

age_stats

#median of age
age_stats %>%
  select(-AGE) %>%
  map(cumsum) %>%
  map(function(x) x/x[nrow(age_stats)]) %>%
  glimpse

#using map_fc
# calculate median age for each state
age_stats <- age_stats %>%
  select(-AGE) %>%
  map_df(cumsum) %>%
  map_df(function(x) x/x[nrow(age_stats)]) %>%
  mutate(AGE = age_stats$AGE) %>%
  select(AGE, everything())

glimpse(age_stats)

####Crime####
#Crime data, from the FBI’s Uniform Crime Report, are stored as an Excel file, so we’ll use a similar approach for these data:

crime <- read_excel(here("data", "raw_data", "table_5_crime_in_the_united_states_by_state_2015.xls"), sheet = 1, skip = 3)
crime

crime
colnames(crime)
#select helpful columns
violentcrime <- crime %>% 
  select(c(1,3,5))

violentcrime

#Want to see cases per 100,000 inhabitants!

violentcrime <- violentcrime %>% 
  fill(State) %>%
  filter(.[[2]] == "Rate per 100,000 inhabitants") %>%
  rename( violent_crime = `Violent\ncrime1`) %>%
  select(-`...3`)

violentcrime

# lower case and remove numbers from State column
violentcrime <- violentcrime %>%
  mutate(State = tolower(gsub('[0-9]+', '', State)))

violentcrime

# join with census data
firearms <- left_join(census_stats, violentcrime, 
                      by = c("NAME" = "State"))

firearms

####brady####
brady


