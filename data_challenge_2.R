#  ####################################################################### 
#       File-Name:      data_challenge_2.R
#       Version:        R 3.2.4
#       Date:           10/22/2017
#       Author:         AMP
#       Purpose:        Complete data challenge. 
#       Input Files:    AllViolenceData_170216.csv (cleaned data)
#       Output Files:   NONE
#       Data Output:    NONE
#       Previous files: NONE
#       Dependencies:   NONE
#       Required by:    NONE 
#       Status:         IN PROGRESS
#       Machine:        Mac laptop
#  ####################################################################### 
library(tidyverse)
library(data.table)
library(rpart)
library(rpart.plot)
library(RColorBrewer)
library(randomForest)
library(rattle)

path <- "/Users/alexandraplassaras/Desktop/Spring_2017/QMSS_G5069/QMSS_G5069"
setwd(path)

# select AllViolenceData_170216.csv
all_vio <- read.csv(file.choose())



# Question 1.a. --------------------------------------------------------------
table(all_vio$total.people.dead)

ggplot(all_vio) +
  geom_bar(mapping = aes(x = total.people.dead )) +
  labs(x = "People Killed", y = "Count") +
  theme_minimal() +
  ggtitle("Distribution of People Killed")


lm1 <- lm( total.people.dead ~ afi + army + federal.police + ministerial.police + municipal.police + 
             navy + other + state.police + long.guns.seized + small.arms.seized + cartridge.sezied + clips.seized +
             vehicles.seized, data = all_vio)
summary(lm1)

# with interactions
lm2 <- lm( total.people.dead ~ afi + army + federal.police + ministerial.police + municipal.police + 
             navy + other + state.police + long.guns.seized + small.arms.seized + cartridge.sezied + clips.seized +
             vehicles.seized + army * long.guns.seized + army * cartridge.sezied +
             federal.police * long.guns.seized + federal.police * cartridge.sezied +
             ministerial.police * long.guns.seized + ministerial.police * cartridge.sezied +
             municipal.police*long.guns.seized + municipal.police*cartridge.sezied +
             state.police * long.guns.seized + state.police * cartridge.sezied, data = all_vio)
summary(lm2)

# Plotting linear model

all_vio$model <- stats::predict(lm2, newdata=all_vio)
err <- stats::predict(lm2, newdata=all_vio, se = TRUE)
all_vio$ucl <- err$fit + 1.96 * err$se.fit
all_vio$lcl <- err$fit - 1.96 * err$se.fit





ggplot(data = all_vio) + 
  geom_point(aes(x=total.people.dead, y = model), size = 2, colour = "blue", alpha = 0.2) + 
  geom_smooth(aes(x=total.people.dead, y=model, ymin=lcl, ymax=ucl), size = 1, 
              colour = "red", se = TRUE, stat = "smooth") +
  labs(x = "Number of People Dead", y = "Multiliner Model") +
  theme_minimal() +
  ggtitle("Multilinear Regression")



# Question 1.b. -----------------------------------------------------------

vio_data <- all_vio[c("event.id", "total.people.dead", "state", "afi", "army", "federal.police", "ministerial.police", "municipal.police",  
                      "navy", "other", "state.police", "long.guns.seized", "small.arms.seized", "cartridge.sezied", "clips.seized",
                      "vehicles.seized", "perfect.lethality")]


vfit <- rpart(perfect.lethality ~ long.guns.seized + afi + army + federal.police + ministerial.police + municipal.police + 
                navy + other + state.police  + small.arms.seized + cartridge.sezied + clips.seized +
                vehicles.seized,
              data=vio_data,
              method="class")
fancyRpartPlot(vfit)

set.seed(415)

vfit2 <- randomForest(as.factor(perfect.lethality) ~ afi + army + federal.police + ministerial.police + municipal.police + 
                      navy + other + state.police + long.guns.seized + small.arms.seized + cartridge.sezied + clips.seized +
                      vehicles.seized,
                    data=vio_data, 
                    importance=TRUE, 
                    ntree=500)

varImpPlot(vfit2)
prop.table(table(vio_data$perfect.lethality))




# Question 2.a. --------------------------------------------------------------

lm3 <- lm(civilian.dead ~ long.guns.seized + small.arms.seized + cartridge.sezied + clips.seized +
             vehicles.seized + civilian.wounded + afi + army + federal.police + ministerial.police + 
            municipal.police + navy + other + state.police, data = all_vio)
summary(lm3)


lm4 <- lm(civilian.dead ~ long.guns.seized + small.arms.seized + cartridge.sezied + clips.seized +
            vehicles.seized + civilian.wounded + afi + army + federal.police + ministerial.police + 
            municipal.police + navy + other + state.police + civilian.wounded * long.guns.seized, data = all_vio)
summary(lm4)


vcov(lm4)


lm4_var <-  0.00016927 + 1 * 1 * 0.000007318 + 2 * 1 * 0.0000010899
lm4_var
sqrt(lm4_var) 

lm5 <- lm(civilian.dead ~ long.guns.seized + small.arms.seized + cartridge.sezied + clips.seized +
            vehicles.seized + civilian.wounded + afi + army + federal.police + ministerial.police + 
            municipal.police + navy + other + state.police + civilian.wounded * long.guns.seized * army, data = all_vio)
summary(lm5)


vcov(lm5)

lm5_var <- -0.00001489899 + 0.00006652938 + 0.00003493079 + 0.00008237581 - (2 * 0.000008826540) - 
  (2 * 0.00002404255) + (2 * 0.000008668532) + (2 * 0.000008576130) - (2 * 0.00006636864) + (2 * 0.00008237581)
lm5_var 
sqrt(lm5_var)
