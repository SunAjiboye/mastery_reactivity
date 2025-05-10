# mastery_reactivity
# Reactivity Exercise Answers

## 1. Primary Difference Between `reactive()` and `eventReactive()`
`reactive()` creates **reactive expressions** that update whenever any reactive dependencies change. In contrast, `eventReactive()` only **updates** when a specific triggering event occurs.

### When to Choose Each:
- Use `reactive()` for computations that should update **whenever inputs change**.
- Use `eventReactive()` when an update should happen **only after a user action** (e.g., clicking a button).

---

## 2. Difference Between `observe()` and `observeEvent()`
- **`observe()`**: Runs its code whenever any of its reactive dependencies change.
- **`observeEvent()`**: Runs only when the specified event occurs (e.g., a button press).

### Example Scenarios:
```r
# observe() - Runs whenever input$value changes
observe({
  print(paste("Value changed:", input$value))
})

# observeEvent() - Runs only when button is clicked
observeEvent(input$btn, {
  print("Button clicked!")
})
