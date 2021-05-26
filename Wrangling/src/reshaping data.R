library(tidyverse)

#Converting your data from wide-to-long or from long-to-wide data formats is referred to as reshaping your data.

# Within the tidyverse, tidyr is the go-to package for accomplishing this task.

#The two most pertinent to reshaping data are: pivot_wider() and pivot_longer().

airquality <- as_tibble(airquality)
airquality

# use pivot_longer() to reshape from wide to long
gathered <- airquality %>%
  pivot_longer(everything())

## take a look at first few rows of long data
gathered

## to rename the column names that gather provides,
## change key and value to what you want those column names to be
gathered <- airquality %>%
  pivot_longer(everything(), names_to = "variable", values_to = "value")

## take a look at first few rows of long data
gathered 

## in pivot_longer(), you can specify which variables 
## you want included in the long format
## it will leave the other variables as is
gathered <- airquality %>%
  pivot_longer(c(Ozone, Solar.R, Wind, Temp), 
               names_to = "variable", 
               values_to = "value")

## take a look at first few rows of long data
gathered

## use pivot_wider() to reshape from long to wide
spread_data <- gathered %>%
  pivot_wider(names_from = "variable", 
              values_from = "value")

## take a look at the wide data
spread_data