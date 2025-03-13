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



#for ACS5 fiund a variable of interest.
ACS5_2023_variables <- load_variables(2023, "acs5", cache = TRUE)
View(ACS5_2023_variables)


#	 Replace the B19013_001 with your own indicator
# note I called the result myVariable
myVariable <- get_acs(geography = "county", 
                          variables = "B19013_001",
                          state = "Iowa", 
                          output = "wide",
                          geometry = TRUE, 
                          survey = "acs5",
                          year = 2023)
#Look at the data frame and notice only 10 results!
view(myVariable)

#optionally if you want to use this in Tableau you can save it as a geoJSON
st_write(myVariable, "WednesdayDemo2.geojson")




## ----Leaflet Mapping-----------------------------------------------------------

# Ensure spatial data is in WGS84 (EPSG:4326) for Leaflet
myVariableTransform <- st_transform(myVariable, crs = 4326)

# Define a color palette for the income values
# I will try and provide a few more options for colors, 
# so check back for an updated version of this r file
#You will need to replace B19013_001E with the column name 
# of the variable you want to map. You need to fix this throughout 
# the rest of the code. 
income_pal <- colorNumeric(
  palette = "YlGnBu", # Yellow-Green-Blue color scheme
  domain = myVariableTransform$B19013_001E
)


# Create Leaflet interactive map
myMap <- leaflet(myVariableTransform) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%  # Use a light basemap
  addPolygons(
    fillColor = ~income_pal(B19013_001E), #replace B19013_001Ewith your  value
    color = "black", #Outline color - you can select a color
    weight = 0.5, #line thinckness is 0 - 1
    smoothFactor = 0.3,
    fillOpacity = 0.6,  #transparency value of 0-1, you can edit this
    #Prof Seeger will provide more detail on this label in an updated version
    #replace B19013_001Ewith your  value
    label = ~paste(NAME, "<br>Median Income Demo: $", format(B19013_001E, big.mark = ",")),
    highlightOptions = highlightOptions(
      weight = 2,
      color = "red", #the outline color of the selected feature
      fillOpacity = 0.9, #0-1 transparency
      bringToFront = TRUE
    )
  ) %>%
  addLegend(
    position = "bottomright",
    pal = income_pal,
    values = myVariableTransform$B19013_001E, #replace B19013_001Ewith your  value
    title = "Median Household Income",   #you will need to edit this!
    labFormat = labelFormat(prefix = "$")
  ) %>%
  addControl("<strong>Iowa Median Household Income (2023)</strong>", position = "topright", className = "leaflet-control-title")
#replace the text above

myMap

# make sure and save and set session to location of local file!!!
# Save the map as an HTML widget
saveWidget(myMap, file = "wednesdayDemo.html") #name the file
