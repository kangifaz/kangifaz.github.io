plot(data$USDIDR, data$GPM, 
     main = "GPM vs USDIDR",
     xlab = "USDIDR", ylab = "GPM", 
     pch = 19, col = "blue")
model_GPM <- lm(GPM ~ USDIDR, data = data)
abline(model_GPM, col = "red")
summary(model_GPM)
