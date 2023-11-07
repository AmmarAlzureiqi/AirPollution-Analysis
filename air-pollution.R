library(ggplot2)
library(gridExtra)
library(tidyr)
library(sp)
library(rgdal)
library(raster)
library(maps)
library(gstat)
library(MAP)
library(ggplot2)
library(psych)
library(kableExtra)
library(leaps)
library(MASS)
library(geoR)


data <- read.csv('air_data.csv')
City <- data[seq(9, 329, by = 8)]
SO2 <- as.numeric(data[seq(10, 330, by = 8)])
Temp <- as.numeric(data[seq(11, 331, by = 8)])
Man <- as.numeric(data[seq(12, 332, by = 8)])
Pop <- as.numeric(data[seq(13, 333, by = 8)])
Wind <- as.numeric(data[seq(14, 334, by = 8)])
Rain <- as.numeric(data[seq(15, 335, by = 8)])
RainDays <- as.numeric(data[seq(16, 336, by = 8)])
air.data <- data.frame(City, SO2, Temp, Man, Pop, Wind, Rain, RainDays)


air.data$City <- as.factor(c("SW", "SE", "W", "W", "NE", "NE", "W", "SE", "SE", "SE", "MW", "MW", "MW", "MW", "SE", "SE", "NE", "MW", "MW", "MW", "MW", "MW", "SW", "NE", "NE", "MW", "MW", "MW", "NE", "NE", "NE", "SE", "SE", "SW", "SW", "W", "SE", "SE", "W", "SE", "MW"))

set.seed(192835647)
train.obs <- sample(1:41, 25)
test.obs <- c(1:41)[-train.obs]
train.data <- air.data[train.obs,]
test.data <- air.data[test.obs,]


plot(air.data)
ggplot(gather(air.data[,-1]), aes(value)) + geom_histogram(bins = 10) + facet_wrap(~key, scales = 'free_x')

p1 <- ggplot(air.data, aes(Man, Pop)) + geom_point() + geom_smooth() + ggtitle("Manufacturers vs. Population") + theme(plot.title = element_text(size = 8),axis.title.x = element_text(size = 8),axis.title.y = element_text(size = 8))
p2 <- ggplot(air.data, aes(Temp, Rain)) + geom_point() + geom_smooth() + ggtitle("Avg. Temperature vs. Avg. Rain") + theme(plot.title = element_text(size = 8),axis.title.x = element_text(size = 8),axis.title.y = element_text(size = 8))
p3 <- ggplot(air.data, aes(Man, SO2)) + geom_point() + geom_smooth() + ggtitle("SO2 vs. Manufacturers") + theme(plot.title = element_text(size = 8),axis.title.x = element_text(size = 8),axis.title.y = element_text(size = 8))
p4 <- ggplot(air.data, aes(Pop, SO2)) + geom_point() + geom_smooth() + ggtitle("SO2 vs. Population") + theme(plot.title = element_text(size = 8),axis.title.x = element_text(size = 8),axis.title.y = element_text(size = 8))
p5 <- ggplot(air.data, aes(SO2, Wind)) + geom_point() + geom_smooth() + ggtitle("SO2 vs. Avg. Wind") + theme(plot.title = element_text(size = 8),axis.title.x = element_text(size = 8),axis.title.y = element_text(size = 8))
p6 <- ggplot(air.data, aes(x = City, y = Temp)) + stat_summary(fun.y = "mean", geom = "bar") + ggtitle("Region vs. Avg. Temperature ") + theme(plot.title = element_text(size = 8),axis.title.x = element_text(size = 8),axis.title.y = element_text(size = 8))

grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 3, nrow = 2)

round(cor(air.data[,-1]), 2)

ggplot(air.data, aes(x = SO2)) +  geom_histogram(aes(y = ..density..), colour = "black", fill = "green") + geom_density(alpha = .2, fill = "#FF6666") 


shapiro.test(air.data$SO2)


getClass("Spatial")

Latitude <- c(33.448376, 34.746483, 37.773972, 39.742043, 41.763710, 34.225727, 38.900497, 30.332184, 25.761681, 33.753746, 41.881832, 39.791000, 41.619549, 37.697948, 38.328732, 29.951065, 39.299236, 42.331429, 44.954445, 39.099724, 38.627003, 41.257160, 35.106766, 42.652580, 42.880230, 39.103119, 41.505493, 39.983334, 39.952583, 40.440624, 41.825226, 35.117500, 36.174465, 32.779167, 29.749907, 40.758701, 36.850769, 37.541290, 47.608013, 32.776566, 43.038902)
Longitude <- c(-112.074036, -92.289597, -122.431297, -104.991531, -72.685097, -77.944710, -77.007507, -81.655647, -80.191788, -84.386330, -87.623177, -86.148003, -93.598022, -97.314835, -85.764771, -90.071533, -76.609383, -83.045753, -93.091301, -94.578331, -90.199402, -95.995102, -106.629181, -73.756233, -78.878738, -84.512016, -81.681290, -82.983330, -75.165222, -79.995888, -71.418884, -89.971107, -86.767960, -96.808891, -95.358421, -111.876183, -76.285873, -77.434769, -122.335167, -79.930923, -87.906471)

air.data$Longitude <- Longitude
air.data$Latitude <- Latitude

coordmat <- cbind(Longitude, Latitude)
pts <- SpatialPoints(coordmat)
llCRS <- CRS("+proj=longlat +datum=WGS84")
pts <- SpatialPoints(coordmat, proj4string = llCRS)
df <- data.frame(id = 1:41,  SO2 = SO2)
spdf <- SpatialPointsDataFrame(pts, data = df)

plot(spdf)

usa <- map_data("state")
ggplot() + geom_path(data = usa, aes(x = long, y = lat, group = group)) + geom_point(data = air.data, aes(x = Longitude, y = Latitude, size = SO2), color = "red") 


xyplot(SO2 ~ City, as.data.frame(spdf))


describe(SO2)
describe(log(SO2))


boxplot(SO2, main = "SO2 Concentration")


boxplot(log(SO2), main = "log(SO2) Concentration")


plot(variogram(SO2 ~ 1, spdf, cloud = TRUE))
plot(variogram(log(SO2) ~ 1, spdf, cloud = TRUE))
v <- variogram(log(SO2) ~ 1, spdf, cloud = TRUE)
df <- data.frame(np = v[1:10,1], AvgDist = v[1:10,2], Est = v[1:10, 3])
kable(df, "simple")


exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 1000)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 2000)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 3000)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 4000)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 5000)
plot(exp.var1)



exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 1000, width = 50)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 1000, width = 75)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 1000, width = 100)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 1000, width = 125)
plot(exp.var1)



exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 2000, width = 50)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 2000, width = 100)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 2000, width = 150)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 2000, width = 200)
plot(exp.var1)



exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 4500, width = 200)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 4500, width = 250)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 4500, width = 300)
plot(exp.var1)
exp.var1 <- variogram(log(SO2) ~ 1, spdf, cutoff = 4500, width = 350)
plot(exp.var1)



v.experi <- variogram(log(SO2) ~ 1, spdf, cutoff = 4500, width = 350)
plot(v.experi)



show.vgms()


v.fita <- vgm(0.6, "Exp", 1500, 0.15)
v.fitb <- vgm(0.5, "Exp", 1500, 0.2)
v.fitc <- vgm(0.5, "Sph", 2000, 0.1)
v.fitd <- vgm(0.35, "Gau", 1200, 0.24)
plot(v.experi, v.fita, main = "Exponential")
plot(v.experi, v.fitb, main = "Exponential")
plot(v.experi, v.fitc, main = "Spherical")
plot(v.experi, v.fitd, main = "Gaussian")



fit1 <- fit.variogram(v.experi, v.fita)
fit2 <- fit.variogram(v.experi, v.fitb)
fit3 <- fit.variogram(v.experi, v.fitc)
fit4 <- fit.variogram(v.experi, v.fitd)

attr(fit1, "SSErr")
attr(fit2, "SSErr")
attr(fit3, "SSErr")
attr(fit4, "SSErr")


kable(fit3, "simple")

kable(fit4, "simple")



fitted.fit1 <- fit.variogram(v.experi, vgm(psill = 0.4917201, model = "Sph", range = 2684.134, nugget = 	0.1835652, kappa = 0.5))
plot(v.experi, fitted.fit1, main = "Second Best Fit")

fitted.fit2 <- fit.variogram(v.experi, vgm(psill = 0.4356466, model = "Gau", range = 1257.821, nugget = 0.2412378, kappa = 0.5))
plot(v.experi, fitted.fit2, main = "Best Fit")

Cols <- seq(from = -125, to = -70, by = 2)
Rows <- seq(from = 25, to = 50, by = 2)
air.grid <- expand.grid(x = Cols, y = Rows)
air.grid <- SpatialPoints(air.grid, proj4string = llCRS)
gridded(air.grid) <- TRUE
plot(air.grid)
points(spdf, col = "red")
title("Interpolation Grid and Sample Points")



ordinary.krig <- krige(log(SO2) ~ 1, spdf, air.grid, model = fitted.fit2)
spplot(ordinary.krig)

cv.krig <- krige.cv(log(SO2) ~ 1, spdf, fitted.fit1, nmax = 40, nfold=5)
bubble(cv.krig, "residual", main = "log(SO2): 5-fold CV residuals")

mean(cv.krig$residual^2)


ord.krig <- krige(log(SO2) ~ 1, spdf, air.grid, model = fitted.fit1)
spplot(ord.krig)

cv.krig1 <- krige.cv(log(SO2) ~ 1, spdf,fitted.fit2, nmax = 40, nfold=5)
bubble(cv.krig1, "residual", main = "log(SO2): 5-fold CV residuals")

mean(cv.krig1$residual^2)



linear.model <- lm(SO2 ~ City + Temp + Man + Wind + Rain + RainDays, data = train.data)
summary(linear.model)

trainMSE <- mean(linear.model$residuals^2)
testMSE <- mean((test.data$SO2 - predict(linear.model, newdata = test.data))^2)

trainMSE
testMSE

linear.model1 <- lm(SO2 ~ City + Man + Wind, data = train.data)
summary(linear.model1)



trainMSE1 <- mean(linear.model1$residuals^2)
testMSE1 <- mean((test.data$SO2 - predict(linear.model1, newdata = test.data))^2)

trainMSE1
testMSE1



set.seed(123456)
train.obs1 <- sample(1:41, 25)
test.obs1 <- c(1:41)[-train.obs1]
train.data1 <- air.data[train.obs1,]
test.data1 <- air.data[test.obs1,]



linear.model2 <- lm(SO2 ~ City + Man + Wind, data = train.data1)
trainMSE1f <- mean(linear.model2$residuals^2)
testMSE1f <- mean((test.data1$SO2 - predict(linear.model2, newdata = test.data1))^2)
trainMSE1f
testMSE1f



linear.model3 <- lm(SO2 ~ City + Temp + Man + Wind + Rain + RainDays, data = train.data1)
trainMSEf <- mean(linear.model3$residuals^2)
testMSEf <- mean((test.data1$SO2 - predict(linear.model3, newdata = test.data1))^2)
trainMSEf
testMSEf



anova(linear.model, linear.model1)


plot(linear.model1, which = 1)
plot(linear.model1, which = 2)


plot(1:25, residuals(linear.model1), xlab = "Index", ylab = "Residuals")
abline(h = 0, col = "red")


library(car)

vif(linear.model1)



library(lmtest)

bptest(linear.model1)



hatvalues(linear.model1)

hatvalues(linear.model1) > 3*mean((hatvalues(linear.model1)))


stdres(linear.model1)
stdres(linear.model1) > 3



cooks.distance(linear.model1) > 1
cooks.distance(linear.model1) > 0.5



boxcox(linear.model1, lambda = seq(-3, 3, by = 0.1))


linear.model.log <- lm(log(SO2) ~ City + Man + Wind, data = train.data)
plot(linear.model.log, which = 1)
summary(linear.model.log)


trainMSE3 <- mean((train.data$SO2 - exp(predict(linear.model.log)))^2)
trainMSE3
testMSE3 <- mean((test.data$SO2 - exp(predict(linear.model.log, newdata = test.data)))^2)
testMSE3



linear.model.logf <- lm(log(SO2) ~ City + Man + Wind, data = train.data1)
trainMSE3f <- mean((train.data1$SO2 - exp(predict(linear.model.logf)))^2)
testMSE3f <- mean((test.data1$SO2 - exp(predict(linear.model.logf, newdata = test.data1)))^2)


back.models <- regsubsets(SO2 ~., data = train.data, nvmax = 5, method = "backward")
summary(back.models)
plot(back.models, scale = "adjr2", main = "Adjusted R^2")


forward.models <- regsubsets(SO2 ~., data = train.data, nvmax = 5, method = "forward")
summary(forward.models)
plot(forward.models, scale = "adjr2", main = "Adjusted R^2")



select.model <- lm(SO2 ~ City + Temp + Pop + Wind + Rain, data = train.data)
summary(select.model)



select.model1 <- lm(SO2 ~ City + Temp + Pop + Wind, data = train.data)
summary(select.model1)

anova(select.model, select.model1)



select.model2 <- lm(SO2 ~ City + Pop + Wind, data = train.data)
summary(select.model2)

anova(select.model1, select.model2)



trainMSE4 <- mean(select.model$residuals^2)
trainMSE4
testMSE4 <- mean((test.data$SO2 - predict(select.model, newdata = test.data))^2)
testMSE4

trainMSE5 <- mean(select.model2$residuals^2)
trainMSE5
testMSE5 <- mean((test.data$SO2 - predict(select.model2, newdata = test.data))^2)
testMSE5



select.modelf <- lm(SO2 ~ City + Temp + Pop + Wind + Rain, data = train.data1)
select.model2f <- lm(SO2 ~ City + Pop + Wind, data = train.data1)

trainMSE4f <- mean(select.modelf$residuals^2)
testMSE4f <- mean((test.data1$SO2 - predict(select.modelf, newdata = test.data1))^2)

trainMSE5f <- mean(select.model2f$residuals^2)
testMSE5f <- mean((test.data1$SO2 - predict(select.model2f, newdata = test.data1))^2)


poly.model <- lm(SO2 ~ City + Man + poly(Wind, 2), data = train.data)
summary(poly.model)

trainMSE6 <- mean(poly.model$residuals^2)
trainMSE6
testMSE6 <- mean((test.data$SO2 - predict(poly.model, newdata = test.data))^2)
testMSE6



poly.modelf <- lm(SO2 ~ City + Man + poly(Wind, 2), data = train.data1)
trainMSE6f <- mean(poly.modelf$residuals^2)
testMSE6f <- mean((test.data1$SO2 - predict(poly.modelf, newdata = test.data1))^2)



plot(poly.model)


library(FNN)

train.x <- cbind(train.data[,c(3, 5, 6)])
test.x <- cbind(test.data[,c(3, 5, 6)])
train.SO2 <- train.data$SO2

nonp.model1 <- knn.reg(train.x, test.x, train.SO2, k = 1)
nonp.model2 <- knn.reg(train.x, test.x, train.SO2, k = 2)
nonp.model3 <- knn.reg(train.x, test.x, train.SO2, k = 3)
nonp.model4 <- knn.reg(train.x, test.x, train.SO2, k = 4)
nonp.model5 <- knn.reg(train.x, test.x, train.SO2, k = 5)
nonp.model6 <- knn.reg(train.x, test.x, train.SO2, k = 6)
nonp.model7 <- knn.reg(train.x, test.x, train.SO2, k = 7)

MSEs <- c(mean((test.data$SO2 - nonp.model1$pred)^2), mean((test.data$SO2 - nonp.model2$pred)^2), mean((test.data$SO2 - nonp.model3$pred)^2), mean((test.data$SO2 - nonp.model4$pred)^2), mean((test.data$SO2 - nonp.model5$pred)^2), mean((test.data$SO2 - nonp.model6$pred)^2), mean((test.data$SO2 - nonp.model7$pred)^2))

plot(1:7, MSEs)
plot(test.data$SO2, nonp.model2$pred, xlab = "y", ylab = expression(hat(y)), main = "k = 2")

testMSE7 <- MSEs[2]
testMSE7


train.xf <- cbind(train.data1[,c(3, 5, 6)])
test.xf <- cbind(test.data1[,c(3, 5, 6)])
train.SO2f <- train.data1$SO2
nonp.model2f <- knn.reg(train.xf, test.xf, train.SO2f, k = 2)
testMSE7f <- mean((test.data1$SO2 - nonp.model2f$pred)^2)



linear.modelr <- lm(log(SO2) ~ City + Man + poly(Wind, 2), data = train.data)
summary(linear.modelr)

trainMSEr <- mean((train.data$SO2 - exp(predict(linear.modelr)))^2)
trainMSEr
testMSEr <- mean((test.data$SO2 - exp(predict(linear.modelr, newdata = test.data)))^2)
testMSEr

linear.modelrf <- lm(log(SO2) ~ City + Man + poly(Wind, 2), data = train.data1)
summary(linear.modelrf)

trainMSErf <- mean((train.data1$SO2 - exp(predict(linear.modelrf)))^2)
testMSErf <- mean((test.data1$SO2 - exp(predict(linear.modelrf, newdata = test.data1)))^2)

plot(linear.modelr)


library(kableExtra)
Model <- c("All Variables", "City, Man, Wind", "log(y) ~ City, Man, Wind", "F&B Selection: City, Temp, Pop, Wind", "F&B Selection: City, Pop, Wind", "Poly: City, Man, Wind^2", "KNN, k = 2", "log(y) ~ City, Man, Wind^2t")
trainMSEs <- c(trainMSE, trainMSE1, trainMSE3, trainMSE4, trainMSE5, trainMSE6, NA, trainMSEr)
testMSEs <- c(testMSE, testMSE1, testMSE3, testMSE4, testMSE5, testMSE6, testMSE7, testMSEr)
trainMSEfs <- c(trainMSEf, trainMSE1f, trainMSE3f, trainMSE4f, trainMSE5f, trainMSE6f, NA, trainMSErf)
testMSEfs <- c(testMSEf, testMSE1f, testMSE3f, testMSE4f, testMSE5f, testMSE6f, testMSE7f, testMSErf)
summarize <- data.frame(Model, trainMSEs, testMSEs, "Second Train MSE" = trainMSEfs, "Second Test MSE" = testMSEfs)
kable(summarize, "simple")



model <- lm(SO2 ~., data = train.data)
summary(model)
model1 <- lm(SO2 ~ City + Temp + Pop + Wind, data = train.data)
summary(model1)
anova(model, model1)

air.fun <- function(fitted, resids){
  yi <- fitted
  yi.new <- yi - resids
  boot.resids <- sample(resids, length(resids), replace = TRUE)
  yi.new <- yi.new + boot.resids
  return(yi.new)
}

boot.coefs <- as.matrix(replicate(1000, summary(lm(SO2 ~ City + Temp + Pop + Wind, data = data.frame(SO2 = air.fun(model1$fitted.values, model1$residuals), train.data[,-2])))$coefficients[,1]))

par(mfrow = c(3,4))
hist(boot.coefs[1,])
hist(boot.coefs[2,])
hist(boot.coefs[3,])
hist(boot.coefs[4,])
hist(boot.coefs[5,])
hist(boot.coefs[6,])
hist(boot.coefs[7,])

Boot.ests <- apply(boot.coefs, 1, mean)
Boot.ests
boot.ses <- apply(boot.coefs, 1, var)
sqrt(boot.ses)

model1$coefficients


set.seed(34)
idx <- sample(1:length(train.data$SO2), 300, replace = T)
boot.sample <- train.data[idx,]

boot.model <- lm(SO2 ~., data = boot.sample)
summary(boot.model)







