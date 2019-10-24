
#load libraries
library(tidyverse)
library(magrittr)
library(readxl)
library(ggmap)
library(shiny)
library(leaflet)
library(maps)
library(htmlwidgets)
library(mapdata) 
library(htmltools)

#import data


df <- read.csv( file="Colleges_and_Universities.csv", header = TRUE, sep = "," )
df <- select(df,Latitude,Longitude,Address,Name,City)


ui <- fluidPage(
  titlePanel("Colleges and Universities"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("city", "Select City", unique(df$City))),
      mainPanel(
        leafletOutput("myMap")
      )
    
)
)


server <- function(input, output, session) {

  #create the map
  output$myMap <- renderLeaflet({
    df = df %>% filter(City == input$city)
    myMap = leaflet(df) %>% addTiles()%>%
      setView(lng = -71.0589, lat = 42.3601, zoom = 12)  %>% 
      addMarkers(data = df, lng =~Longitude,lat =~Latitude, label = ~htmlEscape(Name), popup = ~htmlEscape(Address))
      
})
  }



shinyApp(ui, server)



