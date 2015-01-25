
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("The Effect of Vitamin C on Tooth Growth in Guinea Pigs"),

  # Sidebar with a drop down for selecting the variable
  sidebarLayout(
          sidebarPanel(
                  selectInput("variable", "Variable:",
                              list("Supplement" = "supp", 
                                   "Dose" = "dose",
                                    "Dose Supplement" = "dose * supp"))
          ),

    # Show a plot of the generated distribution
    mainPanel(
      #plotOutput("lenPlot")
      tabsetPanel(type = "tabs", 
                  tabPanel("BoxPlot", plotOutput("lenPlot")),
                  tabPanel("Regression model", 
                           plotOutput("lenRegPlot"),
                           verbatimTextOutput("fit")
                  ),
                  tabPanel("Ressidual", 
                           plotOutput("lenResPlot")
                  ))
                  
    )
  )
))
