view(EMDAT)
library(purrr)
library(dplyr)

EQrecord<- list(
  data.frame(Entity=c("Afghanistan","Albania","Algeria"),
             death_eq=c(201,120,1250)),
  data.frame(Entity=c("American Samoa","Chile","China"), 
             death_eq=c(34,20000,1800))
)
  
Major_Death<- 200
Major_EQ<- map(EQrecord, ~ filter(.x, death_eq >= Major_Death))
Major_EQ
Combined_Deatheq <- reduce(Major_EQ, bind_rows)
Combined_Deatheq

Afghanplot <- EMDAT %>%
  dplyr::filter(Entity == "Afghanistan") %>%
  ggplot(aes(x=Year, y=deaths_earthquake))+
  geom_point()+
  labs(title = "Earthquate death in Afghanistan",
       y="death count")
print(Afghanplot)

disaster_plot <- function(data, entity_name) {
  entity_data <- data %>%
    filter(Entity == entity_name)
  plot <- entity_data %>%
    ggplot(aes(x = Year, y = total_affected_all_disasters)) +
    geom_point() +
    labs(title = paste("All Disasters in", entity_name),
         y = "Damage Level")
  return(plot)
}

Afgplot <- disaster_plot(EMDAT, "Afghanistan")
Albaniaplot <- disaster_plot(EMDAT, "Albania")
Algeriaplot <- disaster_plot(EMDAT, "Algeria")
Samoaplot <- disaster_plot(EMDAT, "American Samoa")
Chileplot <- disaster_plot(EMDAT, "Chile")
Chinaplot <- disaster_plot(EMDAT, "China")

library(gridExtra)
Allplots <- gridExtra::grid.arrange(Afghanplot, Albaniaplot, Algeriaplot, Samoaplot, Chileplot, Chinaplot, ncol = 3) 
