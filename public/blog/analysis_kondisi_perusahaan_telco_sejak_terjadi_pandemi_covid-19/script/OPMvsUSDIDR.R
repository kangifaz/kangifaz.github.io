plot(data$USDIDR, data$OPM, 
     main = "OPM vs USDIDR",
     xlab = "USDIDR", ylab = "OPM", 
     pch = 19, col = "blue")
model_OPM <- lm(OPM ~ USDIDR, data = data)
abline(model_OPM, col = "red")
summary(model_OPM)
