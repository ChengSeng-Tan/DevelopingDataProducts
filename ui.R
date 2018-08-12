# Define UI for application to display violent crime rates in USA
library(shiny)
library(plotly)

# load data

data(USArrests)
UStates<-data.frame(state=state.abb,state.name)
color_bar = rep("&nbsp;",30)

# Define UI for random distribution app ----
ui <- fluidPage(
  
  # App title ----
  # App title ----
  titlePanel("Violent Crimes in the US"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input for Measure 
      selectInput("Measure", "Choose the Measure",
                   c("% Urban Population" = "UrbanPop",
                     "Murder Incidence" = "Murder",
                     "Assault Incidence" = "Assault",
                     "Rape Incidence" = "Rape")),
      
      # br() element to introduce extra vertical spacing ----
      br(),
      
      #  Input for Color Scheme
 
      radioButtons(
        inputId = "Color",
        label = "Choose a Color Scheme for the Map",
        choiceNames = list(
          tags$span(style ="color:#eff3ff;background:linear-gradient(to right, #eff3ff, #08519c)","___________________________"), 
          tags$span(style ="color:#fee5d9;background:linear-gradient(to right, #fee5d9, #a50f15)","___________________________"), 
          tags$span(style ="color:#edf8e9;background:linear-gradient(to right, #edf8e9, #006d2c)","___________________________"), 
          tags$span(style ="color:#f2f0f7;background:linear-gradient(to right, #f2f0f7, #54278f)","___________________________"), 
          tags$span(style ="color:#feedde;background:linear-gradient(to right, #feedde, #a63603)","___________________________"), 
          tags$span(style ="color:#f7f7f7;background:linear-gradient(to right, #f7f7f7, #252525)","___________________________") 
        ),
        choiceValues = c("Blues", "Reds", "Greens", "Purples","Oranges","Greys")
      )
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Map", 
                           h4('Violent Crime Rate (per 100,000 residents) by State', align ="center"), 
                           plotlyOutput(outputId = "mapPlot"),
                           h5('Please hover over the state location to see the crime rate & urban population %.', 
                              align ="center")
                           ),
                  tabPanel("About",  
                           h2("Welcome to the Application on Violent Crimes in the USA", align="center"),
                           p("This Shiny App allows you to explore the data on Violent Crimes in The USA by State"),
                           p("You will be able to find answers to questions like:"),
                           p("(a) What are the violent crime rates of New York State?"),
                           p("(b) Which are the states that have the highest rate for Murder?"),
                           p("(c) Are high violent crime rates associated with high urban populations?"),
                           h3("Features"),
                           p("1. Select the measure you want to show on the USA map."),
                           p("2. Choose the color scheme you prefer for the shading of the USA map."),                           
                           p("3. Mouse over the rendered USA map and you will see the crime rate for the state"),
                           p(HTML("<i>If <font color=blue>% Urban Population</font> is chosen, the shading shows the level of urban population & the hover message show rates for all three violent crimes.</i>")),                           
                           h3("Documentation"),
                           p(HTML("ui.r and server.R code files are available on <a href='https://github.com/chengseng/DevelopingDataProducts'  target='_blank'>GitHub</a>.")),
                           p(HTML("The pitch presentation for the app can be found on <a href='http://rpubs.com/ChengSeng/411753' target='_blank'>RPubs</a>")),
                           h3("References"),
                           p("This data set from McNeil's monograph contains statistics, in arrests per 100,000 residents for assault, murder, and rape in each of the 50 US states in 1973. Also given is the percent of the population living in urban areas."),
                           p("McNeil, D. R. (1977) Interactive Data Analysis. New York: Wiley."),
                           br()
                           )
      )
      
    )
  )
)