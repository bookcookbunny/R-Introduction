# 05-1 functions to help comprehend data

exam <- read.csv(file = "csv_exam.csv",
                 stringsAsFactors = F)
exam

  # head(); to print 6 rows from the head
    head(exam)
    head(exam, 4)

  # tail(); to print 6 rows from the tail
    tail(exam)
    tail(exam,8)    

  # View(); to view data in a viewer similar to Excel
    View(exam)

  # dim(); to display how many dimensions a data frame has
    dim(exam)

  # str(); to display the structure of a data frame
    str(exam)

  # summary(); to print the main statistics such as mean
    summary(exam)

  install.packages("ggplot2")
  library(ggplot2)  
  mpg  

  mpg <- as.data.frame(ggplot2::mpg)
  # ?as.data.frame; to check if an object is a data frame,
                    # or coerce it if possible
  # ?data.frame; to creat data frames
  # :: 더블 콜론은 특정 패키지에 내장된 함수나 데이터 지정
  
  head(mpg)  
  summary(mpg)  
  dim(mpg)
  str(mpg)


# 05-2 dplyr::rename; a function to change variables's names

  ?dplyr  
  df_raw <- data.frame(var1 = c(1, 2, 1),
                       var2 = c(2, 3, 2))
  df_raw  

  install.packages("dplyr")  
  library(dplyr)

  df_new <- df_raw # make a copy of df_raw
  df_new

  df_new <- rename(df_new, v2 = var2) # new = old
  df_new  

  df_new <- rename(df_new, v1 = var1)  
  df_new  

# Quiz
  
  install.packages("ggplot2")
  library(ggplot2)  
  
  df_mpg <- as.data.frame(ggplot2::mpg)
  
  install.packages("dplyr")  
  library(dplyr)  

  df_mpg2 <- df_mpg  
  df_mpg2 <- rename(df_mpg2, city = cty)  
  df_mpg2 <- rename(df_mpg2, highway = hwy)  
  head(df_mpg2)
  
  
# 05-3 to make derived variables
  
  df <- data.frame(var1 = c(4, 3, 8),
                   var2 = c(2, 6, 1))
   
  df$var_sum <- df$var1 + df$var2
  df  

  df$var_mean <- (df$var1 + df$var2)/2
  df  

  rm(df_mpg)
  rm(df_mpg2)
  df_mpg <- as.data.frame(ggplot2::mpg)
  df_mpg2 <- df_mpg
  
  df_mpg2$total <- (df_mpg2$cty + df_mpg2$hwy)/2
  head(df_mpg2)
  
  mean(df_mpg2$total)

  summary(df_mpg2)  
  summary(df_mpg2$total)
  hist(df_mpg2$total) # 히스토그램(Histogram)

  df_mpg2$test <- ifelse(df_mpg2$total >= 20, "pass", "fail")
  head(df_mpg2)  
  
  table(df_mpg2$test) # 빈도표(Frequency Table)
  qplot(df_mpg2$test) # 막대 그래프(Bar Graph)

  df_mpg2$grade <- ifelse(df_mpg2$total >= 30, "A",
                          ifelse(df_mpg2$total >= 20, "B", "C"))
  head(df_mpg2, 30)
  summary(df_mpg2$total)

  table(df_mpg2$grade)  
  ggplot2::qplot(df_mpg2$grade)

  df_mpg2$grade2 <- ifelse(df_mpg2$total >= 30, "A",
                           ifelse(df_mpg2$total >= 25, "B",
                                  ifelse(df_mpg2$total >= 20, "C", "D")))
  head(df_mpg2)  
  
  table(df_mpg2$grade2)  
  qplot(df_mpg2$grade2)  
  
  
# Quiz
  
  df_midwest <- as.data.frame(ggplot2::midwest)
  head(df_midwest)  
  dim(df_midwest)
  summary(df_midwest)  

  df_mid <- df_midwest
  df_mid <- dplyr::rename(df_mid, total = poptotal)
  df_mid <- rename(df_mid, asian = popasian)  
  head(df_mid)  

  df_mid$asofpop = df_mid$asian/df_mid$total
  hist(df_mid$asofpop)
  ggplot2::qplot(df_mid$asofpop)

  mean(df_mid$asofpop)  
  median(df_mid$asofpop) 
  df_mid$prprtn_asian <- ifelse(df_mid$asofpop >= mean(df_mid$asofpop), "large", "small")  
  
  table(df_mid$prprtn_asian)  
  ggplot2::qplot(df_mid$prprtn_asian)
  