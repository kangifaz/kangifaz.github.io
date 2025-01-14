# Instal dan muat paket yang diperlukan
rm(list = ls())
if (!require("readxl")) install.packages("readxl", dependencies = TRUE)
library(readxl)

# Tentukan path file Anda
file_path <- "~/Documents/EAS_Finance/FinantialRatio7_USDIDR_untuk_MTDL_BRPT_UNTR_MPPA_BATA.xlsx"

# Baca data dari sheet 'MTDL'
data <- read_excel(file_path, sheet = "MTDL")

# Tampilkan beberapa baris pertama data
head(data)

# Periksa struktur data
str(data)

# Pastikan variabel numerik dalam format numeric
data$ROA <- as.numeric(data$ROA)
data$ROE <- as.numeric(data$ROE)
data$GPM <- as.numeric(data$GPM)
data$OPM <- as.numeric(data$OPM)
data$DER <- as.numeric(data$DER)
data$CR <- as.numeric(data$CR)
data$ICR <- as.numeric(data$ICR)
data$USDIDR <- as.numeric(data$USDIDR)

# Daftar variabel dependen
dependent_vars <- c("ROA", "ROE", "GPM", "OPM", "DER", "CR", "ICR")

# Inisialisasi list untuk menyimpan model
models <- list()

# Loop untuk menjalankan regresi dan menyimpan hasilnya
for (var in dependent_vars) {
  formula <- as.formula(paste(var, "~ USDIDR"))
  models[[var]] <- lm(formula, data = data)
  cat("\n===== Model untuk", var, "=====\n")
  print(summary(models[[var]]))
}

# Regresi Multivariat menggunakan manova()
manova_model <- manova(cbind(ROA, ROE, GPM, OPM, DER, CR, ICR) ~ USDIDR, data = data)
cat("\n===== MANOVA Summary =====\n")
print(summary(manova_model))
