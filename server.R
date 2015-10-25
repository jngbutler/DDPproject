library(shiny)
library(fields)
library(leaflet)

mydata <- read.csv("StarbucksLocationsCleaned.csv",colClasses = c("ZIP"="character"))
mydata <- mydata[,c(2,7,11,12,13,16,18,19)]
levels(mydata$Country.Subdivision) <- c("Alaska","Alabama","Arkansas","Arizona",
                                        "California","Colorado","Connecticut","District of Columbia","Delaware","Florida",
                                        "Georgia","Hawaii","Iowa","Idaho","Illinois","Indiana","Kansas","Kentucky","Lousiana",
                                        "Massachusetts","Maryland","Maine","Michigan","Minnesota","Missouri","Mississippi",
                                        "Montana","North Carolina","North Dakota","Nebraska","New Hampshire","New Jersey",
                                        "New Mexico","Nevada", "New York", "Ohio","Oklahoma","Oregon","Pennsylvania",
                                        "Rhode Island","South Carolina","South Dakota", "Tennessee","Texas","Utah","Virginia",
                                        "Vermont","Washington","Wisconsin","West Virginia","Wyoming")

shinyServer <- function(input,output,session){
  source("SBlocationsZip.R")
  source("SBlocationsState.R")
  output$mymap <- renderLeaflet({
    if (input$zip_vs_state == "By Zip Code") {
      
      SBlocationsZip(input$zip,input$radius)
    } else {
      SBlocationsState(input$state)
    }
  })
} 



