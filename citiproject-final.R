################################
# Citi Project - Final Version #
# Author: JJ                   #
# Date: 9/18/2019              #
################################
####################
# Install Packages #
####################
install.packages("shiny")
install.packages("shinythemes")
install.packages("ggplot2")

#################
# Load Packages #
#################
library(shiny)
library(shinythemes)
library(ggplot2)

############################
# Create (Global) Data Set #
############################
set.seed(123)
ID <- c(1:10) 
Name <- c("JJ","Bonnie","Leo","Sean","Mark","Jasmine","Peter","Ann","Mary","Jack")
TotalLimit <- rep(5000,10)
Balance <- round(runif(10,min=0,max=5000),digits = 2)
AvailableLimit <- TotalLimit-Balance
MaxLimitIncrease <- signif((5000*3-Balance),digits = 3)
request <- rep(NA,10)
share = Balance / TotalLimit
rest = 1 - share

CustomerData <- data.frame(ID,Name,TotalLimit,Balance,AvailableLimit,MaxLimitIncrease,share,rest,request)

#############
# Shiny APP #
#############
shinyApp(
    
    # vvvvvvvvvvvvvv UI - Start vvvvvvvvvvvvvvv
    ui = fluidPage(
        
        theme=shinytheme("cerulean"),
        
        tags$head(
            tags$style(type="text/css",
                       "button{display:width: 180px; display: flex;abtext-align: center; vertical-align: middle;}", 
                       "label{ width:250px;display: table-cell; text-align: center; vertical-align: middle;} .form-group { display: table-row;}", 
                       ".navbar-brand {width: 500px; font-size:35px; text-align:center;}")
        ),
        
        # Navigation bar
        navbarPage("My Account"),
        
        # Part 1 - Customer login box and info display, default: JJ
        div(
            div(style=" left:8%;position: absolute; inline-block;vertical-align:top;",textInput("variable", "Enter Your Name","JJ")),
            br(),
            div(style=" left:9%;position: absolute; inline-block;vertical-align:top; width:250px;display: table-cell; text-align: center; vertical-align: middle;", helpText("e.g: JJ,Leo, Sean,...")),
            br(),br(),br(),
            tableOutput("data") 
        ),
        
        # Donut chart for current customer
        div(style="position: relative;left:8%;display: flex; width: 400px;",plotOutput("pie")),
       
         hr(),
        
        # Part2 - "Limit Increase"
        titlePanel(title=div(img(src="pie_logo.png",height = 50, width = 50), "Limit Increase")),
        div(style=" left:8%;position: absolute; inline-block;vertical-align:top; width: 500px;",h3(
            paste("Maximum Increase Amount: ","       $",15000)
        )),
      
        
        # Fill out limit request
        br(),br(),br(),br(),
        div(style=" left:8%;position: absolute; inline-block;vertical-align:top; width: 500px;",numericInput(inputId="request_input", label = "Increase Limit To:", value = "" )),
      
          
        # Open new window after submit request
        uiOutput("newWindowContent", style = "display: none;"),
        tags$script(HTML("
      $(document).ready(function() {
        if(window.location.hash != '') {
          $('div:not(#newWindowContent)').hide();
          $('#newWindowContent').show();
          $('#newWindowContent').appendTo('body');
        }
      })
    ")),
        
        a(href = "#NEW", 
          target = "blank",
          div(style="display:width: 150px; display: flex; left:60%;position: absolute; inline-block;vertical-align:top; width: 150px;",
              actionButton("submit","SUBMIT", class = "btn-primary"
              ))
        )
    ),
    # ^^^^^^^^^^^^ UI - End ^^^^^^^^^^^^^^^^^
    
   # vvvvvvvvvvvv Server - Start vvvvvvvvvvvv
    server = function(input, output) {
        
        # Draw donut chat
        output$pie <- renderPlot({
            
            # Specify record from dataset
            i <- which(CustomerData$Name == c(input$variable))
            
            pieData <- data.frame("Total" = c("Balance","Available Limit"),
                                  "amount" = c(CustomerData$Balance[i],CustomerData$AvailableLimit[i]),
                                  "share" = c(CustomerData$share[i],CustomerData$rest[i]))
            
            # Coloring pie
            mycols <- c("#0073C2FF","#EFC000FF" )
            
            if (is.null(pieData$Total)) return()
            # Make the plot
            ggplot(pieData, aes(x = 2, y = share, fill = Total)) +
                geom_bar(stat = "identity", color = "white") +
                coord_polar(theta = "y", start = 0)+
                scale_fill_manual(values = mycols) +
                theme_void()+
                xlim(0.5, 2.5)+
                annotate(geom = 'text', x = 0.5, y = 0.5, label = paste0("Available Limit \n","$ ",pieData$amount[pieData$Total=='Available Limit']))
            
        })
        
        # Restrict request input, cannot be blank for submition
        observe({
            shinyjs::toggleState("submit", !is.null(input$request_input) && input$request_input != "")
        })
        
        
        
        # Open new window
        output$newWindowContent <- renderUI({
            div(style=" left:8%;position: absolute; inline-block;vertical-align:top; width: 500px;",h2("Your Request Submited Successfully!"))
        })
        
        
    }
   
   # ^^^^^^^^^^ End Server ^^^^^^^^^^^^^^^^
   
   )