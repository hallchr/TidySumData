library(tidyverse)
#install.packages('janitor')
library(janitor)
#install.packages('skimr')
library(skimr)

#Working with Factors
#In R, categorical data are handled as factors. By definition, categorical data are limited in that 
#they have a set number of possible values they can take.
#To make working with factors simpler, we’ll utilize the forcats package, a core tidyverse package.

####Forcats###

## all 12 months
all_months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

## our data
some_months <- c("Mar", "Dec", "Jan",  "Apr", "Jul")

# alphabetical sort
sort(some_months)
## [1] "Apr" "Dec" "Jan" "Jul" "Mar"

# create factor
mon <- factor(some_months, levels = all_months)

# look at factor
mon

sort(mon)

#What if you wanted your months to start with July first? That can be accomplished using fct_relevel().
mon_relevel <- fct_relevel(mon, "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", after = 0)

# releveled
mon_relevel

sort(mon_relevel)

# keep order of appearance
mon_inorder <- fct_inorder(some_months)

# output
mon_inorder

sort(mon_inorder)

# chickwt : This dataset includes data from an experiment that was looking to compare the “effectiveness of various feed supplements on the growth rate of chickens.

## take a look at frequency of each level 
## using tabyl() from `janitor` package
tabyl(chickwts$feed)

## order levels by frequency 
fct_infreq(chickwts$feed) %>% head()

## reverse factor level order
fct_rev(fct_infreq(chickwts$feed)) %>% head()

## order levels by a second numeric variable 
chickwts %>%
  mutate(newfeed = fct_reorder(feed, weight)) %>% 
  ggplot(., aes(newfeed,weight)) +
  geom_point()

## we can use mutate to create a new column
## and fct_recode() to:
## 1. group horsebean and soybean into a single level
## 2. rename all the other levels.
chickwts %>%
  mutate(feed_recode = fct_recode(feed,
                                  "seed"    =   "linseed",
                                  "bean"    =   "horsebean",
                                  "bean"    =   "soybean",
                                  "meal"    =   "meatmeal",
                                  "seed"    =   "sunflower",
                                  "casein"  =   "casein"
  )) %>%
  tabyl(feed_recode)

#Converting Numeric Levels to factors: ifelse() + factor()
#Finally, when working with factors, there are times when you want to convert a numeric variable into a factor.


#Within a single statement we provide R with a condition: weight <= 200. With this, we are stating that the condition is if a chicken’s weight
#is less than or equal to 200 grams. Then, if that condition is true, meaning if a chicken’s weight is less than or equal to 200 grams, let’s 
#assign that chicken to the category low. Otherwise, and this is the else{} part of the ifelse() function, assign that chicken to the category high. 
#Finally, we have to let R know that weight_recode is a factor variable, so we call factor() on this new column. This way we take a numeric variable 
#(weight), and turn it into a factor variable (weight_recode).

## convert numeric variable to factor
chickwts %>%
  mutate(weight_recode = ifelse(weight <= 200, "low", "high"), #means if less than 200 = "low", and if else then "high"
         weight_recode = factor(weight_recode)) %>%
  tabyl(weight_recode)
