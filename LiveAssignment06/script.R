library(tidyverse)
setwd("C:/Users/William/OneDrive/MSDS_6306_DoingDataScience/MSDS_6306_Homework/LiveAssignment6")
load("./dataFiles/N-MHSS-2015-DS0001-data/N-MHSS-2015-DS0001-data-r.rda")
names(mh2015_puf)
levels(mh2015_puf$LST)
exclude <- c("HI","PR","VI","GU","AK","AS","FM","MH","MP","PW")
mainland <- mh2015_puf %>% filter(!(str_squish(LST) %in% exclude))
state_counts <- as.data.frame(mainland %>% count(LST))
names(state_counts) <- c("State", "Count")
ggplot(state_counts, aes(x=reorder(State,Count), y=Count, fill=State)) + 
  geom_bar(stat="identity") + 
  coord_flip() + 
  theme(legend.position = "none",plot.title = element_text(hjust = 0.5),axis.title.y=element_text(angle=0,vjust=1)) +
  labs(x="State",y="Count of VA Centers",title = "Count of VA Centers by State")


statesize <- read_csv("./dataFiles/statesize.csv")
head(statesize)
paste(state_counts$State)

#dont know, presumably the spaces

state_counts$State <- str_squish(state_counts$State)
state_countandsize <- state_counts %>% left_join(statesize,by = c("State" = "Abbrev"))
state_countandsize[state_countandsize$State == "DC","StateName"] <- "District of Columbia"
state_countandsize[state_countandsize$State == "DC","SqMiles"] <- 68
state_countandsize[state_countandsize$State == "DC","Region"] <- "South" #Based on Region of MD and VA
head(state_countandsize)
state_countandsize <- state_countandsize %>% mutate(centersPer1000SqMiles = Count/SqMiles*1000)
head(state_countandsize,10)

ggplot(state_countandsize, aes(x=reorder(State,centersPer1000SqMiles), y=centersPer1000SqMiles, fill=Region)) + 
  geom_bar(stat="identity") + 
  theme(plot.title = element_text(hjust = 0.5),axis.title.y=element_text(angle=0,vjust=1)) +
  labs(x="State",y="VA Centers Per 1000 Sq Miles",title = "VA Centers Per 1000 Sq Miles by State") +
   coord_flip(ylim=c(0,100))
 
table(mh2015_puf$FACILITYTYPE)

looky <- combined %>% arrange(Brewery)

df <- data.frame( state = c("california","texas","nevada","north dakota", rep("NA", 47)),
                  freq = c(14717, 6842, 1090, 52, rep(0, 47)),
                  stringsAsFactors = FALSE )

library(maps)
library(ggthemes)
states_map <- map_data("state", region = c("california","texas","nevada","north dakota"))
new_map <- merge(states_map, df, by.x = "region", by.y = "state")
new_map <- arrange(new_map, group, order) # to sort polygons in right order

ggplot(new_map, aes(x = long, y = lat, group = group, fill = freq)) + 
  geom_polygon(color = "black") + 
  coord_map("polyconic") + theme_tufte() + labs(x = "", y = "")