##working with Strings

library(tidyverse)
#install.packages('janitor')
library(janitor)
#install.packages('skimr')
library(skimr)
library(stringr)

stringA <- "This sentence is a string."

objectA <- c( "This sentence is a string.", "Short String", "Third string" )

#stringr is a core tidyverse package specifically designed to help make your life easier when working with strings.
#Similar to what we saw with forcats functions starting with fct_, all functions within this package start with str_, 
#as you’ll see below.



str_length(objectA) # length of strings

str_c( "Good", "Morning") #combines strings

str_c( "Good", "Morning", sep=" ") #will add space
## [1] "Good Morning"

object <- c( "Good", "Morning") # subsetting strings

str_sub(object, 1, 3)
## [1] "Goo" "Mor"

object <- c( "Good", "Morning") #negative numbers work from end of word

str_sub(object, -3, -1)
## [1] "ood" "ing"

names <- c("Keisha", "Mohammed", "Jane")

str_sort(names) #will sort alphabetially
## [1] "Jane"     "Keisha"   "Mohammed"








