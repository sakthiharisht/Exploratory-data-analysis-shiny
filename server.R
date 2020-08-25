#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  dat2 = dat[sample(nrow(dat), 300), ]
  
  output$datatable <- renderDataTable({
    
    datatable(data = dat2[,input$show_vars, drop=FALSE])
    
  })
  output$corplot <- renderPlot({
    
    corrgram(dat,
             order = input$Group2,
             abs = input$abs2,
             cor.method = input$CorrMeth2,
             text.panel = panel.txt,
             main = "Correlation of Given data")
    
    
    
  })
  output$pairsPlot1 <- renderPlot({
    if(input$CorrMeth3 =="pearson" )
    ggpairs(data = dat,columns = pearsonTopVariables1,  title = "Pairs plot 1 of Top Pearson variables")
    else if(input$CorrMeth3=="spearman")
      ggpairs(data = dat,columns = spearmanTopVariables1,  title = "Pairs plot 1 of Top Spearman variables ")
    else if(input$CorrMeth3=="kendall")
      ggpairs(data = dat,columns = kendallTopVariables1,  title = "Pairs plot 1 of Top Kendall variables ")
  })
  output$pairsPlot2 <- renderPlot({
    if(input$CorrMeth3 =="pearson" )
    ggpairs(data = dat,columns = pearsonTopVariables2,  title = "Pairs plot 2 of Top Pearson variables")
    else if(input$CorrMeth3=="spearman")
      ggpairs(data = dat,columns = spearmanTopVariables2,  title = "Pairs plot 2 of Top Spearman variables ")
    else if(input$CorrMeth3=="kendall")
      ggpairs(data = dat,columns = kendallTopVariables2,  title = "Pairs plot 2 of Top Kendall variables ")
    
  })
  output$pairsPlot3 <- renderPlot({
    if(input$CorrMeth3 =="pearson" )
    ggpairs(data = dat,columns = pearsonTopVariables3,  title = "Pairs plot 3 of Top Pearson variables ")
    else if(input$CorrMeth3=="spearman")
      ggpairs(data = dat,columns = spearmanTopVariables3,  title = "Pairs plot 3 of Top Spearman variables")
    else if(input$CorrMeth3=="kendall")
      ggpairs(data = dat,columns = kendallTopVariables3,  title = "Pairs plot 3 of Top Kendall variables ")
  })
  output$pairsPlot4 <- renderPlot({
    if(input$CorrMeth3 =="pearson" )
    ggpairs(data = dat,columns = pearsonTopVariables4,  title = "Pairs plot 4 of Top Pearson variables")
    else if(input$CorrMeth3=="spearman")
      ggpairs(data = dat,columns = spearmanTopVariables4,  title = "Pairs plot 4 of Top Spearman variables")
    else if(input$CorrMeth3=="kendall")
      ggpairs(data = dat,columns = kendallTopVariables4,  title = "Pairs plot 4 of Top Kendall variables ")
  })
  output$boxPlot <- renderPlot({
    data <- as.matrix(dat[cols])
    data <- scale(data, center = input$standardise, scale = input$standardise)
    Boxplot(data, use.cols = TRUE, notch = FALSE, varwidth = FALSE,
            horizontal = FALSE,
            col = brewer.pal(n = 11, name = "RdBu"),
            range = input$range, main = "Boxplots of given data",las=2)
  })
  
  output$mosaicPlot <- renderPlot({
    
    formula <- as.formula(paste("~",paste(input$VariablesA, collapse = " + ")))
    mosaic(formula, data = dat,
           main = "Mosaic of given data", shade = TRUE, legend = TRUE)
  })
  output$MissingValuePlot <- renderPlot({
      vis_dat(dat) + theme(axis.text.x = element_text(angle = 90))+ggtitle("Data Frame Visualization with missing data")
  })
  output$MissingValuePlot2 <-renderPlot(
    {
      missingdat <- dat[,colnames(dat) %in% input$VariablesC]
      vis_miss(missingdat,cluster = input$cluster, sort_miss = TRUE)+
        theme(axis.text.x = element_text(angle = 90))+ggtitle("Missing Data Plot")
    }
  )
  
  output$risingValuePlot <- renderPlot({
    d <- d[,colnames(d) %in% input$VariablesB]
    for (col in 1:ncol(d)) {
      d[,col] <- d[order(d[,col]),col] #sort each column in ascending order
    }
    d <- scale(x = d, center = TRUE, scale = TRUE)  # scale so they can be graphed with a shared Y axis
    mypalette <- rainbow(ncol(d))
    matplot(x = seq(1, 100, length.out = nrow(d)), y = d, type = "l", xlab = "Percentile", ylab = "Values", lty = 1, lwd = 1, col = mypalette, main = "Rising value chart")
    legend(legend = colnames(d), x = "topleft", y = "top", lty = 1, lwd = 1, col = mypalette, ncol = round(ncol(d)^0.3))
    
  }
  
  )
  
  output$dfSummary <- renderUI(
    {
      print(dfSummary(dat,varnumbers=TRUE, labels.col = TRUE, plain.ascii = FALSE, style = "grid", justify = "c", graph.magnif = 1),method = "render")
      
    }
  )
  
  output$dSummary <- renderPrint(
    {
      summary(dat)
      
    }
  )
  
  output$gSummary <- renderPrint(
    {
      glimpse(dat)
      
    }
  )
  
})

