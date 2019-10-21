library(shiny)

function(input, output) {
  output$Depth <- renderTable(data$Depth)

}