#tomaten
succes <- c(1, 3, 5)
n <- c(6,4,6)
prop.test(succes, n)

library(readxl)
df <- read_excel("../data/tomaten.xlsx")

fit <- glm(rijp~factor(tijd), family = binomial(link = "logit"), data =df)
summary(fit)
