library(shiny)
library(dplyr)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("species", "Choose a Species:", choices = unique(iris$Species)),
      sliderInput("sepal", "Sepal Length Range:", min = 0, max = 100, value = c(5, 7)),
      actionButton("filter", "Filter Data")
    ),
    mainPanel(
      tableOutput("filtered_table")
    )
  )
)

server <- function(input, output, session) {
  
  observeEvent(input$species, {
    species_data <- iris %>%
      filter(Species == input$species)
    
    sepal_min <- min(species_data$Sepal.Length)
    sepal_max <- max(species_data$Sepal.Length)
    
    updateSliderInput(session, "sepal", 
                      min = sepal_min, max = sepal_max, 
                      value = c(sepal_min, sepal_max))
  })
  
  filtered_species <- reactive({
    iris %>%
      filter(Species == input$species)
  })
  
  filtered_event <- eventReactive(input$filter, {
    req(input$sepal)  # Ensure input is available
    
    filtered_species() %>%
      filter(Sepal.Length >= input$sepal[1] & Sepal.Length <= input$sepal[2])
  })
  
  observe({
    print(paste("User selected species:", input$species))
    showNotification("Species selected", duration = 2, type = "message")
  })
  
  output$filtered_table <- renderTable({
    filtered_event()
  })
}

shinyApp(ui, server)
