library(shiny)
library(plotly)

ui <- fluidPage(

  titlePanel("Depth and Reef Fish"),
  sidebarLayout(
    sidebarPanel(
      selectInput("depth", "Depth:", 
                  choices=colnames(df)),
      hr(),
      helpText("Data from the Reef Life Survey.")
    ),
    mainPanel(
      plotOutput("depthPlot")  
    )
)
)

server <- function(input,output,session){

  output$depthPlot <- renderPlot({
  
    barplot(df[,input$depth], main=input$depth,ylab="Number of Reef Fish",
            xlab="Species")
  })

}

shinyApp(ui,server)

