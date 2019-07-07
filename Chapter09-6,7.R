setwd("C:/EX/R/easy_r")
getwd()

install.packages("foreign")
install.packages("dplyr")
install.packages("readxl")
install.packages("ggplot2")
library(foreign)
library(dplyr)
library(readxl)
library(ggplot2)

raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = TRUE,
                         header = TRUE,
                         stringsAsFactors = FALSE)
welfare <- raw_welfare
welfare <- rename(welfare, gender = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_reg = h10_reg7)


# 09-6 The difference of Income Depeding on Jobs

  # preprocessing "income"

  class(welfare$income)
  table(is.na(welfare$income))
  summary(welfare$income) 
  
  welfare <- welfare %>% 
    mutate(income = ifelse(income < 1 | income > 9998, NA, income))
  
  summary(welfare$income)  
  
  # preprocessing "job"
  
  class(welfare$code_job)
  summary(welfare$code_job)
  
  list_job <- read_excel("Koweps_Codebook.xlsx",
             sheet = 2,
             col_names = T)
  head(list_job)
  dim(list_job)
  
  welfare <- left_join(welfare, list_job, id = code_job)
  welfare %>% select(code_job, job) %>% 
    filter(!is.na(job)) %>% 
    arrange(code_job)

  # Analizing
  
  job_income <- welfare %>% 
    filter(!is.na(income) & !is.na(code_job)) %>% 
    group_by(job) %>% 
    summarise(mean_income = mean(income))
  
  top10 <- job_income %>% 
    arrange(desc(mean_income)) %>% 
    head(10)
  
  ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
    geom_col() +
    coord_flip()
    
  
  lowest10 <- job_income %>% 
    arrange(mean_income) %>% 
    head(10)
  lowest10
  
  ggplot(data = lowest10, aes(x = reorder(job, -mean_income), y = mean_income)) +
    geom_col() +
    coord_flip() +
    ylim(0, 850)
  
# 09-7 The Frequency of Jobs Depending on Gender
  
  welfare$gender <- ifelse(welfare$gender == 1, "male", "female")
  job_male <- welfare %>% 
    filter(!is.na(job) & gender == "male") %>% 
    group_by(job) %>% 
    summarise(n = n()) %>% 
    arrange(desc(n)) %>% 
    head(10)
  
  job_male
  
  ggplot(data = job_male, aes(x = reorder(job, n), y = n)) +
    geom_col() +
    coord_flip()

  job_female <- welfare %>% 
    filter(!is.na(job) & gender == "female") %>% 
    group_by(job) %>% 
    summarise(n = n()) %>% 
    arrange(desc(n)) %>% 
    head(10)

  job_female  
  
  ggplot(data = job_female, aes(x = reorder(job, n), y = n)) +
    geom_col() +
    coord_flip()
  