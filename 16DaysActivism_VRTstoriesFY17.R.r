# Pull out stories for 16 Days of Activism (for Ashley)
# Data source: VRT extract pulled through Tableau SQL connection
# Data source fields required: Post, Fiscal Year, Project, Vol ID, First Name, Story
# Data pull for FY17, pulled on 10/25/2018 from VRT; code updated with comments on 4/25/2019

#install and load libraries
install.packages("magrittr")
library(magrittr)
library(stringr)
library(tidyverse)

#insert working directory below
setwd("")

#read in VRT file
data <- readxl::read_xlsx("VRTstories_20181025.xlsx", col_names=TRUE)

#rename columns
names(data) [1] <- "firstname"
names(data) [2] <- "fiscalyear"
names(data) [3] <- "post"
names(data) [4] <- "project"
names(data) [5] <- "reportingperiod"
names(data) [6] <- "story"
names(data) [7] <- "volid"

#select for stories where phrase in " " is mentioned
df2 <- data %>% 
  select(post, fiscalyear, volid, firstname, story) %>% 
  filter(str_detect(data$story,("In Her Shoes")))

#export to CSV
write.csv(df2, "VRT20181025_stories")

#select for stories where phrase in " " is mentioned
df3 <- data %>% 
  select(post, fiscalyear, volid, firstname, story) %>% 
  filter(str_detect(data$story,"(violence|Violence)"))

#export to CSV
write.csv(df3,"VRT20181025_stories_violence.csv" )

#select for stories where phrase in " " is mentioned
df4 <- data %>% 
  select(post, fiscalyear, volid, firstname, story) %>% 
  filter(str_detect(data$story,("Men as Partners")))

#export to CSV
write.csv(df4,"VRT20181025_MAP.csv" )

#select for stories where phrase in " " is mentioned
df5 <- data %>% 
  select(post, fiscalyear, volid, firstname, story) %>% 
  filter(str_detect(data$story,("16 Days of Activism")))

#export to CSV
write.csv(df5,"VRT20181025_16days.csv" )
