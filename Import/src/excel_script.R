#importing and working with Excel
getwd()

install.packages("readxl")
library(readxl)
library(here)

example <- readxl_example("datasets.xlsx") #example dataset in R
df <- read_excel(example)
df

#can use here package to locate data in different folders without an absolute path
LS_1 <-read_excel(here("data", "TMDL_Stream_2010-2020.xlsx"), sheet = "LS_1")
SARU <-read_excel(here("data", "TMDL_Stream_2010-2020.xlsx"), sheet = "SARU")
JO_1 <- read_excel(here("data", "TMDL_Stream_2010-2020.xlsx"), sheet = "JO_1")
PM_1 <-read_excel(here("data", "TMDL_Stream_2010-2020.xlsx"), sheet = "PM_1")
NCLD <-read_excel(here("data", "TMDL_Stream_2010-2020.xlsx"), sheet = "NCLD")

df2 <- rbind(LS_1, SARU, JO_1, PM_1, NCLD) # create a union between the sheets
df2

#sheet - argument specifies the name of the sheet from the workbook you’d like to read in (string) 
#or the integer of the sheet from the workbook.
#col_names - specifies whether the first row of the spreadsheet should be used as column names (default: TRUE). 
#Additionally, if a character vector is passed, this will rename the columns explicitly at time of import.
#skip - specifies the number of rows to skip before reading information from the file into R. 
#Often blank rows or information about the data are stored at the top of the spreadsheet that you want R to ignore.

# read example file into R using .name_repair default
read_excel(
  readxl_example("deaths.xlsx"),
  range = "arts!A5:F8",
  .name_repair = "unique"
)