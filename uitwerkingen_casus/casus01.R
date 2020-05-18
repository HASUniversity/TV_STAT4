library(readxl)
radijs <- read_excel("../data/radijs.xlsx")
View(radijs)

#Vat data samen in frequenties
table(radijs$ras, radijs$bloei)

x <- c(16, 15)
n <- c(16+9, 15+10)

#alternatief
radijs %>% 
  group_by(ras, bloei) %>% 
  count() %>% 


prop.test(x,n, alternative = "greater")
