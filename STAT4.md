--- 
title: "Stat4: Binomiale data"
author: "Team Toegepaste Biologie Venlo"
date: '2020-05-04'
documentclass: book

site: bookdown::bookdown_site
biblio-style: apalike
---

# Voorwoord {-}
Het afgelopen blok hebben jullie gewerkt met responsvariabelen die van het niveau interval/ratio en continue zijn, op een hoofdstuk na: survival analysis.

Survivaldata is een duidelijk voorbeeld van binomiale data.
Het kan twee waardes aannemen: dood/levend, heel/kapot, etc.
In dit blok gaan we verder met binomiale data (hoofdstuk 1 en 2).

Verder gaan we aan de slag met frequentiedata (hoofstuk 3).
Een voorbeeld van frequentiedata heb je al verzameld en geanalyseerd in jaar 1 (krekelpracticum) en mogelijk ook tijdens je eigen project in blok 2 (diergedrag).

Hoofstuk 4 en 5 gaan over multivariate technieken.
Dan heb je te maken met meerdere responsvariabelen.

We eindigen dit blok met een overzicht van alle toetsen die jullie gehad hebben.
Hiermee hopen we dat jullie voorbereid zijn op dataverwerking in jaar 3 en 4.
Dan moeten jullie het namelijk zelf kunnen.


<!--chapter:end:index.Rmd-->

#Binomiale verdeling: toets op fractie

\BeginKnitrBlock{ABD}<div class="ABD">Lees chapter 7 (*Analysing proportions*)</div>\EndKnitrBlock{ABD}

De binomiale verdeling werd al in de 17^de^ eeuw uitgebreid onderzocht.
In die tijd was het spel kop-en-munt razend populair.
Je moest gokken, van een x-aantal munten, hoeveel kop of munt je zou krijgen.
Doe je dat spelletje met één munt, dan is het niet zo moeilijk.
De kans op kop of munt is gelijk (tenminste bij een "eerlijke" munt).

Voor een grotere serie, moet je gaan rekenen.
Doe je dit voor n=2, dan zijn dit de opties:


munt1   munt2    aantal_kop
------  ------  -----------
munt    munt              0
munt    kop               1
kop     munt              1
kop     kop               2

Kans op 0x kop = 1/4, kans op 1x kop = 2/4 en kans op 2x kop = 1/4.

Bij grotere n is dat aardig wat rekenwerk.
Gelukkig heeft R daar een functie voor.
Als voorbeeld de kans dat je 2x kop hebt bij een serie van 2 muntjes:


```r
dbinom(x=2, size = 2, prob = 0.5)
```

```
## [1] 0.25
```

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:kop-of-munt"><strong>(\#exr:kop-of-munt) </strong></span>Bereken de volgende kansen:

* 1 keer kop bij n=2
* 4 keer kop bij n=8
* 8 keer kop bij n=16

Bedenk waarom de kans afneemt?
</div>\EndKnitrBlock{exercise}


##Betrouwbaarheidsinterval
In het geval van kop-en-munt weet je (ongeveer) de theoretische kans (*probability*), je gaat er vanuit dat die 0,5.
De kans wordt weergegeven met de letter **p** (niet te verwarren met hetzelfde symbool voor de overschrijdingskans van onder de H~0~-hypothese).
Meestal wordt er gesproken van kans op **succes**, waarbij je zelf aangeeft welke van de twee waardes je succes noemt (kop of munt). 

Vaak weet je **p** niet, en schat je die vanuit een steekproef, weergegeven met $\hat{p}$.

Net als bij de normale verdeling, kan je het betrouwbaarheidsinterval berekenen van je schatter.
Bij de normale verdeling gaat het vaak om het gemiddelde, bij de binomiale data gaat het om $\hat{p}$.

Ook hier geldt weer dat de schatting alleen betrouwbaar is als de daadwerkelijke verdeling de regels van je theoretische verdeling volgt.
Voor de binomiale verdeling geldt:

* Het aantal steekproeven (n) staat vast (dus bijv. 10x kop-of-munt)
* De steekproeven zijn onafhankelijk van elkaar
* De kans op succes (p) is gelijk voor iedere steekproef

Wanneer we ervan uit kunnen gaan dat de verdeling aan bovenstaande voorwaarden voldoet, kunnen we een betrouwbaarheidsinterval uitrekenen.

Hoe doe je dat in R?


```r
library(Hmisc)
binconf(x, n, alpha=0.05)
```

waarbij x het aantal successen is, en n het aantal steekproeven.
In het geval van voorbeel 7.3 uit het boek:


```r
library(Hmisc)
binconf(x=30, n=87, alpha=0.05)
```

```
##   PointEst     Lower     Upper
##  0.3448276 0.2534266 0.4493523
```

Zoals je ziet is `binconf()` een functie uit de package Hmisc.

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:Hmisc"><strong>(\#exr:Hmisc) </strong></span>Package Hmisc

* installeer de package Hmisc
</div>\EndKnitrBlock{exercise}



\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:dobbelsteen1"><strong>(\#exr:dobbelsteen1) </strong></span>Betrouwbare dobbelsteen

Stel, je werpt 20 keer met een dobbelsteen en gooit 0 keer 6.

* Bereken het betrouwbaarheidsinterval van de kans op 6 op basis van bovenstaande steekproef.
* Verwacht je dat de dobbelsteen "zuiver" is (kans op iedere waarde is gelijk)?

</div>\EndKnitrBlock{exercise}



##De binomiale toets
Je kan ook testen of de gevonden $\hat{p}$ afwijkt van een theoretische waarde.
In het geval van de vorige opgave, over de dobbelsteen, kan je testen of p< 1/6:


```r
binom.test(0, 20, p=1/6, alternative = "less")
```

```
## 
## 	Exact binomial test
## 
## data:  0 and 20
## number of successes = 0, number of trials = 20, p-value = 0.02608
## alternative hypothesis: true probability of success is less than 0.1666667
## 95 percent confidence interval:
##  0.0000000 0.1391083
## sample estimates:
## probability of success 
##                      0
```

De functie `binom.test()` berekent de **exacte** kans op het voorkomen van de gegeven, of meer extremere uitkomst bij een bepaalde p (in dit geval 1/6).
Net als bij de t-toets kan je aangeven of je eenzijdig, danwel tweezijdig wilt toetsen.

De hypotheses die bij bovenstaande code horen zijn:

* H~0~: $p = 1/6$ of, meer formeel, $p \geq 1/6$ 
* H~1~: $p < 1/6$

**NB**: de binomiale test geeft ook een betrouwbaarheidsinterval, maar deze is gebaseerd op de F-verdeling (bij grote steekproeven volgt een binomiale verdeling min of meer een normale verdeling).
Zoals je kan lezen in het boek, kan je beter een andere methode gebruiken: de Agresti-Coull-methode ("Wilson interval").
Dat is de standaardmethode in d functie `binconf()`.


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:dobbelsteen2"><strong>(\#exr:dobbelsteen2) </strong></span>Dobbelsteen

Je gooit met een dobbelsteen 6 keer, en je gooit telkens 4.
Je wilt testen of de dobbelsteen afwijkt t.o.v. een zuivere dobbelsteen.

* Geef de hypotheses
* Bereken de overschrijdingskans.
</div>\EndKnitrBlock{exercise}

##Verschiltoets voor fracties
Soms wil je een fractie niet testen ten opzichte van een theoretische waarde, maar juist met een andere steekproef.

Stel dat je de kans op 6 voor twee dobbelstenen wilt vergelijken. Je vermoedt dat ze verschillen van elkaar.
Met de ene dobbelsteen gooi je 100 keer, en je krijgt 12x zes, en met de andere dobbelsteen gooi je 80 keer en je krijgt 20x zes.
Je hypotheses zijn:

* H~0~: $p_{1} \neq p_{2}$
* H~1~: $p_{1} = p_{2}$ 

Met de volgende functie test dit in R:


```r
succes = c(12, 20, 5)
n = c(100, 80, 60)
prop.test(succes, n)
```

```
## 
## 	3-sample test for equality of proportions without continuity
## 	correction
## 
## data:  succes out of n
## X-squared = 8.8382, df = 2, p-value = 0.01204
## alternative hypothesis: two.sided
## sample estimates:
##     prop 1     prop 2     prop 3 
## 0.12000000 0.25000000 0.08333333
```

De functie `prop.test()` heeft als input een vector met de aantallen succes voor de verschillende objecten (je kan de toets met meer dan twee groepen uitvoeren ).
Als toets wordt een chi-kwadraattoets uitgevoerd.
Daarover leer je meer in hoofdstuk 2.


##Opgaven
Gebruik voor de volgende opgaven R.

In het boek wordt ervan uitgegaan dat je per mogelijke uitkomst (bijvoorbeeld 5 resistente stammen in opgave 1) de kans berekent met je rekenmachine.
Dat kan natuurlijk gemakkelijker in R.
Met de functie `dbinom(x, n, prob)` kan je de exacte kans berekenen.
In het geval van opgave 1c: `dbinom(x=5, n=7, prob=0.3)`, of nog korter: `dbinom(5, 7, 0.3)`.

Maar als je de kans op minstens of maximaal x successen wilt berekenen, dan kan dat natuurlijk ook met `binom.test()`.
Voor opgave 1e krijg je dan: `binom.test(x=5, n=7, p=0.3, alternative="greater")`.

Wordt er gevraagd naar een confidence interval via de Agresti-Coull-methode: R doet dat automatisch met de functie `binconf()`.




\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:PP07"><strong>(\#exr:PP07) </strong></span>Practise Problems, chapter 7

Los de volgende Practise problems op:

* 1 t/m 4.
* 6 t/m 9</div>\EndKnitrBlock{exercise}

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:verschiltoetsfrac"><strong>(\#exr:verschiltoetsfrac) </strong></span>Zaadbehandeling

In een onderzoek worden 120 ontkiemde zaden behandeld met 18 uur donker / 6 uur licht (behandeling A) en 80 ontkiemde zaden met 12 uur licht / 12 uur donker (behandeling B).
Na precies 2 weken werd er gekeken hoeveel zaden volledig tot groei gekomen waren.
Bij behandeling A waren dat er 92 van de 120 en bij behandeling B waren dat er 48 van de 80.

* Toets met $\alpha = 0,05$ de hypothese dat behandeling A beter werkt dan behandeling B.
</div>\EndKnitrBlock{exercise}


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:medicijn"><strong>(\#exr:medicijn) </strong></span>Medicijn
</div>\EndKnitrBlock{exercise}

Een fabrikant beweert dat zijn medicijn (A) in 70% van de behandelingen bij paarden effectief is.
Een onderzoeker vergelijkt A met een andere medicijn (B) en vindt de volgende resultaten:


Soort medicijn    wel effectief   niet effectief
---------------  --------------  ---------------
A                            19               11
B                            19                6

De onderzoeker meent dat de door de fabrikant aangegeven percentage van 70% te hoog is.

* Is dit op basis van bovenstaande steekproef met een zekerheid van 95% te beweren? Formuleer de hypothese en voer een toets uit en eindig met een duidelijke conclusie
* Toets met een foutmarge van $\alpha =0,05$ de bewering dat medicijn B beter werkt dan 

<!--chapter:end:hfst1_binomfractie.Rmd-->

#Logistische regressie

\BeginKnitrBlock{ABD}<div class="ABD">
* Lees paragraph 9.2 (*Estimating*)
* Lees paragraph 17.9 (*Logistic regression: fitting a binary response variable*)
</div>\EndKnitrBlock{ABD}

In het vorige hoofdstuk heb je kennis gemaakt met binaire data (dood/levend, etc.).
Je kan deze kans beschrijven als een kansproces met de kans p op "succes".
Je hebt al geleerd om te bepalen wat het betrouwbaarheidsinterval is van de geschatte p uit een steekproef en of de p van twee steekproeven significant van elkaar verschillen.

Maar er zijn meer onderzoeksvragen mogelijk.
Ter illustratie een voorbeeld over tomaten:

Een tomatenteler onderzoekt of de tomatenoogst eerder kan, zonder dat de tomaten onrijp worden geoogst.
Het volgende experiment wordt uitgevoerd:

* Bij zes planten worden de tomaten 10 dagen eerder dan normaal geoogst.
* Bij vier andere planten worden de tomaten 5 dagen eerder geoogst.
* Bij zes planten worden de tomaten op de standaardtijd geoogst.

Vervolgens wordt gekeken hoeveel van de geplukte tomaten, per tijdstip, rijp zijn:


       onrijp   rijp
----  -------  -----
-10         5      1
-5          1      3
0           1      5

Zulke data kan je mooi presenteren in een mozaiekplot (In het Engels *mosaic plot* geheten):


```r
library(ggmosaic)

tomaat %>% 
  ggplot() +
  geom_mosaic(aes(x=product(tijd), fill = rijp)) +
  scale_fill_manual(values = c("green", "red")) +
  xlab("tijd (dagen voor oogstijd)") +
  ylab("fractie rijp") +
  theme(legend.position = "none")
```

<img src="hfst2_logregr_files/figure-html/unnamed-chunk-3-1.png" width="672" />

Kenmerk van een mozaiekplot is dat op de y-as en x-as af te lezen welke fractie in welke categorie gevonden is. Zie ook in het boek blz. 40-41. 
Voor het creëren van zulke plots heb je de package **ggmosaic** nodig.
NB: de variabele voor de x-as moet opgegeven worden als `product(variabele)`.

De code voor bovenstaande figuur heeft wel wat extra code om de figuur op te leuken:

* `scale_fill_manual(values = c("green", "red")) +`: handmatig kleuren kiezen 
* `xlab("tijd (dagen voor oogstijd)") +`: label voor x-as definiëren
* `ylab("fractie rijp") +`: label voor y-as definiëren
* `theme(legend.position = "none")`: legenda niet laten zien


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:ggmosaic"><strong>(\#exr:ggmosaic) </strong></span>ggmosaic

* Installeer de package ggmosiac
* Maak van je krekeldata een mozaiekplot (weliswaar geen bonomiale data, maar mozaiekplot werkt ook voor zulke data)
</div>\EndKnitrBlock{exercise}

In de volgende paragrafen gaan we hypothesetoetsen voor binomiale data uitvoeren.

##Generalized Linear Model
De responsdata is nu binomiaal verdeeld, dus je kan geen gewoon *General Linear Model* toepassen.
Daarvoor in de plaats gebruiken we het *Generalized Linear Model*, met de functie in R: `glm()`.

Verschil met de functie `lm()` is dat je nu kan aangeven wat voor soort data je hebt.
In dit geval hebben we te maken met binomiale data:


```r
glm(respons~verklarende, family = binomial())
```

Met deze informatie zet de glm de responsveriabele om naar **log-odds**, dat is een alternatieve manier om kans weer te geven:



$$\log{\frac{p}{1-p}}$$

De fractie $\frac{p}{1-p}$ wordt de **odd** genoemd en komt misschien raar over, maar is iets wat jullie waarschijnlijk allemaal ooit hebben gebruikt: "die kans is fifty-fifty" of "tien tegen een".

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:unnamed-chunk-5"><strong>(\#exr:unnamed-chunk-5) </strong></span>Odd

* Welke odd-waarde heeft de kans "fifty-fifty is"?
* Welke odd-waarde heeft een kans van tien tegen een?
* Welke odd-waarde heeft rijpheid van tomaten bij 10 dagen voor oogsttijd?
</div>\EndKnitrBlock{exercise}


##ANOVA met binomiale data

Stel, we willen testen of tijdstip van oogsten echt een effect heeft op de rijpheid, dan krijgen we de volgende hypotheses:

* H~0~: alle tijdstippen hebben gelijke kans op rijpheid
* H~1~: minstens een verschil in kans op rijpheid tussen tijdstippen

Dat klinkt als een *one-way ANOVA*, maar dan met binomiale data.
En dat is het ook.
Om het *generalized linear model* uit te voeren, moet de responsvariabele in de vorm 0 of 1 zijn.
In dit geval zijn het twee categoriën in de vorm van tekst ("rijp" en "onrijp").
Om die om te zetten gebruiken we de functien`recode()`:


```r
tomaat_num <- tomaat %>% 
  mutate(rijp = recode(rijp, "onrijp" = 0, "rijp" = 1))
```

Met de functie `mutate()` definieer je een nieuwe variabele (in dit geval weer rijp genoemd).
Met `recode()` zet je de variabele rijp om van tekst naar 0-en en 1-en.
En natuurlijk uitgevoerd in een *pipeline*.

Volgende stap is om het *generalized linear model* uit te voeren:


```r
fit <- glm(rijp~factor(tijd), family = binomial(), data = tomaat_num)
```

En vervolgens een soort van ANOVA-tabel, dat doen we nu met de functie `Anova()` uit de package car:


```r
library(car)
Anova(fit)
```

```
## Analysis of Deviance Table (Type II tests)
## 
## Response: rijp
##              LR Chisq Df Pr(>Chisq)  
## factor(tijd)   6.6179  2    0.03655 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

In deze tabel staat de overschrijdingskans van de verklarende variabele(n), in dit geval uitgerekend met een Chi-kwadraattoets i.p.v. een F-toets (omdat we categoriedata hebben).
Chikwadraattoets komt in volgend hoofdstuk aan de orde.

Je kan ook de functie `summary()` gebruiken, die de geschatte waarden voor ieder niveau geeft (in log-odds uitgedrukt):


```r
summary(fit)
```

```
## 
## Call:
## glm(formula = rijp ~ factor(tijd), family = binomial(), data = tomaat_num)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -1.8930  -0.6039   0.6039   0.6425   1.8930  
## 
## Coefficients:
##                Estimate Std. Error z value Pr(>|z|)  
## (Intercept)      -1.609      1.095  -1.469   0.1418  
## factor(tijd)-5    2.708      1.592   1.701   0.0889 .
## factor(tijd)0     3.219      1.549   2.078   0.0377 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 21.930  on 15  degrees of freedom
## Residual deviance: 15.312  on 13  degrees of freedom
## AIC: 21.312
## 
## Number of Fisher Scoring iterations: 4
```

Net als bij een gewone ANOVA kan je hier ook een posthoc-toets uitvoeren.
Dat doen we met de functie `emmeans()` uit de package emmeans:


```r
library(emmeans)
pairs(emmeans(fit, "tijd"), adjust = "tukey")
```

```
##  contrast estimate   SE  df z.ratio p.value
##  -10 - -5   -2.708 1.59 Inf -1.701  0.2046 
##  -10 - 0    -3.219 1.55 Inf -2.078  0.0945 
##  -5 - 0     -0.511 1.59 Inf -0.321  0.9448 
## 
## Results are given on the log odds ratio (not the response) scale. 
## P value adjustment: tukey method for comparing a family of 3 estimates
```

Wil je alleen vergelijken met een controlebehandeling (bijv. om te kijken welk tijdstip significant afwijkt van normale oogsttijd):


```r
emmeans(fit, specs = trt.vs.ctrlk ~ tijd)
```

```
## $emmeans
##  tijd emmean   SE  df asymp.LCL asymp.UCL
##   -10  -1.61 1.10 Inf    -3.756     0.538
##    -5   1.10 1.15 Inf    -1.165     3.362
##     0   1.61 1.10 Inf    -0.538     3.756
## 
## Results are given on the logit (not the response) scale. 
## Confidence level used: 0.95 
## 
## $contrasts
##  contrast estimate   SE  df z.ratio p.value
##  -10 - 0    -3.219 1.55 Inf -2.078  0.0710 
##  -5 - 0     -0.511 1.59 Inf -0.321  0.9141 
## 
## Results are given on the log odds ratio (not the response) scale. 
## P value adjustment: dunnettx method for 2 tests
```

De optie `trt.vs.ctrlk` van het argument `specs` geeft aan dat de laatste (op basis van de factorvolgorde die R aanhoudt) categorie gebruikt wordt als controle.
Is de eerste controle, dan gebruik je `trt.vs.ctrl`.
Als de controle halverwege de rij zit, gebruik  `trt.vs.ctrlk` en voeg het argument `ref = 2` (met 2 de plek waar je controle staat).
Het simpelst is om met behulp van `levels` de volgorde van je categoriën aan te geven, en de controle voor of achteraan te zetten.
Dat is ook mooier in grafieken.

Hoe je dat ook alweer doet:


```r
tomaat %>%
  mutate(tijd = factor(tijd, levels = c(0, -5, -10)))
```


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:insecticiden"><strong>(\#exr:insecticiden) </strong></span>Insecticiden.

Een derdejaarstudent Toegepast Biologie loopt stage bij een kweker en moet vijf verschillende insecticiden testen.
Daarvoor doet hij het volgende experiment: per insecticide stelt hij een aantal vliegen bloot aan deze insecticide en een uur later noteert hij hoeveel vliegen nog in leven zijn.
Daarnaast is er een controlegroep die geen insecticide krijgt.

* Download de dataset van BB ("insecticiden.xlsx")
* Waarom zou je op deze dataset geen *survival analysis* op loslaten?
* Test welke insectide significant meer vliegen dood dan de controle.
* Welk insecticide doodt de meeste vliegen?
</div>\EndKnitrBlock{exercise}


##Regressie met binomiale data

We kunnen de tomatendata ook op de volgende manier presenteren:


```r
tomaat %>% 
  ggplot(aes(tijd, rijp, color = rijp)) + 
  geom_jitter(height = 0.1, width = 0.1) +
  scale_color_manual(values = c("green", "red")) +
  theme(legend.position = "none")
```

<img src="hfst2_logregr_files/figure-html/unnamed-chunk-13-1.png" width="672" />


Voor de duidelijkheid zijn de individuele punten iets verspreid weergegeven (via `geom_jitter()`).
Met wat toevoegingen (`color = rijp`, `scale_color_manual(values = c("green", "red"))`) zijn de rijpe waarden rood en onrijpe waarden weer groen.

Nu hebben we op de x-as geen categoriën, maar een continue schaal.
Zouden we nu iets met een regressie kunnen doen?
Het antwoord is ja.

Met hetzelfde *generalized linear model*  kunnen we ook regressies uitvoeren:


```r
fit2 <- glm(rijp ~ tijd, family = binomial(), data = tomaat_num)
```

Het enige verschil met de vorige analyse is dat we van de variabele tijd **geen** factor maken.

Kijken wat de uitkomst is met de functie `Anova()`:


```r
Anova(fit2)
```

```
## Analysis of Deviance Table (Type II tests)
## 
## Response: rijp
##      LR Chisq Df Pr(>Chisq)  
## tijd   5.9506  1    0.01471 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Fractie rijpe vruchten lijkt dus inderdaad te veranderen met de tijdstip van plukken.

Met de functie `summary()` krijg je de geschatte parameters van het statistisch model te zien:


```r
summary(fit2)
```

```
## 
## Call:
## glm(formula = rijp ~ tijd, family = binomial(), data = tomaat_num)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -2.0802  -0.7021   0.4941   0.6254   1.7443  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)  
## (Intercept)   2.0416     1.1143   1.832   0.0669 .
## tijd          0.3316     0.1597   2.077   0.0378 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 21.930  on 15  degrees of freedom
## Residual deviance: 15.979  on 14  degrees of freedom
## AIC: 19.979
## 
## Number of Fisher Scoring iterations: 4
```

Het model is een rechte lijn die de y-as (die de **log-odd-waarde** aangeef!) snijdt op 2,0416 en een richtingscoëfficiënt heeft van 0.3316.

Voor de tomatenteler is het van belang vanaf welk tijdstip het waarschijnlijk is dat een minimale fractie tomaten (zeg 25% rijp is).
Daarvoor hebben we het betrouwbaarheidsinterval nodig.

Met ggplot kunnen we gemakkelijk het betrouwbaarheidsinterval plotten, en tegelijkertijd de minimale fractie rijpheid aangeven:


```r
tomaat_num %>% 
  ggplot(aes(tijd, rijp)) + 
  geom_point(alpha=0.2, size = 2) +
  geom_smooth(method=glm, method.args = list(family = binomial())) +
  ylab("Fractie rijp") +
  geom_hline(yintercept = 0.25, color = "blue", linetype = "dashed")
```

<img src="hfst2_logregr_files/figure-html/unnamed-chunk-17-1.png" width="672" />

```r
  theme(legend.position = "none") 
```

```
## List of 1
##  $ legend.position: chr "none"
##  - attr(*, "class")= chr [1:2] "theme" "gg"
##  - attr(*, "complete")= logi FALSE
##  - attr(*, "validate")= logi TRUE
```

Je ziet nu de typische S-vorm van een logistisch regressie.
Bij vijf dagen eerder oogsten zit de teler dus nog veilig.

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:guppies"><strong>(\#exr:guppies) </strong></span>Guppies

Pitkow *et al.* (1960) onderzocht het effect van tijdsduur blootstelling aan lage temperatuur op de overleving van guppies.
Hij stelde steeds 40 guppies bloot aan water van 5°C, voor 3, 8, 12 of 18 minuten.

* Download de data van BB (guppies.xlsx)
* Zet de data uit in een grafiek.
* Voer een logistische regressie uit.
* Wat zijn je conclusies?
</div>\EndKnitrBlock{exercise}


##LT50

De afkorting LT50 is een begrip uit de toxicologie en staat voor de "mediaan letale tijd" (tijd tot aan de dood).
Wat breder geïnterpreteerd staat het voor de waarde van de verklarende factor waarbij de kans op succes 0,5 is.

In principe kan je met behulp van de *estimates* van het logistisch model uitrekenen bij welke waarde je LT50 bereikt, maar er is (natuurlijk) een gemakkelijke functie voor: `dose.p()`.

Deze functie zit in de package MASS.
Nu is het punt met **MASS** dat er een paar functies in zitten met dezelfde naam als functies in de package **tidyverse**.
Om te voorkomen dat deze functies overschreven worden, kan je een functie ook oproepen zonder de hele library op te roepen.
Dat doe je op de volgende manier:

`MASS::dose.p(fit, p=0.5)`

Die dubbele dubbele punt betekent dat je vanuit de package MASS de functie dose.p oproept.

In bovenstaande functie staat fit voor het GLM-model, en het argument p geeft aan voor welke kans je de waarde voor de verklarende factor wilt weten.

Als voorbeeld weer de tomaten.
De teler wilt weten op welk moment 75% van de tomaten rijp zijn:


```r
MASS::dose.p(fit2, p=0.75)
```

```
##              Dose       SE
## p = 0.75: -2.8435 2.349679
```

Bij 2,84 dagen voor oogsten is gemiddeld 75% van de tomaten rijp.
De standaardfout van deze schatting is 2,35

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:LT50"><strong>(\#exr:LT50) </strong></span>LT50

* Welke log-odd hoort bij LT50?
</div>\EndKnitrBlock{exercise}

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:MASS"><strong>(\#exr:MASS) </strong></span>MASS

* installeer de package MASS
* Bereken de LG50 voor het voorbeeld van de Guppies.
</div>\EndKnitrBlock{exercise}

<!--chapter:end:hfst2_logregr.Rmd-->

#Chikwadraattoets

\BeginKnitrBlock{ABD}<div class="ABD">
* Lees *chapter* 8 (*Fitting probability models to frequency data*)
* Lees *section* 9.4 (*The $\chi^2$ contigency test*)
</div>\EndKnitrBlock{ABD}

Dit hoofdstuk gaat, net als de vorige hoofdstukken, over nominale data.
Heb je meer dan twee categoriën, dan kan je geen binomiale toets meer gebruiken.
Daarvoor is de Chi-kwadraattoets ontwikkeld.
Deze ben je al tegengekomen in de output van de verschiltoets voor fracties (`prop.test()`).
Nu gaan we hier dieper op in.


##Chi-kwadraattoets op aanpassing
Met de Chi-kwadraattoets op aanpassing (*goodness of fit*) kan onderzocht worden of de waargenomen aantallen een bepaalde verdeling volgen.
Er wordt getoetst of de gevonden frequenties in het onderzoek overeenkomen met een verwachte verdeling tussen die frequenties op basis van bijvoorbeeld:

* eerdere waarnemingen
* een theoretisch model (bijvoorbeeld uit de genetica)
* kennis van de hele populatie (representativiteit). 

De Chi-kwadraattoets op aanpassing toetst of het aannemelijk is dat de aantallen in een bepaalde steekproef overeenkomen met de theoretisch te verwachten waarden.
De toets maakt onderscheid tussen ‘kleine’ verschillen en ‘grote’ verschillen: worden de verschillen veroorzaakt door het toeval (verschillen zijn klein) of zal de conclusie zijn dat de verdeling in de steekproef afwijkt van de verwachte verdeling (verschillen zijn voldoende groot, ofwel significant).

Als voorbeeld data van jullie kruisingsexperiment met kolen:


fenotype         frequentie
--------------  -----------
glad-groen                3
groen-gekruld            14
rood-glad                10
rood-gekruld             37

De onderzoeksvraag was of de gevonden verdeling de verwachte verdeling volgt als rood en gekruld dominanten eigenschappen zijn, en de kruising Mendeliaanse overerving volgt.

De hypotheses zijn dan:

* H~0~: de verdeling volgt de theoretische verdeling.
* H~1~: de verdeling volgt niet de theoretische verdeling.


##Voorwaarden
De Chi-kwadraattoets is een afgeleide van de F-verdeling, welke weer een afgeleide is van de normale verdeling.
Dat werkt goed zolang de kans op een bepaalde frequentie niet te klein is.
Dat kan je checken met de **regel van Cochran**:

* Alle verwachte frequenties zijn groter of gelijk aan 1
* Het percentage cellen met verwachte frequenties kleiner dan 5 is minder dan 20%

Als niet aan deze voorwaarden voldaan wordt, heb je de volgende opties:

* Categoriën samenvoegen (zodat de gecombineerde frequenties boven de drempelwaarde komen)
* De H~0~ simuleren door middel van heel veel berekeneningen (wat heel gemakkelijk gaat in R)

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:cochran"><strong>(\#exr:cochran) </strong></span>Kruisingsexperiment:

* Test of de data van de kruisingsproef voldoet aan de regels van Cochran
</div>\EndKnitrBlock{exercise}


##Chi-kwadraattoets in R

Met de functie `chisq.test()` voor je de Chi-kwadraattoets uit (in dit geval voor de data van de kruisingsproef):
 

```r
chisq.test(df$frequentie, p=c(1/16, 3/16, 3/16,  9/16))
```

Als argumenten zijn de gevonden frequentie en de verwachte kansverdeling (als een vector) gegeven.

Hieronder staat de uitkomst:


```
## 
## 	Chi-squared test for given probabilities
## 
## data:  df$frequentie
## X-squared = 0.94444, df = 3, p-value = 0.8147
```
X-squared staat voor de Chi-kwadraatwaarde, df voor het aantal vrijheidsgraden en p-value voor de overschrijdingskans onder de H~0~.

In dit geval is $p>0.05$, dus we verwerpen de H~0~ niet (met $\alpha=0.05$).
We kunnen dus niet de aanname van Mendeliaanse overerving verwerpen.
Of met andere woorden: de gevonden frequentie is niet significant afwijkend van de voorspelde frequentie volgens Mendeliaanse overerving.

NB: de kansverdeling over de verschillende categoriën (argument **p** in de functie) moet bij elkaar opgeteld precies 1 zijn.
Dat kan simpel met de volgende code `p=df$verwach/sum(df$verwacht)`.
Alternatief is om als extra argument `rescale.p = TRUE` te gebruiken.
Dan berekent R automatisch de kansverdeling.

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:plantenkwekers"><strong>(\#exr:plantenkwekers) </strong></span>Enquête plantenkwekers:

In 2008 teelde 33% van de Nederlandse snijbloementelers als hoofdproduct roos, 29% chrysant, 25% tulp, de overige 13% andere soorten. 
In 2008 werd een enquête gehouden onder 200 Nederlandse snijbloementelers.
Daarvan teelden er 70 roos als hoofdgewas, 52 chrysant, 49 tulp, en de overige 29 andere soorten:
</div>\EndKnitrBlock{exercise}


Hoofdgewas    Aantal telers in enquête   Percentage kwekers
-----------  -------------------------  -------------------
Roos                                70                   33
Chysant                             49                   29
Tulp                                52                   25
Overig                              29                   13

De vraag is of de enquête representatief is voor de Nederlandse telers (met andere woorden de respondenten volgen dezelfde verdeling als de verdeling van kwekers in Nederland over de verschillende hoofdgewassen).

* Beschrijf de H~0~ en de H~1~.
* Test of aan de regel van Cochran wordt voldaan.
* Voer een Chi-kwadraattoets uit (voer data direct in in R, of maak eerst een Excelbestand).
* Wat is je conclusie


##Poisonverdeling
Met een Chi-kwadraattoets test je de gevonden frequentieverdeling ten opzichte van een theoretische verdeling.
Een veel voorkomende verdeling is de Poisonverdeling.
Deze verdeling is vernoemd naar [Siméon Poisson](https://nl.wikipedia.org/wiki/Sim%C3%A9on_Poisson).

Net als de binomiale verdeling gaat het hier om discrete data.
Het geeft ook de kans op x-aantal voorvallen.
Het verschil met de binomiale verdeling is dat je niet uitgaat van een bepaald aantal herhalingen (zoals de voorbeelden met een dobbelsteen), maar uitgaat van een *richting* oneindig aantal herhalingen (n) met een *richting* oneindig kleine kans (p) waarbij $n*p=\lambda$.
Het teken $\lambda$ (de Griekse letter *Lambda*) staat voor het gemiddelde aantal voorvallen.

Klinkt ingewikkeld?
Bekijk het voorbeeld (met figuren!) van de rekolonisatie door spinnen in het boek aandachten.

Gelukkig heeft R een simpele functie om de kansverdeling uit te rekenen.
Als voorbeeld *example 8.6* uit het boek:

* Sterven organismen random uit in de geschiedenis van het leven?

Raup en Sepkoski (1982) hebben data verzameld van mariene invertebraten en per tijdsblok aangegeven hoeveel families er uitstierven:


 aantal_uitstervingen   frequentie
---------------------  -----------
                    0            0
                    1           13
                    2           15
                    3           16
                    4            7
                    5           10
                    6            4
                    7            2
                    8            1
                    9            2
                   10            1
                   11            1
                   12            0
                   13            0
                   14            1
                   15            0
                   16            2
                   17            0
                   18            0
                   19            0
                   20            1

De vraag is nu of uitsterven gezien kan worden als random proces in de tijd, of dat er juist momenten zijn waarbij relatief veel dieren uitsterven (massa-extincties).

De H~0~ is dat uitsterven een random proces is, dus een Poissonverdeling volgt.
De H~1~ is dat uitsterven niet de Poissonverdeling volgt.

In R kunnen we gemakkelijk de verwachte waarden per tijdsvak uitrekenen als de H~0~ waar is.

De eerste stap is het gemiddeld aantal uitstervingen per tijdsvak te berekenen ($\lambda$  in de functie voor de Poissonverdeling).
Bovenstaande tabel is een frequentietabel, in dertien tijdsvakken is bijvoorbeeld 1 mariene invertebraatgroep uitgestorven.
Om het gemiddelde per tijdsvak te berekenen moeten we iedere regel net zo vaak meetellen als de frequentie aangeeft.
Dat noem je een gewogen gemiddelde:


```r
lambda <- weighted.mean(df$aantal_uitstervingen, df$frequentie)
lambda
```

```
## [1] 4.210526
```

Met deze waarde kunnen we verwachte frequentie voor ieder aantal uitstervingen per tijdvak berekenen:


```r
df$verwacht <- dpois(df$aantal_uitstervingen, lambda = lambda)*sum(df$frequentie)
```

Met `dpois()` bereken je de dichtheid voor ieder aantal.
Als je dat vermenigvuldigt met het totale aantal tijdvakken (de som van de frequenties) dan krijg je de verwachte verdeling van aantal uitstervingen over het totaal aantal tijdblokken (76 in dit geval).

Nu kunnen we de daadwerkelijke en de verwachte verdeling weergeven in een grafiek:

<img src="hfst3_chi_aanpassing_files/figure-html/unnamed-chunk-9-1.png" width="672" />

Je kan in de grafiek al zien dat de werkelijke verdeling anders loopt dan de Poissonverdeling.
Hoe waarschijnlijk is het nu om minstens zo'n afwijking t.o.v. de Poissonverdeling te vinden als H~0~ klopt?

We hebben nu een gevonden  en een verwachte frequentievedeling, dus kunnen we daar een Chi-kwadraattoets op loslaten.

Eerst de regel van Cochran toepassen:

* E~i~< 1?
* Aantal E~i~ < 5 > 20% van E~i~'s?

Elf cellen hebben een verwachte frequentie kleiner dan 1, en 15 cellen een verwachte frequentie kleiner dan 5 (dat is meer dan 20% van 21 cellen).
Dus we kunnen de Chi-kwadraattoets niet toepassen.

###Optie 1: categoriën samenvoegen
In het boek passen ze optie 1 toe: categorieën samenvoegen.
Je krijgt dan de volgende verdeling:


categorie    frequentie    verwacht
----------  -----------  ----------
a                    13    5.876068
b                    15    9.996501
c                    16   14.030177
d                     7   14.768607
e                    10   12.436722
f                     4    8.727524
g                     2    5.249639
h                     9    4.914760

Bijbehorende Chi-kwadraattoets:


```r
chisq.test(df_cat$frequentie, p=df_cat$verwacht, rescale.p = TRUE)
```

```
## 
## 	Chi-squared test for given probabilities
## 
## data:  df_cat$frequentie
## X-squared = 23.95, df = 7, p-value = 0.001163
```

NB: bovenstaande output is een fractie anders dan de uitwerking in het boek.
De reden is dat de verwachte frequenties berekend zijn op basis van het geschatte gemiddelde aantal uitstervingen per tijdvak.
Hiermee snoep je een vrijheidsgraad op.
Wil je het helemaal netjes aanpakken, dan moet je handmatig aangeven hoeveel vrijheidsgraden de Chikwadraatverdeling heeft onder de H~0~:


```r
fit <- chisq.test(df_cat$frequentie, p=df_cat$verwacht, rescale.p = TRUE)
pchisq(fit$statistic, df=6, lower.tail = FALSE)
```

```
##    X-squared 
## 0.0005334918
```


###Optie twee: simuleren
Optie twee is de verdeling onder de H~0~ te simuleren.
Dat kan met dezelfde functie `chisq.test()`, met als extra argument `simulate.p.value = TRUE`:


```r
chisq.test(df$frequentie, p=df$verwacht, 
           rescale.p = TRUE,simulate.p.value = TRUE)
```

```
## 
## 	Chi-squared test for given probabilities with simulated p-value (based
## 	on 2000 replicates)
## 
## data:  df$frequentie
## X-squared = 711152, df = NA, p-value = 0.0004998
```


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:extinction"><strong>(\#exr:extinction) </strong></span>Uitsterven

* Downdload de data van BB ("uitsterven.xlsx").
* Voer de Chi-kwadraattoets uit op de orinele data (wetende dat het niet voldoet aan de regel van Cochran).
* Voer nu de toets uit waarbij de de kansverdeling onder de H~0~ gesimuleerd wordt.
* Vergelijk de gevonden p-waarden. Neemt de fout van de eerste soort toe of af? Leg uit.
</div>\EndKnitrBlock{exercise}

##Chikwadraattoets op onafhankelijkheid
Zoals je in *section* 9.4 van het boek kan lezen, kan je de Chikwadraattoets ook gebruiken als je wilt testen of twee nominale variabele afhankelijk van elkaar zijn.
Met andere woorden: heeft categorie van de ene variabele effect op frequentieverdeling over de categorieën van de andere variabele.

Als voorbeeld *Example* 9.4 uit het boek.
Onderzoekers hebben het vermoeden dat vissen die geïnfecteerd zijn door een parasitaire worm een grotere kans hebben om gegeten te worden door reigers omdat ze vaker aan het oppervlak zwemmen.
Lafferty en Morris (1996) testten deze hypothese door vissen met drie niveaus van infectiegraad in een groot bassin te laten zwemmen, en te tellen hoeveel van welke groep gepredeerd werd:


gegeten        infectiegraad    frequentie
-------------  --------------  -----------
niet gegeten   niet                      1
niet gegeten   licht                    10
niet gegeten   zwaar                    37
wel gegeten    niet                     49
wel gegeten    licht                    35
wel gegeten    zwaar                     9

Bovenstaande manier is een goede manier om de data uit *Table* 9.4-1 in bijv. Excel te zetten.

De volgende hypotheses worden getest met de Chikwadraattoets op onafhankelijkheid:

* H~0~: Infectiegraad en gegeten worden zijn onafhankelijk
* H~1~: Infectiegraad en gegeten worden zijn niet onafhankelijk

De Chikwadraattoets op onafhankelijkheid kan op verschillende manieren data verwerken:

* als `table()` output (heb je gezien bij de krekeldata in jaar 1)
* als 'lange' tabel met op iedere regel een waarneming (je hebt dan 141 regels!)
* als matrix (gaan we hier niet doen)

Voor de eerste twee methoden moet je eerst de tabel 'lang' maken.
Daar is in tidyverse een simpele functie voor `uncount()`:



```r
library(tidyverse)
df_lang <- df %>% 
  uncount(frequentie)
```

Dan kan je de de Chikwadraattoets op onafhankelijkheid uitvoeren:


```r
chisq.test(df_lang$gegeten, df_lang$infectiegraad)
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  df_lang$gegeten and df_lang$infectiegraad
## X-squared = 69.756, df = 2, p-value = 7.124e-16
```

In principe kan je deze toets ook uitvoeren als je meer dan twee nominale variabelen hebt. 


##Extra opgaven
Gebruik bij onderstaande opgaven uit het boek R.
Ga dus niet zelf met de hand de Chikwadraatwwaarde uitrekenen, en overschrijdingskans opzoeken in een tabel.
Daar hebben we tegenwoordig computers voor!


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:chiboek"><strong>(\#exr:chiboek) </strong></span>*Practise problems*

Maak de volgende *Practise problems chapter 8 (vanaf blz. 225):

* 1, 2, 3 

Maak de volgende *Practise problems chapter 9 (vanaf blz. 258):

* 2, 7</div>\EndKnitrBlock{exercise}

<!--chapter:end:hfst3_chi_aanpassing.Rmd-->

#Clusteranalyse

\BeginKnitrBlock{ABD}<div class="ABD">
</div>\EndKnitrBlock{ABD}

we leven in het 'big data'-tijdperk.
Iedereen (op een enkele fanatiekeling na) die regelmatig gebruik maakt van internet draagt zijn steentje bij aan de informatieberg.
Deze informatie wordt gebruikt om "profielen" aan te maken.
Daarmee krijgen we gepersonificeerde reclame, nieuwsberichten, zoekresultaten, etc.
Hiervoor is statistiek nodig: multivariate analyses.

Multivariaat slaat op het aantal **respons**variabelen.
Tot nu toe hadden we te maken met één responsvariabele waarvan we de variatie wilden verklaren aan de hand van een of meerdere **verklarende** variabelen.
Nu hebben we te maken met meerdere (soms wel duizenden) responsvariabelen (bijv. hoe vaak je bepaalde websites gezocht hebt, of bepaalde zoektermen voorkwamen in je zoekopdrachten).
Vandaar de term **multi**variaat.

Binnen de ecologie wordt al lang met multivariate data gewerkt, vooral binnen de vegetatiekunde.
De responsvariabelen zijn dan de abundantie van de verschillende plantensoorten per plot.
Een onderzoeksvraag kan zijn welke plots op elkaar lijken en welke van elkaar verschillen.

Met de opkomst van *metagenomics* hebben we niet alleen voor planten, maar ook voor andere organismen (vooral microbiologie) enorme datasets met multivariate data.

Deze week en volgende week gaan jullie aan de slag met multivariate data.
We behandelen twee technieken:

* Clustering (deze les)
* MANOVA (volgende les)

Clustering is, zoals de naam al zegt, het clusteren van multivariate data.
MANOVA staat voor *Multivariate Analysis of Variance*, een soort van ANOVA met meerdere responsvariabelen.

> NB De bijbehorende powerpoint is tentamenstof.
De volgende paragrafen over clustering is in ontwikkeling, en geen tentamenstof (maar natuurlijk wel heel interessant!).

## Twee manieren van clusteren
Jullie zijn met het vak biotechnologie al een vorm van clusteren tegengekomen: de fylogenetische boom (**fylogram**), een voorbeeld van een **dendrogram**.
Deze manier van clusteren wordt **hierarchisch** genoemd.

Een andere manier van clusteren 



<!--chapter:end:hfst4_Cluster.Rmd-->

#MANOVA

Multivariate variantieanalyse (MANOVA) is een uitbreiding van de ANOVA's die je eerder hebt geleerd.
Het kan toegepast worden in het geval dat er twee of meer responsvariabelen zijn.

Een MANOVA is een scherpere toets dan een serie one-way ANOVA's vanwege de volgende redenen:

* houdt rekening met onderlinge samenhang tussen responsvariabelen
* onderzoekt of er tussen subgroepen (van verklarende variabelen) significante verschillen bestaan in gezamenlijke gemiddelden van de combinatie van de responsvariabelen

Er wordt, net als in een gewone ANOVA, een statistisch model geschat en een *test statistic*  uitgerekend (meestal **Pillai's trace**) en met een F-toets getest of deze afwijkt van de nulhypothese.


Voorbeeld: Fruitvliegjes
De vraag is of twee soorten fruitvliegjes van elkaar verschillen in een aantal kenmerken:

* lengte borststuk
* lengte vleugels
* lengte dijbeen
* lengte antenne
* oogomvang




soort   geslacht    borststuk   lengtevleugel   lengtedijbeen   oogomvang   antenne
------  ---------  ----------  --------------  --------------  ----------  --------
s1      man              1.01            2.51            0.06        0.52      0.11
s1      man              0.98            2.45            0.05        0.53      0.12
s1      man              1.02            2.57            0.08        0.55      0.11
s1      man              1.05            2.61            0.07        0.52      0.10
s1      vrouw            0.98            2.40            0.04        0.54      0.13
s1      vrouw            0.89            2.35            0.04        0.50      0.14
s1      vrouw            0.89            2.38            0.05        0.50      0.12
s1      vrouw            0.95            2.41            0.05        0.49      0.12
s2      man              1.20            3.10            0.09        0.48      0.09
s2      man              1.15            3.12            0.10        0.52      0.10
s2      man              1.18            3.21            0.09        0.52      0.11
s2      man              1.21            3.20            0.10        0.55      0.09
s2      vrouw            0.95            2.51            0.08        0.56      0.11
s2      vrouw            0.94            2.50            0.07        0.49      0.13
s2      vrouw            0.96            2.62            0.08        0.51      0.14
s2      vrouw            0.91            2.45            0.07        0.52      0.13

Wat zijn nu mogelijke hypotheses die je kan testen?

* Is er significant verschil in lengte vleugels, lengte borststuk, enz. tussen de twee soorten (hoofdeffect)?
* Is er significant verschil in lengte vleugels, lengte borstuk, enz., tussen de geslachten (hoofdeffect)?
* Verschilt het effect van geslacht per soort (interactie-effect)?

Welke nulhypothese hoort hier bij?

* De gemiddelden van de responsvariabelen zijn voor alle subgroepen gelijk.

##MANOVA in R
Hoe voer je nu een MANOVA uit in R?
Je hebt daarvoor de functie `manova()` waar je, net als in een `lm()` een statistisch model invoert.
Nu heb je meerdere responsvariabelen.
Die moet je samenvoegen met de functie `cbind()`.
Zie hieronder voor de code:


```r
fit <- manova(cbind(df$borststuk, 
             df$lengtevleugel, 
             df$lengtedijbeen,
             df$oogomvang,
             df$antenne) ~ df$soort*df$geslacht
      )
summary(fit)
```

```
##                      Df  Pillai approx F num Df den Df    Pr(>F)    
## df$soort              1 0.94188   25.928      5      8 9.589e-05 ***
## df$geslacht           1 0.95619   34.921      5      8 3.151e-05 ***
## df$soort:df$geslacht  1 0.93240   22.070      5      8 0.0001733 ***
## Residuals            12                                             
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Zoals te zien is er een significant verschil tussen de twee soorten, tussen geslacht en is er een interactie tussen geslacht en soort (sommige eigenschappen, of combi's van eigenschappen zijn bij de ene soort anders tussen de geslachten dan bij de andere soort).


##Posthoc
In voorgaand voorbeeld hadden de verklarende variabelen ieder maar twee niveau's, dus is een posthoctoets niet nodig om te bepalen welke categorieën significant van elkaar verschillen.

Heb je dat wel, dan kan je gewoon weer een posthoctoets uitvoeren:


```r
library(emmeans)

emmeans(fit, list(pairwise ~ var1), adjust = "tukey")
```

Net als bij een gewone ANOVA geldt dat je alleen tukey mag gebruiken als de groepen ongeveer even groot zijn.
Is dat niet zo, moet je bonferroni gebruiken.

##Oefeningen

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:poelen"><strong>(\#exr:poelen) </strong></span>Poelen.

Een groepje studenten onderzoeken voor hun jaarproject drie poelen in de buurt van Venlo en ze willen kijken of er verschillen zijn in de hoeveelheid van verschillende vormen stikstof. Daarvoor nemen ze per poel vijf monsters en per monster bepalen ze het gehalte nitriet, nitraat en ammonium. 

* Download de file poelen.xlsx van BB
* Importeer en bekijk de dataset. Waarom is een MANOVA hier geschikt om de data te analyseren?
* Voer een manova uit om te toetsen of er verschillen zijn tussen de drie poelen. 
* Als er een significant verschil is, voer dan een posthoctoets uit.
</div>\EndKnitrBlock{exercise}



<!--chapter:end:hfst5_multvar.rmd-->

#Voorbereiding op jaar 3 en 4

Met dit laatste hoofdstuk sluit je je statistiekonderwijs af.
Vanaf nu ga je het écht in de praktijk leren toepassen!


##Overzicht toetsen

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:overzicht"><strong>(\#exr:overzicht) </strong></span>Overzicht

* Maak voor jezelf een overzicht van de statistische toetsen die je tijdens je studie hebt geleerd.
* Geef voor iedere toets aan van wat voor niveau (interval/ratio, ordinaal of nominaal) de responsvariabele(n) en verklarende variabele(n) zijn.
* Geef voor iedere toets een voorbeeld van een bijbehorende experimentele opzet.
</div>\EndKnitrBlock{exercise}


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:welke_toets"><strong>(\#exr:welke_toets) </strong></span>Wanneer welke toets?

* Maak de quiz via de volgende [link](https://forms.office.com/Pages/ResponsePage.aspx?id=KiOfzFGYsEayPmQdaAWQ3wQeab5hX9VKmg2j17Cef29UOE9HRVE0S1dVRVBEV1JQMFFYV0RZUzdJUi4u)

</div>\EndKnitrBlock{exercise}

##Oefenen met case studies


```
## [1] "test"
```



<!--chapter:end:hfst6_overzichtoetsen.Rmd-->

