#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram


shinyUI(fluidPage(
  useShinyjs(),
  
  # Application title
  titlePanel("Sakthi Harish Thennarasu"),
  theme = shinytheme("flatly"),
  
  sidebarPanel(width = 2 ,
               conditionalPanel(
                 condition="input.tabselected==1",
                 radioButtons("choice","Choose a summary style", choices=c("DataFrame Summary" = 11, "Summary" = 12,"Glimpse" = 13 ))
               ),
               conditionalPanel(
                 condition="input.tabselected==2",
                 checkboxGroupInput("show_vars", "Columns in dataset to show:",
                                    names(dat), selected = names(dat))
               ) ,
               conditionalPanel(
                 condition="input.tabselected==3",
                 checkboxInput(inputId = "abs2", label = "Uses absolute correlation", value = FALSE),
                 selectInput(inputId = "CorrMeth2", label = "Correlation method", choices = c("pearson","spearman","kendall"), selected = "pearson"),
                 selectInput(inputId = "Group2", label = "Grouping method", choices = list("none"=FALSE,"OLO"="OLO","GW"="GW","HC"="HC"), selected = "GW")
                 
               ),
               conditionalPanel(
                 condition="input.tabselected==4",
                 selectInput(inputId = "CorrMeth3", label = "Correlation method", choices = c("pearson","spearman","kendall"), selected = "pearson")
               ),
               conditionalPanel(
                 condition="input.tabselected==5",
                 checkboxInput(inputId = "standardise", label = "Show standardized", value = TRUE),
                 sliderInput(inputId = "range", label = "IQR Multiplier", min = 0, max = 5, step = 0.1, value = 2.8)
                 
               ),
               conditionalPanel(
                 condition="input.tabselected==6",
                 selectizeInput(inputId = "VariablesA", label = "Show variables:", choices = mosaicVariables, multiple = TRUE, selected = c("Priority","Price","Duration","State"), options = list(maxItems=4))
                 
               ),
               conditionalPanel(
                 condition="input.tabselected==7",
                 selectizeInput(inputId = "VariablesB", label = "Show variables:", choices = risingValueVariables, multiple = TRUE, selected = c("sensor3","sensor4","sensor7","sensor13","sensor17","sensor22","sensor24","sensor27"), options = list(maxItems=10))
                 
               ),
               conditionalPanel(
                 condition="input.tabselected==8",
                 selectizeInput(inputId = "VariablesC", label = "Show variables: (Only applies to Missing data Plot)", choices = missingValueVariables, multiple = TRUE, 
                                selected = missingValueVariables),  
                 checkboxInput(inputId = "cluster", label = "Cluster missingness", value = FALSE)
               )
  ),
  mainPanel(
    tabPanel(h3("Exploratory Data Analysis"),
    tabsetPanel(
      id = "tabselected",
      tabPanel("Data Summary",value=1,conditionalPanel(condition="input.choice==11", withSpinner(htmlOutput(outputId = "dfSummary"))),
               conditionalPanel(condition="input.choice==12", withSpinner(verbatimTextOutput(outputId = "dSummary"))),
               conditionalPanel(condition="input.choice==13",  withSpinner(verbatimTextOutput(outputId = "gSummary")))
               
      ),
      tabPanel("Data Table",value=2,
               withSpinner(
                 dataTableOutput(outputId = "datatable"))
      ),
      
      tabPanel("Correlation Plot", value=3,
               withSpinner(
                 plotOutput(outputId = "corplot")
               )),
      tabPanel("Pairs plot",value=4,
               withSpinner(
                 plotOutput(outputId = "pairsPlot1")
               ),
               hr(),
               withSpinner(
                 plotOutput(outputId = "pairsPlot2")
               ),
               hr(),
               withSpinner(
                 plotOutput(outputId = "pairsPlot3")
               ),
               hr(),
               withSpinner(
                 plotOutput(outputId = "pairsPlot4")
               )
      ),
      tabPanel("Box Plot", value=5,
               withSpinner(
                 plotOutput(outputId = "boxPlot"))
      ),
      
      tabPanel("Mosaic Plot",value=6,
               withSpinner(plotOutput(outputId = "mosaicPlot"))
      ),
      tabPanel("Rising value Plot",value=7,
               withSpinner(
                 plotOutput(outputId = "risingValuePlot")
               )
      ),
      tabPanel("Missing value Plot",value=8,
               withSpinner(
                 plotOutput(outputId = "MissingValuePlot")),
               hr(),
               withSpinner(
                 plotOutput(outputId = "MissingValuePlot2"))
      )
      
    ),
    tabPanel(h3("Missing Data Analysis"))
    )
    
  )
  
)
)

