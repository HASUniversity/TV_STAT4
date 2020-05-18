library(tidyverse)
theme_set(theme_classic(base_size = 15))

set.seed(1)

netto <- rnorm(5, 410, 5)

#H0
gemiddelde <- (3800:4200)/10
dichtheid <- dnorm(gemiddelde, 400, sd(netto)/sqrt(length(netto)))
df <- data.frame(gemiddelde, dichtheid)
df %>% 
  ggplot(aes(gemiddelde, dichtheid, color = "H0")) +
  geom_line() +
  geom_vline(aes(xintercept = mean(netto), color = "steekproef")) +
  scale_color_manual(name = "", values = c(H0 = "blue", steekproef = "red")) +
  theme(legend.position = c(0.2, 0.8))

t.test(netto, mu=400)

data.frame(t=(-50:50)/10) %>% 
  ggplot(aes(x=t)) +
  stat_function(fun = dt, args = list(df=4)) +
#  geom_vline(xintercept = 4.9542) +
#  stat_function(fun = dt, args = list(df=4),
#                xlim = c(4.9542, 10), geom = "area", fill = "blue") +
#  stat_function(fun = dt, args = list(df=4),
#                xlim = c(-10, -4.9542), geom = "area", fill = "blue") +
  theme_classic(base_size = 15)

#kruisingsproef
library(latex2exp)
p <- data.frame(chi = (0:200)/10, dichtheid = dchisq((0:200)/10, df=3)) %>% 
  ggplot(aes(chi, dichtheid)) +
  geom_line(aes(color = "df_3")) +
  scale_color_manual(name = "", values = (c(df_3 = "blue")),
                     labels = c("df = 3")) +
  xlab(TeX("$\\chi^2$")) +
  theme(legend.position = c(0.8, 0.8))

data.frame(chi = (0:200)/10) %>% 
  ggplot(aes(x=chi)) +
  stat_function(fun = dchisq, args = list(df=3)) +
  geom_vline(xintercept = 0.94444, color = "blue") +
  stat_function(fun = dchisq, args = list(df=3), xlim = c(0.94444, 20),
                geom = "area", fill = "blue", alpha = 0.5) +
  xlab(TeX("$\\chi^2$")) +
  ylab("dichtheid") +
  annotate(geom = "text", x = 4, y=0.02, label = "p = 0,8147")
