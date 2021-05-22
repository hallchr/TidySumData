library(tidyverse)
library(here)
library(ProjectTemplate)

getwd()
create.project(project.name = "tibble", template = "minimal") #creates project template folder structure


tree_tibble <- as_tibble(trees) #converts data.frame to tibble
view(tree_tibble)
print(tree_tibble)
slice_sample(tree_tibble, n = 5) #part of dplyer package - gives random slice of data
slice_head(tree_tibble, n = 5) # first 5
slice_tail(tree_tibble, n = 5) # last 5

#Can also create a tibble on the fly rather easily. If you input only one value it will
#be "recycled"
example_tibble <- tibble(
  a = 1:5,
  b = 6:10,
  c = 1,
  z = (a + b)^2 + c
)

print(example_tibble)

#You can creat nontraditional names in tibble as well using backticks
non_trad_tibble <- tibble(
  `two words` = 1:5,
  `12` = "numeric",
  `:)` = "smile",
)

view(non_trad_tibble)

#Subsetting tibbles also differs slightly from how subsetting occurs with data.frame. 
#When it comes to tibbles,  [[ can subset by name or position; $ only subsets by name. For example:

# Extract by name using $ or [[]]
example_tibble$z
## [1]  50  82 122 170 226
example_tibble[["z"]]
## [1]  50  82 122 170 226
# Extract by position requires [[]]
example_tibble[[4]]
## [1]  50  82 122 170 226