#Health Expenditures

library(httr)
library(dplyr)
library(dbplyr)
library(tidyverse)
library(haven)
library(magick)
library(tesseract)
library("googledrive")
library(readr)
library(here)
library(readxl)
library(googlesheets4)
library(jsonlite)
library(RSQLite)
library(ProjectTemplate)
library(rvest)

#load data from github
health_CSV <- read_lines(file = 'https://raw.githubusercontent.com/opencasestudies/ocs-healthexpenditure/master/data/KFF/healthcare-coverage.csv', n_max = 10)

#skip first 2 lines
coverage <- read_csv('https://raw.githubusercontent.com/opencasestudies/ocs-healthexpenditure/master/data/KFF/healthcare-coverage.csv', 
                     skip = 2)

## read coverage data into R and remove notes section from data!
coverage <- read_csv('https://raw.githubusercontent.com/opencasestudies/ocs-healthexpenditure/master/data/KFF/healthcare-coverage.csv', 
                     skip = 2,
                     n_max  = which(coverage$Location == "Notes")-1)

tail(coverage)

#get an idea of what's included
glimpse(coverage)

####Spending excercise
spending <- read_csv('https://raw.githubusercontent.com/opencasestudies/ocs-healthexpenditure/master/data/KFF/healthcare-spending.csv', 
                     skip = 2)

#got some parsing errors...
spending <- read_csv('https://raw.githubusercontent.com/opencasestudies/ocs-healthexpenditure/master/data/KFF/healthcare-spending.csv', 
                     skip = 2, 
                     n_max  = which(spending$Location == "Notes")-1)
tail(spending)

library(here)
## here() starts at /Users/carriewright/Documents/GitHub/tidyversecourse
save(coverage, spending, file = here::here("data", "raw_data", "case_study_1.rda"))
#the coverage object and the spending object will get saved as case_study_1.rda within the raw_data directory which is a subdirectory of data 
#the here package identifies where the project directory is located based on the .Rproj, and thus the path to this directory is not needed
