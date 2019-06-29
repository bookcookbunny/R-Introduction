# 03-2

income <- c(1000, 2000, 3000, 4000)
gender <- c("m", "m", "f", "f")
gpa <- c(3.8, 4.2, 2.6, 4.5)


var1 <- c(3:8)
var2 <- c(-9:6)
var3 <- seq(3, 8)
var4 <- seq(1, 3, by = 0.1)
var5 <- seq(-3, -1, by = 0.1)

var1*2


# 여러 값으로 구성된 변수끼리 연산하면 같은 순서에 위치한 값끼리 연산

var4*var5
var1+var2 # 길이가 서로 다르기 때문에 연산 불가
          # 변수의 길이가 서로 같아야 연산 가능

char1 <- c("Life", "is", "great", "YOLO")
char1


# 문자 처리 전용 함수
  
  # paste() ; 여러 문자를 합쳐 하나로 만드는 함수

paste(char1, collapse = ' ')

  # 파라미터(Parameter) = 매개변수
  # ; collapse처럼 함수의 옵션을 설정하는 명령어

  char2 <- paste(char1, collapse = ' ')
  char2



# 03-3

install.packages("ggplot2")
library(ggplot2)

  # 빈도 막대 그래프
  x <- c("a", "b", "b", "c", "d", "d", "d", "d", "d")
  x
  qplot(x)  

  
  # qqplpot2 패키지에 들어 있는 mpg 데이터
  mpg
  qplot(data = mpg, x = hwy)
  qplot(data = mpg, x = manufacturer, y = hwy, geom = 'boxplot', color = drv )

  
# Quiz
  
  # Q1
  
  score <- c(80, 60, 70, 50, 90)
  score  

  
  # Q2
  
  mean(score)

  
  # Q3
  
  mean <- mean(score)
  mean
  