library(readxl)
library(tidyverse)
library(factoextra)

#Data importeren uit Excelfile
autoding <- read_excel("../data/preferences_cars.xlsx")
df <- autoding %>%
  gather(merk, waardering, -`Respondents / Brands`) %>% 
  spread(`Respondents / Brands`, waardering) %>% 
  column_to_rownames(var = "merk") #deze functie verplaats kolom naar rownames

#Tegenwoordig zijn er alternatieven voor gather en spread:
df <- autoding %>%
  pivot_longer(-`Respondents / Brands`, 
               names_to = "merk", values_to = "waardering") %>% 
  pivot_wider(names_from = `Respondents / Brands`, values_from=waardering) %>% 
  column_to_rownames(var = "merk")

#Data normaliseren
df <- scale(df)

#Elbow graph maken
fviz_nbclust(df, kmeans, method = "wss", k.max = 9) +
  geom_vline(xintercept = 5, linetype = 2)+
  labs(subtitle = "Elbow method") +
  theme_classic()

#Dus we gaan voor 5 clusters
kclust <- kmeans(df, centers = 5, nstart = 25)

#Figuur maken
fviz_cluster(kclust, df[,-1]) +
  theme_classic()