#Functional programming

#Functional programming is an approach to programming in which the code evaluated is treated as a mathematical function. It is
#declarative, so expressions (or declarations) are used instead of statements. Functional programming is often touted and used 
#due to the fact that cleaner, shorter code can be written.

#Using the purr package!!!


library(tidyverse)
library(purrr)

#map() - returns a list
#map_lgl() - returns a logical vector
#map_int() - returns an integer vector
#map_dbl() - returns a double vector
#map_chr() - returns a character vector

#say you want to calculate median in trees data set. Base R allows you to loop, but it's very tedious.

trees <- as_tibble(trees)
trees


# create output vector
output <- vector("double", ncol(trees)) 
                                                    #Example of for loop....least desired
# loop through columns
for (i in seq_along(trees)) {          
  output[[i]] <- median(trees[[i]])      
}
output

# In a loop the tibble columns are selected. With a function, you can apply to any dataframe. Still not as good as purr!

# create function
col_median <- function(df) {
  output <- vector("double", length(df))
  for (i in seq_along(df)) {  
    output[i] <- median(df[[i]])
  }
  output
}                                                   #Example of function method......less desired
                  
# execute function
col_median(trees)

#instead, let's use the purr package!!!!            #Most desired

#Using purrr requires you to determine how to carry out your operation of interest for a single occurrence (i.e. calculate the median 
#for a single column in your data frame). Then purrr takes care of carrying out that operation across your data frame. Further,
#once you break your problem down into smaller building blocks, purrr also helps you combine those smaller pieces into a functional program.

# use purrr to calculate median
map_dbl(trees, median)

# use purrr to calculate mean
map_dbl(trees, mean)

# use purrr to calculate mean, specifying to remove NAs
map_dbl(trees, mean, na.rm = TRUE)

# use map_dfr to calculate mean and create a dataframe
map_dfr(trees, mean, na.rm = TRUE)

####mULTIPLE vECTORS#####

#So far, we’ve only looked at iterating over a single vector at a time; however in analysis, you’ll often find that you 
#need to iterate over more than one vector at a time.

#map2() allows you to iterate over two vectors at the same time. 

#Want to caluclate volume of tree by heigh (ft) and girth(in)? Use map2() becuase of multiple vectors.

# generate volume function
volume <- function(diameter, height){
  # convert diameter in inches to raidus in feet
  radius_ft <- (diameter/2)/12
  # calculate volume
  output <- pi * radius_ft^2 * height
  return(output)
}

map2_dbl(trees$Girth, trees$Height, volume)

# calculate volume
trees %>%
  mutate(volume_cylinder = map2_dbl(trees$Girth, trees$Height, volume),
         volume_diff = Volume - volume_cylinder)

#  pmap() - which stands for parallel map - function. The pmap() function takes a list of arguments over which you’d like to iterate:
#Takes more than 2 vectors

####Anonymous Functions####

#This is a function that is not given a name but that is utilized within our map call. We are not able to refer back to 
#this function later, but we are able to use it within our map call:

map2_dbl(trees$Girth, trees$Height, function(x,y){ pi * ((x/2)/12)^2 * y})

map2_dbl(trees$Girth, trees$Height, ~ pi * ((.x/2)/12)^2 * .y)






