# Cek dan instal paket jika diperlukan
if (!require("readxl")) install.packages("readxl")
if (!require("corrplot")) install.packages("corrplot")

# Memuat library yang dibutuhkan
library(readxl)
library(corrplot)

# Membaca data keuangan dari file Excel
file_finance <- "~/Documents/EAS_Finance/FinantialRatio7_USDIDR_untuk_MTDL_BRPT_UNTR_MPPA_BATA.xlsx"

# Baca data dari sheet "MTDL"
data_finance <- read_excel(file_finance, sheet = "MTDL")

# Tampilkan beberapa baris pertama data
head(data_finance)

# Periksa struktur data
str(data_finance)

# Pastikan variabel numerik dalam format numeric
numeric_vars_fin <- c("ROA", "ROE", "GPM", "OPM", "DER", "CR", "ICR", "USDIDR")
for (var in numeric_vars_fin) {
    data_finance[[var]] <- as.numeric(data_finance[[var]])
}

# Membaca data makroekonomi dari file CSV
file_macro <- "~/Documents/EAS_Finance/macro_data_indonesia_2008_2024.csv"
data_macro <- read.csv(file_macro, header = TRUE, sep = ",")

# Tampilkan beberapa baris pertama data
head(data_macro)

# Periksa struktur data
str(data_macro)

# Mengubah nama kolom 'year' menjadi 'Year' di data_macro untuk kesesuaian
names(data_macro)[names(data_macro) == "year"] <- "Year"

# Pastikan variabel makro dalam format numeric
numeric_vars_macro <- c("GDP", "Inflation", "Unemployment", "Consumption", "InterestRate", "USDIDR")
for (var in numeric_vars_macro) {
    data_macro[[var]] <- as.numeric(data_macro[[var]])
}

# Periksa apakah kombinasi Year dan Quarter unik di data_finance
if (any(duplicated(data_finance[, c("Year", "Quarter")]))) {
    stop("Terdapat duplikasi kombinasi Year dan Quarter di data_finance.")
}

# Periksa apakah kombinasi Year dan Quarter unik di data_macro
if (any(duplicated(data_macro[, c("Year", "Quarter")]))) {
    stop("Terdapat duplikasi kombinasi Year dan Quarter di data_macro.")
}

# Menggabungkan data berdasarkan Year dan Quarter
merged_data <- merge(data_finance, data_macro, by = c("Year", "Quarter"))

# Periksa hasil penggabungan
head(merged_data)
str(merged_data)

# Memilih variabel yang ingin dikorelasikan
vars_keuangan <- c("ROA", "ROE", "GPM", "OPM", "DER", "CR", "ICR")
vars_makro <- c("GDP", "Inflation", "Unemployment", "Consumption", "InterestRate")

# Subset data untuk variabel yang diperlukan
data_for_corr <- merged_data[, c(vars_keuangan, vars_makro)]

# Hitung matriks korelasi
cor_matrix <- cor(data_for_corr, use = "complete.obs")  # gunakan nilai lengkap (tanpa NA)

# Cetak matriks korelasi
print(cor_matrix)

# Visualisasikan korelasi menggunakan corrplot
corrplot(cor_matrix, method = "color", type = "upper", 
         tl.col = "black", tl.srt = 45, 
         addCoef.col = "black", number.cex = 0.7)
