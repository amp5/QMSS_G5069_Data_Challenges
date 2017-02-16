<p align="right">
  <b>Name:</b> Alexandra Plassaras
  <br>
  <b>Date Due:</b> 2/22/17
</p>


<p align="center">
  <b>Assingment 1 </b>
</p>


**1. Can you replicate the 86.1% number? the overall lethality ratio? the ratios for the Federal Police, Navy and Army?**
  <br>
  I could not replicate the 86.1% number, the overall lethality ratio or the ratios for the Federal Police, Navy and Army exactly. I believe this is because either 1) the data we have is incomplete or 2) the calculations for these numbers was not made transparent so we have no way of replicating these numbers exactly. As a result we can only calculate what we believe are similar calculations with hopefully the same assumtptions. 
  * **Provide a visualization that presents this information neatly.**
    <p align="left">
      <b>Graph 1</b>
    </p>
    
    ![viz1](https://cloud.githubusercontent.com/assets/5368361/23034613/65c16e0c-f44a-11e6-99d6-3dd31bba13c6.png)
    <p align="left">
      <b>Graph 2</b>
    </p>
    
    ![viz2](https://cloud.githubusercontent.com/assets/5368361/23034616/673abb44-f44a-11e6-8529-0119c190a229.png)
  * **Please show the exact computations you used to calculate them (most likely than not, you'll need to do some additional munging in the data to get there)**
    <br>
    
    **Code for "Percent of Civilians Killed in Events of Perfect Lethality"**
    ```r
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
    ```
    
    **Code for "Lethality Ratio for Various Groups"**
    ```r
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
    ```
  * **If you could not replicate them, please show why and the difference relative to your own computations (also, include a neat graph that summarizes this)**
 
 The reason I could not replicate the 86.1% precisely is because I was not given the exact calculation that researchers used to come up with this percentage. I assumed that the calculation would be *the number of civilian deaths in perfect lethality / total number of civilian deaths* If that calculation is correct the actual numbers that we were provided with were 101/376 =  26.9%
 
 The lethality rates were also ratios that I could not replicate exactly. The quote provided to us for this exercise did not specifically define how the ratios were calculated and since we only have the numbers for how many different groups of people were killed and not who killed whom, I cannot calculate the lethality ratio of how many civilians the Navy or the Federal Police killed. Thus my ratio results are much smaller that the original calculation. For the Federal Police, Navy and Army this makes sense given what we know from the data - that as time increased these armed forced spent more time and resources training and therefore became better at killing and less likely to die than to be wounded themselves. 
  
  | Metric        | Original Calculation| Updates Calculation|
  | ------------- |:-------:| -----:|
  | % of dead civilians in perfect lethality events  | 86.1% | 26.9% |
  | Mexico Overall  | 2.6  | 1.44 |
  | Federal Police | 2.6 | 0.30 |
  | Navy| 17.3 | 0.31 |
  | Army | 9.1 | 0.18 |
  
  Below is a graph that visualizes the percentage change for each metric:
  
  ![viz3](https://cloud.githubusercontent.com/assets/5368361/23040760/851cb552-f460-11e6-9941-d079eacb9238.png)

  * **Be very explicit: What are you assuming to generate these computations?**
 
   I am assuming that the information provided to me is correct and as complete as possible. In calculating the first metric of percent of  dead civilians in perfectly lethal events I assumed that the number of deaths is only regarding civilians and not any organized crime agents or government workers. For the remaining lethality ratios I was assuming that the ratios were focused on all deaths / wounded for the Mexico Overall Ratio, Federal Police deaths / wounded for the Federal Police Ration, Navy deaths / wounded for the Navy Ratio and Army deaths / wounded for the Army Ratio. Since I do not have any information on how many people certain armed groups killed I cannot calculate that particular ratio (which may have been what the original ratios were discussing).

**2. Now you know the data more intimately. Think a little bit more about it, and answer the following questions:**
  * **Is this the right metric to look at? Why or why not?**
  
  If the question we are asking is whether this aggressive stratgey is effective or not, then this metric is not a good metric to use. First, it doesn't show how the various armed forces might be effective in killing organized crime members versus civilians, it just gives us the total counts for how many civilians were killed and how many organized crime members were killed. They could have been killed by government armed forces or the organized crime members could have killed each other. The data doesn't distinugish between who killed whom. Second, this data needs to contain more context for us to determine the efficiacy of these government like the organized crime rate at a given time. Having more robust crime data like roberies, murder, assult, extortion, kiddnaping and drug peddling would provide helpful context on how these lethality measures affected the crime rate. 
  
  * **What is the "lethality index" showing explicitly? What is it not showing? What is the definition assuming?**
  
  The lethality index *should* show how effective certain armed forces are at permanently extinguishing enemy forces. But instead, with the data that we have access too the lethality index is only showing us the death rate vs wounded rate for each subgroup - civilians and the various government armed forces. Thus the definition is assuming that we have data we clearly do not - who killed whom.
  
  * **With the same available data, can you think of an alternative way to capture the same construct? Is it "better"?**
  If the "lethality index" is trying to discern whether the armed forces' tactics are actually effecient in helping either deter or reduce organized crime throughout Mexico, then perhaps looking at the number of weapons seized could be another useful construct to consider for effectiveness. Just as in the business world, I think it is dangerous to focus on one KPI or one overall measurement to determine the success or failure of a product, a policy or any other decision. I don't think one index alone would be "better". Particularly with sensitive data such as this in a turbulent environment the causes at play are vast and complex. Choosing only one index or metric to try and understand the entire complex issue is, especially in this case, dangerous. It is dangerous because people's lives are at risk because of this military response to organized crime. Instead I would argue that a number of metrics would be better served as a way to gauge effectiveness. In addition to noting how many weapons were seized and are no longer in the hands of organized crime, I think the ratio of civilians to organized crime members killed in each event should be considered. The smaller the ratio, the better efficacy because it would mean that armed forces are hitting their marks more often than killing innocent civilians. In fact, there are many more metrics that could and should be used to better understand this complex issue such as how much corruption is going on within the armed forces or how accurate is this data anyway. But again, I don't think one construct is better on its own. Each construct alone carries with it its own downsides and it is only with the use of multiple metrics that we can better understand complex issues such as this. 
  
  * **What additional information would you need to better understand the data?**

  Additional information that I would need to better understand the data would be contextual data such as the number of non-violent interactions with the armed forces or what the current crime rate was at that given time. That way I would have a better way to measure the effectiveness of this policy. 
  
  * **What additional information could help you better capture the construct behind the "lethality index"**

    Additional information that could help better capture the construct behind the "lethality index" would be the complete dyads for each event. For example, on a given date at a given location the Navy killed 4 organized crime members and 1 civilian. Instead what we have is just the date, location, and number of deaths. Ideally having the dyads of killer (don't have) and killled (have) would be needed to better understand the data in general and to be able to more accurately construct a helpful "lethality index". 
