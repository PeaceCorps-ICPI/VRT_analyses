#Merge VRT Indicator Extracts for HE-140-PEPFAR 

#merge excel files
#source code: https://medium.com/@niharika.goel/merge-multiple-csv-excel-files-in-a-folder-using-r-e385d962a90a 
install.packages('openxlsx')
library(openxlsx)
getwd()

path <- "C:/R/VRT/IndicatorExtracts/HE140PEPFAR"

merge_file_name <- "VRTmergedHE140.xlsx"

filenames_list <- list.files(path= path, full.names=TRUE)

All <- lapply(filenames_list,function(filename){
  print(paste("Merging",filename,sep = " "))
  read.xlsx(filename)
})

df <- do.call(rbind.data.frame, All)

names(df)

#drop any unnecessary columns s
subdf <- df[c(-(9),-(12:13), -(23), -(22),  -(37:44), -(47))]
names(subdf)


library(tidyverse)
#reshape dataset from wide to long
longdf <- gather(subdf, key= "disaggregate", "value", 41:58, na.rm=TRUE)

names(longdf)

write.xlsx(longdf, file = "VRTmergedHE140.xslx", colNames = TRUE)
