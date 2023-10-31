library(tidyverse)
library(ggplot2)
EMDAT
data_1<-EMDAT
data_list<- list(
  data.frame(Entity=c("China","Haiti","Indonesia"),
             EarthquakeDeaths=c(242000,225700,165816)),
  data.frame(Entity=c("Italy","Pakistan","Peru"),
             EarthquakeDeaths=c(75000,73338,66835))
)
EarthquakeDeaths_threshold<- 70000
filtered_data<- map(data_list, ~ filter(.x, EarthquakeDeaths >= EarthquakeDeaths_threshold))
filtered_data
combined_data <- reduce(filtered_data, bind_rows)
combined_data

library(skimr)
data_1$Entity

data.China<-data_1%>%
  dplyr::filter(Entity == "China") 
data.China
data.Haiti<-data_1%>%
  dplyr::filter(Entity =="Haiti")
data.Italy<-data_1%>%
  dplyr::filter(Entity =="Italy")
data.Indonesia<-data_1%>%
  dplyr::filter(Entity =="Indonesia")
data.Pakistan<-data_1%>%
  dplyr::filter(Entity =="Pakistan")
data("data.China")
plot.China<-data.China%>%
  ggplot(aes(x=Year, y=total_affected_all_disasters))+
  geom_point()+
  labs(title = "China affected by all disasters",
       y="damages intensity")
plot.Haiti<-data.Haiti%>%
  ggplot(aes(x=Year, y=total_affected_all_disasters))+
  geom_point()+
  labs(title = "Haiti affected by all disasters",
       y="damages intensity")
plot.Italy<-data.Italy%>%
  ggplot(aes(x=Year, y=total_affected_all_disasters))+
  geom_point()+
  labs(title = "Italy affected by all disasters",
       y="damages intensity")
plot.Indonesia<-data.Indonesia%>%
  ggplot(aes(x=Year, y=total_affected_all_disasters))+
  geom_point()+
  labs(title = "Indonesia affected by all disasters",
       y="damages intensity")
plot.Pakistan<-data.Pakistan%>%
  ggplot(aes(x=Year, y=total_affected_all_disasters))+
  geom_point()+ 
  labs(title = "Pakistan affected by all disasters",
       y="damages intensity")
plots_grid <- gridExtra::grid.arrange(plot.China,plot.Haiti,plot.Italy,plot.Indonesia,plot.Pakistan, ncol = 2) 

