# Oscillating genes


This shiny app does two different things to explore oscillating genes. The first is to simulate genes having phase shifts then perform PCA to identify those cycling genes. This can curently be done assuming all genes are similar but shifted. The other option is to have 2 gene groups where the groups might have different oscillation behavior. The second is to simulate two oscillating genes and see how an ellipse is formed.



## 1. Installation
To run, it requires the following packages: shiny, shinyFiles, Oscope

> install.packages("shiny")

> install.packages("shinyFiles")

> source("https://bioconductor.org/biocLite.R")

> biocLite("Oscope")


### Run the app
To launch WaveCrest GUI, in R run:
> library(shiny)
> runGitHub('rhondabacher/Oscillating-genes')

![Screenshot](https://github.com/rhondabacher/Oscillating-genes/blob/master/screenshot.png)
