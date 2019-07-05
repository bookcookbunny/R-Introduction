# 09-1

  setwd("C:/EX/R/easy_r")
  getwd()

  # How to import Spss files (.sav)
  install.packages("foreign")
  install.packages("dplyr")
  install.packages("ggplot2")
  library(foreign)
  library(dplyr)
  library(ggplot2)

  raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = TRUE,
                         header = TRUE)
  welfare <- raw_welfare # You should copy the original data frame

  str(welfare)
  dim(welfare)
  summary(welfare)
  View(welfare)


  # Rename Variables

  welfare <- rename(welfare, gender = h10_g3,
                    birth = h10_g4,
                    marriage = h10_g10,
                    religion = h10_g11,
                    income = p1002_8aq1,
                    code_job = h10_eco9,
                    code_reg = h10_reg7)


# 09-2 The Difference of Income Depending on Gender
  
  # Preprocessing "gender"
  
  table(welfare$gender)        # There's no outlier in gender
  table(is.na(welfare$gender)) # There's no NA in gender
  welfare$gender <- ifelse(welfare$gender == 1, "male", "female")
  table(welfare$gender)
  
  
  # Preprocessing "income"
  
  class(welfare$income)
  summary(welfare$income)
  boxplot(welfare$income)$stats
  qplot(welfare$income)
  qplot(welfare$income) + xlim(0, 1000)
  
  welfare$income <- ifelse(welfare$income == 0, NA, welfare$income)
  #welfare$income <- ifelse(welfare$income %in% C(0, 9999), NA, welfare$income)
  welfare$income <- ifelse(is.na(welfare$income), 192.5, welfare$income) # Imputation
  summary(welfare$income)  
  table(is.na(welfare$income))  
  
  # Analizing
  
  gender_income <- welfare %>% 
    group_by(gender) %>% 
    summarise(mean_income = mean(income))
  gender_income
  
  ggplot(data = gender_income, aes(x = gender, y = mean_income)) + geom_col()
                # You use "geom_col()" when you make bar graph from the frequency table, not the data.
  
  