**Data Challenge 2 (due on 3/22 at 6PM)**

**1. Ask two (2) questions that might help you understand better the dynamics of violence contained on our data set. 
Apply one algorithm per question and share your insights from each analysis. [50 pts] 
Remember: a non-finding is also a finding! It tells you whether a question is worth pursuing further or not.**
- **perform the necessary transformations in your data - if any are needed, and explain why you did that**
- **show the output from your analysis in a consumable form**
- **be explicit about the limitations of your anaylisis, due to estimation or to the data itself**
- **did you find something interesting? what is that? does your finding suggest this question is worth pursuing further? why or why not?**
- **if you did not find something interesting, explain why, and whether there is some additional information that would help in answering your question**
- **provide your code, and a single visualization per question that summarizes your finding**
- **phrase your finding for each question in two ways:**
  - **one sentence that summarizes your insight**
  - **one paragraph that reflects all nuance in your insight**
  - **make sure to also include your code**

**Question 1:** Can we predict total people dead based on the variables given in our data set and by using a multilinear regression?

My hypothesis is that by looking at the different types of items seized in a confrontation and whether a particular government body participated in a confrontation I might be able to better understand how many people are killed in an event.  My reasoning behind this is that certain types of weapons are more destructive than others and the presence of them in a confrontation might help predict whether an event will have higher or lower death rates. Additionally, one government body might be more effective (or conversely ineffective) than other bodies. Hypothetically speaking, if the navy was the most lethal government body in confrontations, looking at which events had navy participants might help predict the total number of people dead. Government officials, the military and public policy makers who might consider the ethical justifications of future policy measures might benefit from understanding what factors predict the total number of people dead and whether or not certain strategies should be used to combat organized crime based on this relationship. 

Before creating my linear I confirm the distribution of the variable ```total.people.dead```.

![](https://cloud.githubusercontent.com/assets/5368361/24215041/dcc2bc76-0f0d-11e7-9c01-6d4014257436.png)

My initial linear model is below:

```r
> summary(lm1)

Call:
lm(formula = total.people.dead ~ afi + army + federal.police + 
    ministerial.police + municipal.police + navy + other + state.police + 
    long.guns.seized + small.arms.seized + cartridge.sezied + 
    clips.seized + vehicles.seized, data = all_vio)

Residuals:
    Min      1Q  Median      3Q     Max 
-12.118  -0.966  -0.749   0.337  50.737 

Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         1.389e+00  6.245e-02  22.240  < 2e-16 ***
afi                 5.574e-01  5.016e-01   1.111   0.2665    
army               -4.228e-01  7.753e-02  -5.453 5.16e-08 ***
federal.police     -5.486e-01  9.911e-02  -5.536 3.25e-08 ***
ministerial.police -4.597e-01  1.133e-01  -4.056 5.06e-05 ***
municipal.police   -6.400e-01  8.177e-02  -7.828 5.95e-15 ***
navy                1.084e-01  1.708e-01   0.635   0.5255    
other              -1.259e-01  1.598e-01  -0.788   0.4309    
state.police       -4.915e-01  1.074e-01  -4.577 4.81e-06 ***
long.guns.seized    1.568e-01  1.026e-02  15.286  < 2e-16 ***
small.arms.seized  -3.802e-03  2.196e-02  -0.173   0.8626    
cartridge.sezied   -1.916e-04  2.298e-05  -8.337  < 2e-16 ***
clips.seized        1.172e-04  3.753e-04   0.312   0.7549    
vehicles.seized     1.051e-02  4.152e-03   2.531   0.0114 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.06 on 5382 degrees of freedom
Multiple R-squared:  0.08532,	Adjusted R-squared:  0.08311 
F-statistic: 38.62 on 13 and 5382 DF,  p-value: < 2.2e-16
```

First, looking at the F-statistic we can see that 38.62 is statistically significant and tells us that there are relatively good relationships between our predictors and response variables but that number could be improved. Looking at the coefficients we can see that the army, federal police, ministerial police, municipal police, state police and the seizure of cartridges all have negative statistically significant effects on the total number of people dead. The only highly positive statistically significant coefficient is the number of long guns seized. 


The next step in my analysis will be to incorporate interactions in my model since there is the possibility that the variables used above may be interacting with eachother and the effect of one predictor variable on the response variable is different at different values of  other predictor variables. Specifically I will look at the two statistically significant items seized and how they interact with the statistically significant government bodies that effect total people dead.

```r
> summary(lm2)

Call:
lm(formula = total.people.dead ~ afi + army + federal.police + 
    ministerial.police + municipal.police + navy + other + state.police + 
    long.guns.seized + small.arms.seized + cartridge.sezied + 
    clips.seized + vehicles.seized + army * long.guns.seized + 
    army * cartridge.sezied + federal.police * long.guns.seized + 
    federal.police * cartridge.sezied + ministerial.police * 
    long.guns.seized + ministerial.police * cartridge.sezied + 
    municipal.police * long.guns.seized + municipal.police * 
    cartridge.sezied + state.police * long.guns.seized + state.police * 
    cartridge.sezied, data = all_vio)

Residuals:
   Min     1Q Median     3Q    Max 
-9.121 -1.045 -0.701  0.301 50.773 

Coefficients:
                                      Estimate Std. Error t value Pr(>|t|)    
(Intercept)                          1.342e+00  6.424e-02  20.897  < 2e-16 ***
afi                                  4.607e-01  4.999e-01   0.922 0.356749    
army                                -2.975e-01  8.076e-02  -3.684 0.000232 ***
federal.police                      -6.419e-01  1.048e-01  -6.125 9.73e-10 ***
ministerial.police                  -4.707e-01  1.182e-01  -3.982 6.91e-05 ***
municipal.police                    -5.985e-01  8.370e-02  -7.151 9.77e-13 ***
navy                                -9.017e-02  1.726e-01  -0.523 0.601308    
other                               -1.159e-01  1.593e-01  -0.727 0.467102    
state.police                        -4.203e-01  1.117e-01  -3.762 0.000170 ***
long.guns.seized                     1.769e-01  2.010e-02   8.800  < 2e-16 ***
small.arms.seized                   -1.604e-03  2.257e-02  -0.071 0.943333    
cartridge.sezied                     1.473e-04  9.378e-05   1.571 0.116306    
clips.seized                         2.247e-05  3.772e-04   0.060 0.952505    
vehicles.seized                      1.043e-02  4.132e-03   2.523 0.011649 *  
army:long.guns.seized               -4.513e-02  2.138e-02  -2.111 0.034811 *  
army:cartridge.sezied               -3.274e-04  9.566e-05  -3.423 0.000624 ***
federal.police:long.guns.seized      1.095e-01  3.111e-02   3.520 0.000435 ***
federal.police:cartridge.sezied     -4.914e-04  1.298e-04  -3.787 0.000154 ***
ministerial.police:long.guns.seized  1.658e-02  5.979e-02   0.277 0.781609    
ministerial.police:cartridge.sezied  2.032e-04  3.961e-04   0.513 0.607997    
municipal.police:long.guns.seized   -3.534e-02  3.298e-02  -1.072 0.283945    
municipal.police:cartridge.sezied    1.160e-04  1.897e-04   0.612 0.540704    
state.police:long.guns.seized       -8.055e-02  3.517e-02  -2.290 0.022049 *  
state.police:cartridge.sezied        1.585e-04  1.772e-04   0.895 0.371054    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.049 on 5372 degrees of freedom
Multiple R-squared:  0.09698,	Adjusted R-squared:  0.09311 
F-statistic: 25.08 on 23 and 5372 DF,  p-value: < 2.2e-16
``` 

After adding the interactions we see that holding other variables constant, when no long guns are seized and when army personnel, pederal police, ministerial police, municipal policeand state police are involved in a confrontation there continues to be a statistically significant and negative effect on the number of people dead in an event. Additionally when cartridges are seized by the army or the federal police there also appears to be a negative statistically significant effect on the number of people dead. What is interesting however is the positive effect on the number of people dead when long guns are seized by the federal police. Purhaps a closer look at the common practices of the federal police compared to other security forces or government bodies should be looked into. Additionally, other factors such as how many federal police agents present per event would be helpful. Perhaps the more federal police agents there are the higher the death count.  

Some limitations to this model include the fact that you can only ascertain relationships, but never be sure about underlying causal mechanism. Thus we cannot say for certain whether the presence of the federal police in a confrontation causes an increase in total dead or not. There are probably many other factors that might be useful in predicting the total number of dead - either as constitutive terms or constitutive terms with various interaction terms that could provide a more clear understanding of the relationship of perfect lethality and other variables. Another limitation to this model is that there are a large number of events where there were no people killed. 

A vizualiation for my second model is shown below.

![](https://cloud.githubusercontent.com/assets/5368361/24216223/cdf5c8e2-0f11-11e7-9c54-9541208553b9.png)

**One sentence:** For every additional long gun seized by the federal police the total number of people dead in an event is on average increased by ~3 deaths.

**On paragraph:** When trying to understand the underlying factors for the total number of people dead in confrontations between organized crime and goverment bodies like the miliatry or police force, the  types of weapons seized and who is involved in the confrontation are important. The most important weapon seizure that is positively assoiated to the number of deaths in a confrontation is the long gun -  holding other variables constant, when long guns are seized the total number of people dead is more likely to increase. In particular there is a positive correlation between the federal police seizing long guns and the increase in deaths in confrontations.  


**Question 2:** Can we predict perfect lethality based on the variables given in our data set using a random forest algorithm?
My hypothesis is similar to the hypoethesis above in that by looking at the different types of items seized in a confrontation and whether a particular government body participated in a confrontation I might be able to better understand what factors are associated with perfect lethality confrontations. My reasoning behind this is that certain types of weapons are more destructive than others and the presence of them in a confrontation might help predict whether an event will have pefect lethality or not. Additionally, one government body might be more effective (or conversely ineffective) than other bodies. Hypothetically speaking, if the navy was the most lethal government body in confrontations, looking at which events had navy participants might help predict whether a confrontation might have perfect lethality. Government officials, the military and public policy makers who might consider the ethical justifications of future policy measures might benefit from understanding what factors predict perfect lethality and whether or not certain strategies should be used to combat organized crime based on this relationship. Perhaps a different strategy that does not endager the lives of civilians might be more effective.

First looking at the number of confrontations that had perfect lethality we can see that 27.4% had perfect lethality. 

```r
prop.table(table(vio_data$perfect.lethality))

        0         1 
0.7255374 0.2744626 
```
Before implementing a random forest algorithm on my dataset, I first created a simple decision tree to look at the probabilities of certain outcomes. 

``` r
vio_data <- all_vio[c("event.id", "total.people.dead", "state", "afi", "army", "federal.police", "ministerial.police", "municipal.police",  
                      "navy", "other", "state.police", "long.guns.seized", "small.arms.seized", "cartridge.sezied", "clips.seized",
                      "vehicles.seized", "perfect.lethality")]
                      
vfit <- rpart(perfect.lethality ~ long.guns.seized + afi + army + federal.police + ministerial.police + municipal.police + 
                navy + other + state.police  + small.arms.seized + cartridge.sezied + clips.seized +
                vehicles.seized,
              data=vio_data,
              method="class")
              
fancyRpartPlot(vfit)
```


![](https://cloud.githubusercontent.com/assets/5368361/24261594/dd786fa6-0fcd-11e7-9040-ae76bb39f83b.png)


In the root node we see that events that did not have any long guns seized (since you cannot seize 0.5 of a gun), the probabiloity that an event would not have perfect lethality is 82%. Then we see that if long guns were seized and the army is not present in a confrontation the event is 64% likely to not have perfect lethality. The next node shows that for events where  long guns were seized, the army was not ino=voled and 3 or more catridges were seized along with less than 3 long guns, the likelihood that an event would not contain perfect lethality is 59%. The last two leaf nodes show us that if long guns were seized, the army was not involved and either 1) 3 or more cartridges were seized and more than 3 long guns were seized or 2) less than 3 cartridges were seized the likelihood of perfect lethality would be 56% or 61% respectively. 


Since decision tree algorithms make decisions on the current node which appear to be the best at the time, but are unable to change their mind as they grow new nodes, are prone to overfitting themselves and are biased to favour factors with many levels, I will switch over to a random forest algorithm to see which variables might be the best predictors for perfect lethality. 

``` r
set.seed(415)
vfit2 <- randomForest(as.factor(perfect.lethality) ~ afi + army + federal.police + ministerial.police + municipal.police + 
                      navy + other + state.police + long.guns.seized + small.arms.seized + cartridge.sezied + clips.seized +
                      vehicles.seized,
                    data=vio_data, 
                    importance=TRUE, 
                    ntree=500)
varImpPlot(vfit2)
```

![](https://cloud.githubusercontent.com/assets/5368361/24261546/b7e65cb2-0fcd-11e7-9500-8037daf5801f.png)

Fromt the results shown above we can see that long guns seized have the highest accuracy and Gini values which mean that long guns seized is a very predictive variable for perfect lethality and if this variable were taken out of the model this would greatly affect the results of predicting perfect lethality.  Some limitations for this analysis include having only so much available data. It would be interesting to look at how many police officers, soldiers, etc. were involved in a specific conflict to see if there are any important predictive variables that this current model is missing. Also one limitation of using random forest models is that there is a limit of 32 levels that random forests in r can digest. I was also curious at looking at how geography factors into this analysis since I imagine that the state and municipality differ greatly. There are currently 735 different municipalities and 32 states. When I tried to run the random forest algorithm using the 32 states my R program crashed multiple times so I wasn't able to run that analysis at this time. I think though as a next step, it would be interesting to look into that further. 

Something that I found interesting is that compared to government bodies, various weapons seized were overall more important predictors of perfect lethality. Having more information on how these variables were calculated and the accuracy of this information would be helpful in pursing this further. Additionally if other categories were made available of items seized in a confrontation perhaps new insight could be found there. 

**One sentence:** Using a random forst algorithm long guns seized is the most important variable in predicting perfect lethality. 

**One paragraph:** When trying to understand the underlying factors for whether a confrontation will result in perfect lethality, the  types of weapons seized appear to be better predictors overall than who is involved in the confrontation are important. The most important weapon seizure is the long gun. Confrontations that involve the afi, other armed forces or government entities and the navy appear to be the worst predictors for perfect lethality. Further research on whether these three groups are still effective in decreasing crime might be interesting to look especially because that might mean that they are still effective while minimizing the loss of human life. 


**2. Formulate two (2) conditional hypotheses that you seek to investigate with the data. One of your hypotheses should 
condition on two variables (as the example on the slides), and the other should condition on three variables. [50 pts]**

- **formulate each one of your hypotheses explicitly in substantive terms (as opposed to statistical terms) using 2-3 lines at most**
- **show exactly how each one of your hypotheses translates into the marginal effect that you will seek to estimate from the data**
- **show the output from your analysis in a consumable form**
- **show all your computations to estimate the corresponding marginal effect and its standard error**
- **be explicit in your assumptions**
- **be explicit in the limitations of your inferences**
- **phrase your finding for each question in two ways:**
  - **one sentence that summarizes your insight**
  - **one paragraph that reflects all nuance in your insight**
  - **make sure to also include your code**

**Conditional Hypothesis 1:** That there is a meaningful relationship between the number of civilian dead and the types of weapons seized as well as the group of armed forces or government entities. Furthermore, this relationship between the number of civilian wounded on the amount of civilian dead if the number of long guns seized were varied.  

This hypothesis is coming from the first model above that long guns seized and the federal police have a meaningful relationship with the total number of people dead. I'm interested in seeing if this is the same for the amount of civilians dead and whether or not further research is warranted on the federal police tactics. 

The first multilinear model below doesn't have any interactions within the model. Without any interactions we can see that the number of civilian wounded is positively associated with the number of civilian deaths (at a statistically significant rate) and that the army and other governmental groups or entities are moderately associated with the number of civilian deaths - negative associate with the army and a positive association with the other groups. 

Given that the number of civilian wounded is highly associated with civilian deaths, adding an interaction with long guns seized with the number of civilian deaths would perhaps increase the number of civilian deaths. Since long guns are the most deadly weapons seized in this datasetm the presence of long guns (by the fact that they have been seized) may mean that the event was more violent and destructive and that civilians are at a higher risk of dying in said events. Thus we would expect that the interaction term would be positive and statistically significant and the marginal effect would be higher than computing this model without the interaction term. 

``` r
> lm3 <- lm(civilian.dead ~ long.guns.seized + small.arms.seized + cartridge.sezied + clips.seized +
+              vehicles.seized + civilian.wounded + afi + army + federal.police + ministerial.police + 
+             municipal.police + navy + other + state.police, data = all_vio)
> summary(lm3)

Call:
lm(formula = civilian.dead ~ long.guns.seized + small.arms.seized + 
    cartridge.sezied + clips.seized + vehicles.seized + civilian.wounded + 
    afi + army + federal.police + ministerial.police + municipal.police + 
    navy + other + state.police, data = all_vio)

Residuals:
   Min     1Q Median     3Q    Max 
-4.118 -0.084 -0.039 -0.018 49.797 

Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         1.015e-01  2.517e-02   4.034 5.56e-05 ***
long.guns.seized    6.975e-03  4.110e-03   1.697  0.08973 .  
small.arms.seized   1.063e-02  8.796e-03   1.208  0.22712    
cartridge.sezied   -1.370e-05  9.207e-06  -1.488  0.13680    
clips.seized       -8.702e-05  1.503e-04  -0.579  0.56273    
vehicles.seized    -3.935e-04  1.663e-03  -0.237  0.81299    
civilian.wounded    2.397e-01  1.447e-02  16.564  < 2e-16 ***
afi                 1.259e-01  2.009e-01   0.626  0.53103    
army               -8.927e-02  3.108e-02  -2.872  0.00410 ** 
federal.police     -5.114e-02  3.970e-02  -1.288  0.19774    
ministerial.police -2.441e-02  4.540e-02  -0.538  0.59081    
municipal.police   -6.239e-02  3.276e-02  -1.905  0.05688 .  
navy               -1.126e-01  6.841e-02  -1.646  0.09984 .  
other               1.839e-01  6.412e-02   2.868  0.00415 ** 
state.police       -8.383e-02  4.303e-02  -1.948  0.05142 .  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.8251 on 5381 degrees of freedom
Multiple R-squared:  0.05599,	Adjusted R-squared:  0.05353 
F-statistic: 22.79 on 14 and 5381 DF,  p-value: < 2.2e-16
```

Once an interaction term is added for civilian wounded and long guns seized we see that the statistically significant coefficients have changed slightly. Civilian wounded still remains as having a positive association with civilian deaths and the army and other still remain slightly significant (negative for the army and positive for the other group). But now we see that there is a statistically significant negative association when long guns are seized and civilian are wounded on the number of civilian deaths. Perhaps in situations like this the government forces are more concerned with seizing weapons than they are in shooting at people? Who knows. But it is an interesting finding to date. 

``` r 
> lm4 <- lm(civilian.dead ~ long.guns.seized + small.arms.seized + cartridge.sezied + clips.seized +
+             vehicles.seized + civilian.wounded + afi + army + federal.police + ministerial.police + 
+             municipal.police + navy + other + state.police + civilian.wounded * long.guns.seized, data = all_vio)
> summary(lm4)

Call:
lm(formula = civilian.dead ~ long.guns.seized + small.arms.seized + 
    cartridge.sezied + clips.seized + vehicles.seized + civilian.wounded + 
    afi + army + federal.police + ministerial.police + municipal.police + 
    navy + other + state.police + civilian.wounded * long.guns.seized, 
    data = all_vio)

Residuals:
   Min     1Q Median     3Q    Max 
-4.810 -0.088 -0.034 -0.016 49.413 

Coefficients:
                                    Estimate Std. Error t value Pr(>|t|)    
(Intercept)                        8.828e-02  2.516e-02   3.509 0.000454 ***
long.guns.seized                   9.548e-03  4.114e-03   2.321 0.020337 *  
small.arms.seized                  1.238e-02  8.768e-03   1.412 0.157975    
cartridge.sezied                  -1.723e-05  9.190e-06  -1.875 0.060888 .  
clips.seized                      -9.926e-05  1.498e-04  -0.663 0.507585    
vehicles.seized                   -3.507e-04  1.657e-03  -0.212 0.832418    
civilian.wounded                   2.878e-01  1.626e-02  17.695  < 2e-16 ***
afi                                1.390e-01  2.002e-01   0.694 0.487622    
army                              -8.110e-02  3.100e-02  -2.617 0.008907 ** 
federal.police                    -4.713e-02  3.956e-02  -1.191 0.233595    
ministerial.police                -1.813e-02  4.524e-02  -0.401 0.688578    
municipal.police                  -5.683e-02  3.265e-02  -1.741 0.081785 .  
navy                              -1.071e-01  6.817e-02  -1.572 0.116057    
other                              1.968e-01  6.392e-02   3.079 0.002087 ** 
state.police                      -8.097e-02  4.287e-02  -1.889 0.058976 .  
long.guns.seized:civilian.wounded -1.728e-02  2.705e-03  -6.388 1.82e-10 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.8221 on 5380 degrees of freedom
Multiple R-squared:  0.06309,	Adjusted R-squared:  0.06048 
F-statistic: 24.15 on 15 and 5380 DF,  p-value: < 2.2e-16 
```
civilian dead = b0 + b1 * long guns seized + b2 * civilian wounded + b3 * long guns seized * civilian wounded + e

              
marginal effect = b1 + b3 * long guns seized
                 = 0.009548 - 0.01728 * 1  
                 = -.007732

standard error = Var(b1)+Var(b3)⋅Z^2+2⋅Z⋅Cov(b1,b3)


``` r
> vcov(lm4)
                                    (Intercept) long.guns.seized small.arms.seized cartridge.sezied  clips.seized vehicles.seized
(Intercept)                        6.330567e-04    -1.753298e-06     -2.021382e-06     1.015047e-09 -5.989694e-08   -1.944040e-06
long.guns.seized                  -1.753298e-06     1.692746e-05     -1.760065e-05    -2.519424e-08 -1.231568e-07   -4.113869e-07
small.arms.seized                 -2.021382e-06    -1.760065e-05      7.688237e-05     1.540199e-08 -1.436575e-08   -4.047900e-07
cartridge.sezied                   1.015047e-09    -2.519424e-08      1.540199e-08     8.444978e-11 -9.351069e-11    1.578826e-10
clips.seized                      -5.989694e-08    -1.231568e-07     -1.436575e-08    -9.351069e-11  2.243844e-08   -1.091213e-09
vehicles.seized                   -1.944040e-06    -4.113869e-07     -4.047900e-07     1.578826e-10 -1.091213e-09    2.746397e-06
civilian.wounded                  -5.529553e-05     2.118344e-06      2.298587e-06    -2.702124e-09 -1.275699e-09    7.852377e-08
afi                               -9.794971e-05    -3.326296e-05      1.144082e-05     6.193577e-08  3.707773e-07   -1.738705e-06
army                              -5.709737e-04    -1.982232e-05     -1.257188e-05     1.937498e-08 -7.306057e-08   -8.454049e-07
federal.police                    -5.005080e-04    -7.206088e-06     -1.929264e-05     1.194326e-08  1.388523e-07    3.475644e-07
ministerial.police                -5.323513e-04    -2.001050e-06     -8.935895e-06     5.904044e-09  9.497019e-08    9.458083e-07
municipal.police                  -5.685039e-04     1.028539e-07     -8.911376e-06     2.877553e-09  8.874958e-08    1.434503e-06
navy                              -5.224726e-04    -1.922941e-05     -1.040582e-05     2.033587e-08  3.485551e-08   -6.032209e-06
other                             -4.666548e-04    -5.572530e-06     -1.357887e-05     1.430510e-08  1.410058e-07    6.564152e-07
state.police                      -4.488726e-04    -4.307541e-06     -1.259967e-05     9.041494e-09  1.319402e-07    1.202953e-06
long.guns.seized:civilian.wounded  5.608383e-06    -1.089943e-06     -7.436970e-07     1.493911e-09  5.184168e-09   -1.813547e-08
                                  civilian.wounded           afi          army federal.police ministerial.police municipal.police
(Intercept)                          -5.529553e-05 -9.794971e-05 -5.709737e-04  -5.005080e-04      -5.323513e-04    -5.685039e-04
long.guns.seized                      2.118344e-06 -3.326296e-05 -1.982232e-05  -7.206088e-06      -2.001050e-06     1.028539e-07
small.arms.seized                     2.298587e-06  1.144082e-05 -1.257188e-05  -1.929264e-05      -8.935895e-06    -8.911376e-06
cartridge.sezied                     -2.702124e-09  6.193577e-08  1.937498e-08   1.194326e-08       5.904044e-09     2.877553e-09
clips.seized                         -1.275699e-09  3.707773e-07 -7.306057e-08   1.388523e-07       9.497019e-08     8.874958e-08
vehicles.seized                       7.852377e-08 -1.738705e-06 -8.454049e-07   3.475644e-07       9.458083e-07     1.434503e-06
civilian.wounded                      2.644543e-04  1.177310e-05  2.868671e-05   9.852532e-06       1.553792e-05     1.434213e-05
afi                                   1.177310e-05  4.007637e-02  5.452041e-05  -1.347118e-04       2.832482e-05     4.866590e-05
army                                  2.868671e-05  5.452041e-05  9.607473e-04   4.661914e-04       4.846748e-04     5.185505e-04
federal.police                        9.852532e-06 -1.347118e-04  4.661914e-04   1.565005e-03       4.021689e-04     4.326865e-04
ministerial.police                    1.553792e-05  2.832482e-05  4.846748e-04   4.021689e-04       2.046792e-03     4.652431e-04
municipal.police                      1.434213e-05  4.866590e-05  5.185505e-04   4.326865e-04       4.652431e-04     1.065912e-03
navy                                  1.929900e-05  1.616243e-04  5.109540e-04   4.512328e-04       4.222975e-04     4.818835e-04
other                                -3.580504e-05 -5.161315e-04  4.269881e-04   3.583191e-04       3.647152e-04     4.239560e-04
state.police                         -1.108233e-05 -3.714506e-05  4.002345e-04   3.097056e-04       3.545540e-04     3.673776e-04
long.guns.seized:civilian.wounded    -2.034599e-05 -5.543106e-06 -3.459207e-06  -1.700039e-06      -2.658113e-06    -2.353974e-06
                                           navy         other  state.police long.guns.seized:civilian.wounded
(Intercept)                       -5.224726e-04 -4.666548e-04 -4.488726e-04                      5.608383e-06
long.guns.seized                  -1.922941e-05 -5.572530e-06 -4.307541e-06                     -1.089943e-06
small.arms.seized                 -1.040582e-05 -1.357887e-05 -1.259967e-05                     -7.436970e-07
cartridge.sezied                   2.033587e-08  1.430510e-08  9.041494e-09                      1.493911e-09
clips.seized                       3.485551e-08  1.410058e-07  1.319402e-07                      5.184168e-09
vehicles.seized                   -6.032209e-06  6.564152e-07  1.202953e-06                     -1.813547e-08
civilian.wounded                   1.929900e-05 -3.580504e-05 -1.108233e-05                     -2.034599e-05
afi                                1.616243e-04 -5.161315e-04 -3.714506e-05                     -5.543106e-06
army                               5.109540e-04  4.269881e-04  4.002345e-04                     -3.459207e-06
federal.police                     4.512328e-04  3.583191e-04  3.097056e-04                     -1.700039e-06
ministerial.police                 4.222975e-04  3.647152e-04  3.545540e-04                     -2.658113e-06
municipal.police                   4.818835e-04  4.239560e-04  3.673776e-04                     -2.353974e-06
navy                               4.646741e-03  4.022222e-04  3.834300e-04                     -2.311232e-06
other                              4.022222e-04  4.085310e-03  2.534228e-04                     -5.475496e-06
state.police                       3.834300e-04  2.534228e-04  1.837901e-03                     -1.211643e-06
long.guns.seized:civilian.wounded -2.311232e-06 -5.475496e-06 -1.211643e-06                      7.318016e-06
```
``` r
> lm4_var <-  0.00016927 + 1 * 1 * 0.000007318 + 2 * 1 * 0.0000010899
> lm4_var
[1] 0.0001787678
> sqrt(lm4_var)
[1] 0.01337041
```
Thus the standard error of the marginal effect is 0.01337041.

By using this model I am assuming that the relationship between these variables is linear and continuous and that the predictors are not significantly correlated with one another. Some limitations include the fact that there may be other predictive factors that are correlated with one another that this model does not address and that there may be other data not currently available that might better explain the association with civilian deaths. 

**One sentence:** When long guns are seized and civilians are wounded, the number of civilian deaths is more likely to decrease. 

**One paragraph:** Contrary to my original hypothesis, it appears that the seizure of long guns and higher number of civilian wounded is more likely associated with a decrease in civilian deaths. It may be because the government forces did not need to enact more violence and risk the possibility of higher deaths in general and also higher civilian deaths once long guns were seized.b Additionally we see that conforntations that involve the army are more likely to have lower rates of civlian death whereas other armed forces or government entity confrontations are more likely to have higher rates of civilian death. 

**Hypothesis 2:** That there is a meaningful relationship between the number of civilian dead and the types of weapons seized as well as the group of armed forces or government entities. Furthermore, this relationship between the number of civilian wounded on the amount of civilian dead if the number of long guns seized were varied and if the army specifically did or did not participate in a confrontation.

Since the interaction model above showed a negative significant relationship between participation of the army in a conflict and the number of civilians dead, I am curious to see if that relationship is maintained if an interaction is added to account for additional variation in my model. 

``` r
> lm5 <- lm(civilian.dead ~ long.guns.seized + small.arms.seized + cartridge.sezied + clips.seized +
+             vehicles.seized + civilian.wounded + afi + army + federal.police + ministerial.police + 
+             municipal.police + navy + other + state.police + civilian.wounded * long.guns.seized * army, data = all_vio)
> summary(lm5)

Call:
lm(formula = civilian.dead ~ long.guns.seized + small.arms.seized + 
    cartridge.sezied + clips.seized + vehicles.seized + civilian.wounded + 
    afi + army + federal.police + ministerial.police + municipal.police + 
    navy + other + state.police + civilian.wounded * long.guns.seized * 
    army, data = all_vio)

Residuals:
   Min     1Q Median     3Q    Max 
-5.621 -0.084 -0.040 -0.022 49.175 

Coefficients:
                                         Estimate Std. Error t value Pr(>|t|)    
(Intercept)                             8.453e-02  2.541e-02   3.326 0.000886 ***
long.guns.seized                        2.787e-03  5.788e-03   0.482 0.630171    
small.arms.seized                       1.156e-02  8.764e-03   1.319 0.187243    
cartridge.sezied                       -1.940e-05  9.337e-06  -2.078 0.037799 *  
clips.seized                           -1.053e-04  1.495e-04  -0.704 0.481280    
vehicles.seized                        -3.764e-04  1.654e-03  -0.228 0.820008    
civilian.wounded                        3.176e-01  1.760e-02  18.042  < 2e-16 ***
afi                                     1.601e-01  1.999e-01   0.801 0.423159    
army                                   -7.148e-02  3.263e-02  -2.191 0.028520 *  
federal.police                         -3.803e-02  3.955e-02  -0.962 0.336342    
ministerial.police                     -1.433e-02  4.519e-02  -0.317 0.751111    
municipal.police                       -5.465e-02  3.267e-02  -1.673 0.094450 .  
navy                                   -8.427e-02  6.874e-02  -1.226 0.220283    
other                                   2.000e-01  6.382e-02   3.133 0.001737 ** 
state.police                           -7.342e-02  4.283e-02  -1.714 0.086529 .  
long.guns.seized:civilian.wounded      -2.360e-02  8.157e-03  -2.893 0.003825 ** 
civilian.wounded:army                  -2.063e-01  4.645e-02  -4.442  9.1e-06 ***
long.guns.seized:army                   9.196e-03  5.910e-03   1.556 0.119760    
long.guns.seized:civilian.wounded:army  1.951e-02  9.076e-03   2.149 0.031640 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.8205 on 5377 degrees of freedom
Multiple R-squared:  0.06719,	Adjusted R-squared:  0.06407 
F-statistic: 21.52 on 18 and 5377 DF,  p-value: < 2.2e-16
```

First it looks as though this might not be the best model as my F-statistic is decreasing compared to lm4 and lm3 so this may be overkill as an analyis. But as expected civilian wounded is still a positive and statistically significant variable in predicting civilian death. Compared to the previous model though it appears the interaction between long gun seizure and civilian wounded becomes less significant and the interaction between the number of civilian wounded and the presence of the army in a confrontation is more negatively significant in predicting civilian deaths. Thus the presence of civilian wounded and the army in a confrontation is more likely to result in a decrease in civilian deaths by -0.02063. If the marginal effect that is calculated from this three-way interaction is positive we will see that conditioning on the presence of the army adds any additional information to this model about the relationship between long gun seizures and civlian wounded on civilian deaths. 

civilian_deaths = b0 + b1 * long guns seized + b2 * civilian wounded + b3 * army + b4 * long guns seized * civilian wounded + b5 * civilian wounded * army + b6 * long guns seized * army + b7 * long guns seized * civilians wounded * army + e

marginal effect = b1 + b4 * long guns seized + b6 * long guns seized * army + b7 * long guns seized * civilians wounded * army
                 =  0.002787 - 0.02360 + 0.009196 + 0.01951
                 = .007893

This means that the army is present in a confrontation and there is a long gun seized, each additional civilian wounded is associated with 0.007893 more civilian deaths.        

standard error = Var(b1) + Z^2 * Var(b4) + W^2 * Var(b6) + Z^2 * W^2 * Var(b7) + 2 * Z * Cov(b1, b4) + 2 * W * Cov(b1, b6) + 2 * Z * W *  Cov(b1, b7) + 2 * Z * W * cov(b4, b6) + 2 * W * Z^2 * Cov(b4, b7) + 2 * Z * W^2 * Cov(b6, b7)

Z = civilian wounded
W = army (0 = no army, 1 = army)

``` r
> vcov(lm5)
                                         (Intercept) long.guns.seized small.arms.seized
(Intercept)                             6.457029e-04    -1.489899e-05     -1.238565e-06
long.guns.seized                       -1.489899e-05     3.349539e-05     -1.759504e-05
small.arms.seized                      -1.238565e-06    -1.759504e-05      7.680735e-05
cartridge.sezied                       -4.992918e-09    -1.845556e-08      1.502895e-08
clips.seized                           -6.490574e-08    -1.153839e-07     -1.462801e-08
vehicles.seized                        -1.910662e-06    -4.125045e-07     -3.958900e-07
civilian.wounded                       -7.076495e-05     4.886111e-06      1.032886e-06
afi                                    -8.873291e-05    -5.256980e-05      1.054729e-05
army                                   -6.088572e-04     1.454596e-05     -1.498235e-05
federal.police                         -4.952923e-04    -1.410751e-05     -1.915674e-05
ministerial.police                     -5.355368e-04     2.250631e-06     -8.859350e-06
municipal.police                       -5.753544e-04     7.757630e-06     -9.458976e-06
navy                                   -4.914471e-04    -5.729694e-05     -9.450110e-06
other                                  -4.633624e-04    -7.067977e-06     -1.289034e-05
state.police                           -4.516941e-04    -2.939847e-06     -1.285053e-05
long.guns.seized:civilian.wounded       9.875133e-06    -8.826540e-06     -3.399548e-06
civilian.wounded:army                   1.021439e-04    -5.118193e-06      1.218969e-05
long.guns.seized:army                   1.959769e-05    -2.404255e-05      2.844873e-07
long.guns.seized:civilian.wounded:army -1.087623e-05     8.668532e-06      2.136688e-06
                                       cartridge.sezied  clips.seized vehicles.seized
(Intercept)                               -4.992918e-09 -6.490574e-08   -1.910662e-06
long.guns.seized                          -1.845556e-08 -1.153839e-07   -4.125045e-07
small.arms.seized                          1.502895e-08 -1.462801e-08   -3.958900e-07
cartridge.sezied                           8.718489e-11 -8.970972e-11    1.463983e-10
clips.seized                              -8.970972e-11  2.235739e-08   -1.098405e-09
vehicles.seized                            1.463983e-10 -1.098405e-09    2.736161e-06
civilian.wounded                          -8.135550e-10 -4.646793e-09    3.838809e-08
afi                                        5.483403e-08  3.597401e-07   -1.759001e-06
army                                       3.559966e-08 -5.809775e-08   -9.247658e-07
federal.police                             8.864234e-09  1.336939e-07    3.492221e-07
ministerial.police                         7.304410e-09  9.501752e-08    9.440357e-07
municipal.police                           6.551506e-09  9.175371e-08    1.409478e-06
navy                                       3.645935e-09  1.446274e-08   -5.975919e-06
other                                      1.263746e-08  1.377647e-07    6.758888e-07
state.police                               9.700941e-09  1.307545e-07    1.188934e-06
long.guns.seized:civilian.wounded          2.638300e-09  1.010105e-08   -1.092270e-07
civilian.wounded:army                     -1.273982e-08  2.013672e-08    3.946043e-07
long.guns.seized:army                     -9.867463e-09 -1.085962e-08    1.048292e-08
long.guns.seized:civilian.wounded:army    -4.826298e-10 -6.604596e-09    7.469443e-08
                                       civilian.wounded           afi          army
(Intercept)                               -7.076495e-05 -8.873291e-05 -6.088572e-04
long.guns.seized                           4.886111e-06 -5.256980e-05  1.454596e-05
small.arms.seized                          1.032886e-06  1.054729e-05 -1.498235e-05
cartridge.sezied                          -8.135550e-10  5.483403e-08  3.559966e-08
clips.seized                              -4.646793e-09  3.597401e-07 -5.809775e-08
vehicles.seized                            3.838809e-08 -1.759001e-06 -9.247658e-07
civilian.wounded                           3.098643e-04  2.812760e-05  6.918656e-05
afi                                        2.812760e-05  3.995532e-02  3.207701e-05
army                                       6.918656e-05  3.207701e-05  1.064671e-03
federal.police                             1.799933e-05 -1.227209e-04  4.550384e-04
ministerial.police                         2.440369e-05  2.617712e-05  4.957014e-04
municipal.police                           2.340727e-05  4.360596e-05  5.408656e-04
navy                                       2.385990e-05  2.080100e-04  4.306544e-04
other                                     -3.208478e-05 -5.123000e-04  4.196213e-04
state.police                               1.213856e-06 -3.350909e-05  4.103808e-04
long.guns.seized:civilian.wounded         -3.579539e-05  3.920990e-06 -7.124861e-06
civilian.wounded:army                     -3.099164e-04 -1.341080e-04 -2.736122e-04
long.guns.seized:army                     -4.859023e-06  2.736610e-05 -5.150888e-05
long.guns.seized:civilian.wounded:army     3.581701e-05 -1.979033e-06  2.066903e-05
                                       federal.police ministerial.police municipal.police
(Intercept)                             -4.952923e-04      -5.355368e-04    -5.753544e-04
long.guns.seized                        -1.410751e-05       2.250631e-06     7.757630e-06
small.arms.seized                       -1.915674e-05      -8.859350e-06    -9.458976e-06
cartridge.sezied                         8.864234e-09       7.304410e-09     6.551506e-09
clips.seized                             1.336939e-07       9.501752e-08     9.175371e-08
vehicles.seized                          3.492221e-07       9.440357e-07     1.409478e-06
civilian.wounded                         1.799933e-05       2.440369e-05     2.340727e-05
afi                                     -1.227209e-04       2.617712e-05     4.360596e-05
army                                     4.550384e-04       4.957014e-04     5.408656e-04
federal.police                           1.564272e-03       4.009778e-04     4.289043e-04
ministerial.police                       4.009778e-04       2.041959e-03     4.663037e-04
municipal.police                         4.289043e-04       4.663037e-04     1.067334e-03
navy                                     4.693230e-04       4.145556e-04     4.623849e-04
other                                    3.595191e-04       3.647425e-04     4.209367e-04
state.police                             3.104561e-04       3.557453e-04     3.685900e-04
long.guns.seized:civilian.wounded       -6.195554e-06      -1.185259e-05    -2.660987e-06
civilian.wounded:army                   -5.473086e-05      -5.079359e-05    -6.208940e-05
long.guns.seized:army                    1.011510e-05      -6.023233e-06    -1.152868e-05
long.guns.seized:civilian.wounded:army   8.251506e-06       1.308355e-05     4.127967e-06
                                                navy         other  state.police
(Intercept)                            -4.914471e-04 -4.633624e-04 -4.516941e-04
long.guns.seized                       -5.729694e-05 -7.067977e-06 -2.939847e-06
small.arms.seized                      -9.450110e-06 -1.289034e-05 -1.285053e-05
cartridge.sezied                        3.645935e-09  1.263746e-08  9.700941e-09
clips.seized                            1.446274e-08  1.377647e-07  1.307545e-07
vehicles.seized                        -5.975919e-06  6.758888e-07  1.188934e-06
civilian.wounded                        2.385990e-05 -3.208478e-05  1.213856e-06
afi                                     2.080100e-04 -5.123000e-04 -3.350909e-05
army                                    4.306544e-04  4.196213e-04  4.103808e-04
federal.police                          4.693230e-04  3.595191e-04  3.104561e-04
ministerial.police                      4.145556e-04  3.647425e-04  3.557453e-04
municipal.police                        4.623849e-04  4.209367e-04  3.685900e-04
navy                                    4.725345e-03  4.093617e-04  3.819350e-04
other                                   4.093617e-04  4.073105e-03  2.534653e-04
state.police                            3.819350e-04  2.534653e-04  1.834149e-03
long.guns.seized:civilian.wounded      -5.846248e-06 -1.819034e-05 -6.100733e-06
civilian.wounded:army                  -4.020114e-05 -1.023866e-05 -8.064419e-05
long.guns.seized:army                   5.593460e-05  2.809546e-06 -2.144553e-06
long.guns.seized:civilian.wounded:army  6.396649e-06  1.444232e-05  1.024400e-05
                                       long.guns.seized:civilian.wounded
(Intercept)                                                 9.875133e-06
long.guns.seized                                           -8.826540e-06
small.arms.seized                                          -3.399548e-06
cartridge.sezied                                            2.638300e-09
clips.seized                                                1.010105e-08
vehicles.seized                                            -1.092270e-07
civilian.wounded                                           -3.579539e-05
afi                                                         3.920990e-06
army                                                       -7.124861e-06
federal.police                                             -6.195554e-06
ministerial.police                                         -1.185259e-05
municipal.police                                           -2.660987e-06
navy                                                       -5.846248e-06
other                                                      -1.819034e-05
state.police                                               -6.100733e-06
long.guns.seized:civilian.wounded                           6.652938e-05
civilian.wounded:army                                       3.499887e-05
long.guns.seized:army                                       8.576130e-06
long.guns.seized:civilian.wounded:army                     -6.636864e-05
                                       civilian.wounded:army long.guns.seized:army
(Intercept)                                     1.021439e-04          1.959769e-05
long.guns.seized                               -5.118193e-06         -2.404255e-05
small.arms.seized                               1.218969e-05          2.844873e-07
cartridge.sezied                               -1.273982e-08         -9.867463e-09
clips.seized                                    2.013672e-08         -1.085962e-08
vehicles.seized                                 3.946043e-07          1.048292e-08
civilian.wounded                               -3.099164e-04         -4.859023e-06
afi                                            -1.341080e-04          2.736610e-05
army                                           -2.736122e-04         -5.150888e-05
federal.police                                 -5.473086e-05          1.011510e-05
ministerial.police                             -5.079359e-05         -6.023233e-06
municipal.police                               -6.208940e-05         -1.152868e-05
navy                                           -4.020114e-05          5.593460e-05
other                                          -1.023866e-05          2.809546e-06
state.police                                   -8.064419e-05         -2.144553e-06
long.guns.seized:civilian.wounded               3.499887e-05          8.576130e-06
civilian.wounded:army                           2.157827e-03          1.663399e-05
long.guns.seized:army                           1.663399e-05          3.493079e-05
long.guns.seized:civilian.wounded:army         -1.701282e-04         -1.026227e-05
                                       long.guns.seized:civilian.wounded:army
(Intercept)                                                     -1.087623e-05
long.guns.seized                                                 8.668532e-06
small.arms.seized                                                2.136688e-06
cartridge.sezied                                                -4.826298e-10
clips.seized                                                    -6.604596e-09
vehicles.seized                                                  7.469443e-08
civilian.wounded                                                 3.581701e-05
afi                                                             -1.979033e-06
army                                                             2.066903e-05
federal.police                                                   8.251506e-06
ministerial.police                                               1.308355e-05
municipal.police                                                 4.127967e-06
navy                                                             6.396649e-06
other                                                            1.444232e-05
state.police                                                     1.024400e-05
long.guns.seized:civilian.wounded                               -6.636864e-05
civilian.wounded:army                                           -1.701282e-04
long.guns.seized:army                                           -1.026227e-05
long.guns.seized:civilian.wounded:army                           8.237581e-05


> lm5_var <- -0.00001489899 + 0.00006652938 + 0.00003493079 + 0.00008237581 - (2 * 0.000008826540) - 
+   (2 * 0.00002404255) + (2 * 0.000008668532) + (2 * 0.000008576130) - (2 * 0.00006636864) + (2 * 0.00008237581)
> lm5_var
[1] 0.0001697025
> sqrt(lm5_var)
[1] 0.01302699
> 
```

Thus the standard error of the marginal effect is 0.01302699.

Assumptions are similar to those above in that I am assuming that the relationship betweent he variables is linear and that I have all of the information I need to predict civilian deaths in this situation. That assumption is also a limitation of this model since there may be other pieces of information that would provide a better understanding of the predictors of civilian deaths in confrontations. 

**One sentence:** The more civilians wounded in confrontations involving the army are more likely associated with a decrease in civilian deaths. 

**One paragraph** In confrontations involving the army, the more civilians wounded is associated with lower civilian death rates. Adding the seizure of a long gun to confrontations involving the army wit civilians wounded modestly significantly affects civilian deaths at the 0.05% significance level compared to the highly significant level that army conflict and wounded civilians affect civilian death. Furthermore, long guns seized and civilians wounded moderately decreases the rate of civilian deaths while the precence of other army officials or government entities moderately increases the rate of civilian deaths. 

