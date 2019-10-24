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
library(mapproj)


type = c(Cylindrica = "cylindrical", Mercato = "mercator", Sinusoidal = "sinusoidal", Gnomonic = "gnomonic", 
         Rectangula =  "rectangula", Cylequalarea = "cylequalarea")



##############################################

ui = fluidPage(
  titlePanel("Type of Maps"),
    selectInput("maps", "Select a type of maps", choices = type),
  
      mainPanel(
        plotOutput(outputId = "Map")
      )
)

server = function(input, output, session){
  mapWorld <- map_data("world")
  mp1 <- ggplot(mapWorld, aes(x=long, y=lat, group=group))+
    geom_polygon(fill="white", color="black") +
    coord_map(xlim=c(-180,180), ylim=c(-60, 90))
  output$Map = renderPlot({
    if(input$maps == "cylindrical" | input$maps =="mercator" | input$maps =="sinusoidal"|input$maps =="gnomonic" ){
    mp2 = mp1 + coord_map(input$maps, xlim=c(-180,180), ylim=c(-60, 90))}
    else{
    mp2 = mp1 + coord_map(input$maps, parameters = 0, xlim=c(-180,180), ylim=c(-60, 90))}
    mp2
  })
}

shinyApp(ui,server)
