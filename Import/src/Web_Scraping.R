##Web Scraping

#rvest is used to scrape websites of data. Then store the data in a more stable 
  #type like CSV, etc.

## load package
# install.packages("rvest")
library(rvest) # this loads the xml2 package too!

#using selectorgadget will make using rvest much easier! It's a chrome extension.
#https://chrome.google.com/webstore/detail/selectorgadget/mhjhnkcfbdhnjickkkdbjoemdmbfginb

#Example excercise
#Navigate to http://jhudatascience.org/stable_website/webscrape.html
#Use selectorgadget chrome extenstion

packages <- read_html("http://jhudatascience.org/stable_website/webscrape.html") # the function is from xml2

## Get Packages
packages %>% 
  html_nodes("td") %>%
  html_text() 