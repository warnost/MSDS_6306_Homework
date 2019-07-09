library(tidyverse)
library(rvest)
library(humaniformat)

url<-"https://www.imdb.com/title/tt1201607/fullcredits?ref_=tt_ql_1"

cast_list <- read_html(url) %>% html_nodes(.,"table") %>% html_table %>%.[[3]]

str(cast_list)

table(cast_list$X1)
table(cast_list$X3)

cast_list$X1 <- NULL
cast_list$X3 <- NULL

names(cast_list) <- c("Actor","Character")
str(cast_list)
head(cast_list)

cast_list_filtered <- cast_list %>% filter(Actor != "",Actor !="Rest of cast listed alphabetically:")
str(cast_list_filtered)
head(cast_list_filtered,10)

cast_list_filtered$Character <- str_squish(cast_list_filtered$Character)
head(cast_list_filtered,10)

no_accents <- stri_trans_general(cast_list_filtered$Actor,"Latin-ASCII")
parsed_names <- parse_names(no_accents)
head(parsed_names)
firstName <- ifelse(is.na(parsed_names$middle_name),
                    parsed_names$first_name,
                    paste(parsed_names$first_name,parsed_names$middle_name)
                    )
lastName <- parsed_names$last_name


cast_list_addNames <- cast_list_filtered %>% add_column(FirstName = firstName, Surname = lastName)
head(cast_list_addNames)

cast_list_final <- cast_list_addNames %>% select(FirstName, Surname, Character)
head(cast_list_final,10)



###ESPN
url <- "http://www.espn.com/nba/team/stats/_/name/sa/san-antonio-spurs"

site_html <- read_html(url)
table_nodes <- html_nodes(site_html,"table") 
html_tables <- html_table(table_nodes, fill = TRUE)
stats <- data.frame(html_tables[8])
players <- data.frame(html_tables[6])
names(players) <- "Player"
shooting_stats <- cbind(players,stats) %>% filter(Player != "Total")

shooting_stats$Name = word(shooting_stats$Player,1,-2)
shooting_stats$Position = word(shooting_stats$Player,-1,-1)
shooting_stats_final <- shooting_stats %>% select(Name,Position,2:14) %>% arrange(Position)
str(shooting_stats_final)


ggplot(shooting_stats_final,aes(x=reorder(Name,FG.), y=FG., fill=Position)) + 
  geom_bar(stat = "identity") + 
  coord_flip() + 
  ggtitle("Field Goals Percentage Per Game for the San Antonio Spurs") + 
  ylab("Field Goals Percentage Per Game") + 
  xlab("Player Name") +
  theme(plot.title = element_text(hjust = 0.5),axis.title.y=element_text(angle=0,vjust=1)) 
geom  