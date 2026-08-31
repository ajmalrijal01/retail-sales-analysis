# 🛒 Project 1: Retail Sales Analysis (SQL + Python)

**Dataset:** `retail_sales.csv` (2,015 rows — orders from 2023–2024 across 4 regions)

This is a realistic dataset — it has a few messy bits on purpose (missing values, duplicate rows, inconsistent text casing) so you practice cleaning, not just analyzing.

**Columns:**
`order_id, order_date, region, customer_segment, category, sub_category, ship_mode, quantity, unit_price, discount, sales, profit`

---

## 🎯 How to use this project

Do it in **two passes**:
1. First with **SQL** (using SQLite — no install needed if you use an online tool, or use DB Browser for SQLite locally)
2. Then with **Python/Pandas** in **Google Colab**

Answering the same business questions twice, in two tools, is exactly how the concepts click.

---

## Step 1: Load the data

### Option A — SQL (recommended: DB Browser for SQLite, free, no server setup)
1. Download [DB Browser for SQLite](https://sqlitebrowser.org/) (free)
2. Open it → "Import" → "Table from CSV file" → select `retail_sales.csv`
3. Now you can write SQL directly against it.

*(Alternative: use [sqliteonline.com](https://sqliteonline.com/) if you don't want to install anything — upload the CSV there.)*

### Option B — Python (Google Colab)
1. Go to [colab.research.google.com](https://colab.research.google.com/) → New Notebook
2. Upload `retail_sales.csv` (left sidebar → Files → upload)
3. Run:
```python
import pandas as pd
df = pd.read_csv('retail_sales.csv')
df.head()
```

---

## Step 2: Clean the data first (do this before analyzing!)

This is the step beginners skip — don't skip it. Real analysts spend 60-70% of their time here.

**In SQL:**
```sql
-- Check for duplicates
SELECT order_id, COUNT(*) 
FROM retail_sales 
GROUP BY order_id 
HAVING COUNT(*) > 1;

-- Fix inconsistent casing in region
SELECT DISTINCT region FROM retail_sales;
-- You'll notice lowercase 'north', 'east' etc mixed in with 'North', 'East'

UPDATE retail_sales 
SET region = 
  CASE 
    WHEN LOWER(region) = 'north' THEN 'North'
    WHEN LOWER(region) = 'south' THEN 'South'
    WHEN LOWER(region) = 'east' THEN 'East'
    WHEN LOWER(region) = 'west' THEN 'West'
  END;

-- Check missing values
SELECT COUNT(*) FROM retail_sales WHERE ship_mode IS NULL;
```

**In Python:**
```python
# Check for duplicates
df.duplicated().sum()
df = df.drop_duplicates()

# Fix inconsistent casing
df['region'].unique()   # spot the lowercase ones
df['region'] = df['region'].str.title()

# Check missing values
df.isnull().sum()

# Fill missing ship_mode with 'Unknown' (a reasonable, documented choice)
df['ship_mode'] = df['ship_mode'].fillna('Unknown')
```

**👉 Exercise for you:** After cleaning, confirm `df['region'].unique()` now shows only 4 clean values, and check the row count dropped after removing duplicates.

---

## Step 3: Answer real business questions

Try to write the SQL/Python yourself first before looking at the answer below.

### Q1. Which region generates the most total sales?

**SQL:**
```sql
SELECT region, ROUND(SUM(sales), 2) AS total_sales
FROM retail_sales
GROUP BY region
ORDER BY total_sales DESC;
```

**Python:**
```python
df.groupby('region')['sales'].sum().round(2).sort_values(ascending=False)
```

---

### Q2. Which product category is most profitable (not just highest sales)?

**SQL:**
```sql
SELECT category, ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(profit) * 100.0 / SUM(sales), 2) AS profit_margin_pct
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC;
```

**Python:**
```python
summary = df.groupby('category').agg(
    total_profit=('profit', 'sum'),
    total_sales=('sales', 'sum')
)
summary['profit_margin_pct'] = (summary['total_profit'] / summary['total_sales'] * 100).round(2)
summary.sort_values('total_profit', ascending=False)
```

**💡 Think about this:** Is the category with the highest sales also the one with the highest profit margin? This is the kind of insight that impresses in interviews — sales ≠ profit.

---

### Q3. Which customer segment gives the most discounts, and does it hurt profit?

**SQL:**
```sql
SELECT customer_segment,
       ROUND(AVG(discount), 3) AS avg_discount,
       ROUND(AVG(profit), 2) AS avg_profit
FROM retail_sales
GROUP BY customer_segment;
```

**Python:**
```python
df.groupby('customer_segment').agg(
    avg_discount=('discount', 'mean'),
    avg_profit=('profit', 'mean')
).round(2)
```

---

### Q4. Monthly sales trend — is the business growing?

**SQL:**
```sql
SELECT strftime('%Y-%m', order_date) AS month, 
       ROUND(SUM(sales), 2) AS total_sales
FROM retail_sales
GROUP BY month
ORDER BY month;
```

**Python:**
```python
df['order_date'] = pd.to_datetime(df['order_date'])
df.set_index('order_date').resample('M')['sales'].sum().round(2)
```

**👉 Exercise:** Plot this in Python:
```python
import matplotlib.pyplot as plt
monthly = df.set_index('order_date').resample('M')['sales'].sum()
monthly.plot(kind='line', title='Monthly Sales Trend', figsize=(10,5))
plt.ylabel('Sales')
plt.show()
```

---

### Q5. (Window function practice) Rank sub-categories by profit within each category

**SQL:**
```sql
SELECT category, sub_category, 
       SUM(profit) AS total_profit,
       RANK() OVER (PARTITION BY category ORDER BY SUM(profit) DESC) AS rank_in_category
FROM retail_sales
GROUP BY category, sub_category;
```

**Python:**
```python
sub_profit = df.groupby(['category', 'sub_category'])['profit'].sum().reset_index()
sub_profit['rank_in_category'] = sub_profit.groupby('category')['profit'] \
    .rank(ascending=False, method='min')
sub_profit.sort_values(['category', 'rank_in_category'])
```

---

## Step 4: Turn it into a mini dashboard (Power BI or Tableau Public)

Once you've done the SQL/Python analysis, import the same CSV into **Power BI Desktop** or **Tableau Public** and build:
- A bar chart: Sales by Region
- A bar chart: Profit by Category
- A line chart: Monthly Sales Trend
- A KPI card: Total Sales, Total Profit, Total Orders
- A filter/slicer for Region and Category

This turns your SQL/Python findings into something visual and shareable — **this dashboard is your first portfolio piece.**

---

## Step 5: Write it up (this is what makes it a "project," not just an exercise)

Create a short write-up (README on GitHub, or a LinkedIn post) answering:
1. What business question did I explore?
2. What did I find? (2-3 key insights, with numbers)
3. What would I recommend to the business based on this?

Example insight format:
> "While Electronics generated the highest revenue ($X), Furniture had a notably higher profit margin (Y%), suggesting the business may benefit from promoting Furniture more aggressively rather than discounting Electronics further."

This "insight → recommendation" framing is exactly what interviewers want to see.

---

## ✅ Your action list right now

1. [ ] Download `retail_sales.csv`
2. [ ] Open it in DB Browser for SQLite (or sqliteonline.com) AND Google Colab
3. [ ] Do the cleaning steps yourself before looking at the answers
4. [ ] Answer Q1–Q5 in both SQL and Python
5. [ ] Build one simple dashboard in Power BI or Tableau Public
6. [ ] Write a 3-sentence insight summary
7. [ ] Push the SQL file + Python notebook to a GitHub repo (I can guide you through GitHub setup too if it's new to you)

Come back and share your results/insights — I'll review them and tell you what to improve, just like a real feedback loop.
