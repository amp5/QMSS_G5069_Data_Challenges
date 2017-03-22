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


Question 1: Can we predict perfect_lethality based on the variables given in our data set?
To attempt to answer this question I will randomly divide my data into two groups: training data (80%) and test data(20%).

```r
# select AllViolenceData_170216.csv
all_vio <- read.csv(file.choose())

## 80% of the sample size
bound <- floor((nrow(all_vio)/5)*4)                   #define % of training and test set

all_vio <- all_vio[sample(nrow(all_vio)), ]           #sample rows 
av_train <- all_vio[1:bound, ]                        #get training set
av_test <- all_vio[(bound+1):nrow(all_vio), ]         #get test set
```
My hypothesis is that by looking at the different types of items seized in a confrontation and whether a particular government body participated in a confrontation I might be able to predict perfect lethality. My reasoning behind this is that certain types of weapons are more destructive than others and the presence of them in a confrontation might help predict whether an event will have perfect lethality. Additionally, one government body might be more lethal than other bodies. Hypothetically speaking, if the navy was the most lethal government body in confrontations, looking at which events had navy participants might help predict perfect lethality. Government officials, the military and public policy makers who might consider the ethical justifications of future policy measures might benefit from understanding what factors  predict perfect lethality and whether or not that should be the focus of the government. Perhaps focusing instead on organized crime dead or wounded might be better than perfect lethality which involves both organized crime members and civilians.

My initial linear model is below:

```r
linear <- lm( perfect.lethality ~ afi + army + federal.police + ministerial.police + municipal.police + 
              navy + other + state.police + long.guns.seized + small.arms.seized + cartridge.sezied + clips.seized +
              vehicles.seized, data = av_train)
> summary(linear)

Call:
lm(formula = perfect.lethality ~ afi + army + federal.police + 
    ministerial.police + municipal.police + navy + other + state.police + 
    long.guns.seized + small.arms.seized + cartridge.sezied + 
    clips.seized + vehicles.seized, data = av_train)

Residuals:
    Min      1Q  Median      3Q     Max 
-1.3515 -0.2761 -0.1411  0.4627  1.1520 

Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         2.761e-01  1.401e-02  19.707  < 2e-16 ***
afi                -2.897e-02  1.082e-01  -0.268 0.788920    
army                1.163e-01  1.749e-02   6.650 3.30e-11 ***
federal.police     -7.492e-02  2.230e-02  -3.360 0.000786 ***
ministerial.police -1.281e-01  2.569e-02  -4.987 6.37e-07 ***
municipal.police   -1.742e-01  1.845e-02  -9.442  < 2e-16 ***
navy                1.068e-01  3.808e-02   2.804 0.005070 ** 
other              -1.190e-01  3.654e-02  -3.256 0.001140 ** 
state.police       -1.350e-01  2.442e-02  -5.530 3.40e-08 ***
long.guns.seized    2.121e-02  2.364e-03   8.974  < 2e-16 ***
small.arms.seized  -6.037e-03  5.069e-03  -1.191 0.233671    
cartridge.sezied   -3.227e-05  5.113e-06  -6.311 3.05e-10 ***
clips.seized        9.851e-05  7.699e-05   1.280 0.200763    
vehicles.seized     1.859e-03  8.457e-04   2.198 0.027970 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.4169 on 4302 degrees of freedom
Multiple R-squared:  0.1261,	Adjusted R-squared:  0.1235 
F-statistic: 47.75 on 13 and 4302 DF,  p-value: < 2.2e-16
```

First, looking at the F-statistic we can see that 47.75 is statistically significant and tells us that there are relatively good relationships between our predictors and response variables. Looking at the coefficients we can see that the army and number of long guns seized have high positive statistically significant effects on perfect lethality while federal police, ministerial police, municipal police, state police and the number of cartridges seized have high negative statisically significant results. The navy has moderate positive statistical significance while the other armed forces or government entities have a moderate negative statistical significance on perfect lethality. 




**2. Formulate two (2) conditional hypotheses that you seek to investigate with the data. One of your hypotheses should 
condition on two variables (as the example on the slides), and the other should condition on three variables. [50 pts]**

- formulate each one of your hypotheses explicitly in substantive terms (as opposed to statistical terms) using 2-3 lines at most
- show exactly how each one of your hypotheses translates into the marginal effect that you will seek to estimate from the data
- show the output from your analysis in a consumable form
- show all your computations to estimate the corresponding marginal effect and its standard error
- be explicit in your assumptions
- be explicit in the limitations of your inferences
- phrase your finding for each question in two ways:
- one sentence that summarizes your insight
- one paragraph that reflects all nuance in your insight
- make sure to also include your code
