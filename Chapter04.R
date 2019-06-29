
# 04-1 How to understand data frames

  # Data Frame = Data Set = Table = Row*Column

  # What does that mean when data is big? that have lots of rows or columns

  # What you want to be many is columns, not rows.
  # Columns is key to the variety of your analysis.


# 04-2 How to make data frames

  name <- c("ê¹€ì§€?›ˆ", "?´?œ ì§?", "ë°•ë™?˜„", "ê¹€ë¯¼ì?€")
  english <- c(90, 80, 60, 70)
  math <- c(50, 60, 100, 20)  

  df_score <- data.frame(name, english, math)
  df_score  

  mean(df_score$english)  
  mean(df_score$math)  

  df_score2 <- data.frame(name = c("ê¹€ì§€?›ˆ", "?´?œ ì§?", "ë°•ë™?˜„", "ê¹€ë¯¼ì?€"),
                          english = c(90, 70, 60, 70),
                          math = c(50, 60, 100, 20))  
  df_score2  

# Quiz
  
  # Q1
  
  # i)
  fruit <- c("?‚¬ê³?", "?”¸ê¸?", "?ˆ˜ë°?")
  price <- c(1800, 1500, 3000)
  sale <- c(24, 38, 13)
  
  df_x <- data.frame(fruit, price, sale)
  df_x  

  # ii)
  df_x2 <- data.frame(fruit2 = c("?‚¬ê³?", "?”¸ê¸?", "?ˆ˜ë°?"),
                      price2 = c(1800, 1500, 3000),
                      sale2 = c(24, 38, 13))
  df_x2    

  
  # Q2
  mean(df_x$price)
  mean(df_x$sale)
  

# How to import data
  
  # From Excel
  
  install.packages("readxl")
  library(readxl)
  
  df_exam <- read_excel("excel_exam.xlsx")
  df_exam  
  
  mean(df_exam$math)
  mean(df_exam$english)  
  mean(df_exam$science)  
  
  
  install.packages("readxl")
  library(readxl)  

  df_exam2 <- read_excel("excel_exam_novar.xlsx", col_names = FALSE)
  df_exam2
  
  ?read_excel
  
  
  # From Excel but sheets are plural
  
  df_exam3 <- read_excel("excel_exam_sheet.xlsx", sheet = 3)
  df_exam3  

  
  # How to import CSV files (CSV = Comma-seperated Values)

  df_csv_exam <- read.csv("csv_exam.csv", header = TRUE)
  df_csv_exam    
  
  df_csv_exam2 <- read.csv("csv_exam.csv", header = TRUE,
                           stringsAsFactors = F)
  df_csv_exam2  # ¹®ÀÚ°¡ µé¾îÀÖ´Â ÆÄÀÏ ºÒ·¯¿Ã ¶§ stringAsFactors = F
  
  
  # How to export data frames to CSV files
  
  df_midterm <- data.frame(english = c(90, 80, 60, 70),
                           math = c(50, 60, 100, 20),
                           class = c(1, 1, 2, 2))
  df_midterm

  ?write.csv

  write.csv(df_midterm, file = "df_midterm.csv")
  
  # How to save a data frame as a R Data
  
  save(df_midterm, file = "df_midterm.rda")

  
  # Import R Data
  
  rm(df_midterm)
  df_midterm  

  load("df_midterm.rda")