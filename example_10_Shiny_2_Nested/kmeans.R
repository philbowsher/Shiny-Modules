library(RColorBrewer)

kmeansClusInput <- function(id, label) {
  ns <- NS(id)

  col <- colorPickerInput(ns("col"), "Color scheme")
  tags <- tagList(
    selectInput(ns('xcol'), 'X Variable', names(iris)),
    selectInput(ns('ycol'), 'Y Variable', names(iris), selected=names(iris)[[2]]),
    numericInput(ns('clusters'), 'Cluster count', 3, min = 1, max = 9))

  fluidRow(
    column(4, tags, col),
    column(8, plotOutput(ns("plot1")))
  )
}

kmeansClus <- function(input, output, session) {
  innerResult <- callModule(colorPicker, "col")

  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })

  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })

  output$plot1 <- renderPlot({
    cols <- brewer.pal(input$clusters, innerResult$scheme)[clusters()$cluster]
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = cols,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })

}

