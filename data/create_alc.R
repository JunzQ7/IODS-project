# Juhana Rautavirta 
# 10.2.2017
# This data is about alcohol consumption among Portuguese students
# https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION

# Reading the two datasets
math <- read.csv("/home/juhana/Desktop/IODS-project/data/student-mat.csv", sep = ";", header = T)
por <- read.csv("/home/juhana/Desktop/IODS-project/data/student-por.csv", sep = ";", header = T)

# Exploring the structure and dimension
str(math)
dim(math)
str(por)
dim(por)

library(dplyr)

# This are the variables that identify the same students
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

# Joining the two datasets
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

str(math_por)
dim(math_por)

alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]
for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

# Creating a new column of alcohol usage on weeks and weekends and another column
# of high usage of alcohol

alc <- mutate(alc, alc_use = (Dalc + Walc)/2)
alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)

setwd("/home/juhana/Desktop/IODS-project/data")
write.csv(x = alc, file = "alc.csv")
