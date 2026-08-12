# Final Project - MIS443

# DataCo Smart Supply Chain Database Analysis

## Overview

This project was developed for the **MIS443 – Business Data Management** course. It demonstrates the implementation of a relational database using PostgreSQL and the application of SQL and Python to analyze the **DataCo Smart Supply Chain Dataset**. The project aims to transform raw transactional data into meaningful business insights to support decision-making in supply chain management.

---

## Project Objectives

- Design and implement a relational database in PostgreSQL.
- Normalize the dataset into related tables.
- Perform SQL-based business analysis.
- Connect Python to PostgreSQL for data extraction.
- Visualize business performance using Python.
- Generate business insights and recommendations.

---

## Project Files

```
├── SQL/
│   ├── Database_Schema.sql
│   ├── Data_Import.sql
│   └── Business_Queries.sql
│
├── Python/
│   └── DataCo_Analysis.ipynb
│
├── Report/
│   └── Final_Report.pdf
│
├── Presentation/
│   └── Final_Presentation.pptx
│
└── README.md
```

---

## Dataset

- **Dataset:** DataCo Smart Supply Chain Dataset
- **Records:** ~180,000 transactions
- **Domain:** Supply Chain & Retail Analytics

---

## Technologies Used

- PostgreSQL
- SQL
- Python
- Pandas
- SQLAlchemy
- Matplotlib
- Jupyter Notebook

---
## Entity Relationship Diagram (ERD)

  <img src="SQL/ERD Group Project.png" width="500">
</p>

## How to Run

### 1. Create the Database

Open PostgreSQL (pgAdmin) and execute the SQL scripts in the following order:

```
Database_Schema.sql
```

```
Data_Import.sql
```

---

### 2. Execute SQL Analysis

Run:

```
Business_Queries.sql
```

---

### 3. Run Python Analysis

Open:

```
DataCo_Analysis.ipynb
```

Update the database connection if necessary:

```python
connection_string = (
    "postgresql+psycopg2://{username}:{password}@{host}:{port}/{database}"
)

engine = create_engine(
    connection_string.format(
        username="postgres",
        password="your_password",
        host="localhost",
        port=5432,
        database="dataco"
    )
)
```

Run all notebook cells to reproduce the analysis and visualizations.

---

## Business Questions

The project investigates the following business questions:

1. What is the overall business performance?
2. Which products and categories perform best?
3. How do customer segments and geographic markets contribute to sales?
4. How effective is the logistics and delivery process?
5. How do sales and profit change over time?

---

## Key Findings

- Total Sales: **~$36.78 Million**
- Total Profit: **~$3.97 Million**
- Consumer customers contribute the largest share of orders.
- Sales are concentrated in several high-performing products and regions.
- Late delivery remains an important operational challenge.

---

## Authors

**Group:** DataMinds

- Lu Anh Thu
- Nguyen Thi Anh Tuyet
- Tang So Han
- Pham Thi Trang

MIS443 – Business Data Management

---

## License

This repository is created for academic purposes only.

