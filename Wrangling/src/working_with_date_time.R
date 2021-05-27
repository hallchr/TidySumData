library(tidyverse)
#install.packages('janitor')
library(janitor)
#install.packages('skimr')
library(skimr)
#install.packages('lubridate')
library(lubridate)

#Working with dates and times!

#The lubridate package is not part of the core tidyverse packages, so it will have to be loaded individually. 
#This package will make working with dates and times easier. 

#date from string
#Date information is often provided as a string. The functions within the lubridate package can effectively handle this information. 
# year-month-date
ymd("1988-09-29")

#month-day-year
mdy("September 29th, 1988")

#day-month-year
dmy("29-Sep-1988")

#date-time
ymd_hms("1988-09-29 20:11:59")

#From individual parts
#f you have a dataset where month, date, year, and/or time information are included in separate columns, the functions
#within lubridate can take this separate information and create a date or date-time object.

#install.packages('nycflights13')
library(nycflights13)

## make_date() creates a date object 
## from information in separate columns
flights %>% 
  select(year, month, day) %>% 
  mutate(departure = make_date(year, month, day))

# make_datetime() creates a date-time object 
## from information in separate columns
flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))

#Often you’re most interested in grouping your data by year, or just looking at monthly or weekly trends. To accomplish this, you have to be able to extract just a component of your date object. 
#You can do this with the functions: year(), month(), mday(),wday(), hour(), minute() and second(). Each will extract the specified piece of information from the date or date-time object.

mydate <- ymd("1988-09-29")

## extract year information
year(mydate)

## extract day of the month
mday(mydate)

## extract weekday information
wday(mydate)

## label with actual day of the week
wday(mydate, label = TRUE)

#Time-Spans
## how old is someone born on Sept 29, 1988
mydate <- ymd("1988-09-29")

## subtract birthday from todays date
age <- today() - mydate
''
age

## a duration object can get this information in years
as.duration(age)
## [1] "1013126400s (~32.1 years)"

