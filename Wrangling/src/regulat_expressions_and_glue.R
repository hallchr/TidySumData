#regular expressions and glue

library(tidyverse)
#install.packages('janitor')
library(janitor)
#install.packages('skimr')
library(skimr)
library(stringr)
#install.packages('htmlwidgets')
library(htmlwidgets)

# install.packages("glue")
library(glue)

#Regular expressions (regexps) are used to describe patterns within strings. They can take a little while to get the hang 
#of but become very helpful once you do. With regexps, instead of specifying that you want to extract the first three 
#letters of a string (as we did above), you could more generally specify that you wanted to extract all strings that 
#start with a specific letter or that contain a specific word somewhere in the string using regexps. We’ll explore the basics of regexps here.

#str_view() - View the first occurrence in a string that matches the regex
#str_view_all() - View all occurrences in a string that match the regex
#str_count() - count the number of times a regex matches within a string
#str_detect() - determine if regex is found within string
#str_subset() - return subset of strings that match the regex
#str_extract() - return portion of each string that matches the regex
#str_replace() - replace portion of string that matches the regex with something else

names <- c("Keisha", "Mohammed", "Jane", "Mathieu")


str_view(names, "^M") ## identify strings that start with "M"


str_view(names, "d$") ## identify strings that end with "d" Remember case sensitivity!

## identify strings that start with "M"
str_count(names, "^M")## return count of the number of times string matches pattern


str_detect(names, "^M") ## identify strings that start with "M" and return TRUE if they do; FALSE otherwise


str_subset(names, "^M") ## identify strings that start with "M" and return whole string

## return "M" from strings that start with "M", otherwise, return NA
str_extract(names, "^M")

str_replace(names, "^M", "?") ## replace capital M with a question mark

str_view_all(names, "[aeiou]") #search for characters, identify all lowercase vowels

str_view_all(names, "[^aeiou]") ## identify anything that's NOT a lowercase vowel

addresses <- c("1234 Main Street", "1600 Pennsylvania Ave", "Brick Building")

str_view_all(addresses, "\\d") ## identify anything that's a digit

str_view_all(addresses, "\\s") ## identify any whitespace

str_view_all(addresses, ".") ## identify any character

#Looking for repetitions of strings

#? : 0 or 1
#+ : 1 or more
#\\* : 0 or more
#{n} : exactly n times
#{n,} : n or more times
#{n,m} : between n and m times

str_view_all(addresses, "n+") ## identify any time n shows up one or more times

str_view_all(addresses, "n{2}") ## identify any time n shows up exactly two times in a row

str_view_all(addresses, "nn+") ## identify any time 'nn' shows up one or more times 

str_view_all(addresses, "n{2,3}") ## identify any time n shows up two or three times 

#####Glue######
#Beyond using stringr to work with strings, there’s an additional helpful package called glue. According to the glue website:
  
  #Glue offers interpreted string literals that are small, fast, and dependency-free. Glue does this by embedding R expressions 
  #in curly braces which are then evaluated and inserted into the argument string.

topic <- 'tidyverse'
glue('My favorite thing to learn about is the {topic}!') # use glue to interpret string literal
## My favorite thing to learn about is the tidyverse!

# add a description column using glue
msleep %>%
  mutate(description = glue("The {name} typically sleeps for {sleep_total * 60} minutes and is awake for {awake * 60} minutes each day.")) %>% 
  select(name, sleep_total, awake, description)

colors <- c('red','orange','yellow','green','blue','violet','#C8C8C8','#000000')






