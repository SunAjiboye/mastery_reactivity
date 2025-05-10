library(shiny)

ui <- fluidPage(
  titlePanel("Iris Dataset Reactivity Demo"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "species",
        label = "Select Species",
        choices = unique(iris$Species),
        selected = unique(iris$Species)[1]
      ),
      sliderInput(
        inputId = "sepal_length",
        label = "Sepal Length Range",
        min = min(iris$Sepal.Length),
        max = max(iris$Sepal.Length),
        value = c(min(iris$Sepal.Length), max(iris$Sepal.Length)),
        step = 0.1
      ),
      actionButton(
        inputId = "filter_button",
        label = "Filter Data"
      )
    ),
    mainPanel(
      tableOutput("filtered_table")
    )
  )
)

server <- function(input, output, session) {
  # Reactive expression to filter by species (updates instantly)
  species_filtered <- reactive({
    req(input$species) # Ensure species input is available
    iris[iris$Species == input$species, ]
  })
  
  # Event reactive to filter by sepal length range when button is clicked
  filtered_data <- eventReactive(input$filter_button, {
    req(species_filtered()) # Ensure species_filtered is available
    data <- species_filtered()
    data[data$Sepal.Length >= input$sepal_length[1] & 
           data$Sepal.Length <= input$sepal_length[2], ]
  })
  
  # Observe species selection changes and log to console
  observe({
    req(input$species)
    cat("Selected species:", input$species, "\n")
  })
  
  # Render the filtered dataset
  output$filtered_table <- renderTable({
    req(filtered_data()) # Ensure filtered_data is available
    filtered_data()
  })
}

shinyApp(ui = ui, server = server)
