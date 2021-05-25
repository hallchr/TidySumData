#Firearms example
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

census <- read_csv('https://raw.githubusercontent.com/opencasestudies/ocs-police-shootings-firearm-legislation/master/data/sc-est2017-alldata6.csv',
                   n_max = 236900)
census

#The Counted project started to count persons killed by police in the US
counted15 <- read_csv("https://raw.githubusercontent.com/opencasestudies/ocs-police-shootings-firearm-legislation/master/data/the-counted-2015.csv")

# read in suicide data
suicide_all <- read_csv("https://raw.githubusercontent.com/opencasestudies/ocs-police-shootings-firearm-legislation/master/data/suicide_all.csv")
suicide_all

# read in firearm suicide data
suicide_firearm <- read_csv("https://raw.githubusercontent.com/opencasestudies/ocs-police-shootings-firearm-legislation/master/data/suicide_firearm.csv")
suicide_firearm

#read Brady data in.For the Brady Scores data, quantifying numerical scores for firearm legislation in each state,
#we’ll need the httr package, as these data are stored in an Excel spreadsheet
library(readxl)
library(httr)

# specify URL to file
url = "https://github.com/opencasestudies/ocs-police-shootings-firearm-legislation/blob/master/data/Brady-State-Scorecard-2015.xlsx?raw=true"

# Use httr's GET() and read_excel() to read in file
GET(url, write_disk(tf <- tempfile(fileext = ".xlsx")))

brady <- read_excel(tf, sheet = 1)

brady

#Crime data, from the FBI’s Uniform Crime Report, are stored as an Excel file, so we’ll use a similar approach for these data:

# specify URL to file
url = "https://github.com/opencasestudies/ocs-police-shootings-firearm-legislation/blob/master/data/table_5_crime_in_the_united_states_by_state_2015.xls?raw=true"

# Use httr's GET() and read_excel() to read in file
GET(url, write_disk(tf <- tempfile(fileext = ".xls")))

crime <- read_excel(tf, sheet = 1, skip = 3)
crime

#US Census 2010 land area data are also stored in an excel spreadsheet. So again we will use a similar method.
# specify URL to file
url = "https://github.com/opencasestudies/ocs-police-shootings-firearm-legislation/blob/master/data/LND01.xls?raw=true"

# Use httr's GET() and read_excel() to read in file
GET(url, write_disk(tf <- tempfile(fileext = ".xls")))

land <- read_excel(tf, sheet = 1)
land

#This data was available online from the Bureau of Labor Statistics (BLS), now it is available on the archive, 
#but there is no easy download of the table. 

library(rvest)

# specify URL to where we'll be web scraping
url <- read_html("https://web.archive.org/web/20210205040250/https://www.bls.gov/lau/lastrk15.htm")

# scrape specific table desired
out <- html_nodes(url, "table") %>%
  .[2] %>%
  html_table(fill = TRUE) 

# store as a tibble
unemployment <- as_tibble(out[[1]]) 

unemployment

out2 <- read_html("https://web.archive.org/web/20210205040250/https://www.bls.gov/lau/lastrk15.htm")

## Get Packages
out2 %>% 
  html_nodes("th") %>%
  html_text() 

library(here)
save(census, counted15, suicide_all, suicide_firearm, brady, crime, land, unemployment , file = here::here("data", "raw_data", "case_study_2.rda"))
#all of these objects (census, counted15 etc) will get saved as case_study_2.rda within the raw_data directory which is a subdirectory of data 
#the here package identifies where the project directory is located based on the .Rproj, and thus the path to this directory is not needed

