# 07-1 to Filter Missing Values

df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
is.na(df)
table(is.na(df))
table(is.na(df$sex))
table(is.na(df$score))

mean(df$sex)
mean(df$score)

df_nomiss <- df %>% filter(!is.na(sex) & !is.na(score))
df_nomiss

table(is.na(df))

df_nomiss2 <- na.omit(df)
df_nomiss2

df
mean(df$score, na.rm = T)
sum(df$score, na.rm = TRUE)

exam <- read.csv("csv_exam.csv", stringsAsFactors = F)
exam2 <- exam
exam2

exam2[c(3, 8, 15), "math"] <- NA
exam2

exam2 %>% filter(!is.na(math))

install.packages("dplyr")
library(dplyr)
exam2 %>% summarise(mean = mean(math, na.rm = TRUE))
exam2 %>% group_by(class) %>% 
  summarise(mean = mean(math, na.rm = TRUE))

exam2 %>% group_by(class) %>% 
  summarise(mean_math = mean(math, na.rm = TRUE),
            mean_eng = mean(english),
            mean_sci = mean(science))

  # Imputation; Replace missing values
  mean(exam2$math, na.rm = TRUE)
  median(exam2$math, na.rm = TRUE)  
  
  exam2$math <- ifelse(is.na(exam2$math), 63.5, exam2$math)
  exam2$math
  table(is.na(exam2$math))
  
  mean(exam2$math)

# Quiz
  mpg <- as.data.frame(ggplot2::mpg)
  mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA  
  
  # Q1
  table(is.na(mpg$hwy))
  table(is.na(mpg$drv))
  
  # Q2
  
    # (1) 
    mpg %>% group_by(drv) %>% 
    summarise(mean_hwy = mean(hwy, na.rm = TRUE))
        # 구동방식 "f"의 고속도로 연비 평균이 가장 높다.
    
    # (2)
    mpg %>% filter(!is.na(hwy)) %>% 
      group_by(drv) %>% 
      summarise(mean_hwy = mean(hwy))
         # 구동방식 "f"의 고속도로 연비 평균이 가장 높다
    
# 07-2 Remove outliers
    
    outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                          score = c(5, 4, 3, 4, 2, 6))
    table(outlier$sex) # outlier = 3
    table(outlier$score) # outlier = 6
    
    outlier$sex <- ifelse(outlier$sex > 2, NA, outlier$sex)
    outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
    outlier
    
    outlier %>% 
      filter(!is.na(sex) & !is.na(score)) %>% 
      group_by(sex) %>% 
      summarise(mean_score = mean(score))

  # determine outliers
  
    boxplot(mpg$hwy)$stats
    
    mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
    table(is.na(mpg$hwy))
    
    mpg %>% 
      filter(!is.na(mpg$hwy)) %>% 
      group_by(drv) %>% 
      summarise(mean_hwy = mean(hwy))
    
    mpg %>% 
      group_by(drv) %>% 
      summarise(mean_hwy = mean(hwy, na.rm = TRUE))

# Quiz
  mpg <- as.data.frame(ggplot2::mpg, header = TRUE)
  mpg[c(10, 14, 58, 33), "drv"] <- "k"
  mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)
  
  # Q1
  table(mpg$drv)
  mpg$drv <- ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA)
  table(mpg$drv)  

  # Q2
  boxplot(mpg$cty)$stats
  mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
  boxplot(mpg$cty)$stats
  
  # Q3
  
  install.packages("dplyr")
  library(dplyr)
  
  mpg %>%
    group_by(drv) %>% 
    summarise(mean_cty = mean(cty, na.rm = TRUE))
  
  mpg %>%
    filter(!is.na(cty) & !is.na(drv)) %>% 
    group_by(drv) %>% 
    summarise(mean_cty = mean(cty))
    