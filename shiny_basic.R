pacman::p_load(shiny, shinythemes, pacman)

# define UI
ui <- fluidPage(theme = shinytheme('superhero'),
                navbarPage(
                  'Basic Information',
                  tabPanel('Page 1',
                           sidebarPanel(
                             tags$h3('Input:'),
                                     textInput('txt1','Given Name:', ''),
                                     textInput('txt2','Surname:', ''),
                                     ), 
                           mainPanel(
                             h2('Results'),
                             h4('Full Name'),
                             verbatimTextOutput('txtout'),
                           ) 
                  ),
                  tabPanel('Page 2', 'This panel is intentially left blank'),
                  tabPanel('Page 3', 'This panel is intentially left blank')
                )
)


# Define server func tion

server <- function(input, output){
  output$txtout <- renderText({
    paste(input$txt1, input$txt2, sep =' ')
  })
}

# Creaete shiny object
shinyApp(ui = ui, server = server)
