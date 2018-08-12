# Define server logic required to draw a histogram
library(shiny)
library(plotly)

data(USArrests)
UStates<-data.frame(state=state.abb,state.name)

# Create data frame of required columns, adding state code from UStates
arrdata <- merge(cbind(statename=rownames(USArrests),USArrests),UStates,
                 by.x=c("statename"),by.y=c("state.name"))

server <- function(input, output) {
  
  observeEvent(input$Measure,{
  
  # Create hover text
  arrdata$hover <- with(arrdata, paste("Urban Pop:", UrbanPop, '%', '<br>', 
                        switch(input$Measure,"Murder"=paste("Murder:", Murder),
                               "Assault"=paste("Assault:", Assault),
                               "Rape"= paste("Rape:", Rape),
                               "UrbanPop" = paste("Murder:", Murder, 
                                                  '<br>',"Assault:", Assault,
                                                  '<br>',"Rape: ", Rape) ) ) )
    output$mapPlot <- renderPlotly({
  
      # give state boundaries a white border
      l <- list(color = toRGB("white"), width = 2)
      # specify some map projection/options
      g <- list(
        scope = 'usa',
        projection = list(type = 'albers usa'),
        showlakes = TRUE,
        lakecolor = toRGB('white')
      )
      
      p <- plot_geo(arrdata, locationmode = 'USA-states') %>%
             add_trace(z = ~get(input$Measure), text = ~hover, locations = ~state,
                   color = ~get(input$Measure), colors = input$Color) %>%
             colorbar(title = ifelse(input$Measure=="UrbanPop","% Urban Population","Arrests")) %>%
             layout(title = ifelse(input$Measure=="UrbanPop","% Urban Population",input$Measure), geo = g)      
      print(p)      
      
    })
    
  })
}