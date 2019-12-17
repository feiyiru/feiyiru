library(dplyr)
library(tidyverse)
library(knitr)
library(tidytext)
library(gridExtra)
library(shiny)
library(leaflet)
library(shinydashboard)

boston = read.csv(file= "crime_report.csv")
boston = na.omit(boston)
boston = boston %>% dplyr::select(OFFENSE_CODE_GROUP,YEAR,MONTH,DAY_OF_WEEK,STREET,Lat,Long)
boston = boston %>% filter(YEAR == 2019)

sanf = read.csv(file= "Police_Present.csv")
sanf = sanf[1:(length(sanf)-9)]
sanf = na.omit(sanf)%>% filter(Incident.Year == 2019)
sanf = separate(sanf,Incident.Date,into = c("year","month","day"),sep = "/")
sanf = sanf %>% dplyr::select(Incident.Category,Incident.Year,month,Incident.Day.of.Week,Intersection,Latitude,Longitude)

#######################
header <- dashboardHeader(title = p("Crime Report in 2019"), titleWidth = 400)

dashboard1 <- column(width =4,
                    
                    box(width = NULL , title =tagList(shiny::icon("filter",class = 'fa-lg'), "Filter Data") ,
                        solidHeader = T, collapsible = T, status = 'info',
                        
                        selectizeInput('crimeType1','Crime Type', choices =unique(boston$OFFENSE_CODE_GROUP),
                                       selected = "Auto Theft",width = 380,multiple = T),
                       
                        selectizeInput('day_of_week1','Days of Week', width = 380,choices =unique(boston$DAY_OF_WEEK),
                                       selected = "Monday",
                                       multiple = T),
                        
                        selectizeInput('month1','Month', width = 380,choices =unique(boston$MONTH),
                                       selected = 1,multiple = T),
                        
                        submitButton(text = "Submit",icon =icon('filter'))
                    )
                   
)

dashboard2 <- column(width =4,
                     
                     box(width = NULL , title =tagList(shiny::icon("filter",class = 'fa-lg'), "Filter Data") ,
                         solidHeader = T, collapsible = T, status = 'info',
                         
                         selectizeInput('crimeType2','Crime Type', choices =unique(sanf$Incident.Category),
                                        selected = "Arson",
                                        width = 380,multiple = T),
                         
                         selectizeInput('day_of_week2','Days of Week', width = 380,
                                        choices =unique(sanf$Incident.Day.of.Week),selected = "Monday",
                                        multiple = T),
                         
                         selectizeInput('month2','Month', width = 380,choices =unique(sanf$month),
                                        selected = '01',multiple = T),
                         
                         submitButton(text = "Submit",icon =icon('filter'))
                     )
                    
)

map1 <- column(width =8,
              box(width = NULL, solidHeader = TRUE,
                  leafletOutput('BostonMap',height = 500)))


map2 <- column(width =8,
               box(width = NULL, solidHeader = TRUE,
                   leafletOutput('SanMap',height = 500)))


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Boston", tabName = "b", icon = icon("map")),
    menuItem("San Francisco", tabName = "sf", icon = icon("map"))
  )
)

body <- dashboardBody(
  tabItems(
  tabItem(
    tabName="b",
      fluidRow(
        dashboard1, map1
                )
              ),
  
  tabItem(
      tabName="sf",
        fluidRow(
         dashboard2, map2)
)
)
)




ui <- dashboardPage(skin = 'blue',
                    header,
                    sidebar,
                    body
)

server <- function(input, output) {
  filteredData1 <- reactive({
    boston %>%
      filter(OFFENSE_CODE_GROUP == input$crimeType1 ) %>%
      filter(DAY_OF_WEEK == input$day_of_week1) %>%
      filter(MONTH == input$month1)
  })
  
  output$BostonMap <- renderLeaflet({
    leaflet(filteredData1())  %>%addTiles()%>%
      setView(lng = -71.0589, lat = 42.3601, zoom = 12)  %>%
      addMarkers(
        ~Long, ~Lat,popup = ~STREET,clusterOptions = markerClusterOptions()
      )
  })
  
  filteredData2 <- reactive({
    sanf %>%
      filter(Incident.Category == input$crimeType2) %>%
      filter(Incident.Day.of.Week == input$day_of_week2) %>%
      filter(month == input$month2)
  })
  
  output$SanMap <- renderLeaflet({
    leaflet(filteredData2())  %>%addTiles()%>%
      setView(lng = -122.4194, lat = 37.7749, zoom = 12)  %>%
      addMarkers(
        ~Longitude, ~Latitude,popup = ~Intersection,clusterOptions = markerClusterOptions()
      )
  })
}

shinyApp(ui = ui, server = server)
