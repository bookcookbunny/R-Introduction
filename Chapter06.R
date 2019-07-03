
# 06-1 Data Preprocessing (?ç∞?ù¥?Ñ∞ ?†ÑÏ≤òÎ¶¨)
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
  
  # %>% Pipe Operator(?åå?ù¥?îÑ ?ó∞?Ç∞?ûê) Ctrl + Shift + M 
  
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
  mean(df_toyota$cty)  # ?èÑ?öî??Ä?ùò ?ó∞ÎπÑÍ?Ä ?ïÑ?ö∞?îîÎ≥¥Îã§ ?èâÍ∑†Ï†Å?úºÎ°? ?Üí?ùå
  
  # Q3
  
  df_highway <- df_mpg %>% filter(df_mpg$manufacturer %in% 
                                  c("chevrolet", "ford" , "honda"))
  mean(df_highway$hwy)  # ?úÑ ?Ñ∏ ?†úÏ°∞ÏÇ¨?ùò Í≥†ÏÜç?èÑÎ°? ?ó∞Îπ? ?èâÍ∑†Ï?Ä ?ïΩ 23
  
  
# 06-3
  
  df_exam %>% select(math)
  df_exam %>% select(english)

  df_exam <- rename(df_exam, id = ?ô§?ìÅd)
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
  mean(df_compact$cty)  # compact ?ûê?èôÏ∞®Í?Ä suv ?ûê?èôÏ∞®Î≥¥?ã§ ?èÑ?ãú ?ó∞ÎπÑÍ?Ä ?Üí?ã§
  
  
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
  
# Quiz
  install.packages("ggplot2")
  library(ggplot2)
  
  install.packages("dplyr")
  library(dplyr)
  
  mpg <- as.data.frame(ggplot2::mpg, header = TRUE,
                       stringsAsFactors = FALSE)  
  head(mpg)  
  
  mpg1 <- mpg

  # Q1
  
  mpg1 %>% group_by(class) %>% 
    summarise(mean = mean(cty))
  
  # Q2
  mpg1 %>% group_by(class) %>% 
    summarise(mean = mean(cty)) %>% 
    arrange(desc(mean))
  
  # Q3
  
  mpg1 %>% group_by(manufacturer) %>% 
    summarise(mean = mean(hwy)) %>% 
    arrange(desc(mean)) %>% 
    head(3)

  # Q4
  
  mpg1 %>%  group_by(manufacturer) %>%
    filter(class == "compact") %>% 
    summarise(n = n()) %>% 
    arrange(n)
  
# 06-7
  
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterms = c(60, 80, 70, 90, 85))

test2 <- data.frame(id= c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))

total <- left_join(test1, test2, by = "id")
# Caution! Insert "" before and after the name of the reference variable

name <- data.frame(class = c(1, 2, 3, 4, 5),
              teacher = c("Kim", "Lee", "Park", "Choi", "Jung"))

exam <- read.csv("csv_exam.csv")
head(exam)

exam <- rename(exam, id = ?ô§?ìÅd)
head(exam)
head(name, 2)

exam_new <- left_join(name, exam, by = "class")
head(exam_new, 3)

group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))

group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))

install.packages("dplyr")
library(dplyr)

group_all <- bind_rows(group_a, group_b)
head(group_all, 10)

# Quiz

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = FALSE)

install.packages("ggplot2")
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg,
                     stringsAsFactors = FALSE)
head(mpg, 1)

mpg_fl <- left_join(mpg, fuel, by = "fl")
head(mpg_fl, 2)

mpg_fl %>% select(model, fl, price_fl) %>% 
  head(5)

# Quiz

install.packages("ggplot2")
library(ggplot2)

install.packages("dplyr")
library(dplyr)

midwest <- as.data.frame(ggplot2::midwest, header = TRUE,
                        stringsAsFrame = FALSE)
midwest2 <- midwest
midwest2 %>% 
  mutate(pop_minor = round((poptotal-popadults)/poptotal*100, 2),
         grade_minor = ifelse(pop_minor >= 40, "large",
                              ifelse(pop_minor >= 30, "middle", "small")),
         p_asian = round((popasian/poptotal)*100, 2)) %>%
  select(state, county, p_asian) %>% 
  arrange(p_asian) %>% 
  head(10)

