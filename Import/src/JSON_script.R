#JSON files (javascript Object Notation)

## generate a JSON object
json <-
  '[
  {"Name" : "Woody", "Age" : 40, "Occupation" : "Sherriff"}, 
  {"Name" : "Buzz Lightyear", "Age" : 34, "Occupation" : "Space Ranger"},
  {"Name" : "Andy", "Occupation" : "Toy Owner"}
]'

## take a look
json
## [1] "[\n  {\"Name\" : \"Woody\", \"Age\" : 40, \"Occupation\" : \"Sherriff\"}, \n  {\"Name\" : \"Buzz Lightyear\", \"Age\" : 34, \"Occupation\" : \"Space Ranger\"},\n  {\"Name\" : \"Andy\", \"Occupation\" : \"Toy Owner\"}\n]"

#install.packages("jsonlite")
library(jsonlite)
## Warning: package 'jsonlite' was built under R version 4.0.2


## take JSON object and covert to a data frame
JSONdf <- fromJSON(json)

## take a look
JSONdf

## take JSON object and convert to a data frame
json <- toJSON(JSONdf)
json
## [{"Name":"Woody","Age":40,"Occupation":"Sherriff"},{"Name":"Buzz Lightyear","Age":34,"Occupation":"Space Ranger"},{"Name":"Andy","Occupation":"Toy Owner"}]

# read JSON file into R
read_json("json_file.json")

# read JSON file into R and ***********
# simplifies nested lists into vectors and data frames
read_json("json_file.json", simplifyVector = TRUE)
