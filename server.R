
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
require(shiny)
require(datasets)
require(ggplot2)

tgData <- ToothGrowth 

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
        
        # Compute the forumla text in a reactive expression since it is 
        # shared by the output$caption and output$mpgPlot expressions
        formulaText <- reactive({
                paste("len ~", input$variable)
        })
        
        selectedVar <- reactive({
                input$variable
        })
        
        fit <- reactive({
                lm(as.formula(formulaText()), data=tgData)
        })
        

        # Return the formula text for printing as a caption
        output$caption <- renderText({
                formulaText()
        })
        
        # Generate a plot of the requested variable against len and only 
        # include outliers if requested
        output$lenPlot <- renderPlot({
                boxplot(as.formula(formulaText()), 
                        data = tgData)
                
        })
        
        
        output$fit <- renderPrint({
                summary(fit())
        })
        
        output$lenRegPlot <- renderPlot({
                if(length(grep("\\*",formulaText())==1)){
                        g<-ggplot(tgData,aes(y=len,x=dose,colour=supp))
                        g<-g+geom_point(colour="grey50",size=5) + geom_smooth(method=lm,see=FALSE,colour="black") + geom_point(size=4)
                        g
                        
                }
                else{        
                        with(tgData, {
                                plot(as.formula(formulaText()))
                                abline(fit(), col=2,lwd=3)
                        })
                }
        })
        
        output$lenResPlot <- renderPlot({
                with(tgData, {
                        par(mfrow=c(2,2))
                        plot(fit())
                })
        })
        

                
})

