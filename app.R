# See how to use a button to update  the state behind the output
# Created on: 31/03/2021
#WS

# Title     :Mess about with Shiny Environment
# Objective : TODO
# Created by: WRStewart
# Created on: 25/03/2021
require("shiny")
library(shiny)

# How do to stuff when a button is pressed.



ui <- pageWithSidebar(


  headerPanel("Buttons"),

  sidebarPanel(
    br(),

    actionButton("but1","Button1"),

    sliderInput('nSlider',"n",5,1000,50)



  ),


  mainPanel(

    verbatimTextOutput('but1Text'),

    verbatimTextOutput('sliderVal'),

    plotOutput('plot1',400,400)
  )

)
#--------------------------------------------------------------------



server <- function(input, output) {

 gl1 <- reactiveValues(counter = 0L,counter2 = 100L)
  # or
  gl2 <- reactiveValues(counter = 0L)
  gl3 <- reactiveValues(counter = 0L)

  # seems i can use a function call to tidy up all responses to the button press
  serviceBut1 <- function()  {
     gl1$counter <- gl1$counter +10
    gl2$counter <- gl2$counter +1000000

  }


   # demonstrate you can  have several statements in the response.
  #observeEvent(input$but1, {gl1$counter <- gl1$counter +1L;gl2$counter <- gl2$counter +2L;gl1$counter2 <- gl1$counter2 +100})
  # and that you can have several observeEvents.
  observeEvent(input$but1, {gl3$counter <- gl3$counter +3L})

  observeEvent(input$but1, {serviceBut1()})


  #ntext<- eventReactive(input$but1,{gl1 <- gl1 +1})

output$but1Text <- renderText(

if (input$but1 > 0) {   return(paste(gl1$counter,gl2$counter,gl3$counter,gl1$counter2))   }   else return("init")

)

output$sliderVal <- renderText(paste(input$nSlider))

  # The bottom line is put the code for output into output - use functions if necessary!

output$plot1 <- renderPlot( hist(rnorm(input$nSlider))

  # plot(
   # table(

    # {replicate (input$nSlider, sum (sample(1:6,12,replace= TRUE) == 1  )  );}

        # )
     # )
)


#gl5 <- reactiveValues(n =60L)

#  observeEvent(input$nSlider, {gl5$n <- input$nSlider} )

#observeEvent(input$nSilder,{

# scores <-replicate (gl5$n, sum (sample(1:6,12,replace= TRUE) == 1  )  );
#t <- table(scores);
#output$plot1 <- renderPlot(plot(t))

#})




}


shinyApp(ui,server)
