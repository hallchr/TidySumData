#Reading CSVs

## install.packages("readr")
library(readr)
library(here)

## read CSV into R
df_csv <- read_csv(here("data", "TMDL_data.csv"))

## look at the object
head(df_csv)

#col_names = FALSE to specify that the first row does NOT contain column names.
#skip = 2 will skip the first 2 rows. You can set the number to any number you want. This is helpful if there is additional information in the first few rows of your data frame that are not actually part of the table.
#n_max = 100 will only read in the first 100 rows. You can set the number to any number you want. This is helpful if you’re not sure how big a file is and just want to see part of it.
#By default, read_csv() converts blank cells to missing data (NA).

#TSV files
#Similar to CSVs but use tabs to seperate
#Just a sample, wont run
## read TSV into R
df_tsv <- read_tsv("sample_data - Sheet1.tsv")

## look at the object
head(df_tsv)
