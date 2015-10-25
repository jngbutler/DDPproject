SBlocationsState <- function(s) {
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
  results <- mydata[which(mydata$Country.Subdivision==s),c(1,7,8)]
  m = leaflet() %>% addTiles() %>% 
    setView(results[1,3],results[1,2],zoom = 18)
  m %>% addMarkers(results[,3],results[,2],popup = results[,1])  %>% 
    fitBounds(min(results[,3]), min(results[,2]), max(results[,3]), max(results[,2]))
}

