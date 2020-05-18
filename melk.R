library(readxl)
library(tidyverse)
theme_set(theme_classic(base_size = 15))
library(factoextra)

vet <- c(1.0,1.4,1.8,3.4,3.2,4.8,6.4,7.9,7.2,5.9,5.1,13.1,12.6,19.7,20.3,21.2)
prot <- c(2.6,1.7,2.0,3.5,3.9,3.0,5.6,5.9,7.4,6.6,7.1,12.3,9.2,10.4,10.7,11.1)
soort <- c("Paard","Ezel","Muildier","Kameel","Lama","Zebra","Schaap",
           "Buffel","Duif","Vos","Varken","Konijn","Rat","Hert","Rendier","Walvis")

df <- data.frame(soort, vet, prot)
writexl::write_xlsx(df, "../data/melk.xlsx")

df %>% 
  ggplot(aes(vet, prot)) +
  geom_point(color = "blue") +
  xlab("vetgehalte (%)") +
  ylab("eiwitgehalte (%)") +
  ylim(c(0, 12.5))

#Dendrogram (uitwerken)
library(ape)
library(ggdendro)
#item names
row.names(df) <- df$soort
clusters <- hclust(dist(scale(df[-1])))

#3 hoofdgroepen

colors <- c("red", "blue", "green")
clus3 <- cutree(clusters, 3)
plot(as.phylo(clusters), tip.color = colors[clus3],
     label.offset = 0.1, cex=0.7)
ggdendrogram(clusters, rotate = TRUE, theme_dendro = FALSE)

#K-means
#normalize data
df_scaled <- df
df_scaled[-1] <- scale(df_scaled[-1])

kclust <- kmeans(df_scaled[,-1], centers = 2, nstart = 25)

fviz_cluster(kclust, df_scaled[,-1], 
             geom = c("point")) +
  xlab("vetgehalte (normalized)") +
  ylab("eiwitgehalte (normalized)") +
  theme_classic()

#Elbow graph maken
fviz_nbclust(df_scaled[,-1], kmeans, method = "wss", k.max = 10) +
  geom_vline(xintercept = 5, linetype = 2)+
  labs(subtitle = "Elbow method") +
  theme_classic()
