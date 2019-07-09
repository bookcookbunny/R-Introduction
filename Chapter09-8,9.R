
# 09-8 Devorce Depending on Religions

setwd("C:/EX/R/easy_r")
getwd()

install.packages("dplyr")
install.packages("foreign")
install.packages("ggplot2")
library(dplyr)
library(foreign)
library(ggplot2)

raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = TRUE,
                         stringsAsFactors = FALSE)

  # Overview the data frame
  welfare <- raw_welfare
  head(welfare, 1)
  summary(welfare)
  dim(welfare)
  str(welfare)
  View(welfare)
  
  
  # Preprocessing the data frame 1: rename variables
  welfare <- rename(welfare, gender = h10_g3,
                    birth = h10_g4,
                    marriage = h10_g10,
                    religion = h10_g11,
                    income = p1002_8aq1,
                    code_job = h10_eco9,
                    code_reg = h10_reg7)
  
  # Preprocessing the data frame 2: the variable "religion"
  class(welfare$religion)
  summary(welfare$religion) # No NA & outlier
  welfare <- welfare %>% 
    mutate(religion = ifelse(religion == 1, "yes", "no"))
  
  # Preprocessing the data frame 3: the variable "marriage"
  class(welfare$marriage)
  summary(welfare$marriage)
  table(welfare$marriage) # No NA & outlier
  
  # Preprocessing the
  data frame 4: make a derived variable
  welfare <- welfare %>% 
    mutate(group_marriage = ifelse(marriage == 1, "marriaged",
                                   ifelse(marriage == 3, "divorced", NA)))
  table(welfare$group_marriage)  
  summary(welfare$group_marriage)           
  table(is.na(welfare$group_marriage))
  qplot(welfare$group_marriage)
  
  # (i)
  religion_marriage <- welfare %>% 
    filter(!is.na(group_marriage)) %>% 
    group_by(religion, group_marriage) %>% 
    summarise(n = n()) %>% 
    mutate(total_group = sum(n)) %>% 
    mutate(p_group = round(n/total_group*100, 1))
  
  religion_marriage      
  
  # (ii)
  religion_marriage <- welfare %>% 
    filter(!is.na(group_marriage)) %>% 
    count(religion, group_marriage) %>% 
    group_by(religion) %>% 
    mutate(p = round(n/sum(n)*100, 1))
  
  religion_marriage  
  
  group_divorce <- religion_marriage %>% 
    filter(group_marriage == "divorced") %>% 
    group_by(religion) %>% 
    select(religion, p)
  group_divorce 
  
  ggplot(data = group_divorce, aes(x = religion, y = p)) +
    geom_col()
  
# Quiz: Analize how different or similar divorce rates are depending on age groups & religions
  
  #rm(group_divorce)
  #rm(religion_marriage)
  #rm(welfare)
  
  welfare <- raw_welfare
  welfare <- rename(welfare, gender = h10_g3,
                    birth = h10_g4,
                    marriage = h10_g10,
                    religion = h10_g11,
                    income = p1002_8aq1,
                    code_job = h10_eco9,
                    code_reg = h10_reg7)
  
  # preprocessing "birth"  
  class(welfare$birth)  
  summary(welfare$birth) # No outlier & NA

  # make a derived variable "ageg" (age group)
  welfare$age <- 2015 - welfare$birth + 1
  summary(welfare$age)
  welfare <- welfare %>% 
    mutate(ageg = ifelse(age < 30, "young",
                    ifelse(age < 60, "middle", "old")))
  
  table(welfare$ageg)
  
  # preprocessing "religion"
  class(welfare$religion)
  table(welfare$religion)
  summary(welfare$religion) # No NA & outlier
  welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")
  table(welfare$religion)  
  
  # preprocessing "marriage"  
  class(welfare$marriage)  
  summary(welfare$marriage)  
  table(welfare$marriage) # No NA & outlier
  
  # Make a derived variable "d/m" from "marriage"
  welfare <- welfare %>% 
    mutate(dvrc_mrrg = ifelse(marriage == 1, "married",
                                 ifelse(marriage == 3, "divorced", NA)))
  table(welfare$dvrc_mrrg)
  
  df_ageg_religion <- welfare %>%
    filter(!is.na(dvrc_mrrg)) %>% 
    group_by(ageg, religion, dvrc_mrrg) %>% 
    summarise(n = n()) %>% 
    mutate(sum = sum(n)) %>% 
    mutate(p1 = round(n/sum*100, 1))
    
  df_ageg_religion
  
  # Analize
  rates_divorce <- df_ageg_religion %>%
    filter(dvrc_mrrg == "divorced") %>% 
    select(ageg, religion, p1)
  rates_divorce
  
  ggplot(data = rates_divorce, aes(x = ageg, y = p1, fill = religion)) +
    geom_col(position = "dodge")

  
  
# 09-9 Proportions of age groups by region
  
  table(welfare$ageg)
  
  # preprocessing "code_region"
  
  class(welfare$code_reg)
  table(welfare$code_reg)  
  summary(welfare$code_reg)  

  welfare <- welfare %>%
    mutate(region = ifelse(code_reg == 1, "서울",
          ifelse(code_reg == 2, "수도권(인천/경기)",
            ifelse(code_reg == 3, "부산/경남/울산",
              ifelse(code_reg == 4, "대구/경북",
                ifelse(code_reg == 5, "대전/충남",
                  ifelse(code_reg == 6, "강원/충북", "광주/전남/전북/제주도")))))))
  
  p_region <- welfare %>% 
    group_by(region, ageg) %>% 
    summarise(n = n()) %>% 
    mutate(sum = sum(n)) %>% 
    mutate(p2 = round(n/sum*100, 1))
  
  p_region
  
  p_region2 <- p_region %>% 
    select(region, ageg, p2)

  ggplot(data = p_region2, aes(x = region, y = p2, fill = ageg )) +
    geom_col() +
    coord_flip()
  
  list_order <- p_region2 %>% 
    filter(ageg == "old") %>% 
    arrange(p2)
  
  list_order
  
  order <- list_order$region
  order  
  
  ggplot(data = p_region2, aes(x = region, y = p2, fill = ageg )) +
    geom_col() +
    coord_flip() +
    scale_x_discrete(limits = order)

  p_region2$ageg <- factor(p_region2$ageg,
                           level = c("old", "middle", "young"))  

  ggplot(data = p_region2, aes(x = region, y = p2, fill = ageg )) +
    geom_col() +
    coord_flip() +
    scale_x_discrete(limits = order)
  