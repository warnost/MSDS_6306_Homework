library(ggthemes)
plotNumVars <- function(df){
  df %>%
    keep(is.numeric) %>%
    gather() %>%
    ggplot(aes(value)) +
    facet_wrap(~ key, scales = "free") +
    geom_density() +
    geom_histogram() + 
    theme_fivethirtyeight()
}

plotAllNumeric(casedata)


ggplot(casedata,aes(BusinessTravel)) + geom_bar(aes(y = (..count..)/sum(..count..), fill = Attrition), position = "dodge")

x<-casedata %>% group_by(BusinessTravel) %>% summarise(count = n(), percentTotal = paste0(round(n()/dim(casedata)[1]*100,2),"%"))
kable(x)

df %>% group_by(x) %>% summarise( Count = n(), Proportion = n()/dim(df)[1]) %>% kable() %>% kable_styling(full_width = FALSE)

casedata %>% group_by_at("Attrition") %>% 
  summarise(Count = n(), Proportion = n()/dim(casedata)[1]) %>% 
  kable() %>% kable_styling(full_width = FALSE)


library(GGally);library(ggplot2)
ggpairs(data = casedata, 
              mapping = aes(color = Attrition),
              columns = c("HourlyRate","DailyRate","MonthlyRate","MonthlyIncome"))
