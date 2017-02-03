
library(shiny)
library(Oscope)
library(gplots)
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  pcaPlotData <- reactive({
    if(input$subgroups == 1) { 
      a = seq(0, 1,length.out = input$NumCells+1)[-1]
      
      phase =  seq(0, input$phaseShifts * pi, input$phaseShifts * pi/input$NumGenesOSC)[1:input$NumGenesOSC]  #phase = rep(0,100)
      sinNoisec1 = NULL
      for(k in 1:length(phase)) {
        
        sinNoisec1 = rbind( sinNoisec1, c( sin(2 * pi * input$freqOSC * a + phase[k] ) ) + rnorm(input$NumCells, 0, input$varOSC))
      }
      for(k in 1:input$NumGenesNOISE) {
        
        sinNoisec1 = rbind( sinNoisec1, rnorm(input$NumCells, 0, input$varNOISE))
      }
      sinNoisec1 <- NormForSine(sinNoisec1)
      }
    
    if(input$subgroups == 2) {  
      a = seq(0, 1,length.out = input$NumCells2+1)[-1]
      
      phase =  seq(input$phaseShifts1[1] * pi, input$phaseShifts1[2] * pi, length = input$NumGenesOSC1)  #phase = rep(0,100)
      sinNoisec1 = NULL
      for(k in 1:length(phase)) {
        
        sinNoisec1 = rbind( sinNoisec1, c( sin(2 * pi * input$freqOSC1 * a + phase[k] ) ) + rnorm(input$NumCells2, 0, input$varOSC1))
      }
      phase =  seq(input$phaseShifts2[1] * pi, input$phaseShifts2[2] * pi, length = input$NumGenesOSC2)  #phase = rep(0,100)
      for(k in 1:length(phase)) {
        
        sinNoisec1 = rbind( sinNoisec1, c( sin(2 * pi * input$freqOSC2 * a + phase[k] ) ) + rnorm(input$NumCells2, 0, input$varOSC2))
      }
      for(k in 1:input$NumGenesNOISE2) {
        
        sinNoisec1 = rbind( sinNoisec1, rnorm(input$NumCells2, 0, input$varNOISE2))
      }
      sinNoisec1 <- NormForSine(sinNoisec1)
      
    }
    
    List = sinNoisec1
  })
  
  
  
  output$distPlot1 <- renderPlot({
    
    sinNoisec1=pcaPlotData()
    pp <- prcomp(sinNoisec1, center=T, scale=T)
    par(mar=c(5,5,1,1))
    col.conds <- c(rep("red", input$NumGenesOSC), rep("black", input$NumGenesNOISE))
    plot(pp$x[,1], pp$x[,2], xlab="PC1", ylab="PC2", pch=16, cex.lab=1.5, cex.axis=1.5, col=col.conds)
    box(lwd=2)
    })

  output$heatCor1 <- renderPlot({
    sinNoisec1=pcaPlotData()
    cor.mat <- cor(t(sinNoisec1))
    my_palette <- bluered(100)
    heatmap.2(cor.mat,  # same data set for cell labels
              main = "Gene correlations", # heat map title
              notecol="black",      # change font color of cell labels to black
              density.info="none",  # turns off density plot inside color legend
              trace="none",         # turns off trace lines inside the heat map
              col=my_palette,       # use on color palette defined earlier
              # breaks=col_breaks,
              margins =c(7,7),   # enable color transition at specified limits
              dendrogram="none",     # only draw a row dendrogram
              Colv="none", Rowv="none", scale='none')
    })
  
  output$scatterGenes1 <- renderPlot({
    sinNoisec1=pcaPlotData()
      (plot(sinNoisec1[1,], pch=16, main='One gene', xlab="Cell", ylab="Expression"))
  })




  output$distPlot2 <- renderPlot({

    sinNoisec1=pcaPlotData()
      pp <- prcomp(sinNoisec1, center=T, scale=T)
      par(mar=c(5,5,1,1))
      col.conds <- c(rep("red", input$NumGenesOSC1), rep("blue", input$NumGenesOSC2), rep("black", input$NumGenesNOISE))
      plot(pp$x[,1], pp$x[,2], xlab="PC1", ylab="PC2", pch=16, cex.lab=1.5, cex.axis=1.5, col=col.conds)
      box(lwd=2)
    })

  output$heatCor2 <- renderPlot({
    sinNoisec1=pcaPlotData()
       cor.mat <- cor(t(sinNoisec1))
       my_palette <- bluered(100)
    heatmap.2(cor.mat,  # same data set for cell labels
              main = "Gene correlations", # heat map title
              notecol="black",      # change font color of cell labels to black
              density.info="none",  # turns off density plot inside color legend
              trace="none",         # turns off trace lines inside the heat map
              col=my_palette,       # use on color palette defined earlier
              # breaks=col_breaks,
              margins =c(7,7),   # enable color transition at specified limits
              dendrogram="none",     # only draw a row dendrogram
              Colv="none", Rowv="none", scale='none')
})
  
  
  
  output$scatterGenes2 <- renderPlot({
    sinNoisec1=pcaPlotData()
    (plot(sinNoisec1[1,], pch=16, main="Group 1 gene", xlab="Cell", ylab="Expression"))

  })
  
  output$scatterGenes22 <- renderPlot({
    sinNoisec1=pcaPlotData()
    (plot(sinNoisec1[input$NumGenesOSC1 + 1,], pch=16, main="Group 2 gene", xlab="Cell", ylab="Expression"))
    
  })
  

  

  ellipseData <- reactive({
    a = seq(0, 1,length.out = input$NumCells3+1)[-1]
    
    sinNoisec1 = NULL
    
    sinNoisec1 = rbind( sinNoisec1, c( sin(2 * pi * input$freqOSC3 * a + input$phaseShifts3 ) ) + rnorm(input$NumCells3, 0, input$varOSC3))
    sinNoisec1 = rbind( sinNoisec1, c( sin(2 * pi * input$freqOSC4 * a + input$phaseShifts4 ) ) + rnorm(input$NumCells3, 0, input$varOSC4))
    
    sinNoisec1 <- NormForSine(sinNoisec1)
    
    List = sinNoisec1
  })
  
  output$ellipsePlot<- renderPlot({
    sinNoisec1 = ellipseData()
    (plot(sinNoisec1[1,],sinNoisec1[2,], pch=16, main="", xlab="Gene 1", ylab="Gene 2"))
    
  })
  
  output$ellipsePlot<- renderPlot({
    sinNoisec1 = ellipseData()
    
    (plot(sinNoisec1[1,], sinNoisec1[2,], pch=16, main="", xlab="Gene 1", ylab="Gene 2"))
  
    
  })
  
  
  output$geneP1<- renderPlot({
    sinNoisec1 = ellipseData()
    (plot(sinNoisec1[1,], pch=16, main="Gene 1", xlab="Cell", ylab="Expression"))
    
    
  })
  
  
  output$geneP2<- renderPlot({
    
    sinNoisec1 = ellipseData()
    (plot(sinNoisec1[2,], pch=16, main="Gene 2", xlab="Cell", ylab="Expression"))
    
    
  })
  
})