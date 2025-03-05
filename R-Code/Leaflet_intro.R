## ----Install-packages---------------------------------------------------------
#load one at a time
install.packages("tidycensus")
install.packages("dplyr") #this is actually also loaded in the tidyverse
#or several at once, these are more for visual display
install.packages(c("tidyverse", "plotly"))
install.packages("highcharter") #interactive charts
#and these help with spatial
install.packages(c("sf", "tigris", "mapview"))


## ----Load Libraries-----------------------------------------------------------
#load one at a time
library(tidycensus)
library(tidyverse)
library(dplyr)
library(sf)
library(tigris)
library(mapview)
library(ggplot2)
library(plotly)
library(highcharter)

## ----Get some Census Data--------------------------------------------------------

# Before we get to far, we need to set our working directory. So first save this file.
# From the Session Menu --> Set Working Directory --> To Source File Location


#Grab Census tracts in Iowa with geometry
totalPopIA_tracts <- get_decennial(
  geography = "tract", 
  state = "IA",
  variables = "P1_001N",  #Total Population
  year = 2020,
  sumfile = "dhc",  #Demographic and Housing Characteristics
  geometry = TRUE
)

totalPopIA_tracts #note the 


#basic plot
plot(totalPopIA_tracts["value"])


#Leaflet map via mapview package
mapview(totalPopIA_tracts, zcol = "value")


# You can export this from Viewer tab and then select Export --> Save as Web Page ...
# this will create an html page that you can then rename and copy to your GitHub repo and link to it there.