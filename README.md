# DataLab

A local data lakehouse built on the **medallion architecture** (Bronze / Silver / Gold), running entirely in Docker. Designed to mimic a production-grade data platform like Databricks — without cloud.

---

## What This Is

DataLab is a self-contained analytics environment where raw data is ingested from external APIs, stored as Delta Lake tables on local object storage, and progressively refined through ETL pipelines into analytics-ready datasets.

Everything runs locally via Docker Compose. No cloud account required.

---

## Architecture

```
External APIs
   │
   │  Landing notebooks (pure Python, no Spark)
   ▼
data/landing/          ← raw CSVs on local disk
   │
   │  Bronze notebooks (PySpark + Delta Lake)
   ▼
s3a://warehouse/bronze/   ← raw Delta tables on MinIO
   │
   │  Silver notebooks 
   ▼
s3a://warehouse/silver/   ← cleaned & enriched Delta tables
   │
   │  Gold notebooks
   ▼
s3a://warehouse/gold/     ← aggregated, analytics-ready tables
```

---

## Technologies

| Layer | Technology |
|---|---|
| Notebooks | JupyterLab |
| Distributed compute | Apache Spark 3.5 |
| Table format | Delta Lake 3.2 |
| Object storage | MinIO (S3-compatible) |
| Orchestration | Docker Compose |
| Data sources | Binance public API, Alpha Vantage API |

---

## Data Sources

### Crypto — `notebooks/landing/02_fetch_crypto_for_date_binance.ipynb`
Fetches daily OHLCV candles from the **Binance public API** (no API key required).
One CSV per trading pair (e.g. `BTCUSDT.csv`), up to 1000 days of history per call.

### Stocks — `notebooks/landing/01_fetch_stocks_for_date_alphavantage.ipynb`
Fetches daily OHLCV data from the **Alpha Vantage API** (free tier, requires API key).
One CSV per symbol per date (e.g. `AAPL_2026-03-01.csv`).

---

## Getting Started

**Prerequisites:** Docker Desktop

```bash
# 1. Clone the repo
git clone https://github.com/olivermihocs/DataLab.git
cd DataLab

# 2. Set up environment variables
cp .env.example .env
# Edit .env and add your ALPHAVANTAGE_API_KEY

# 3. Start the stack
docker-compose up -d

# 4. Open JupyterLab
# http://localhost:8888
```

### Service URLs

| Service | URL |
|---|---|
| JupyterLab | http://localhost:8888 |
| Spark Master UI | http://localhost:8080 |
| Spark Worker UI | http://localhost:8081 |
| Spark History Server | http://localhost:18080 |
| MinIO Console | http://localhost:9001 |

---