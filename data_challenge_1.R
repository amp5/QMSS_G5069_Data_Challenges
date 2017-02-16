#  ####################################################################### 
#       File-Name:      data_challenge_1.R
#       Version:        R 3.2.4
#       Date:           Feb 16, 2017
#       Author:         AMP
#       Purpose:        Complete data challenge. Primarily replicating 86.1% number, ratios etc 
#                       and answer questions related to analysis
#       Input Files:    ConfrontationsData_170209.csv (cleaned data)
#       Output Files:   NONE
#       Data Output:    NONE
#       Previous files: NONE
#       Dependencies:   NONE
#       Required by:    NONE 
#       Status:         IN PROGRESS
#       Machine:        Mac laptop
#  ####################################################################### 

library(tidyverse)
# working with internal var called 'fullData'

#q1_a creating subset
data_1 <- fullData[c("event.id", "total.people.dead", "civilian.dead", "total.people.wounded", "civilian.wounded")]

# if no total wounded and total death > 0 ----> TRUE for perfect lethality
data_1$perfect.lethality <- ifelse(data_1$total.people.wounded == 0 & data_1$total.people.dead > 0, TRUE, FALSE)
(dead.civil.total <- sum(data_1$civilian.dead) )
(perf.leth.civil <- sum(data_1$perfect.lethality == "TRUE" & data_1$civilian.dead))
  
ggplot(data = data_1, aes(x = perfect.lethality)) +
  geom_bar(mapping = aes(y = (..count..)/sum(..count..)), position = "dodge", fill = c("#8C0000", "#4d0000")) +
  ggtitle("Percent of Civilians Killed in Events of Perfect Lethality") +
  labs(x = "Civilians Killed in Events of Perfect Lethality", y = "Percent") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))


#q1_b - calculating overall lethality reation
# total num dead / total num wounded

(num_dead_total <- sum(fullData$total.people.dead))
(num_wound_total <- sum(fullData$total.people.wounded))
(general_lethality_ratio <- num_dead_total/num_wound_total)

(num_fed_dead <- sum(fullData$federal.police.dead))
(num_fed_wound <- sum(fullData$federal.police.wounded))
(fed_lethality_ratio <- num_fed_dead / num_fed_wound)

(num_navy_dead <- sum(fullData$navy.dead))
(num_navy_wound <- sum(fullData$navy.wounded))
(navy_lethality_ratio <- num_navy_dead / num_navy_wound )

(num_army_dead <- sum(fullData$military.dead))
(num_army_wound <- sum(fullData$military.wounded))
(army_lethality_ratio <- num_army_dead / num_army_wound)


cnames <-c("group", "lethality_ratio")
group_n <- c("Overall", "Federal Police", "Navy", "Army")
ratios <- c(general_lethality_ratio, fed_lethality_ratio, 
            navy_lethality_ratio, army_lethality_ratio)
lethality_df <- data.frame(group_n, ratios)

colnames(lethality_df) <- cnames
rownames(lethality_df) <- group_n


ggplot(lethality_df, aes(group, lethality_ratio, label = round(lethality_df$lethality_ratio, 2))) +
  geom_point() +
  ggtitle("Lethality Ratio for Various Groups") +
  theme_classic() +
  geom_text( size = 4, hjust=-0.2, vjust=-0.2) +
  theme(plot.title = element_text(hjust = 0.5))
  

# calc difference in measures

(metric_d <- c("Perfect Lethality Civilian Deaths", "Mexico Overall Ratio", "Federal Police Ratio", "Navy Ratio", "Army Ratio"))
(orig <- c(.861, 2.6, 2.6, 17.3, 9.1))
(own <- c(.269, 1.44, 0.03, 0.31, 0.18))

(measures <- data.frame(orig, own))
rownames(measures) <- metric_d

#percent change
(measures$delta <- ((measures$own - measures$orig) / measures$orig) *100)

ggplot(data = measures) +
  geom_bar(mapping = aes(x = metric_d, y = delta), stat = "identity", fill = c("#8C0000")) +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggtitle("Percentage Change between Original and Replicated Metrics") +
  labs(x = "Various Civilian Death Ratios", y = "Percent Change")



