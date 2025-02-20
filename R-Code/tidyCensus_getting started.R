## ----Install-packages---------------------------------------------
#load one at a time
install.packages("tidycensus")
install.packages("tidyverse")
install.packages("dplyr") #this is actually also loaded in the tidyverse
#or several at once, these are more for visual display
install.packages(c("tidyverse", "plotly"))
#and these help with spatial
install.packages(c("sf", "tigris"))


## ----Load Libraries---------------------------------------------
#load one at a time
library(tidycensus)
library(tidyverse)
library(dplyr)
library(sf)
library(tigris)

library(ggplot2)
library(plotly)

