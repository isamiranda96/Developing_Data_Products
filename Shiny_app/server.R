
library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
library(DescTools)


#Load and correct data

data <- read.csv("cicle.csv")
data$day <- data$day + 1 


shinyServer(function(input, output) {
  
  d <- reactive({
    
    n <- input$n
    
    data$day_name <- day.name[data$day]
    data$month_name <- month.name[data$month]
    
    switch(input$dist,
       "day" = data[1:n,"day_name"],
       "month" = data[1:n, "month_name"],
       "event" = data[1:n,"events"])
    
  })
   
  output$distPlot <- renderPlot({
    
    n <- input$n
    dist <- input$dist

    # Make different matrix depending on the input
      
      
      if (dist == "month"){
        abb <- month.abb
        sum <- with(data[1:n,], table(month, year))
        
      }
      
      else if (dist == "day"){
        abb <- day.abb
        sum <- with(data[1:n,], table(day, year))
      }
      
      else if (dist == "event"){
        sum <- with(data[1:n,], table(events, year))
        abb <- row.names(sum)
      }
      
     #Make barplot with matrix 
      
      barplot(sum[,input$year], 
              main= paste(" Total Number of Trips by", dist, "in",input$year),
              ylab="Number of Trips",
              xlab= dist,
              names.arg = abb,
              col = "#75AADB", 
              border = "white")
   
    })
  
  output$summary <- renderPrint({
    
    #Summary table of frequency
    
    df <- as.data.frame(table(d()))
    names(df) <- c(input$dist, "Frequency")
    df
    
  })
  
  output$table <- renderTable({
    
    #data table
    
    head(d(), input$n)
    
  })
  
})



