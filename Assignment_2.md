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
