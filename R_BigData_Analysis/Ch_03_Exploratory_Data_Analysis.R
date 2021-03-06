#Ch_03 Exploratory Data Analysis

#R의 데이터 형태
#Numeric - R에서 숫자는 기본적으로 Numeric으로 설정됩니다.

#Integer - 소숫점이 없는 정수이며, as.integer()를 통해 형태를 변환할 수 있다.
as.integer(1.23)

#Character - 문자열을 나타냅니다. as.character()을 통해 설정해 줄 수 있으며,
#cat()로 여러 문자들을 하나로 묶어 줄 수도 있다. 
as.character(1.23)

#Logical - TRUE 혹은 FALSE로 저장되는 값 입니다.
1 == 2
1 == 1

#Factor - 범주형 변수에 적용된다. 범주의 벡터를 각각의 level로 부호화해 저장.
#이러한 구분은 범주에 따라 데이터를 필터링하고 그룹을 만들 때 매우 유용

#데이터의 형태를 알고 싶을때 class()를 활용하면 된다.
class(1.23)
class("1.23")

#하나의 변수 분석하기
#일변량 분석이라고도 하며 데이터를 분석할 때 수치와 분포를 살펴보기위한 
#str()함수를 사용한다.

#현재 경로 확인과 내가 원하는 경로 셋팅하기기
getwd()
setwd("E:/hello-git-sourcetree/R_GO/R_Business_Intelligence")
#데이터 불러오기
sns_marketing<-read.csv("Ch3_SNS_marketing.csv",stringsAsFactors = TRUE)
#str()통해 수치와 분포를 살펴보기기
str(sns_marketing)

#factor()를 통해 변수를 순서형으로 변환 시키기.
#ordered 파라미터를 통해 변수 순서 고정시키기 
sns_marketing$타겟시장_인구밀도<-factor(sns_marketing$타겟시장_인구밀도,
                                       ordered= TRUE,
                                       levels = c("Low","Medium","High"))


#표를 활용한 데이터 탐색
#summary()는 평균을 포함하여 총 6가지의 중요한 수치를 알려줍니다.
summary(sns_marketing$유튜브광고_예산)

#R에서는 mean() / sd() / var()를 통해 평균, 표준편차, 분산을 쉽게 계산
mean(sns_marketing$유튜브광고_예산)
sd(sns_marketing$유튜브광고_예산)
var(sns_marketing$유튜브광고_예산)

#범주형 변수에 summary()적용하게 되면 레벨과 각 수준별 관측치 개수를 알려줍니다.
summary(sns_marketing$타겟시장_인구밀도)

#시각화를 활용한 데이터 탐색색
#anscombe데이터는 R에 내장되어 있는 데이터 입니다.
data("anscombe")
anscombe
#sapply()는 벡터,리스트, 표현식, 데이터 프레임 등에 함수를 적용하고 그 결과를 벡터 또는 행렬로 돌려줍니다.
sapply(sns_marketing, class) #sapply()를 통해 데이터가 가진 범주를 확인할 수도 있다. 
sapply(anscombe,mean)
sapply(anscombe,sd)
sapply(anscombe,var)

#데이터 탐색 시각화
plot(sns_marketing$타겟시장_인구밀도)
boxplot(sns_marketing$유튜브광고_예산, ylab = "지출_Expenditures")
hist(sns_marketing$유튜브광고_예산, main = "지출분포")

#데이터 탐색 시각화_네이버 블로그 광고
summary(sns_marketing$네이버블로그광고_예산)
boxplot(sns_marketing$네이버블로그광고_예산, ylab = "지출_Expenditures",col = "gray")
hist(sns_marketing$네이버블로그광고_예산,main = NULL, col = "skyblue")

#두개의 변수 분석하기 _ 이변량 데이터분석
summary(sns_marketing)

#변수 추가하고 제거하기 
#cut()는 두번째 파라미터로 정한 수 만큼 범주를 분리하여 저장합니다.
#즉, 종업원 수를 중앙값으로 구분하여 두 범주로 구분하도록 합니다.
sns_marketing$emp_factor<-cut(sns_marketing$종업원_수,2)
summary(sns_marketing)

#변수 제거하기 
sns_marketing$emp_factor<-NULL

#table()를 통해 두 변수에 대한 빈도표 생성
#두개의 범주형 데이터 관계는 아이디어를 제공합니다.
#결과값은 두 개의 차원에서 균등하게 보일 수도 있습니다.
table(sns_marketing$emp_factor,sns_marketing$타겟시장_인구밀도)

#시각화를 통해 살펴보기
#mosaicplot()은 두개의 범주형 데이터를 그릴 수 있습니다.
#단, table()가 포함되어야 합니다.
mosaicplot(table(sns_marketing$타겟시장_인구밀도,sns_marketing$emp_factor),
                 col = c("gray","skyblue"),main = "범주형 / 범주형",
                 ylab = "종업원 수",xlab = "인구밀도")

#boxplot()함수에 범주형 데이터와 숫자형 데이터를 넣어 활용할 수도 있다.
boxplot(sns_marketing$총_마케팅_예산 ~ sns_marketing$타겟시장_인구밀도,
        main = "범주형 / 숫자형")

#plot() 함수를 이용해 두 변수의 숫자형 데이터에 대하여 산점도를 그릴 수 있습니다.
plot(sns_marketing$유튜브광고_예산, sns_marketing$수익, main = "숫자형 / 숫자형")

#두 변수 사이의 상관관계를 파악하기 
#유튜브 광고예산과 수익/페이스북 광고예산 간의 상관관계 확인   
cor(sns_marketing$유튜브광고_예산,sns_marketing$수익)
cor(sns_marketing$유튜브광고_예산,sns_marketing$페이스북광고_예산)

#유의성 테스트
cor.test(sns_marketing$유튜브광고_예산,sns_marketing$수익)
cor.test(sns_marketing$네이버블로그광고_예산,sns_marketing$수익)

#예시)1인당 치즈소비량과 토목공학 박사 수여량의 상관관계
cheese<-c(9.3,9.7,9.7,9.7,9.9,10.2,10.5,11,10.6,10.6)
degrees<-c(480,501,540,552,547,622,655,701,712,708)
cor(cheese,degrees)
cor.test(cheese,degrees)

#상관관계가 유의하지 않은 케이스 살펴보기기
cor.test(sns_marketing$유튜브광고_예산,sns_marketing$페이스북광고_예산)

#좁은 신뢰구간 살펴보기기
cor.test(sns_marketing$총_마케팅_예산,sns_marketing$수익)

#그래프를 활용한 상관관계
plot(sns_marketing$유튜브광고_예산, sns_marketing$수익, main = "cor:0.766")
plot(sns_marketing$유튜브광고_예산, sns_marketing$페이스북광고_예산, main = "cor:0.076")
plot(sns_marketing$총_마케팅_예산, sns_marketing$수익,main = "cor:0.853")

#불필요 변수 제거
sns_marketing$emp_factor<-NULL

#4단계 절차를 통한 데이터 탐색
#1.데이터 관찰
str(sns_marketing)
#2.다수의 변수 동시에 분석
pairs(sns_marketing)

#3.다수의 상관관계 파악
cor(sns_marketing[,1:6])

#4.유의성 판단하기 
#cor()함수의 결과와 p값을 결합해주는 corr.test()함수 제공
install.packages("psych")
library(psych)

corr.test(x = sns_marketing[,1:6])

#유의성 판단하기 시각화
install.packages("corrgram")
library(corrgram)

corrgram(sns_marketing[,1:6], order = FALSE,
         main = "Correlogram of SNS_Marketing Data, Unordered",
         lower.panel = panel.conf, upper.panel = panel.ellipse,
         diag.panel = panel.minmax, text.panel = panel.txt)

corrgram(sns_marketing[,1:6], order = TRUE,
         main = "Correlogram of SNS_Marketing Data, Ordered",
         lower.panel = panel.shade, upper.panel = panel.pie,
         diag.panel = panel.minmax, text.panel = panel.txt)

#panel.conf : 상관계수와 신뢰구간 표시
#panel.ellipse : 원과 선으로 상관관계 시각화
#panel.shade : 빗금과 색의 강도로 상관관계 및 계수 시각화
#Panel.pie : 파이그래프로 상관관계 시각화
#panel.minmax : 변수값의 최솟값 최댓값 표기 
#panel.txt : 변수명 표기