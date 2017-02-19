#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/

# Not reactive code:

#Install packages
#install.packages(c("shiny", "dplyr", "ggplo2", "DT", "devtools", "tidyr", "flexdashboard"))
#devtools::install_github("juliasilge/southafricastats")

#Prepare Shiny data
library(southafricastats)
library(dplyr)
library(ggplot2)
library(DT)

mortality_zaf
mortality_zaf$province

mortality <- mortality_zaf %>%
  filter(!(indicator %in% c("All causes")))

# Reactive code:

# Define UI for application that draws a histogram
ui <- fluidPage(
  
   # Application title
   titlePanel("South Africa Stats - Mortality"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        
         #First reactive input
         selectInput(inputId = "province",
                     label = "Choose a province:",
                     choices = unique(mortality$province),
                     selected = "Gauteng",
                     multiple = TRUE),
         
         #Second reactive input
         checkboxInput(inputId = "showtable",
                       label = "Show table?",
                       value = FALSE)
      ),
      
      # Show a plot and a table
      mainPanel(
         #Name of output should be same as 'plotOutput'
         plotOutput("LinePlot"),
         dataTableOutput("mortalityTable")
      )
   )
)

# Define server logic 
server <- function(input, output) {
   
   #Name of output should be same as 'plotOutput'
   
   #First output on first reactive input
   output$LinePlot <- renderPlot({
     mortality %>% 
       filter(province %in% input$province) %>%
       ggplot(aes(year, deaths, color = indicator)) +
       facet_wrap(~province) +
       geom_line(alpha = 0.8, size =1.5) +
       theme_minimal(base_size = 18)
     
   })
   
   #Second output on second reactive input
   output$mortalityTable <- renderDataTable({
     if(input$showtable) {
       datatable(mortality %>% 
       filter(province %in% input$province))}
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

