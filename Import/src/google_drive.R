#google drive!!

#Another really helpful package is the googledrive package which enables users to interact with their Google Drive directly from R. 

#This package, unlike the googlesheets4 package, allows for users to interact with other file types besides Google Sheets.
#It however does not allow for as many modifications of these files like the googlesheets4 package allows for Google Sheets files.

# install.packages("googledrive")
# load package
library("googledrive")
# Files can be found based on file name words like this:
drive_find(pattern ="tidyverse")
# Files can be found based on file type like this:
drive_find(type ="googlesheets")
# Files that have specific types of visibility can be found like this:
files <- drive_find(q = c("visibility = 'anyoneWithLink'"))

#Files can be viewed from your default browser by using the drive_browse() function:
drive_browse("tidyverse")

#Files can be uploaded to your Google Drive using the drive_upload() function.
drive_upload(here::here("tidyverse.txt"))

#uploading into data files in R
drive_upload(here::here("tidyverse.txt"), type = "document")
drive_upload(here::here("tidyverse.csv"), type = "spreadsheet")
drive_upload(here::here("tidyverse.pptx"), type = "presentation")

#Downloading
drive_download("tidyverse", type = "csv")
tidyverse_data <-readr::read_csv(here("tidyverse.csv"))

#Files can be moved to trash using the drive_trash() function. This can be undone using the drive_untrash() function. 
#The trash can also be emptied using drive_empty_trash().
drive_trash("tidyverse.txt")
drive_untrash("tidyverse.txt")
drive_empty_trash()

#To permanently remove a file you can use the drive_rm() function. This does not keep the file in trash.
drive_rm("tidyverse.txt")

#Files can be shared using the drive_share() function. The sharing status of a file can be checked using drive_reveal().
drive_share(file = "tidyverse", 
            role = "commenter", 
            type = "user", 
            emailAddress = "someone@example.com",
            emailMessage = "Would greatly appreciate your feedback.")

drove_share_anyone(file = "tidyverse", verbose = TRUE) # anyone with link can read

drive_reveal(file = "tidyverse", what = "permissions")

