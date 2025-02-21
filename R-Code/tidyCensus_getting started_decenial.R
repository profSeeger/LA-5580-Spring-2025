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
# For this example, we will start with getting the total population for 
# the 2020 decennial census using the TidyCensus package


# before we get to far, we need to set our working directory. So first save this file.
# From the Session Menu --> Set Working Directory --> To Source File Location
getwd()


#Display all the variable in the 2020 Decennial data set
vDec <- load_variables(2020, "dhc", cache = TRUE)
View(vDec)

#name, label, concept and lowest level of geography available are displayed.
# this table is searchable
#search for the word Poverty and we find  there are two variables of interest


totalPop <- get_decennial(
  geography = "county", #could use County or State
 state = "IA",
  variables = "P1_001N",  #Total Population
  year = 2020,
  sumfile = "dhc",  #Demographic and Housing Characteristics
  geometry = TRUE
)
totalPop

#It runs really slow if you do this for State and all counties with geometry!
#plot(totalPop["value"])

#the sf package allows us to write to a shapefile
st_write(totalPop, "totalPop_IAcounties.shp")



#Lets do this again, but for all states and then save it as a csv
totalPopStates <- get_decennial(
  geography = "state", #could use County or State
  #state = "IA",
  variables = "P1_001N",  #Total Population
  year = 2020,
  sumfile = "dhc",  #Demographic and Housing Characteristics
  geometry = FALSE
)
totalPopStates

write_csv2(totalPopStates, "totalPopStates.csv", append = FALSE)



#Same as above but for the Census tracts in Iowa and with geometry
totalPopIA_tracts <- get_decennial(
  geography = "tract", 
  state = "IA",
  variables = "P1_001N",  #Total Population
  year = 2020,
  sumfile = "dhc",  #Demographic and Housing Characteristics
  geometry = TRUE
)
totalPopIA_tracts
st_write(totalPopIA_tracts, "totalPopIA_tracts.geojson")