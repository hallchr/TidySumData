##Relational databases / SQL

## install and load packages
## this may take a minute or two
# install.packages("RSQLite")
library(RSQLite)
library(here)

## Specify driver
sqlite <- dbDriver("SQLite")

## Connect to Database
db <- dbConnect(sqlite, here("data","company.db"))

## List tables in database
dbListTables(db)
##  [1] "albums"          "artists"         "customers"       "employees"      
##  [5] "genres"          "invoice_items"   "invoices"        "media_types"    
##  [9] "playlist_track"  "playlists"       "sqlite_sequence" "sqlite_stat1"   
## [13] "tracks"

## install and load packages
# install.packages("dbplyr")
library(dbplyr)
library(dplyr)

## get two tables
albums <- tbl(db, "albums")
artists <- tbl(db, "artists")

print(albums)

##How to connect to a database

## This code is an example only
con <- DBI::dbConnect(RMySQL::MySQL(), 
                      host = "database.host.com",
                      user = "janeeverydaydoe",
                      password = rstudioapi::askForPassword("database_password")
)
