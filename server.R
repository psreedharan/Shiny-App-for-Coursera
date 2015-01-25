library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    X <- rnorm(100, 5, 3)  

    Bootstrap.Samples <- matrix(sample(X, size = input$NumberSamples*100, replace = TRUE), 
                                input$NumberSamples, 100)

    Bootstrap.Statistic <- apply(Bootstrap.Samples, 1, mean)

    # draw the histogram with the specified number of bins
    require(ggplot2)
    ggplot(data.frame(Mean.X = Bootstrap.Statistic), aes(x = Mean.X)) +
      geom_histogram(binwidth = 0.25, aes(y = ..density..)) + 
      geom_density(color = "red")
    
  })
})