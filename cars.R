library(readxl)
library(tidyverse)
library(factoextra)

#Data importeren uit Excelfile
cars <- read_excel("../data/preferences_cars.xlsx")

#Kolomnamen maken van variabele
cars %>% 
  rename("respondent" = `Respondents / Brands`) %>% 
  column_to_rownames(var ="respondent")

#Elbow graph maken
fviz_nbclust(cars, kmeans, method = "wss", k.max = 15) +
  labs(subtitle = "Elbow method") +
  theme_classic()
