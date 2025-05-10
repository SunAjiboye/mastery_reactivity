library(shiny)

ui <- fluidPage(
  textInput("name", "Enter Your Name:"),
  actionButton("add_score", "Add Score"),
  actionButton("reset_score", "Reset Score"),
  textOutput("score_display")
)

server <- function(input, output, session) {
  values <- reactiveValues(score = 0, user_name = "")
  
  observeEvent(input$add_score, {
    values$score <- values$score + 1
  })
  
  observeEvent(input$reset_score, {
    values$score <- 0
  })
  
  observeEvent(input$name, {
    if (input$name != "") values$user_name <- input$name
  })
  
  output$score_display <- renderText({
    paste("User:", values$user_name, "- Score:", values$score)
  })
}

shinyApp(ui, server)

