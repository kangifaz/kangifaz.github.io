plot(data$USDIDR, data$CR, 
     main = "CR vs USDIDR",
     xlab = "USDIDR", ylab = "CR", 
     pch = 19, col = "blue")
model_CR <- lm(CR ~ USDIDR, data = data)
abline(model_CR, col = "red")
summary(model_CR)
