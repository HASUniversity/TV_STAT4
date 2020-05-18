#Voorbeelden toetsen STAT4

#Chi-kwadraattoets op aanpassing

#Opgave 6
dag <- c("maandag","dinsdag","woensdag", "donderdag", "vrijdag", "zaterdag")
aantal <- c(177,192,192,198,223,218)
mydata <- tibble(dag,aantal)
chisq.test(mydata$aantal)

#Opgave 7
aantal <- c(88,35,24,13)
model <- c(9,3,3, 1)
chisq.test(aantal, p=model/sum(model))
chisq.test(aantal, p = model, rescale.p = TRUE)

#Opgave 8b
chisq.test(x = c(34,20), p = c(3/4,1/4))
chisq.test(x = c(34,20), p = c(3,1)/4)