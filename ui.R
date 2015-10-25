
library(shiny)
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

shinyUI <- fluidPage(
  headerPanel('Where Can I Find a Starbucks Coffeehouse?'),
  sidebarPanel(
    img(src="starbucks.jpg", height="100px"),
    br(),
    br(),
    radioButtons('zip_vs_state','Select locator method',c('By Zip Code','By State')),
    conditionalPanel(condition = 'input.zip_vs_state=="By Zip Code"',
                     textInput('zip','Enter a 5-digit zip code',value=11372),
                     sliderInput('radius','Choose radius in miles',value=1,min=0,max=10,step=0.5)),
    conditionalPanel(condition = 'input.zip_vs_state=="By State"',
                     selectInput("state","Select State", choices=levels(mydata$Country.Subdivision),selected=levels(mydata$Country.Subdivision)[1]))
  ),
  mainPanel(
    tags$style(type="text/css",
               ".shiny-output-error { visibility: hidden; }",
               ".shiny-output-error:before { visibility: hidden; }"
    ),
    tabsetPanel(
      tabPanel("Documentation",
              h3("How to use this app"),
              p("This app was designed to help you locate one or more of the 12,803 Starbucks coffeehouses within the United States."), 
              h4("Searching By Zip Code and Radius"),
              p("(1) Click on the radio button By Zip Code."), 
              p("(2) Enter a 5-digit US Zip Code in the numeric textbox. Example Zip Codes: 90210 for Beverly Hills, 
                or 89109 for Las Vegas, or 10005 for lower Manhattan in New York"),
              p("(3) Then use the slider to enter the distance of your search radius in miles."),
              h4("Searching By Name of the State"),
              p("(1) Click on the radio button By State.  This will in turn display a drop down State selector."), 
              p("(2) Click on the drop down to select the name of the State."),
              h4("Viewing the Map"),
              p(" * Go to the tab labeled Map. Please be patient; it may take the map a few seconds to render."),
              p(" * Click on the blue map marker to see store detail."),
              p(" * Use the + and - buttons (if you are on a touch screen device you can pinch/stretch) to zoom in or zoom out on the map. Note that using the map zoom will not re-do your search."),
              p(" * To search again, go back to the side panel to change your selections."),
              h4("Notes"),
              h5("Starbucks and the Starbucks logo are registered trademarks of ", 
              a(href = "http://www.starbucks.com/", "Starbucks")),
              h5("Special thanks for this dataset goes to the folks at ",
              a(href = "https://opendata.socrata.com/Business/All-Starbucks-Locations-in-the-US/txu4-fsic", "OpenData by Socrata"))
      ),
      tabPanel("Map",
               h4(em("Please be patient. The map may take a few seconds to render.")),
               leafletOutput("mymap"))
      )
      
    )
)