library(shiny)

shinyUI(fluidPage(
    titlePanel("Convergence in Probability"),
    sidebarLayout(
        sidebarPanel(
            selectInput("dist", "Probability Distribution:",
                    choices = c("Normal","Exponential","Lognormal"),
                    selected = "Normal"),
            br(),
            br(),
            sliderInput("n", "Sample size:", min = 10, max = 1000, value = 20),
            sliderInput("N", "Number of simulations:", min = 1, max = 100, value = 5),
            sliderInput("epsilon", "Convergence error (epsilon):", 
                        min = 0.005, max = 1, value = 0.5000)
        ),   
        
        mainPanel(
            tabsetPanel(type="tabs",
                tabPanel("Plot", plotOutput("plot")),
                tabPanel("Limit", verbatimTextOutput("limit"))
            )
        )
    )
))