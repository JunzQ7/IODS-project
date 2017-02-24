# Juhana Rautavirta
# 24.2.2017
# Original data: http://hdr.undp.org/en/content/human-development-index-hdi

# Downloading the data:

human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep = ",", header = T, stringsAsFactors = F)

library(dplyr); library(ggplot2); library(stringr); library(tidyr)

#human$GNI <- mutate(human, GNI = as.numeric(GNI))
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

human <- select(human, one_of(keep))


# remove all rows with NA values
human <- filter(human, complete.cases(human))

#remove the regions and keep the countries
removeThese <- c("Arab States", "East Asia and the Pacific", "Europe and Central Asia", "Latin America and the Caribbean", "Sub-Saharan Africa", "World", "South Asia")
human <- subset(human, ! Country %in% removeThese)

rownames(human) <- human$Country
human <- select(human, -Country)


setwd("/home/juhana/Desktop/IODS-project/data")
write.csv(x = human, file = "human.csv", row.names = T)

