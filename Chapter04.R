
# 04-1 How to understand data frames

  # Data Frame = Data Set = Table = Row*Column

  # What does that mean when data is big? that have lots of rows or columns

  # What you want to be many is columns, not rows.
  # Columns is key to the variety of your analysis.


# 04-2 How to make data frames

  name <- c("김지훈", "이유진", "박동현", "김민지")
  english <- c(90, 80, 60, 70)
  math <- c(50, 60, 100, 20)  

  df_score <- data.frame(name, english, math)
  df_score  

  mean(df_score$english)  
  mean(df_score$math)  

  df_score2 <- data.frame(name = c("김지훈", "이유진", "박동현", "김민지"),
                          english = c(90, 70, 60, 70),
                          math = c(50, 60, 100, 20))  
  df_score2  

# Quiz
  
  # Q1
  
  # i)
  fruit <- c("사과", "딸기", "수박")
  price <- c(1800, 1500, 3000)
  sale <- c(24, 38, 13)
  
  df_x <- data.frame(fruit, price, sale)
  df_x  

  # ii)
  df_x2 <- data.frame(fruit2 = c("사과", "딸기", "수박"),
                      price2 = c(1800, 1500, 3000),
                      sale2 = c(24, 38, 13))
  df_x2    

  
  # Q2
  mean(df_x$price)
  mean(df_x$sale)

