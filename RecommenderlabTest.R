# Author: Rui Wang
# Date: Mar.2014-May.2014
##
# Clear up all data in workspace
##
rm(list=ls())



#ml100k <- read.table("D:/MyCourses/Data Mining/rstudioworkspace/ratings.dat", header = F, stringsAsFactors = T)
ml100k <- read.table("/Users/wangrui/Desktop/study/CS/CS513 data mining/ratings.dat", header = F, stringsAsFactors = T)
#tail(ml100k)

?head()
head(ml100k)
?tail()
tail(ml100k)
##
# Delete the last column of datestamp
##
ml100k<-ml100k[,-4]
View(ml100k)


?prop.table()  #gets x/sum(x)
prop.table(table(ml100k[, 3]))
?summary()
summary(ml100k[, 3])

##
#  In order to function cast, do the following steps:
#     1.Download packages (Be careful with the version, windows, OS X): 
#                           Rcpp    -> http://cran.r-project.org/web/packages/Rcpp/index.html
#                           plyr    -> http://cran.r-project.org/web/packages/plyr/index.html
#                           reshape -> http://cran.r-project.org/web/packages/reshape/index.html
#     2.Install Packages as the order above.
#     Advice: Shall we learn more about this 'cast' function ? We can talk about it in our presentation
#             because this might be the import step to build ratingMatrix used for recommenderlab
##
library(plyr)
library(reshape)
library(registry)
library(arules)
library(proxy)
library(recommenderlab)
ml100k <- cast(ml100k, V1 ~ V2, value = "V3")
ml.useritem=ml100k[,-1]
ml.useritem[1:5, 1:6]

?class()
class(ml.useritem)
# Keep data.frame only
class(ml.useritem) <- "data.frame"
ml.useritem <- as.matrix(ml.useritem)

##
#   In order to use realRatingMatrix as data type, we need to include recommenderlab as library :
#      1. Download packages:
#                     registry -> http://cran.r-project.org/web/packages/registry/index.html
#                     arules   -> http://cran.r-project.org/web/packages/arules/index.html
#                     proxy    -> http://cran.r-project.org/web/packages/proxy/index.html
#      2. Install packages and include them as library
##
?as()
ml.ratingMatrix <- as(ml.useritem, "realRatingMatrix")
ml.ratingMatrix
as(ml.ratingMatrix , "matrix")[1:3, 1:10]
as(ml.ratingMatrix , "list")[[1]][1:10]


recommenderRegistry$get_entries(dataType = "realRatingMatrix")


colnames(ml.ratingMatrix) <- paste("M", 1:1682, sep = "")
as(ml.ratingMatrix[1,1:10], "list")
ml.recommModel <- Recommender(ml.ratingMatrix[1:800], method = "IBCF")
ml.recommModel



ml.predict1 <- predict(ml.recommModel, ml.ratingMatrix[801:803], n = 5)
ml.predict1
as( ml.predict1, "list")

##
#  ml.predict2 <- predict(ml.recommModel, ml.ratingMatrix[801:803], type = "ratings")
#  ml.predict2
#  as(ml.predict2, "matrix")[1:3, 1:6]
##
