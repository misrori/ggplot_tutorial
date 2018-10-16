
library(ggplot2)
library(dplyr)


# materials
#  https://tutorials.iq.harvard.edu/R/Rgraphics/Rgraphics.html
#  https://www.youtube.com/watch?v=HeqHMM4ziXA
#  https://www.youtube.com/watch?v=n8kYa9vu1l8


#Import the datasaet
autodata <- read.csv("DA1_Team_Project_Antal_McNamee_Mihaly.csv", header = T, stringsAsFactors = F, sep = ",")
autodata <- autodata[, -1]
#data preperation#################################################################################
#delete the rows with NA
autodata<-autodata[complete.cases(autodata), ]
autodata$price = autodata$price/1000000
autodata$km = autodata$km/10000
autodata$engine = autodata$engine/1000
autodata$HP = autodata$HP/10
autodata[["km_square"]] =0
autodata$km_square= autodata$km*autodata$km
#deleting the new, and the oldtimer cars
usedcars <-
  autodata %>%
  filter(age <12, km>0.1)
#log price
usedcars["log_price"]=0
usedcars$log_price= log(usedcars$price)
#creating the binary variable on the engine
usedcars <- usedcars %>%
  mutate(engine_3l = as.numeric(usedcars$engine<3),
         engine_4_3l = as.numeric(usedcars$engine>3 & usedcars$engine<4.7),
         engine_4_7l = as.numeric(usedcars$engine >4.7)
  )
#making factors of petrol, cabrio, xdrive, dealer variable, and the engine variables
usedcars$petrol = as.factor(usedcars$petrol)
usedcars$dealer = as.factor(usedcars$dealer)
usedcars$engine_3l = as.factor(usedcars$engine_3l)
usedcars$engine_4_3l = as.factor(usedcars$engine_4_3l)
usedcars$engine_4_7l = as.factor(usedcars$engine_4_7l)
summary(usedcars)



# create the same plots as in the result pdf