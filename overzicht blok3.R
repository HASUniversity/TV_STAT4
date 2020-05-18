library(readxl)
#-------------------------------------------------------------------
#Hst. 1
#-------------------------------------------------------------------

#Binomiale test
binom.test(x=10, n=50, p=0.5, alternative = "less")

#Verschiltoets voor fracties
prop.test(x=c(10, 20), n=c(50, 70), alternative = "greater")
#In wezen chi-kwadraat!


#-------------------------------------------------------------------
#Hst. 2
#-------------------------------------------------------------------

#Logistische regressie
df <- read_excel("../data/tomaten.xlsx")
fit <- glm(df$rijp~factor(df$tijd), family = binomial(link = "logit"))
summary(fit)
#Kan met allerlei lineaire modellen.
#Posthoc
library(emmeans)
pairs(emmeans(fit, "tijd"), adjust = "tukey")


df <- read_excel("../data/insecticiden.xlsx")

#Insecticiden
df <- df %>% mutate(Insecticide = factor(Insecticide, 
                                         levels = c("Control",
                                                    "Avount",
                                                    "Bazuka",
                                                    "Cefanol",
                                                    "Ampligo",
                                                    "Belt")))

df_num <- df %>% mutate(Status = recode(Status, "dood"=0, "levend"=1))

fit <- glm(Status~Insecticide, family = binomial(), data=df_num)
car::Anova(fit)
emmeans::emmeans(fit, specs = trt.vs.ctrl~Insecticide)


#-------------------------------------------------------------------
#Hst. 3
#-------------------------------------------------------------------


#Chi-kwadraattoets op aanpassing
#Voorbeeld kwekers en enquête
chisq.test(x=c(70, 49, 52, 29), 
           p=c(33, 29, 25, 13),
           rescale.p = TRUE)

#Voorbeeld 8.6
df <- read_excel("../data/uitsterven.xlsx")
#bereken mu:
lambda <- weighted.mean(df$aantal_uitstervingen, df$frequentie)
df$expect <- dpois(df$aantal_uitstervingen, lambda)*76
#maak density plot
df %>% 
  ggplot(aes(x=aantal_uitstervingen)) +
  geom_col(aes(y = expect), color = "blue", fill = "white") +
  geom_col(aes(y = frequentie), width = 0.5, fill = "black") +
  ylab("Frequentie") +
  xlab("Aantal uitstervingen")
#Mag geen chi-kwadraat uitvoeren, vanwege veel expecte <1.
#oplossing: cellen samenvoegen
df_sum <- df %>% 
  group_by(categorie) %>% 
  summarise(gemeten = sum(frequentie), verwacht = sum(expect))
chisq.test(df_sum$gemeten, p=df_sum$verwacht, rescale.p = TRUE)


#Chi-kwadraattoets op onafhankelijkheid
#Voorbeeld regenwormen
df <- data.frame(veld1 = c(25,56,19), 
                 veld2 = c(8,41,21)) 
chisq.test(x=as.matrix(df))

#Weight cases: Samenvattingstabel omzetten naar lang
df <- data.frame(x=rep(c("a", "b", "c"), each=2),
                 y=rep(c("nee", "ja"), 3),
                 n=c(20, 15, 34, 32, 15, 17))
library(tidyverse)
df %>% 
  uncount(n)

worm <- read.csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter09/chap09e4WormGetsBird.csv"))
worm

#-------------------------------------------------------------------
#Hst. 4 Multi
#-------------------------------------------------------------------

#Correlaties
library(tidyverse)
theme_set(theme_classic())
library(ggcorrplot)
data(iris)
corr <- iris %>%
  select(-Species) %>%
  cor()

corr %>%
  ggcorrplot(hc.order = TRUE, type = "lower", method = "circle")

#Cluster analysis
fit <- iris %>% 
  select(-Species) %>% 
  kmeans(centers = 4)

iris$cluster <- factor(fit$cluster)

iris %>% 
  ggplot(aes(cluster, fill = Species)) +
  geom_bar()

#MANOVA

