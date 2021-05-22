#Google Sheets Scripts

#install.packages("googlesheets4")
# load package
library(googlesheets4)

#The command gs4_auth() will open a new page in your browser that asks you which Google account you’d 
#like to have access to. Click on the appropriate Google user to provide googlesheets4 access to the 
#Google Sheets API.

gs4_auth()

#In order to ultimately access the information a specific Google Sheet, you can use  the read_sheets() function 
#by typing in the id listed for your Google Sheet of interest when using gs4_find().


# read Google Sheet into R with id
juggernaut_example <- read_sheet("https://docs.google.com/spreadsheets/d/1rZygJSAvsiy4BxViJFQ0uhKCyaZfxM9lIYH0ybmwRxs/edit#gid=0")
# note this is a fake id


# read Google Sheet into R with URL
survey_sheet <- read_sheet("https://docs.google.com/spreadsheets/d/1FN7VVKzJJyifZFY5POdz_LalGTBYaC4SLB-X9vyDnbY/")

#specify sheet
# read Google Sheet into R wih URL
survey_sheet <- read_sheet("https://docs.google.com/spreadsheets/d/1FN7VVKzJJyifZFY5POdz_LalGTBYaC4SLB-X9vyDnbY/", sheet = 2)

#skip = 1 : will skip the first row of the Google Sheet
#col_names = FALSE : specifies that the first row is not column names
#range = "A1:G5" : specifies the range of cells that we like to import is A1 to G5
#n_max = 100 : specifies the maximum number of rows that we want to import is 100
#To read in data from a Google Sheet in googlesheets4, you must first know the id, the name or the URL of the Google Sheet and have access to it. 