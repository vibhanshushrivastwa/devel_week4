library(shiny)
# Define UI for application that predict the volume from girth
shinyUI(fluidPage(
    # Application title
    titlePanel("Predict Volume of Timber by Girth for Black Cherry Trees"),
    # Sidebar with a slider input for the girth of the tree
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderGirth", "What is the girth of the tree?", 8, 21, value = 13),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
            checkboxInput("show_xLabel", "Show/Hide X Axis Label", value = TRUE),
            checkboxInput("show_yLabel", "Show/Hide Y Axis Label", value = TRUE),
            checkboxInput("show_Title", "Show/Hide Title", value = TRUE),
            submitButton("Submit")
        ),
        # Show a plot of the generated distribution
        mainPanel(
            h5("Use the control on the left pane to select: The girth of the tree"),
            h5("The plot adjusts automatically to reflect the effect of girth of the tree on the volume of timber."),
            plotOutput("plot1"),
            h3("Predicted Volume of Timber from Model 1:"),
            textOutput("pred1"),
            h3("Predicted Volume of Timber from Model 2:"),
            textOutput("pred2")
        )
    )
))