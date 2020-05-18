library(shiny)
library(readxl)
library(tidyverse)
theme_set(theme_classic(base_size = 15))



# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Chi-kwadraattoets op onafhankelijkheid"),
   
   # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Selecteer xxx.xlsx",
                 accept = ".xlsx")
      ),
        
      #table with raw data
        tableOutput(outputId = "table")
    ),
   
    mainPanel(
      plotOutput(outputId = "density"),
      verbatimTextOutput("chitest")  
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  mydata <- reactive({
    req(input$file1)
    read_xlsx(input$file1$datapath)
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

