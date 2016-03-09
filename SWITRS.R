library(dplyr)
library(ggplot2)
library(leaflet)

switrs_all <- read.csv("Collisions.csv")

switrs <- subset(switrs_all, POINT_X!=0 & POINT_Y!=0)


switrs$date <- as.Date(as.character(switrs$COLLISION_DATE), "%Y%m%d")

#map all data from 2013-2014
leaflet() %>% addTiles() %>%
  addCircleMarkers(data=switrs, lng=switrs$POINT_X, lat=switrs$POINT_Y,
                   clusterOptions = markerClusterOptions(spiderfyDistanceMultiplier=2, maxClusterRadius=60))

#day of week
datevalues <-tapply(switrs$CASE_ID, switrs$date, length) %>% as.data.frame()

datevalues$date <- as.Date(row.names(datevalues))

ggplot( data = datevalues, aes( date, datevalues )) +
        theme_minimal() +
        #geom_point(alpha=0.2) +
        #geom_line(alpha=0.3, size=.2) +
        geom_bar(stat="identity", alpha=0.3) +
        stat_smooth(size=2) +
        labs(x=NULL, y=NULL, title="Crimes by Date")