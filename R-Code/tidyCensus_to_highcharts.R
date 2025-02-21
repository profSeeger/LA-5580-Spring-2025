

#This code is still in development.

library(htmlwidgets)

data("mpg", "diamonds", "economics_long", package = "ggplot2")
head(mpg)
hc <- hchart(mpg, "point", hcaes(x = displ, y = cty, group = year))


saveWidget(hc, file="highchart.html", selfcontained=FALSE)