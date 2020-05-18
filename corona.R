library(readxl)
library(tidyverse)
theme_set(theme_classic())
library(RColorBrewer)
library(lubridate)

df <- read_excel("../data/corona.xlsx")

df %>% 
  filter(!is.na(Land)) %>% 
  ggplot(aes(dag, overleden, color = Land)) +
  scale_y_log10() +
  geom_line(size = 1) +
  scale_color_brewer(palette = "Dark2")

df %>% 
  filter(!is.na(Land)) %>% 
  ggplot(aes(dag, besmet, color = Land)) +
  scale_y_log10() +
  geom_line(size = 1) +
  scale_color_brewer(palette = "Dark2")

#correct for number of people
inhab <- read_excel("../data/corona.xlsx", sheet = "inhabitants")
df <- merge(df, inhab) %>% 
  mutate(overledenphb = overleden/n)

df %>% 
  filter(!is.na(Land)) %>% 
  ggplot(aes(datum, overledenphb, color = Land)) +
#  scale_y_log10() +
  ylab("fractie overleden phb") +
  geom_line(size = 1) +
  scale_color_brewer(palette = "Dark2")
