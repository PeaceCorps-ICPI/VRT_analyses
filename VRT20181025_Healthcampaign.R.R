
##Collate Success Stories from VRT for the November 2018 Health Campaign at PC
#Data pulled from VRT on 10/25/2018
#Katya Noykhovich

#install and load necessary packages
install.packages("magrittr")
library(magrittr)
library(stringr)
library(tidyverse)

#set working directory
setwd("")

#read in excel dataset, pulled via Tableau Connection to VRT
data <- readxl::read_xlsx("VRTstories_20181025.xlsx", col_names=TRUE)

#rename columns in dataset
names(data) [1] <- "firstname"
names(data) [2] <- "fiscalyear"
names(data) [3] <- "post"
names(data) [4] <- "project"
names(data) [5] <- "reportingperiod"
names(data) [6] <- "story"
names(data) [7] <- "volid"

##(did not work b/c df1$story, need to do data$story) Attempt 1
#subset the data frame to only include keywords and create a column for the keywords
#df1 <- data %>% 
#  select(post, fiscalyear, project, volid, firstname, story) %>% 
#  filter(str_detect(data$story,"(GRS|grassroots soccer|EPCMD|PEPFAR|WASH|malaria|HIV|OVC|VAST|MNCH|Life Skills)")) %>% 
#  mutate(keyword = str_extract_all(data$story, "GRS|grassroots soccer|EPCMD|PEPFAR|WASH|malaria|HIV|OVC|VAST|MNCH|Life Skills"))

##Attempt 2
#Subset the data frame to only include keywords AND IGNORE CASE SENSITIVITY OF KEYWORDS
df2 <- data %>% 
  select(post, fiscalyear, project, volid, firstname, story) %>% 
  filter(str_detect(data$story,regex("(GRS|grassroots soccer|EPCMD|PEPFAR|WASH|malaria|HIV|OVC|VAST|MNCH|Life Skills)",ignore_case = TRUE)))

df2$keyword <- str_extract(df2$story, "WASH")


#Create a column for the keywords, irrespctive of case sensitivity
df3 <- df2  %>% 
    mutate(keyword = str_extract_all(story,("GRS|grassroots soccer|EPCMD|PEPFAR|WASH$*|malaria|Malaria|HIV|OVC|VAST|MNCH|Life Skills"),simplify=FALSE))

#coding w/Yaa
df4 <- data %>% 
  select(post, fiscalyear, project, volid, firstname, story) %>% 
  filter(str_detect(data$story,("WASH$*|wash$*")))
 
df4$keyword <- str_extract(df4$story, "WASH$*|wash$*")

df5 <- df4  %>% 
  mutate(keyword = str_extract(story,("WASH*")))

#embedding regex into keyword column

df6 <- data %>% 
  select(post, fiscalyear, project, volid, firstname, story) %>% 
  filter(str_detect(data$story,regex("(GRS|grassroots soccer|EPCMD|PEPFAR|WASH|malaria|HIV|AIDS|OVC|VAST|MNCH|Life Skills|maternal)",ignore_case = TRUE)))

df6$keywords <- str_extract_all(df6$story, regex("(GRS|grassroots soccer|EPCMD|PEPFAR|WASH|malaria|HIV|AIDS|OVC|VAST|MNCH|Life Skills|maternal)",ignore_case = TRUE))

df6$GRS <- str_extract_all(df6$story, regex("(GRS|grassroots soccer|Life Skills)",ignore_case = TRUE))
df6$EPCMD <- str_extract_all(df6$story, regex("(EPCMD|MNCH|maternal)",ignore_case = TRUE))
df6$HIVAIDS <- str_extract_all(df6$story, regex("(PEPFAR|HIV|AIDS|OVC)",ignore_case = TRUE))
df6$WASH <- str_extract_all(df6$story, regex("(WASH)",ignore_case = TRUE))
df6$VAST <- str_extract_all(df6$story, regex("(VAST)",ignore_case = TRUE))
df6$malaria <- str_extract_all(df6$story, regex("(malaria)",ignore_case = TRUE))

#flatten list in keywords columns to be able to write to csv, solution: https://stackoverflow.com/questions/24829027/unimplemented-type-list-when-trying-to-write-table
df6$keywords <- vapply(df6$keywords, paste, collapse = ", ", character(1L))
df6$GRS <- vapply(df6$GRS, paste, collapse = ", ", character(1L))
df6$EPCMD <- vapply(df6$EPCMD, paste, collapse = ", ", character(1L))
df6$HIVAIDS <- vapply(df6$HIVAIDS, paste, collapse = ", ", character(1L))
df6$WASH <- vapply(df6$WASH, paste, collapse = ", ", character(1L))
df6$VAST <- vapply(df6$VAST, paste, collapse = ", ", character(1L))
df6$malaria <- vapply(df6$malaria, paste, collapse = ", ", character(1L))


write.csv(df6,file ="VRT20181031_HealthCampaignStories.csv")

