
# 06-1 Data Preprocessing (데이터 전처리)
#     = Data Manipulation, Data Handling, Data Wrangling
#     = Data Munging

# dplyr; a function often used for data preprocessing


# 06-2 to return data with matching conditions

  install.packages("dplyr")
  library(dplyr)  
  
  df_exam <- read.csv("csv_exam.csv", header = TRUE,
                      stringsAsFactors = FALSE)
  
  df_exam %>% filter(class == 1)  
  df_exam %>% filter(class == 5)
  
  # %>% Pipe Operator(파이프 연산자) Ctrl + Shift + M 
  
  df_exam %>% filter(class != 1, class != 2)
  
  
  install.packages("ggplot2")
  library(ggplot2)
  
  df_mpg <- as.data.frame(ggplot2::mpg)  
  library(dplyr)
  df_mpg$total <- (df_mpg$hwy + df_mpg$cty)/2
  mean(df_mpg$total)
  median(df_mpg$total)
  
  df_mpg$grade <- ifelse(df_mpg$total >= 30, "A",
                         ifelse(df_mpg$total >= 25, "B",
                                ifelse(df_mpg$total >= 20, "C", "D")))
  table(df_mpg$grade)
  
  df_mpg %>% filter(df_mpg$grade == "A")
  df_mpg %>% filter(df_mpg$grade == "B")
  df_mpg %>% filter(df_mpg$grade == "D")

  # the operator "AND" or "OR' deosn't work in filter()
  # Use "&" or "|"
  df_exam %>% filter(class == 1 & math >= 50)
  df_exam %>% filter(class == 1 &
                     (math >= 50 | science >= 50))

  df_exam %>% filter(class == 1 | class == 2 | class == 5)
  
  
  # %in% Matching Operator
  
  df_exam %>% filter(class %in% c(1, 3, 5))

  df_exam %>% filter(1 <= class & class < 10)

  df_a <- df_mpg %>% filter(df_mpg$grade == "A")  
  df_a  

  
# Quiz
  
  # Q1
  
  df_x1 <- df_mpg %>% filter(df_mpg$displ <= 4)
  df_x2 <- df_mpg %>% filter(df_mpg$displ >= 5)
  
  mean(df_x1$hwy)
  mean(df_x2$hwy)  

  # Q2
  
  df_audi <- df_mpg %>% filter(df_mpg$manufacturer == "audi")
  df_toyota <- df_mpg %>% filter(df_mpg$manufacturer == "toyota")  

  mean(df_audi$cty) 
  mean(df_toyota$cty)  # 도요타의 연비가 아우디보다 평균적으로 높음
  
  # Q3
  
  df_highway <- df_mpg %>% filter(df_mpg$manufacturer %in% 
                                  c("chevrolet", "ford" , "honda"))
  mean(df_highway$hwy)  # 위 세 제조사의 고속도로 연비 평균은 약 23
  
  
# 06-3
  
  df_exam %>% select(math)
  df_exam %>% select(english)

  df_exam <- rename(df_exam, id = 癤퓁d)
  head(df_exam)
  
  df_exam %>% select(-id)
  df_exam %>% select(-id, -class)

  df_exam %>%
    filter(class == 1) %>%
    select(english)
  
  df_mpg %>% 
    filter(grade == "A") %>% 
    select(hwy, cty, total) %>% 
    head(10)

# Quiz
  
  # Q1
  
  dim(mpg)
  library(dplyr)  
  df_mpg1 <- df_mpg %>% select(class, cty)
  head(df_mpg1)

  # Q2
  
  df_suv <- df_mpg1 %>% filter(class == "suv")
  df_compact <- df_mpg1 %>% filter(class == "compact")
  
  mean(df_suv$cty)  
  mean(df_compact$cty)  # compact 자동차가 suv 자동차보다 도시 연비가 높다
  
  
# 06-4
  
  df_exam %>% arrange(desc(math))
  df_exam %>% arrange(class, desc(math))

# Quiz
  
  # Q1
  df_mpg %>% 
    filter(manufacturer == "audi") %>% 
    select(class, model, hwy) %>% 
    arrange(desc(hwy)) %>%
    head(5)

  
# 06-5 mutate(); A fuction to make derived variables in "dplyr"
  
  #rm(df_totalexam)
  mean_exam <-
    df_exam %>% mutate( total = english + math + science,
          mean = (total)/3) %>% 
          arrange(class, desc(mean))
  head(mean_exam, 10) 
  
  mean(mean_exam$mean)
  mean_exam %>%
    mutate(grade = ifelse(mean >= 67, "pass", "fail")) %>% 
    head

# Quiz
  
  rm(df_mpg)
  mpg <- as.data.frame(ggplot2::mpg)
  mpg1 <- mpg
  mpg1 %>% mutate(total = cty + hwy,
                          mean = total/2) %>%
          arrange(desc(mean)) %>% 
          head(3)
  

# 06-6 group_by, summarise; functions to summarise data by group
  
  df_exam %>%
    group_by(class) %>%
    summarise(mean_english = mean(english)) %>% 
    arrange(desc(mean_english))

  df_exam %>% 
    mutate(total = english + math + science) %>% 
    group_by(class) %>% 
    summarise(mean = mean(total)) %>% 
    arrange(desc(mean))
  