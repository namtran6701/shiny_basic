pacman::p_load(shiny, shinythemes, pacman, tidyverse, quantmod, lubridate, PerformanceAnalytics)

# return of the S&P 500
getSymbols('SPY',
           from = as.Date('2022-01-01'),
           to = as.Date('2023-01-01'))

# Get adjusted Price only
SPY <- Ad(SPY)

# Calculate daily return, use percentage form
SPY_ret <- dailyReturn(SPY)*100

# Remove the first row as we apply the function dailyReturn 

SPY_ret <- SPY_ret[-1,]


SPY_ret %<>% 
  data.frame() %>% 
  rownames_to_column(var = 'Date') %>% 
  mutate(Date = ymd(Date))

SPY_ret %>% summary()
# Define the UI

ui <- fluidPage(
  # app title
  titlePanel('Stock Price'),
  
  # Create a sidebar layout 
  sidebarLayout(
    
    # Customize the sidebar pannel 
    sidebarPanel(
      # Create a slider fot the number of bins 
      sliderInput(inputId = 'bins',
                  label = 'Number of bins:',
                  min = 1,
                  max = 50,
                  value = 25, # default number of bins
                  step = 1)
    ),
    
    # Create a main panel for displaying outputs 
    mainPanel(
      plotOutput(outputId = 'distPlot')
    ) 
  )
)

# Define the server 

server <- function(input, output){
  output$distPlot <- renderPlot({
    x <- SPY_ret$daily.returns %>% 
      na.omit()
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = '#75AADB', border = 'black',
         xlab = 'Return',
         main = 'Return Distribution of SPY in 2022')
  })
}

# Create Shiny App object

shinyApp(ui = ui, server = server)

# The SPY jumped 5.54% in its biggest rally since April 2020 on Nov 13


# Data xray
