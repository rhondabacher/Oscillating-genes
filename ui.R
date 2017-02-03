library(shiny)
library(shinyFiles)
# options(shiny.maxRequestSize=500*1024^2) 
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Oscillating genes!"),
  # Application title
  headerPanel("What do you want to do?"),
  
  checkboxInput("pca", "PCA with oscillating genes ?"),
  checkboxInput("ellipse", "Compare two oscillating genes?"),
  
  conditionalPanel(width=20,height=10,  
    condition = "input.pca == true",
    
    selectInput("subgroups", "How many groups of oscillating genes?",
              c("",One = "1", Two = "2"),selected = NULL),
  
    conditionalPanel(width=20,height=10,  
    condition = "input.subgroups == 1",            
      column(width=4,
        sliderInput("NumCells",
                    "Number of Cells:",
                    min = 5,
                    max = 200,
                    value = 100),

      sliderInput("NumGenesOSC",
                  "Number of oscillating genes:",
                  min = 5,
                  max = 200,
                  value = 10),

      sliderInput("NumGenesNOISE",
                  "Number of noise genes:",
                  min = 0,
                  max = 200,
                  value = 10),
      # column(width=4,
      # ## Do you want the phase shifts to go all the way around? 
      # ## Do you 
      sliderInput("phaseShifts",
                  "How far should the phase shift go ?",
                  min = .1,
                  max = 2,
                  value = 2,
                  round=FALSE),
      # 
      sliderInput("varOSC",
                  "How much noise should be in the oscillating genes ?",
                  min = 0,
                  max = 1,
                  value = .05),
      sliderInput("varNOISE",
                  "How much noise should be in the noise genes ?",
                  min = 0,
                  max = 1,
                  value = .05),
      sliderInput("freqOSC",
                  "What should the frequency be?:",
                  min = .1,
                  max = 5,
                  value = 1))
    ,
    column(7,
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("PCA plot", plotOutput("distPlot1")),
        tabPanel("Gene Correlation plot", plotOutput("heatCor1")),
        tabPanel("Example gene plot", plotOutput("scatterGenes1")))
    ))),
    
    
    
    
    
    
conditionalPanel(width=20,height=10,  
 condition = "input.subgroups == 2",            
 column(width=4,
        sliderInput("NumCells2",
                    "Number of Cells:",
                    min = 5,
                    max = 200,
                    value = 100),
        
        sliderInput("NumGenesOSC1",
                    "Number of oscillating genes in group 1:",
                    min = 5,
                    max = 200,
                    value = 10),
        sliderInput("NumGenesOSC2",
                    "Number of oscillating genes in group 2:",
                    min = 5,
                    max = 200,
                    value = 10),
        sliderInput("NumGenesNOISE2",
                    "Number of noise genes:",
                    min = 0,
                    max = 200,
                    value = 10),

        sliderInput("phaseShifts1",
                    "How far sould the phase shift go in group 1?:",
                    min = .1,
                    max = 2,
                    value = c(1,2),
                    round=FALSE),
        sliderInput("phaseShifts2",
                    "How far sould the phase shift go in group 2?:",
                    min = .1,
                    max = 2,
                    value = c(.1,.8),
                    round=FALSE),
  
        sliderInput("varOSC1",
                    "How much noise should be in the oscillating genes in group 1 ?:",
                    min = 0,
                    max = 1,
                    value = .05),
        sliderInput("varOSC2",
                    "How much noise should be in the oscillating genes in group 2 ?:",
                    min = 0,
                    max = 1,
                    value = .05),
        sliderInput("varNOISE2",
                    "How much noise should be in the noise genes ?:",
                    min = 0,
                    max = 1,
                    value = .05),
        sliderInput("freqOSC1",
                    "What should the frequency be in group 1 ?:",
                    min = .1,
                    max = 5,
                    value = 1),
        sliderInput("freqOSC2",
                    "What should the frequency be in group 2 ?:",
                    min = .1,
                    max = 5,
                    value = 1)),
        column(7,
               # Show a plot of the generated distribution
               mainPanel(
                 tabsetPanel(
                   tabPanel("PCA plot", plotOutput("distPlot2")),
                   tabPanel("Gene Correlation plot", plotOutput("heatCor2")),
                   tabPanel("Gene Scatter plots", plotOutput("scatterGenes2")))
               ))
 )),

conditionalPanel(width=20,height=10,  
                 condition = "input.ellipse == true",

                 column(width=4,
                        sliderInput("NumCells3",
                                    "Number of Cells:",
                                    min = 5,
                                    max = 200,
                                    value = 100),
                        sliderInput("phaseShifts3",
                                    "Phase shift in gene 1?:",
                                    min = .1,
                                    max = 2,
                                    value = c(1),
                                    round=FALSE),
                        sliderInput("phaseShifts4",
                                    "Phase shift in gene 2?:",
                                    min = .1,
                                    max = 2,
                                    value = c(.8),
                                    round=FALSE),
                        
                        sliderInput("varOSC3",
                                    "How much noise should be in gene 1 ?:",
                                    min = 0,
                                    max = 1,
                                    value = .05),
                        sliderInput("varOSC4",
                                    "How much noise should be in gene 2 ?:",
                                    min = 0,
                                    max = 1,
                                    value = .05),
                      
                        sliderInput("freqOSC3",
                                    "What should the frequency be for gene 1 ?:",
                                    min = .1,
                                    max = 5,
                                    value = 1),
                        sliderInput("freqOSC4",
                                    "What should the frequency be for gene 2 ?:",
                                    min = .1,
                                    max = 5,
                                    value = 1)),
                 
                 

                 
                 column(7,
                        # Show a plot of the generated distribution
                        mainPanel(
                          tabsetPanel(
                            tabPanel("Gene vs. Gene plot", plotOutput("ellipsePlot")),
                            tabPanel("Gene 1 plot", plotOutput("geneP1")),
                            tabPanel("Gene 2 plot", plotOutput("geneP2")))))


)
))
  