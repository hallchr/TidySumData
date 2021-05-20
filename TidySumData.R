library(tidyverse)
#install.packages("here")
library(here) #helps with setting working directories and finding paths
library(ProjectTemplate) #helps codify a file layout hierarchy

#create project template
create.project(project.name = "ProjectTemplate",
               template = "minimal")
