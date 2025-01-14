plot(data$USDIDR, data$DER, 
     main = "DER vs USDIDR",
     xlab = "USDIDR", ylab = "DER", 
     pch = 19, col = "blue")
model_DER <- lm(DER ~ USDIDR, data = data)
abline(model_DER, col = "red")
summary(model_DER)
