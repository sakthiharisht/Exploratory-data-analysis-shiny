library(shiny)
library(shinyjs)
library(DT)
library(visdat)
library(ggplot2)
library(GGally)
library(visdat)
library(corrgram)
library(summarytools)
library(plotly)
library(randomForest)
library(corrgram)
library(RColorBrewer)
library(car)
library(vcd)
library(shinycssloaders)
library(shinythemes)
library(shinydashboard)
library(shiny.semantic)
library(shinythemes)
library(tibble)
library(plotly)
library(tabplot)
library(Amelia)


givenData<- read.csv("sample.csv",header=TRUE)
dat <- givenData[,-45]
dat$Author = as.factor(dat$Author)
dat$Date = as.Date(dat$Date,"%m/%d/%Y")
dat$Priority = factor(dat$Priority, levels = c("Low","Medium","High"), ordered=TRUE)
dat$Price = factor(dat$Price, levels = c("Cheap","Costly","Extravagant"), ordered=TRUE)
dat$Speed = factor(dat$Speed,levels = c("Slow","Medium","Fast"), ordered=TRUE)
dat$Duration = factor(dat$Duration,levels = c("Short","Long","Very Long"), ordered=TRUE)
dat$Temp = factor(dat$Temp,levels = c("Cold","Warm","Hot"), ordered=TRUE)
dat$Location = as.factor(dat$Location)
dat$Agreed = as.factor(dat$Agreed)
dat$State = factor(dat$State,levels = c("Uncertain","Under review","Checked"), ordered=TRUE)
dat$Class = as.factor(dat$Class)
dat$Surface = as.factor(dat$Surface)
pearsonTopVariables1 <- c(35,37,39,42,43,40,44)
pearsonTopVariables2 <- c(34,30,29,25,33,28,26,32)
pearsonTopVariables3 <- c(36,41,38,17,18,31,27)
pearsonTopVariables4 <- c(20,21,19,15,23,22,16,24)
spearmanTopVariables1 <- c(35,37,39,42,43,40,44)
spearmanTopVariables2 <- c(19,15,23,22,16,24,20,21)
spearmanTopVariables3 <- c(32,34,30,29,25,33,28,26)
spearmanTopVariables4 <- c(38,41,36)
kendallTopVariables1 <- c(35,37,39,42,43,40,44)
kendallTopVariables2 <- c(19,15,23,22,16,24,20,21)
kendallTopVariables3 <- c(32,34,30,29,25,33,28,26)
kendallTopVariables4 <- c(38,41,36)
mosaicVariables <- c("Author","Priority","Price","Speed","Duration","Temp","Location","Agreed","State","Class","Surface")
risingValueVariables <-  c("sensor1","sensor2","sensor3","sensor4","sensor5","sensor6","sensor7","sensor8","sensor9","sensor10",
                           "sensor11","sensor12","sensor13","sensor14","sensor15","sensor16","sensor17","sensor18","sensor19",
                           "sensor20","sensor21","sensor22","sensor23","sensor24","sensor25","sensor26","sensor27",
                           "sensor28","sensor29","sensor30","Y")
missingValueVariables <-  c("sensor1","sensor2","sensor3","sensor4","sensor5","sensor6","sensor7","sensor8","sensor9","sensor10",
                            "sensor11","sensor12","sensor13","sensor14","sensor15","sensor16","sensor17","sensor18","sensor19",
                            "sensor20","sensor21","sensor22","sensor23","sensor24","sensor25","sensor26","sensor27",
                            "sensor28","sensor29","sensor30","Y","ID","Author","Date","Priority","Price","Speed","Duration",
                            "Temp","Location","Agreed","State","Class","Surface")

cols<-c(1,15:44)
d<- dat[,cols]

