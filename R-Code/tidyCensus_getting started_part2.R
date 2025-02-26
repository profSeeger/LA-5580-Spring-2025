## ----Install-packages---------------------------------------------------------
#load one at a time
install.packages("tidycensus")
install.packages("tidyverse")
install.packages("dplyr") #this is actually also loaded in the tidyverse
#or several at once, these are more for visual display
install.packages(c("tidyverse", "plotly"))
install.packages("highcharter") #interactive charts
#and these help with spatial
install.packages(c("sf", "tigris"))



## ----Load Libraries-----------------------------------------------------------
#load one at a time
library(tidycensus)
library(tidyverse)
library(dplyr)
library(sf)
library(tigris)

library(ggplot2)
library(plotly)
library(highcharter)


## ----Loading Tidy Census ACS Data---------------------------------------------
# For this example, we are going to look at Poverty
# To calculate income to poverty, you divide a person or family's total 
# income before taxes by the federally established poverty threshold that 
# corresponds to their household size; if the result is less than 1, then 
# their income is considered below the poverty line.
# official documentation on this data is at 
# https://www.census.gov/topics/income-poverty/poverty/guidance/poverty-measures.html



#Display all the variable in the 2023 ACS and open a tab to view the info
ACS5_2023_variables <- load_variables(2023, "acs5", cache = TRUE)
View(ACS5_2023_variables)

#name, label, concept and lowest level of geography available are displayed.
# this table is searchable
#search for the word Poverty and we find  there are two variables of interest

# B05010_001 total number in the estimate
# B05010_002 total number with a ratio value below 1, by definition in poverty

# Now that we have two variables to work with, we want to retrieve them from 
# The US Census using a package called tidyCensus

# Save the results of this in data frame which I am calling poverty_df

poverty_df <- get_acs(geography = "county", 
              variables = "B05010_002",
              state = "Iowa", 
              output = "wide",
              geometry = TRUE, 
              year = 2023)

























