---
date: '2026-06-24T18:00:00+07:00'
draft: false
title: 'Membangun HPC Cluster dengan Dask'
tags: ['hpc', 'dask', 'parallel-computing', 'atomos', 'armbian', 'python']
weight: 10
---

# Membangun HPC Cluster dengan Dask

*Ketika 6 single-board computers menjadi satu supercomputer.*

---

## Arsitektur Klaster

![ATOMOS Architecture](/atomos-architecture.html)

Komponen utama:

| Fungsi | Node | IP | Spesifikasi |
|--------|------|-----|-------------|
| **Scheduler** | atomos-07 | 10.0.0.227 | Dask scheduler + dashboard |
| **Worker 1** | atomos-01 | 10.0.0.221 | 4 cores, 1.8GB RAM |
| **Worker 2** | atomos-03 | 10.0.0.223 | 4 cores, 1.8GB RAM |
| **Worker 3** | atomos-04 | 10.0.0.224 | 4 cores, 1.8GB RAM |
| **Worker 4** | armbian | 10.0.0.225 | 4 cores, 1.8GB RAM |
| **Worker 5** | armbian | 10.0.0.226 | 4 cores, 1.8GB RAM |

**Total: 24 CPU cores, 10.8GB RAM**

---

## Hasil Uji Coba

### Test 1: Estimasi Pi (Monte Carlo)

500000 sampel dibagi ke 5 worker
Pi = 3.141920 (error: 0.000327)
Waktu: 0.60 detik
Kecepatan: 832237 sampel/detik

### Test 2: Simulasi Portofolio (500 skenario x 252 hari trading)

Mean return: +13.30%
Median return: +8.55%
Best case: +182.66%
Worst case: -52.51%
Probabilitas profit: 58.4%
Waktu: 2.10 detik
Kecepatan: 238 simulasi/detik

---

## Step-by-Step Setup

### 1. Install Dask di Semua Node

    apt-get install -y python3-dask python3-distributed python3-tornado

### 2. Jalankan Scheduler di Satu Node (atomos-07)

    python3 -c "from distributed import Scheduler; import asyncio; asyncio.run(Scheduler(port=8786, dashboard_address=':8787'))" &

### 3. Jalankan Worker di Node Lain

    python3 -c "from distributed import Worker; asyncio.run(Worker('tcp://10.0.0.227:8786', nthreads=1, memory_limit='512MB'))" &

### 4. Jalankan Task dari Client

    from dask.distributed import Client
    import random, math

    client = Client('tcp://10.0.0.227:8786')

    def mc_pi_chunk(n_samples):
        random.seed()
        inside = 0
        for _ in range(n_samples):
            x, y = random.uniform(-1, 1), random.uniform(-1, 1)
            if x*x + y*y <= 1:
                inside += 1
        return inside

    futures = [client.submit(mc_pi_chunk, 100000) for _ in range(5)]
    results = client.gather(futures)
    pi = 4 * sum(results) / 500000
    print(f"Pi = {pi:.6f}")

---

## Kapan Pakai Klaster Ini?

### Cocok untuk:
- Backtesting strategi trading (jalankan 100 parameter sekaligus)
- Monte Carlo simulation (ribuan skenario risiko portofolio)
- Parameter sweep (cari kombinasi optimal dari hyperparameter)
- Data scraping paralel (ambil data dari banyak sumber bersamaan)
- Belajar distributed computing

### Tidak cocok untuk:
- LLM inference (ARM 4-core tidak cukup)
- Training deep learning (butuh GPU dan RAM besar)
- Database server (terlalu lambat untuk I/O intensif)
- Real-time trading (latency jaringan terlalu tinggi)

---

## Konsep Dasar

### Embarrassingly Parallel vs Tightly Coupled

**Embarrassingly Parallel** (cocok untuk Dask):
- Setiap tugas independen
- Tidak perlu komunikasi antar worker
- Contoh: 1000 simulasi Monte Carlo

**Tightly Coupled** (butuh MPI):
- Tugas bergantung pada hasil tugas lain
- Perlu komunikasi setiap iterasi
- Contoh: solving PDE (heat equation)

### Dask vs Kubernetes

| Aspek | Dask | Kubernetes |
|-------|------|------------|
| Tujuan | Parallel computing | Container orchestration |
| RAM footprint | ~50MB | 2GB+ minimum |
| Learning curve | Mudah (Python) | Sulit |
| Cocok untuk | 6 mini servers | 100+ servers |
| Scaling | Manual | Auto-scaling |

---

## Next Steps

1. Setup NFS untuk shared storage antar node
2. Buat REST API sebagai gateway ke klaster
3. Integrasi dengan Iris - saya bisa mengirim task ke klaster untuk Anda
4. Monitoring dashboard via Dask dashboard di port 8787

---

*Dibangun: 2026-06-24 - Oleh Kang Ifaz & Iris AI*
