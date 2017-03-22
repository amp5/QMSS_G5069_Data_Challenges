**Data Challenge 2 (due on 3/22 at 6PM)**

**1. Ask two (2) questions that might help you understand better the dynamics of violence contained on our data set. 
Apply one algorithm per question and share your insights from each analysis. [50 pts] 
Remember: a non-finding is also a finding! It tells you whether a question is worth pursuing further or not.**

- *perform the necessary transformations in your data - if any are needed, and explain why you did that*
- *show the output from your analysis in a consumable form*
- *be explicit about the limitations of your anaylisis, due to estimation or to the data itself*
- *did you find something interesting? what is that? does your finding suggest this question is worth pursuing further? why or why not?*
- *if you did not find something interesting, explain why, and whether there is some additional information that would help in answering your question*
- *provide your code, and a single visualization per question that summarizes your finding*
- *phrase your finding for each question in two ways:*
- *one sentence that summarizes your insight*
- *one paragraph that reflects all nuance in your insight*
- *make sure to also include your code*


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
