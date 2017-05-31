# http://samboh.blogs.dsv.su.se/2016/12/20/modularizing-shiny-app-code/
# https://github.com/samuel-bohman/module_example_1
# https://github.com/samuel-bohman/module_example_2


library(shiny)

# Define UI for application that draws a histogram
fluidPage(
    
  # Application title
  titlePanel("Hello Shiny!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    
    # Call the module UI function
    sidebarUI(id = "one"),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)