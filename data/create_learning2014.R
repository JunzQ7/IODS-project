# Juhana Rautavirta
# 29.1.2017
# This is a R Script for the Week 2 Exercises.

lrn2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
str(lrn2014)
dim(lrn2014)

# This dataset consists of 60 variables and 183 obsertavions. On of the variables is
# factored and the rest are Integer-type.

library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Let us select some columns by combining certain questions.

deep_columns <- select(lrn2014, one_of(deep_questions))
lrn2014$deep <- rowMeans(deep_columns)

surface_columns <- select(lrn2014, one_of(surface_questions))
lrn2014$surf <- rowMeans(surface_columns)

strategic_columns <-select(lrn2014, one_of(strategic_questions))
lrn2014$stra <- rowMeans(strategic_columns)

# Since the Attitude-variable is a sum of 10 questions, we shall divide every observation by 10 and save

lrn2014$attitude <- lrn2014$Attitude / 10

# Here we select the columns that we want to include in the analysis dataset

keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# Creating a new dataset, renaming some columns and excluding observations with zero points

learning2014 <- select(lrn2014, one_of(keep_columns))
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
learning2014 <- filter(learning2014, points > 0)


setwd("~/Desktop/IODS-project")
write.table(x=learning2014, file = "learning2014.txt", sep = ",")

table <- read.table("/home/juhana/Desktop/IODS-project/learning2014.txt", sep = ",", header = T)
str(table)
head(table)
