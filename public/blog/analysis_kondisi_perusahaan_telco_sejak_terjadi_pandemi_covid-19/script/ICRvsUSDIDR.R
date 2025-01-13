plot(data$USDIDR, data$ICR, 
     main = "ICR vs USDIDR",
     xlab = "USDIDR", ylab = "ICR", 
     pch = 19, col = "blue")
model_ICR <- lm(ICR ~ USDIDR, data = data)
abline(model_ICR, col = "red")
summary(model_ICR)
