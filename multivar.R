library(tidyverse)
theme_set(theme_classic(base_size = 15))
library(factoextra)
library(vegan)
data(dune)
data("dune.env")
View(dune)

#K-means
dune_scaled <- scale(dune)
kclust <- kmeans(dune_scaled, centers = 4, nstart=25)
fviz_cluster(kclust, dune_scaled, 
             geom = c("point")) +
  theme_classic()

dune.pca <- rda(dune, scale = TRUE)
uscores <- data.frame(dune.pca$CA$u)
uscores1 <- inner_join(rownames_to_column(dune.env), rownames_to_column(data.frame(uscores)), type = "right", by = "rowname")
vscores <- data.frame(dune.pca$CA$v)

uscores1 %>% 
  ggplot(aes(PC1, y=1, color = Management)) +
  geom_point(size=1.7) +
  scale_color_hue(name = "Beheer", labels = c("Biologische landbouw",
                             "Hobbylandbouw",
                             "Natuurinclusief",
                             "Reguliere landbouw")) +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())
  
uscores1 %>% 
  ggplot(aes(PC1, y=PC2, color = Management)) +
  geom_point(size=1.7) +
  scale_color_hue(name = "Beheer", labels = c("Biologische landbouw",
                             "Hobbylandbouw",
                             "Natuurinclusief",
                             "Reguliere landbouw"))
  
fit <- manova(cbind(dune_scaled)~dune.env$Management)
summary.manova(fit, tol=0)

#Dendrogram (uitwerken)
library(ape)
library(ggdendro)
#item names
clusters <- hclust(dist(scale(dune)))

#4 hoofdgroepen

colors <- c("red", "blue", "green", "black")
clus4 <- cutree(clusters, 4)
plot(as.phylo(clusters), tip.color = colors[clus4],
     label.offset = 0.1, cex=0.7)
#------------------
#Lemons
#------------------
library(readxl)
library(tidyverse)
theme_set(theme_classic(base_size = 15))

df <- read_excel("../data/lemons.xlsx")

df %>% 
  ggplot(aes(lemons, fatalities)) + 
  geom_point(color = "red", size=2) +
  xlab("import citroenen (ton/jaar)") +
  ylab("Fatale snelwegongelukken") +
  geom_smooth(method = "lm", se = FALSE)

#Onderliggende factor
df <- df %>% 
  mutate(tijd = sqrt((fatalities[1]-fatalities)^2+(lemons[1]-lemons)^2))

df %>% 
  ggplot(aes(tijd, y=1)) +
  geom_point(colour = "red", size = 2) +
  geom_line(colour = "blue") +
  xlab("onderliggende factor") +
  geom_label(aes(label = year), vjust = -0.5,
             hjust = c(0, 0.5, 0.5, 0.5, 1)) +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())
#yas verwijderen


#-------------------------------------
#Vb fruitvliegjes manova
#-------------------------------------
library(tidyverse)
library(readxl)

df <- read_excel("../data/fruitvliegjes.xlsx")
View(df)
fit <- manova(cbind(df$borststuk, 
             df$lengtevleugel, 
             df$lengtedijbeen,
             df$oogomvang,
             df$antenne) ~ df$soort* df$geslacht
      )
summary(fit)

library(emmeans)  

emmeans(fit, list(pairwise ~ soort))

