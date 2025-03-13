## ----Install-packages---------------------------------------------------------
#load one at a time
install.packages("tidycensus")
install.packages("tidyverse")
install.packages(c("sf", "tigris"))
install.packages("leaflet") 
install.packages("htmlwidgets")

## ----Load Libraries-----------------------------------------------------------
#load one at a time
library(tidycensus)
library(tidyverse)
library(sf)
library(tigris)
library(leaflet)
library(htmlwidgets)



#for ACS5
ACS5_2023_variables <- load_variables(2023, "acs5", cache = TRUE)
View(ACS5_2023_variables)

# this is a comment

#	 B19013_001.  description of what it is
myVariable <- get_acs(geography = "county", 
                          variables = "B19013_001",
                          state = "Iowa", 
                          output = "wide",
                          geometry = TRUE, 
                          survey = "acs5",
                          year = 2023)
#look at the data frame and notice only 10 results!
view(myVariable)

st_write(myVariable, "WednesdayDemo2.geojson")






#LEAFLET MAPPING

# Ensure spatial data is in WGS84 (EPSG:4326) for Leaflet
myVariableTransform <- st_transform(myVariable, crs = 4326)

# Define a color palette for the income values
income_pal <- colorNumeric(
  palette = "YlGnBu", # Yellow-Green-Blue color scheme
  domain = myVariableTransform$B19013_001E
)


# Create Leaflet interactive map
myMap <- leaflet(myVariableTransform) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%  # Use a light basemap
  addPolygons(
    fillColor = ~income_pal(B19013_001E),
    color = "black",
    weight = 0.5,
    smoothFactor = 0.3,
    fillOpacity = 0.6,
    label = ~paste(NAME, "<br>Median Income Demo: $", format(B19013_001E, big.mark = ",")),
    highlightOptions = highlightOptions(
      weight = 2,
      color = "red",
      fillOpacity = 0.9,
      bringToFront = TRUE
    )
  ) %>%
  addLegend(
    position = "bottomright",
    pal = income_pal,
    values = myVariableTransform$B19013_001E,
    title = "Median Household Income",
    labFormat = labelFormat(prefix = "$")
  ) %>%
  addControl("<strong>Iowa Median Household Income (2023)</strong>", position = "topright", className = "leaflet-control-title")

myMap


# Save the map as an HTML widget
saveWidget(myMap, file = "wednesdayDemo.html")
