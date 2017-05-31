# https://github.com/jenzopr/shiny-modules

library(shiny)

source("colorPicker.R")
source("kmeans.R")

ui <- fixedPage(
  h2("Module example"),
  kmeansClusInput("kmeans")
)

server <- function(input, output, session) {
  km <- callModule(kmeansClus, "kmeans")
}

shinyApp(ui, server)
