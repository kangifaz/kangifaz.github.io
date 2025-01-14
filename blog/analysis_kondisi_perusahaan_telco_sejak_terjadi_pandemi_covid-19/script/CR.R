# CR with Labels
rm(list = ls())

if (!require("readxl")) install.packages("readxl", dependencies = TRUE)
if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)

library(readxl)
library(dplyr)
library(ggplot2)

# Path ke file Excel
file_path <- "/Users/kangifaz/Documents/EAS_Finance/FinantialRatio7_USDIDR_untuk_MTDL_BRPT_UNTR_MPPA_BATA.xlsx"

# Memuat data dari sheet 'MTDL' dalam file Excel
mtdl_data <- read_excel(file_path, sheet = "MTDL")

# Konversi kolom 'Time' ke format Date dan membersihkan data
mtdl_data <- mtdl_data %>%
  mutate(
    Time = as.Date(Time, format = "%b-%y"), # Mengubah format Time
    Covid_Period = ifelse(Time >= as.Date("2020-03-01") & Time <= as.Date("2021-12-31"), "Covid", "Non-Covid")
  ) %>%
  filter(!is.na(Time), CR != 0) # Menghapus nilai NA dan 0

# Plot CR
ggplot(mtdl_data, aes(x = Time, y = CR, color = Covid_Period)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  geom_text(aes(label = round(CR, 2)), vjust = -1, size = 3.5, color = "black") +
  geom_vline(xintercept = as.Date("2020-03-01"), linetype = "dashed", color = "red", size = 1) +
  geom_vline(xintercept = as.Date("2021-12-31"), linetype = "dashed", color = "red", size = 1) +
  scale_color_manual(values = c("Non-Covid" = "blue", "Covid" = "orange")) +
  ggtitle("Grafik CR dengan Penandaan Periode Covid-19 dan Label") +
  xlab("Waktu") + ylab("CR") +
  theme_minimal() +
  theme(legend.title = element_blank())
