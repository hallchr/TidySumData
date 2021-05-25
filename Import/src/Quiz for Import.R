#Lab exercise

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


#1 For this question you will need to read the `excel_data.xlsx` file into R using the readxl package. There are two sheets in this spreadsheet file named "Sheet1" and "Sheet2". 
#Use the readxl package to read in "Sheet2" from the spreadsheet file directly and answer the question below. Recall that the [[ operator can be used to subset a column of tibble or data frame.

#What is the mean of the column labeled "X12" in "Sheet2"? You can use the mean() function to compute the mean of a column. (Choose the closest answer.)



#2 Continuing from Question 1 above, use the readxl package to read in both "Sheet1" and "Sheet2" from the excel_data.xlsx file. 

#What is the correlation between column "X5" in "Sheet1" and column "X8" in "Sheet2"? 
#Use the cor() function to compute the correlation between two columns. (Choose the closest answer.)



#xlsx
xlsx_data <- read_excel(here("data", "raw_data", "excel_data.xlsx"), sheet = 2)
xlsx_data2 <- read_excel(here("data", "raw_data", "excel_data.xlsx"), sheet = 1)
xlsx_bind <- rbind(xlsx_data, xlsx_data2)

cor(xlsx_data2[["X5"]], xlsx_data[["X8"]])


mean(xlsx_data$X12)
mean(xlsx_data[["X12"]])

#For this question you will need to read in the database file sqlite_data.db using the RSQLite package. In this database file there is table named "table1". You will need to read that table to answer this question.

# The "ID" column in "table1" serves as and identification number for elements in the database table. What is the correlation between columns "S2" and "S3" for rows with ID equal to 8 only? (Hint: There should be 100 rows where ID = 8.)

#SQL
sqlite <- dbDriver("SQLite")

## Connect to Database
db <- dbConnect(sqlite, here("data", "raw_data", "sqlite_data.db"))

table1 <- tbl(db, "table1")
table1

#filter/subsetting
table1tibble <- as_tibble(table1)
ID8 <- filter(table1tibble, ID == 8)
cor(ID8[["S2"]], ID8[["S3"]])

#Question 4For this question you need to read in "Sheet2" from the excel_data.xlsx file using the readxl
#package and the data from the table2.json file using the jsonlite package. Then you need to inner join the 
#two tables by their corresponding ID columns to create a new data frame.

json_data <- read_json(here("data", "raw_data", "table2.json"), simplifyVector = TRUE)

json_xlsx_Join <- inner_join(json_data, xlsx_data, by = "ID")

mean(json_xlsx_Join[["J2"]])

#5 Continuing from Question 4 above, what is the correlation between column "X2" and column "J4" in the joined data frame?
cor(json_xlsx_Join[["X2"]], json_xlsx_Join[["J4"]])

