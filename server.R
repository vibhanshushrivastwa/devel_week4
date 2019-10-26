library(shiny)
shinyServer(function(input, output) {
    trees$Girthsp <- ifelse(trees$Girth - 13 > 0, trees$Girth - 13, 0)
    model1 <- lm(Volume ~ Girth, data = trees)
    model2 <- lm(Volume ~ Girthsp + Girth, data = trees)
    
    model1pred <- reactive({
        GirthInput <- input$sliderGirth
        predict(model1, newdata = data.frame(Girth = GirthInput))
    })
    
    model2pred <- reactive({
        GirthInput <- input$sliderGirth
        predict(model2, newdata = 
                    data.frame(Girth = GirthInput,
                               Girthsp = ifelse(GirthInput - 13 > 0,
                                                GirthInput - 13, 0)))
    })
    
    output$plot1 <- renderPlot({
        GirthInput <- input$sliderGirth
        
        xlabel <- ifelse(input$show_xLabel, "Tree Diameter in Inches (Girth)", "")
        ylabel <- ifelse(input$show_yLabel, "Volume of Timber in Cubic ft", "")
        main <- ifelse(input$show_Title, "Girth and Volume for Black Cherry Trees", "")
        
        plot(trees$Girth, trees$Volume, xlab = xlabel, ylab = ylabel, bty = "n", pch = 16,
             xlim = c(5, 25), ylim = c(10, 80), main = main)
        
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
        }
        
        if(input$showModel2){
            model2lines <- predict(model2, newdata = data.frame(
                Girth = 8:21, Girthsp = ifelse(8:21 - 13 > 0, 8:21 - 13, 0)
            ))
            lines(8:21, model2lines, col = "blue", lwd = 2)
        }
        
        legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
               col = c("red", "blue"), bty = "n", cex = 1.2)
        
        points(GirthInput, model1pred(), col = "red", pch = 16, cex = 2)
        
        points(GirthInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
})