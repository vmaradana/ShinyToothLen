
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
                                    "Dose Supplement" = "dose * supp")),
                  
                  h3("Description"),
                  helpText("The response is the length of odontoblasts (teeth) in each of 10 guinea pigs at each of three dose levels of Vitamin C (0.5, 1, and 2 mg) with each of two delivery methods (orange juice (OJ) or ascorbic acid(VC))."),
                  helpText("Use the variable dropdown above to select one of the variables to see the boxplot, regression plot and residuals")
                  
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
