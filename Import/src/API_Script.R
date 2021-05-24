##APIs

#httr package used for APIs
#get() function will be used to "get" data from API

##Example 1 : get repos from my own github

# load package
library(httr)
library(dplyr)
library(tidyverse)
## Save GitHub username as variable
username <- 'hallchr'

## Save base endpoint as variable
url_git <- 'https://api.github.com/'

## Construct API request
api_response <- GET(url = paste0(url_git, 'users/', username, '/repos'))
names(api_response)

## Check Status Code of request
api_response$status_code

## Extract content from API response
repo_content <- content(api_response)

## function to get name and URL for each repo
lapply(repo_content, function(x) {
  df <- tibble(repo = x$name,
                   address = x$html_url)}) %>% 
  bind_rows()

##EXAMPLE 2

## Make API request
api_response <- GET(url = "https://raw.githubusercontent.com/fivethirtyeight/data/master/steak-survey/steak-risk-survey.csv")

## Extract content from API response
df_steak <- content(api_response, type="text/csv")

#use readr to read in CSV from a URL
readCSVdf <- read_csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/steak-survey/steak-risk-survey.csv")

#Not all APIs are open and sometimes require a key!!!
#In these cases, what is known as a key is required to gain access to the API. API keys are obtained from 
#the website’s API site (ie, for Google’s APIs, you would start here). Once acquired, these keys should never 
#be shared on the Internet. There is a reason they’re required, after all. So, be sure to never push a key to 
#GitHub or share it publicly. (If you do ever accidentally share a key on the Internet, return to the API and disable the key immediately.)

#For example, to access the Twitter API, you would obtain your key and necessary tokens from Twitter’s API (https://developer.twitter.com/en/docs/twitter-api/v1/tweets/search/overview) and 
#replace the text in the key, secret, token, and token_secret arguments below. This would authenticate you 
#to use Twitter’s API to acquire information about your home timeline.

myapp = oauth_app("twitter",
                  key = "yourConsumerKeyHere",
                  secret = "yourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
