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
 
 The reason I could not replicate the 86.1% precisely is because I was not given the exact calculation that researchers used to come up with this percentage. I assumed that the calculation would be *the number of civilian deaths in perfect lethality / total number of civilian deaths* If that calculation is correct the actual numbers that we were provided were 101/376 =  26.9%
 
 The lethality rates were also ratios that I could not replicate exactly. The quote provided to us for this exercise did not specifically define how the ratios were calculated and since we only have the numbers for how many different groups of people were killed and not who killed whom, I cannot calculate the lethality ratio of how many civilians the Navy or the Federal Police killed. Thus my ratio results are much smaller that the original calculation. For the Federal Police, Navy and Army this makes sense given what we know from the data - that as time increased these armed forced spent more time and resources training and therefore became better at killing and less likely to die than to be wounded. 
  
  | Metric        | Original Calculation| Updates Calculation|
  | ------------- |:-------:| -----:|
  | % of dead civilians in perfect lethality events  | 86.1% | 26.9% |
  | Mexico Overall  | 2.6  | 1.44 |
  | Federal Police | 2.6 | 0.30 |
  | Navy| 17.3 | 0.31 |
  | Army | 9.1 | 0.18 |

  * Be very explicit: What are you assuming to generate these computations?
2. Now you know the data more intimately. Think a little bit more about it, and answer the following questions:
  * Is this the right metric to look at? Why or why not?
  * What is the "lethality index" showing explicitly? What is it not showing? What is the definition assuming?
  * With the same available data, can you think of an alternative way to capture the same construct? Is it "better"?
  * What additional information would you need to better understand the data?
  * What additional information could help you better capture the construct behind the "lethality index"
