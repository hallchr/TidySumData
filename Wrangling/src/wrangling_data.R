library(tidyverse)
#install.packages('janitor')
library(janitor)
#install.packages('skimr')
library(skimr)
#There is a package specifically designed for helping you wrangle your data. 
#This package is called dplyr and will allow you to easily accomplish many of the data wrangling tasks necessary. 
#Like tidyr, this package is a core package within the tidyverse, and thus it was loaded in for you when you ran library(tidyverse) earlier. 
#We will cover a number of functions that will help you wrangle data using dplyr:

# %>% - pipe operator for chaining a sequence of operations
# glimpse() - get an overview of what’s included in dataset
# filter() - filter rows
# select() - select, rename, and reorder columns
# rename() - rename columns
# arrange() - reorder rows
# mutate() - create a new column
# group_by() - group variables
# summarize() - summarize information within a dataset
# left_join() - combine data across data frame
# tally() - get overall sum of values of specified column(s) or the number of rows of tibble
# count() - get counts of unique values of specified column(s) (shortcut of group_by() and tally())
# add_count() - add values of count() as a new column
# add_tally() - add value(s) of tally() as a new column

#tidyr: unite() - combine contents of two or more columns into a single column
#       separate() - separate contents of a column into two or more columns

#Janitor: this tidyverse-adjacent package provides tools for cleaning messy data
#         clean_names() - clean names of a data frame
#         tabyl() - get a helpful summary of a variable
#         get_dupes() - identify duplicate observations

#Skimr: This package provides a quick way to summarize a data.frame or tibble within the tidy data framework.


library(ggplot2)
glimpse(msleep) #msleep gives sleep times and weights of different animals

#######Filter###########
# filter to only include primates
msleep %>%
  filter(order == "Primates")

# same as filter(msleep, order == "Primates")

msleep %>%
  filter(order == "Primates", sleep_total > 10) 
#can also use: 
msleep %>%
filter(order == "Primates" & sleep_total > 10)

########Select########
# To select columns so that your dataset only includes variables you’re interested in, you will use select().
msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  select(name, sleep_total, sleep_rem, sleep_cycle)
#rename selected columns
msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  select(name, total = sleep_total, rem = sleep_rem, cycle = sleep_cycle)
#rename some columns but return all columns in table
msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  rename(total = sleep_total, rem = sleep_rem, cycle = sleep_cycle)

