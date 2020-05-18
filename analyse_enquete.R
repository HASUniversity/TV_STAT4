library(readxl)
library(tidyverse)
theme_set(theme_classic())

df <- read_excel("../data/afronding statistiek.xlsx")
df <- df %>% 
  rename("onderzoeksopzet" = 8, 
         "stat_methode" = 11, 
         "stat_uitvoer" = 14, 
         "R_figuren" = 17, 
         "veranderen" = 20, 
         "menu_of_R" = 23)
cc <- scales::seq_gradient_pal("red", "green", "Lab")(seq(0,1,length.out=5))


#Alle vier
df %>% 
  pivot_longer(c(8, 11, 14, 17), names_to = "vraag", values_to = "antwoord") %>% 
  mutate(antwoord = factor(antwoord)) %>% 
  group_by(vraag, antwoord) %>% 
  count() %>% 
  ggplot(aes(x=antwoord, y = n, fill = antwoord)) +
  geom_col() +
  scale_x_discrete(limits = 1:5) +
  scale_fill_manual(values = cc) +
  facet_wrap(vars(vraag), nrow = 2)


df %>% 
  select(8,11,14,17) %>% 
  ggplot(aes(stat_methode, stat_uitvoer)) +
  geom_point(color = "blue", size = 2) +
  ylim(1,5) +
  xlim(1,5) +
  geom_abline(slope=1, linetype = "dashed", color = "red")

df %>% 
  select(8,11,14,17) %>% 
  ggplot(aes(R_figuren, stat_uitvoer)) +
  geom_point(color = "blue", size = 2) +
  ylim(1,5) +
  xlim(1,5) +
  geom_abline(slope=1, linetype = "dashed", color = "red")

df %>% 
  select(8,11,14,17) %>% 
  ggplot(aes(onderzoeksopzet, stat_methode)) +
  geom_point(color = "blue", size = 2) +
  ylim(1,5) +
  xlim(1,5) +
  geom_abline(slope=1, linetype = "dashed", color = "red")
  
df %>%
  count(8)
  ggplot(aes(x=8, y=n))
