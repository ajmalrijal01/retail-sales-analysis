# 🛒 Retail Sales Analysis — SQL, Python & Power BI

An end-to-end data analysis project on retail sales data: cleaned and queried with PostgreSQL, explored with Python (Pandas), and visualized in an interactive Power BI dashboard.

This was built as a hands-on beginner project to practice the full analyst workflow — from raw, messy data to business insights and recommendations.

---

## 📂 Project Contents

| File | Description |
|---|---|
| `retail_sales.csv` | Raw dataset — 2,015 retail orders (2023–2024) across 4 regions, 5 product categories, and 3 customer segments |
| `Project_1_Retail_Sales_Analysis.sql` | SQL queries (PostgreSQL) for data cleaning and business analysis |
| `Project_1_Retail_Sales_Analysis.ipynb` | Python/Pandas notebook replicating the same analysis |
| `min_dashboard.pbix` | Power BI dashboard — interactive visual summary |
| `insight_summary.md` | Written business insights and recommendations |

---

## 🎯 Business Questions Explored

1. Which region generates the most total sales?
2. Which product category is most profitable (not just highest sales)?
3. Which customer segment gives the most discounts — and does it hurt profit?
4. Is the business growing month over month?
5. Which sub-categories perform best within each category?

---

## 🧹 Data Cleaning Steps

The raw dataset intentionally included realistic messiness to practice on:
- **15 duplicate rows** — identified and removed
- **Inconsistent text casing** in the `region` column (e.g. `north` vs `North`) — standardized
- **30 missing values** in `ship_mode` — filled with `"Unknown"` as a documented placeholder

---

## 📊 Key Insights

- **West is the top-performing region** by sales (~$209K), while North trails about 15% behind — a potential low-cost growth opportunity.
- **Electronics drives the most total profit (~$139K)**, but profit margin is nearly identical (~36%) across *every* category — meaning higher profit comes from sales volume, not pricing differences.
- **The Corporate segment generates the highest average profit per order (~$156)**, despite not receiving the largest discounts — while the Consumer segment gets the highest average discount (~5.9%) but the lowest average profit per order.
- **Monthly sales are relatively flat** across the two-year period (~$21K–$44K/month), with no clear upward growth trend.

Full write-up with recommendations: [`insight_summary.md`](./insight_summary.md)

---

## 🛠️ Tools Used

- **PostgreSQL** — data cleaning, aggregation, window functions
- **Python (Pandas, Matplotlib)** — exploratory data analysis, visualization
- **Power BI** — interactive dashboard with KPI cards, bar charts, trend line, and slicers

---

## 🚀 How to Reproduce This

1. Clone this repo
2. Import `retail_sales.csv` into PostgreSQL and run `Project_1_Retail_Sales_Analysis.sql`
3. Open `Project_1_Retail_Sales_Analysis.ipynb` in Jupyter/Google Colab to run the Python analysis
4. Open `min_dashboard.pbix` in Power BI Desktop to view/interact with the dashboard

---

## 👤 Author

**Ajmal Rijal**
[LinkedIn](https://www.linkedin.com/in/ajmal-rijal-a3ab721a3/)

Built as part of a self-guided Data Analyst learning path, focused on practicing SQL, Python, and BI tools together on the same real-world-style dataset.
