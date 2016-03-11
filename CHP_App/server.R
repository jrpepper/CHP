##SERVER.R

library(shiny)


# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Fill in the spot we created for a plot
  output$phonePlot <- renderPlot({
    
    switrs <- switrs_all
    
    timeValues <-tapply(switrs$CASE_ID, switrs[,ACCIDENT_YEAR], length)
    timeValues <- as.data.frame(timeValues)
    
    
    timeValues[is.na(timeValues),] <- 0
    
    timeValues$title <- row.names(timeValues)
    names(timeValues) <- c("count","title")
    
    
    
    #make plot
    print(ggplot(data = timeValues, aes( title, count )) +
      theme_minimal() +
      geom_bar(stat="identity", alpha=0.3) +
      #stat_smooth(data=timeValues, aes(x=year, y=count, group = 1), colour="blue", n=24, size=2) +
      #labs(x=title, y=NULL, title="Oakland") + 
      expand_limits(y=0)
    )
  })
})