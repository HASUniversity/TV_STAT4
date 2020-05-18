library(tidyverse)

#Voorbeelden Hst2 Chikwadraattoets op onafhankelijkheid

#Van lange tabel:
library(MASS)
data("survey")
tabel <- table(survey$Smoke, survey$Exer)
tabel
chisq.test(tabel)


#van korte tabel:
library(weights)

df <- survey %>% 
  na.omit(Smoke, Exer) %>% 
  group_by(Smoke, Exer) %>% 
  count()
df_long <- rep(df)

wtd.chi.sq(df$Smoke, df$Exer, weight = df$n, mean1 = FALSE)
#Werkt zo niet!!


chisq.test(df)


file_path <- "http://www.sthda.com/sthda/RDoc/data/housetasks.txt"
housetasks <- read.delim(file_path, row.names = 1)
str(housetasks)
View(housetasks)
chisq.test(housetasks)
