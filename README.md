# 📦 Setup Guide

Welcome to the **`planes-metrics`** dbt project! This guide helps you set up, run, and contribute to the analytics codebase with ease.

---

## 🚀 Project Overview

This dbt project transforms raw data into analytics-ready models using a modular approach: **staging → intermediate → marts**. It's optimized for use with **Snowflake** and supports linting with **sqlfluff**, testing with **dbt-utils**, and automation via **CI/CD pipelines**.

---

## 🛠️ Prerequisites

Make sure you have the following installed:

- Python 3.8+
- Snowflake account & credentials
- Git + GitHub access

---

## 📁 Project Structure

```
.
├── dbt_project.yml
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
├── seeds/
├── macros/
├── tests/
├── .sqlfluff
└── requirements.txt
```

## Installation

1. Clone the repo

```
git clone https://github.com/kimnewzealand/planes-metrics.git
cd planes-metrics
```

2. Set up Python environment
```
python -m venv env
source env/bin/activate   # On Windows use: env\Scripts\activate
pip install -r requirements.txt
```

3. Configure your dbt profile

Update your ~/.dbt/profiles.yml:

```
your_project_name:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <account_id>
      user: <username>
      password: <password>
      role: <role>
      database: <database>
      warehouse: <warehouse>
      schema: <schema>
      threads: 4
      client_session_keep_alive: False
```

✅ Common dbt Commands

Run a model

```
dbt run --select your_model_name
```

Run all tests

```
dbt test
```

Generate & view docs

```
dbt docs generate
dbt docs serve
```

🧼 Code Quality & Style

SQLFluff Linting

```
sqlfluff lint 
sqlfluff fix
```