# Merged Reactivity Exercise
# Combines Iris Filter, Score Tracker, and Debugged Iris Filter into a single Shiny app
# Incorporates improvements: updateSliderInput, dplyr, showNotification, and robust error handling

library(shiny)
library(dplyr)

# UI with tabsetPanel for the three exercises
ui <- fluidPage(
  titlePanel("Mastering Shiny Reactivity"),
  tabsetPanel(
    # Tab 1: Iris Filter with dynamic slider
    tabPanel(
      "Iris Filter",
      sidebarLayout(
        sidebarPanel(
          selectInput("species_ex1", "Choose Species:", choices = unique(iris$Species)),
          sliderInput("sepal_ex1", "Sepal Length Range:", 
                      min = min(iris$Sepal.Length), max = max(iris$Sepal.Length), 
                      value = c(min(iris$Sepal.Length), max(iris$Sepal.Length))),
          actionButton("filter_ex1", "Filter Data")
        ),
        mainPanel(
          tableOutput("filtered_table_ex1")
        )
      )
    ),
    # Tab 2: Score Tracker
    tabPanel(
      "Score Tracker",
      sidebarLayout(
        sidebarPanel(
          textInput("name_ex2", "Enter Your Name:", ""),
          actionButton("add_score_ex2", "Add Score"),
          actionButton("reset_score_ex2", "Reset Score")
        ),
        mainPanel(
          textOutput("score_display_ex2")
        )
      )
    ),
    # Tab 3: Debugged Iris Filter
    tabPanel(
      "Debugged Iris Filter",
      sidebarLayout(
        sidebarPanel(
          selectInput("species_ex3", "Choose Species:", choices = unique(iris$Species)),
          actionButton("update_ex3", "Update Data")
        ),
        mainPanel(
          tableOutput("filtered_data_ex3")
        )
      )
    )
  )
)

server <- function(input, output, session) {
  # Exercise 1: Iris Filter
  # Reactive for species filtering
  filtered_species_ex1 <- reactive({
    req(input$species_ex1)
    iris %>% filter(Species == input$species_ex1)
  })
  
  # Dynamically update slider based on selected species
  observeEvent(input$species_ex1, {
    req(input$species_ex1)
    species_data <- iris %>% filter(Species == input$species_ex1)
    sepal_min <- min(species_data$Sepal.Length)
    sepal_max <- max(species_data$Sepal.Length)
    updateSliderInput(session, "sepal_ex1", 
                      min = sepal_min, max = sepal_max, 
                      value = c(sepal_min, sepal_max))
  })
  
  # Event-reactive for button-triggered filtering
  filtered_data_ex1 <- eventReactive(input$filter_ex1, {
    req(input$sepal_ex1, filtered_species_ex1())
    filtered_species_ex1() %>% 
      filter(Sepal.Length >= input$sepal_ex1[1] & Sepal.Length <= input$sepal_ex1[2])
  })
  
  # Log and notify species selection
  observe({
    req(input$species_ex1)
    print(paste("Selected species (Exercise 1):", input$species_ex1))
    showNotification("Species selected", duration = 2, type = "message")
  })
  
  # Render filtered table
  output$filtered_table_ex1 <- renderTable({
    req(filtered_data_ex1())
    filtered_data_ex1()
  })
  
  # Exercise 2: Score Tracker
  # reactiveValues for mutable state
  values_ex2 <- reactiveValues(score = 0, user_name = "")
  
  # Update user_name when non-empty
  observeEvent(input$name_ex2, {
    if (nchar(input$name_ex2) > 0) {
      values_ex2$user_name <- input$name_ex2
    }
  })
  
  # Increase score on button click
  observeEvent(input$add_score_ex2, {
    values_ex2$score <- values_ex2$score + 1
  })
  
  # Reset score on button click
  observeEvent(input$reset_score_ex2, {
    values_ex2$score <- 0
  })
  
  # Display score and user name
  output$score_display_ex2 <- renderText({
    paste("User:", values_ex2$user_name, "- Score:", values_ex2$score)
  })
  
  # Exercise 3: Debugged Iris Filter
  # Reactive for species filtering
  filtered_ex3 <- reactive({
    req(input$species_ex3)
    iris %>% filter(Species == input$species_ex3)
  })
  
  # Event-reactive for button-triggered filtering
  filtered_event_ex3 <- eventReactive(input$update_ex3, {
    req(input$species_ex3)
    filtered_ex3() # Reuse reactive for efficiency
  })
  
  # Render filtered table
  output$filtered_data_ex3 <- renderTable({
    req(filtered_event_ex3())
    filtered_event_ex3()
  })
}

shinyApp(ui, server)

