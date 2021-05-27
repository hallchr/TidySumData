library(tidyverse)
#install.packages('janitor')
library(janitor)
#install.packages('skimr')
library(skimr)

####Mutate#####
#creating new columns
#The function mutate() was made for all of these new-column-creating situations. This function has a lot of capabilities. 
msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  select(name, sleep_rem, sleep_cycle, sleep_total) %>%
  arrange(name) %>%
  mutate(sleep_total_min = sleep_total * 60) #creating a new column for sleep total in minutes

#conservation abbreviations dataset
## download file 
conservation <- read_csv("https://raw.githubusercontent.com/suzanbaert/Dplyr_Tutorials/master/conservation_explanation.csv")

## take a look at this file
conservation

#####Seperate####
#The separate() function requires the name of the existing column that you want to separate (conservation abbreviation), 
#the desired column names of the resulting separated columns (into = c("abbreviation", "description")), and the characters 
#that currently separate the pieces of information (sep = " = "). We have to put conservation abbreviation in back ticks in 
#the code below because the column name contains a space. Without the back ticks, R would think that conservation and abbreviation 
#were two separate things. This is another violation of tidy data! Variable names should have underscores, not spaces!

conservation %>%
  separate(`conservation abbreviation`, 
           into = c("abbreviation", "description"), sep = " = ") # separates the 2 columns by a separator

####Unite####
#So, if you have information in two or more different columns but wish it were in one single column, you’ll want to use unite().
conservation %>%
  separate(`conservation abbreviation`, 
           into = c("abbreviation", "description"), sep = " = ") %>%
  unite(united_col, abbreviation, description, sep = " = ") #unites what we seperated in the earlier line

#####clean_names()####
#cleans up column names to make sure it's tidy.
conservation %>%
  clean_names() #added underscore for column name

####left_join()#####
#joins two data sets with a primary key. Left join will retain all info of left data set.
#We’ll then use left_join() which takes all of the rows in the first dataset mentioned (msleep, below) and incorporates
#information from the second dataset mentioned (conserve, below), when information in the second dataset is available
#. The by = argument states what columns to join by in the first (“conservation”) and second (“abbreviation”) datasets. 
## take conservation dataset and separate information
## into two columns
## call that new object `conserve`
conserve <- conservation %>%
  separate(`conservation abbreviation`, 
           into = c("abbreviation", "description"), sep = " = ")


## now lets join the two datasets together
msleep %>%
  mutate(conservation = toupper(conservation)) %>% #mutate() to take all the lowercase abbreviations to uppercase abbreviations using the function toupper().
  left_join(conserve, by = c("conservation" = "abbreviation"))

####group_by()####
#The group_by() function groups a dataset by one or more variables. On its own, it does not appear to change the dataset very much. The difference between the two outputs below is subtle:
msleep

msleep %>%
  group_by(order)

####summarize####
#if you wanted to figure out how many samples are present in your dataset, you could use the summarize() function.
msleep %>%
  # here we select the column called genus, any column would work
  select(genus) %>%
  summarize(N=n())

msleep %>%
  # here we select the column called vore, any column would work
  select(vore) %>%
  summarize(N=n())
#if you wanted to count how many of each different order of mammal you had. 
#You would first group_by(order) and then use summarize().
msleep %>%
  group_by(order) %>%
  summarize(N=n())

#There are other ways in which the data can be summarized using summarize(). In addition to using n() to count the
#number of samples within a group, you can also summarize using other helpful functions within R, such as 
#mean(), median(), min(), and max().

msleep %>%
  group_by(order) %>% 
  select(order, sleep_total) %>%
  summarize(N=n(), mean_sleep=mean(sleep_total))

#the tabyl() function from the janitor package can be incredibly helpful for summarizing categorical variables quickly and discerning the output at a glance.
msleep %>%
  tabyl(order)

#summarize numeric values
summary(msleep$awake)

#tally function to get the total number of samples in a tibble or the total number of rows very simply.
msleep %>%
  tally()

msleep %>%
  tally(sleep_total) #will also give sum of a column if numeric

#same as...
msleep %>%
  summarize(sum_sleep_total = sum(sleep_total))

#We can quickly add our tally values to our tibble using add_tally().
msleep %>%
  add_tally() %>%
  glimpse()

msleep %>%
  add_tally(sleep_total) %>%
  glimpse()

####Count####
#The count() function takes the tally() function a step further to determine the count of unique values for specified variable(s)/column(s).
msleep %>%
  count(vore)

msleep %>%
  count(vore, order) #counts by multiple variables
#add_count will add a new column
msleep %>%
  add_count(vore, order) %>%
  glimpse()

###get_dupes()###
#Another common issue in data wrangling is the presence of duplicate entries.
msleep %>% 
  get_dupes(genus, vore)

####skim()####
#When you would rather get a snapshot of the entire dataset, rather than just one variable, 
#the skim() function from the skimr package can be very helpful.

# summarize dataset
skim(msleep)

# see summary for specified columns
skim(msleep, genus, vore, sleep_total)

#can also group_by before skimming
msleep %>% 
  group_by(vore) %>% 
  skim(genus, sleep_total)

skim(msleep) %>% #gives a summary of data at large
  summary()

#Operations accross columns
####across()####
#The across() function is needed to operate across the columns of a data frame. For example, in our airquality 
#dataset, if we wanted to compute the mean of Ozone, Solar.R, Wind, and Temp, we could do:

airquality %>%
  summarize(across(Ozone:Temp, mean, na.rm = TRUE))
#The across() function can be used in conjunction with the mutate() and filter() functions to construct joint operations across different columns of a data frame. 
airquality %>%
  filter(!is.na(Ozone),
         !is.na(Solar.R))
#With the across() function, we can specify columns in the same way that we use the select() function. This allows us to use 
#short-hand notation to select a large set of columns.
airquality %>%
  filter(across(Ozone:Solar.R, ~ !is.na(.)))
#If we wanted to filter the data frame to remove rows with missing values in Ozone, Solar.R, Wind, and Temp, we only need to make a small change
airquality %>%
  filter(across(Ozone:Temp, ~ !is.na(.)))
#The across() function can also be used with mutate() if we want to apply the same transformation to multiple columns.
airquality %>%
  mutate(across(Ozone:Temp, ~ replace_na(., 0))) #will replace all NAs with 0 accross the columns Ozone-Temp

