#forerign formats, google drive, and images
#files used in SAS, SPSS, etc can be read into R using haven

#install.packages("haven")
library(haven)

## SAS
write_sas(data = JSONdf, path = here::here("data", "JSONdf.sas7bdat"))
# read_sas() reads .sas7bdat and .sas7bcat files 
sas_mydf <-read_sas(here::here("data", "JSONdf.sas7bdat")) 
sas_mydf

# use read_xpt() to read SAS transport files (version 5 and 8)

## SPSS
write_sav(data = JSONdf, path = here::here("data", "JSONdf.sav"))
# use to read_sav() to read .sav files
sav_mydf <-read_sav(here::here("data", "JSONdf.sav"))
sav_mydf

## Stata
write_dta(data = JSONdf, path = here::here("data", "JSONdf.dta"))
# use to read_dta() to read .dta files 
dta_mydf <-read_dta(here::here("data", "JSONdf.dta"))
dta_mydf