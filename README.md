# mastery_reactivity

README: Mastering Shiny Reactivity Exercise
Overview
This Shiny application, merged_reactivity_exercise.R, is a comprehensive demonstration of reactive programming concepts in R Shiny, developed as part of the Mastering Shiny Reactivity Intensive Exercise. The app integrates three exercises—Iris Filter, Score Tracker, and Debugged Iris Filter—into a single interface using a tabsetPanel. It showcases the use of reactive(), eventReactive(), observe(), observeEvent(), and reactiveValues(), along with advanced features like dynamic slider updates, dplyr for data filtering, and user notifications.
The app is designed to:

Filter the iris dataset based on species and sepal length (Iris Filter).
Track user scores and names with persistent state (Score Tracker).
Demonstrate a debugged version of a reactive filtering app (Debugged Iris Filter).

Repository Structure
The code is intended to be saved in the master_reactivity folder of a GitHub repository, alongside other exercise files:

merged_reactivity_exercise.R: The main Shiny app combining all three exercises.
reactivity_exercise_answers.md: Conceptual answers to reactivity questions (not included here).
Other exercise files (e.g., reactivity_exercise1.R, reactivity_exercise2.R, debug_reactivity_fixed.R) may also be present.

Features
1. Iris Filter Tab

Purpose: Filters the iris dataset by species and a user-defined sepal length range.
UI Components:
selectInput: Choose a species from iris$Species.
sliderInput: Select a range of Sepal.Length (dynamically updated based on species).
actionButton: Trigger filtering.
tableOutput: Display the filtered dataset.


Reactivity:
reactive(): Filters by species instantly.
eventReactive(): Applies sepal length filter only on button click.
observe(): Logs species selection and shows a notification.
observeEvent(): Updates slider range dynamically using updateSliderInput().


Enhancements:
Uses dplyr for readable filtering.
Shows notifications for species selection.
Robust error handling with req().



2. Score Tracker Tab

Purpose: Tracks a user’s score and name with persistent state.
UI Components:
textInput: Enter a user name.
Two actionButtons: Increment or reset the score.
textOutput: Display the name and score.


Reactivity:
reactiveValues(): Stores score (starts at 0) and user_name (starts empty).
observeEvent(): Updates name (if non-empty), increments score, or resets score.
renderText(): Displays the current state.


Features:
Persistent state across interactions.
Clean output format: "User: [name] - Score: [score]".



3. Debugged Iris Filter Tab

Purpose: A corrected version of a buggy app, filtering iris by species on button click.
UI Components:
selectInput: Choose a species.
actionButton: Trigger filtering.
tableOutput: Display the filtered dataset.


Reactivity:
reactive(): Filters by species.
eventReactive(): Applies filter on button click, reusing the reactive expression.
renderTable(): Displays the result.


Fixes:
Added req() to prevent errors from missing inputs.
Optimized reactivity by reusing the reactive expression.



Setup Instructions
Prerequisites

R: Version 4.0 or higher recommended.
R Packages:
shiny: For the Shiny framework.
dplyr: For data filtering.


Install dependencies:install.packages(c("shiny", "dplyr"))



Installation

Clone or download the repository to your local machine.
Navigate to the master_reactivity folder.
Ensure merged_reactivity_exercise.R is saved in this folder.

Running the App

Open R or RStudio.
Set the working directory to the master_reactivity folder:setwd("path/to/master_reactivity")


Run the app:shiny::runApp("merged_reactivity_exercise.R")

Alternatively, source the script:source("merged_reactivity_exercise.R")


The app will open in your default web browser or RStudio viewer.

Testing Guidelines
To verify the app’s functionality, test each tab as follows:
Iris Filter Tab

Steps:
Select a species (e.g., "setosa").
Verify the slider range updates to match the species’ Sepal.Length range.
Check for a notification ("Species selected") and console log.
Adjust the slider and click "Filter Data".
Confirm the table shows rows matching the species and sepal length range.


Expected: Filtered table updates only on button click, with no errors.

Score Tracker Tab

Steps:
Enter a name (e.g., "Alice").
Click "Add Score" multiple times and verify the score increments.
Click "Reset Score" and confirm the score resets to 0.
Leave the name empty and verify no update to the user name.


Expected: Display shows "User: [name] - Score: [score]", with persistent state.

Debugged Iris Filter Tab

Steps:
Select a species.
Click "Update Data".
Confirm the table shows rows for the selected species.
Change species and click again to verify updates.


Expected: Table updates only on button click, with no errors.

Potential Issues and Solutions

Missing Packages:
Issue: Error like could not find package 'dplyr'.
Solution: Install packages with install.packages(c("shiny", "dplyr")).


Slider Range Errors:
Issue: Rare cases where iris data might be malformed (unlikely).
Solution: The code uses req() to handle missing data; no action needed.


Notification Overload:
Issue: Rapid species changes in the Iris Filter tab may queue multiple notifications.
Solution: Notifications are short (2 seconds); optionally add shiny::debounce for high-frequency inputs.



Notes

The app uses the built-in iris dataset, ensuring reliability.
All reactivity functions (reactive(), eventReactive(), observe(), observeEvent(), reactiveValues()) are implemented as per the exercise requirements.
The code is robust, with req() for error handling and unique IDs to prevent conflicts.
Improvements like updateSliderInput() and showNotification() enhance user experience.

Contact
For issues or questions, please contact the repository maintainer or submit a GitHub issue. Happy Shiny coding!
