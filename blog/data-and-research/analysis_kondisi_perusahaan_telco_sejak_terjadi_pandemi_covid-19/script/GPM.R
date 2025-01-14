#GPM with Labels
rm(list = ls())

if (!require("readxl")) install.packages("readxl", dependencies = TRUE)
if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)

library(readxl)
library(dplyr)
library(ggplot2)

file_path <- "/Users/kangifaz/Documents/EAS_Finance/FinantialRatio7_USDIDR_untuk_MTDL_BRPT_UNTR_MPPA_BATA.xlsx"
mtdl_data <- read_excel(file_path, sheet = "MTDL")

mtdl_data <- mtdl_data %>%
  mutate(Time = as.Date(Time)) %>%
  filter(!is.na(Time)) %>%
  filter(GPM != 0) %>%
  mutate(Covid_Period = ifelse(Time >= as.Date("2020-03-01") & Time <= as.Date("2021-12-31"), "Covid", "Non-Covid"))

ggplot(mtdl_data, aes(x = Time, y = GPM, color = Covid_Period)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  geom_text(aes(label = round(GPM, 2)), vjust = -1, size = 3.5, color = "black") +
  geom_vline(xintercept = as.Date("2020-03-01"), linetype = "dashed", color = "red", size = 1) +
  geom_vline(xintercept = as.Date("2021-12-31"), linetype = "dashed", color = "red", size = 1) +
  scale_color_manual(values = c("Non-Covid" = "blue", "Covid" = "orange")) +
  ggtitle("Grafik GPM dengan Penandaan Periode Covid-19 dan Label") +
  xlab("Waktu") + ylab("GPM") +
  theme_minimal() +
  theme(legend.title = element_blank())
