---
date: '2025-02-16T20:26:54+07:00'
draft: false
title: '1 Present Value (PV) Relations'
math: true
weight: 1
---
# 📘 Catatan Kuliah: 15.401 Finance Theory

## Konsep Kritis dalam Finance

### 1. **Cashflows dan Aset**

#### Apa Itu Aset?  
Dalam bisnis, aset adalah segala sesuatu yang memiliki nilai ekonomi dan dapat memberikan manfaat di masa depan. Beberapa contoh aset:

- **Entitas bisnis** (misalnya perusahaan)
- **Properti, pabrik, dan peralatan**
- **Hak paten dan R&D**
- **Saham, obligasi, opsi, dll.**
- **Pengetahuan, reputasi, dan peluang bisnis**

Dari perspektif bisnis, aset dapat dipandang sebagai _urutan arus kas_ (_sequence of cashflows_). Secara matematis:

```
Asset_t ≡ {CF_t, CF_t+1, CF_t+2, …}
```

🔹 **Penjelasan:** Ini berarti bahwa nilai suatu aset dapat direpresentasikan sebagai serangkaian arus kas (_cashflows_) yang dihasilkannya dari waktu ke waktu.

#### **Contoh Aset Sebagai Cashflows**  
Beberapa contoh bagaimana aset menghasilkan arus kas dalam kehidupan nyata:

- **Boeing**: Dalam pengembangan pesawat regional jet baru, Boeing harus menginvestasikan sekitar `$850` juta selama 3 tahun. Setelah produksi, diperkirakan mereka bisa menjual 30 pesawat per tahun dengan harga rata-rata `$41` juta. Ini mencerminkan bagaimana aset Boeing (pesawat) menghasilkan arus kas melalui penjualan.

- **S&P 500**: Perusahaan dalam indeks S&P 500 menghasilkan laba kolektif $66 dan membayar dividen $24 per saham. Sejak 1926, dividen dan pendapatan tumbuh rata-rata 6,6% per tahun. Ini menunjukkan bagaimana saham sebagai aset dapat menghasilkan arus kas dalam bentuk dividen dan pertumbuhan nilai saham.

- **HP Stock Options**: Jika seseorang dipekerjakan oleh HP dan menerima opsi saham sebanyak 50.000 unit dengan harga eksekusi `$24.92` dan masa berlaku 10 tahun, nilai opsi akan bergantung pada harga saham di masa depan yang telah bervariasi antara `$16.08` hingga `$26.03` selama dua tahun terakhir.

---

### 2. **The Present Value Operator**

Konsep nilai sekarang (_Present Value / PV_) sangat penting dalam analisis keuangan. PV adalah cara menilai nilai uang yang akan diterima di masa depan dalam satuan nilai hari ini.

#### Formula Nilai Sekarang:
\[
PV = \frac{CF_t}{(1+r)^t}
\]

Di mana:
- \( CF_t \) = arus kas pada waktu \( t \)
- \( r \) = tingkat diskonto (_discount rate_)
- \( t \) = periode waktu

🔹 **Penjelasan:** Semakin jauh arus kas di masa depan, semakin kecil nilai sekarangnya karena uang memiliki nilai waktu (_time value of money_).

---

### 3. **The Time Value of Money**

Konsep ini menyatakan bahwa **uang saat ini lebih berharga daripada uang di masa depan** karena uang yang dimiliki sekarang dapat diinvestasikan untuk menghasilkan keuntungan.

Contoh sederhana:
- Jika Anda memiliki Rp1.000.000 hari ini dan menaruhnya di deposito dengan bunga 5% per tahun, maka dalam setahun akan menjadi Rp1.050.000.
- Namun, jika Anda baru menerima Rp1.000.000 setahun lagi, nilainya akan lebih kecil dari Rp1.050.000 jika dibandingkan dengan skenario pertama.

🔹 **Kesimpulan:** Uang sekarang lebih bernilai dibandingkan uang yang sama di masa depan karena dapat diinvestasikan untuk menghasilkan keuntungan.

---

### 4. **Valuing An Asset as a Sequence of Cashflows**

Untuk menilai suatu aset, kita harus melihat aliran arus kasnya sepanjang waktu.

#### **Representasi Matematis:**
\[
Value \ of \ Asset_t ≡ V_t(CF_t, CF_{t+1}, CF_{t+2}, ...)
\]

💡 **Selalu Buat Timeline Untuk Memvisualisasikan Timing Arus Kas!**

🔹 **Penjelasan:**
- Setiap aset memiliki arus kas yang tersebar dalam rentang waktu tertentu.
- Dengan menggambar garis waktu (_timeline_), kita bisa lebih mudah memahami kapan arus kas akan diterima.
- Misalnya, pembayaran dividen tahunan dari saham dapat dipetakan dalam bentuk arus kas yang diterima setiap tahun.

---

### 5. **Special Cashflows: The Perpetuity**

_Perpetuity_ adalah arus kas yang berlangsung **selamanya** dengan jumlah tetap setiap periode.

#### Rumus Nilai Sekarang untuk Perpetuity:
\[
PV = \frac{C}{r}
\]

Di mana:
- \( C \) = arus kas per periode
- \( r \) = tingkat diskonto

🔹 **Penjelasan:** Model ini sering digunakan untuk menilai aset yang menghasilkan pendapatan tetap dalam jangka waktu tak terbatas, seperti obligasi dengan bunga tetap atau dana abadi (_endowments_).

---

### 6. **Special Cashflows: The Annuity**

_Annuity_ adalah serangkaian arus kas tetap yang berlangsung untuk jangka waktu terbatas.

#### Rumus Nilai Sekarang untuk Annuity:
\[
PV = C \times \left( 1 - \frac{1}{(1+r)^t} \right) \div r
\]

🔹 **Penjelasan:** 
- Berbeda dengan perpetuity, annuity memiliki periode terbatas.
- Contoh penggunaan annuity adalah pinjaman rumah, di mana pembayaran dilakukan secara tetap selama beberapa tahun.

---

### 7. **Compounding**

_Komponding_ adalah proses di mana bunga yang diperoleh diinvestasikan kembali untuk menghasilkan lebih banyak bunga.

#### Formula Future Value (_Nilai Masa Depan_):
\[
FV = PV (1 + r)^t
\]

🔹 **Penjelasan:** Semakin sering bunga dikapitalisasi, semakin besar pertumbuhannya. Inilah alasan mengapa investasi jangka panjang bisa menghasilkan keuntungan besar.

---

### 8. **Inflation**

Inflasi adalah kenaikan harga barang dan jasa secara umum dalam suatu perekonomian, yang menyebabkan daya beli uang menurun.

#### Formula Hubungan Inflasi dan Nilai Riil:
\[
Real Rate = \frac{1 + Nominal Rate}{1 + Inflation Rate} - 1
\]

🔹 **Penjelasan:** Jika inflasi lebih tinggi dari tingkat bunga tabungan, maka nilai riil tabungan Anda sebenarnya berkurang.

---

## 📚 Bacaan Tambahan:
- Brealey, Myers, dan Allen **Bab 2 – 3**

---

💡 **Kesimpulan:**
- Aset dapat direpresentasikan sebagai serangkaian arus kas.
- Nilai waktu dari uang menentukan bagaimana kita menilai arus kas di masa depan.
- Perpetuity dan annuity adalah contoh pola arus kas yang sering digunakan dalam keuangan.
- Inflasi dan bunga majemuk mempengaruhi nilai aset dalam jangka panjang.

---

**Catatan:** Jika ada istilah yang masih kurang jelas, silakan tanyakan di komentar atau diskusi blog ini! 
