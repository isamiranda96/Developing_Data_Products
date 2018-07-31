
library(shiny)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Chicago Divvy Bicycle Sharing Data"),
  
  hr(),
  
  # Input choices
  
  sidebarLayout(
    sidebarPanel(
      selectInput("year", "Year:", 
                  choices=colnames(sum)),
      
      hr(),
      
      radioButtons("dist", "Trip Frequency by:",
                   c("Month" = "month",
                     "Day" = "day",
                     "Weather" = "event")),
      
      hr(),
      
      # Sidebar with a slider input for number of observations
      
      sliderInput("n",
                  "Number of observations:",
                  value = 500,
                  min = 1,
                  max = 10000),
      hr(),
      
      helpText("A combination of Chicago Divvy bicycle sharing and weather data.")
    ),
    
    # devide by tabs
    
    mainPanel(
      
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("distPlot")),
                  tabPanel("Summary", verbatimTextOutput("summary")),
                  tabPanel("Table", tableOutput("table")))
      
    )
  )
))
