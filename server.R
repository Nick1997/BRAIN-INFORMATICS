library(shiny)
library(neuralnet)

shinyServer(
  function(input, output){
    
    data=reactive({
      file1=input$file
      if(is.null(file1))
      {
        return()
      }
      read.table(file=file1$datapath, sep=input$sep, header=input$header, stringsAsFactors = input$stringsasfactors)
      })
    
    
    output$filedf <- renderText({
      "Using Artificial Neural Networks to predict the workload (stress levels) of individuals, given their 14-channel EEG values. The training dataset contains EEG values of 30 individuals, along with their Workload level. Based on this training dataset, I train a Artficial Neural Network using Resilient Back Propogation. This ANN can then be fed with EEG values and it will output the workload: Base Level(BL)/Low Workload(LWL)/High Workload(HWL)"
    })
    
    output$ann=renderTable({
      file2=data()
      file2=data.frame(file2)
      x=subset(file2, select= -c(BL, LWL, HWL))
      BL = file2$BL
      LWL= file2$LWL
      HWL= file2$HWL
      y= data.frame(BL, LWL, HWL)
      
      c1 = as.numeric(input$c1)
      c2 = as.numeric(input$c2)
      c3 = as.numeric(input$c3)
      c4 = as.numeric(input$c4)
      c5 = as.numeric(input$c5)
      c6 = as.numeric(input$c6)
      c7 = as.numeric(input$c7)
      c8 = as.numeric(input$c8)
      c9 = as.numeric(input$c9)
      c10= as.numeric(input$c10)
      c11 = as.numeric(input$c11)
      c12 = as.numeric(input$c12)
      c13 = as.numeric(input$c13)
      c14 = as.numeric(input$c14)
      
      c = data.frame(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14)
      
      net=neuralnet(BL+LWL+HWL~AF3+F7+F3+FC5+T7+P7+O1+O2+P8+T8+FC6+F4+F8+AF4, file2, hidden=8, rep=10, algorithm = "rprop+",err.fct="ce", linear.output=FALSE)
      
      j= compute(net, c)$net.result
      
      Base_Load= j[1,1]
      Low_Work_Load= j[1,2]
      High_Work_Load= j[1,3]
      
      result= data.frame(Base_Load, Low_Work_Load, High_Work_Load)
    })
    
    
    output$plotann= renderPlot({
      file2 <- data()
      file2 <- data.frame(file2)
      
      x <- subset(file2, select = -c(BL, LWL, HWL))
      
      BL <- file2$BL
      LWL <- file2$LWL
      HWL <- file2$HWL
      
      y <- data.frame(BL, LWL, HWL)
      
      c1 <- as.numeric(input$c1)
      c2 <- as.numeric(input$c2)
      c3 <- as.numeric(input$c3)
      c4 <- as.numeric(input$c4)
      c5 <- as.numeric(input$c5)
      c6 <- as.numeric(input$c6)
      c7 <- as.numeric(input$c7)
      c8 <- as.numeric(input$c8)
      c9 <- as.numeric(input$c9)
      c10 <- as.numeric(input$c10)
      c11 <- as.numeric(input$c11)
      c12 <- as.numeric(input$c12)
      c13 <- as.numeric(input$c13)
      c14 <- as.numeric(input$c14)
      c <- data.frame(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14)
      
      net <- neuralnet(BL+LWL+HWL~AF3+F7+F3+FC5+T7+P7+O1+O2+P8+T8+FC6+F4+F8+AF4, file2, hidden=8, rep=10, algorithm = "rprop+",err.fct="ce", linear.output=FALSE)
      
      plot(net, rep = "best")
      
    })
    
    output$sample <- renderTable({
      c1 <- as.numeric(input$c1)
      c2 <- as.numeric(input$c2)
      c3 <- as.numeric(input$c3)
      c4 <- as.numeric(input$c4)
      c5 <- as.numeric(input$c5)
      c6 <- as.numeric(input$c6)
      c7 <- as.numeric(input$c7)
      c8 <- as.numeric(input$c8)
      c9 <- as.numeric(input$c9)
      c10 <- as.numeric(input$c10)
      c11 <- as.numeric(input$c11)
      c12 <- as.numeric(input$c12)
      c13 <- as.numeric(input$c13)
      c14 <- as.numeric(input$c14)
      c <- data.frame(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14)
      
    })
    
    
    output$table <- renderTable({
      if(is.null(data())){ 
        return() 
        }
      data()  
    })
    
    output$tb=renderUI({
     # if(is.null(data()))
      #  h5(tags$img(src="brain.png"), height=150, width=300)
      #else
    #  {
        tabsetPanel(
          tabPanel("About the Project", verbatimTextOutput("filedf")),
          tabPanel("Artificial Neural Network", plotOutput("plotann"), tableOutput("sample"), tableOutput("ann"),tableOutput("table"))
        )
      #}
    })
    
    
  }
)