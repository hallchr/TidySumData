#Exploratory data analysis

library(tidyverse)
#install.packages('janitor')
library(janitor)
#install.packages('skimr')
library(skimr)
#install.packages('here')
library(here)
library(ggplot2)
library(dplyr)

#The goal of an exploratory analysis is to examine, or explore the data and find relationships that weren’t previously known. 

#Understand data properties such as nonlinear relationships, the existence of missing values, the existence of outliers, etc.
#Find patterns in data such as associations, group differences, confounders, etc.
#Suggest modeling strategies such as linear vs. nonlinear models, transformation
#“Debug” analyses
#Communicate results

kraggle <- read.csv(here("Data", "raw_data", "athlete_events.csv"))

skim(kraggle)

ggplot(kraggle, aes(x = Sex, y = Age)) +
  geom_boxplot()

#looking at frequency of males vs females
share <- kraggle %>%
  group_by(Year, Sex) %>%
  summarise(n =n()) %>%
  mutate(freq = n / sum(n)) %>%
  filter(Sex == "F")
share

#are taller athletes more likely to medal?

kraggle < kraggle %>% 
  mutate(has.medal=Medal %in% c("Gold", "Silver", "Bronze"))

table(kraggle$Medal)