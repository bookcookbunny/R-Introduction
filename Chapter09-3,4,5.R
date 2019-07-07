# 09-3 The Relation between Age and Income

setwd("C:/EX/R/easy_r")
getwd()

install.packages("foreign")
install.packages("dplyr")
install.packages("ggplot2")
library(foreign)
library(dplyr)
library(ggplot2)

raw_welfare <- read.spss("Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)
welfare <- raw_welfare
dim(welfare)
head(welfare)
str(welfare)

welfare <- rename(welfare, gender = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_reg = h10_reg7)

  # preprocessing "age"
  summary(welfare$birth)
  qplot(welfare$birth)
  class(welfare$birth)
  
  welfare$age = 2015 - welfare$birth + 1
  summary(welfare$age)
  qplot(welfare$age)
  
  # preprocessing "income"
  class(welfare$income)
  summary(welfare$income)
  welfare$income <- ifelse(welfare$income < 1 | welfare$income > 9998, NA, welfare$income)  
  summary(welfare$income)
  
  # analizing
  
  age_income <- welfare %>%
    filter(!is.na(welfare$income) & !is.na(welfare$age)) %>% 
    group_by(age) %>% 
    summarise(mean_income = mean(income))
  
  age_income
  ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line() 
  

# 09-4 The Difference of Income Depending on Age Groups
  
  # prepocessing "age group"
  
  welfare <- welfare %>% 
    mutate(ageg = ifelse(age < 30, "young",
                         ifelse(age < 60, "middle", "old")))
  table(welfare$ageg)  
  qplot(welfare$ageg)

  # analizing
  
  ageg_income <- welfare %>% 
    filter(!is.na(income)) %>% 
    group_by(ageg) %>% 
    summarise(mean_income = mean(income))
  
  ageg_income
  ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) +
    geom_col() +
    scale_x_discrete(limits = c("young", "middle", "old"))
  

# 09-5 The Difference of Income of Age Groups Depending on Gender
  
  # preprocessing "gender"
  
  table(welfare$gender)
  table(is.na(welfare$gender))  
  qplot(welfare$gender)
  
  welfare$gender <- ifelse(welfare$gender == 1, "male", "female")

  gender_income <- welfare %>% 
    filter(!is.na(income) & !is.na(ageg)) %>% 
    group_by(ageg, gender) %>% 
    summarise(mean_income = mean(income))

  gender_income
  
  ggplot(data = gender_income, aes(x = ageg, y = mean_income, fill = gender)) +
    geom_col(position = "dodge") +
    scale_x_discrete(limits = c("young", "middle", "old"))

  gender_age <- welfare %>% 
    filter(!is.na(age) & !is.na(income)) %>% 
    group_by(age, gender) %>% 
    summarise(mean_income = mean(income))

  head(gender_age)  

  ggplot(data = gender_age, aes(x = age, y = mean_income, col = gender)) +
    geom_line()
  