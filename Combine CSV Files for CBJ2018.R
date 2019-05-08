#Code to Combine CSV Files, used for CBJ anaysis

#https://medium.com/towards-data-science/using-r-to-merge-the-csv-files-in-code-point-open-into-one-massive-file-933b1808106

setwd("~/R/Combine CSV Files/temp")
filenames <- list.files(full.names=TRUE)
All <- lapply(filenames,function(i){
  read.csv(i, header=FALSE, skip=4)
})
df <- do.call(rbind.data.frame, All)
head(df)
write.csv(df,"all_posts_FY17CBJ.csv", row.names=FALSE)


