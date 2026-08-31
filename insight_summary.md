# Retail Sales Analysis — Insight Summary

## Business Question
How do sales and profit vary across regions, product categories, and customer segments — and is the business growing over time?

## Key Findings

1. **West is the top-performing region by sales ($209.1K)**, narrowly ahead of South ($202K) and East ($201.4K), with North trailing noticeably behind at $177K — about 15% lower than West. This gap is worth investigating: is it lower demand, fewer customers, or a sales/marketing gap in the North region?

2. **Electronics drives the most profit ($139K total)**, but interestingly, profit margins are nearly identical across all categories (~36% for every category, from Groceries to Electronics). This means Electronics isn't more profitable *per dollar of sales* — it just sells in higher volume. Furniture is a strong second at $102K profit, while Clothing, Toys, and Groceries are far smaller contributors.

3. **The Corporate segment is the most valuable per order**, with average profit of $155.87 per order — noticeably higher than Consumer ($139.08) or Small Business ($138.83) — even though Corporate doesn't receive the highest discounts. Consumer segment actually receives the highest average discount (5.9%) while generating the lowest average profit per order. This raises a real business question: is discounting the Consumer segment actually working, or would that budget be better spent courting more Corporate business?

4. **Monthly sales are relatively stable, not clearly trending up or down** — values fluctuate between roughly $21K and $44K per month across both 2023 and 2024, without a strong seasonal or growth pattern. This suggests the business is steady but not currently scaling.

## Recommendation
Since profit margin is consistent across categories, growth is more likely to come from **volume and mix**, not pricing changes. I'd suggest:
- Investigating why North region underperforms — it may be an easy, low-cost growth opportunity.
- Re-evaluating the Consumer segment's discount strategy, since it isn't converting to higher profit per order compared to Corporate.
- Since sales aren't trending upward month over month, consider what's driving flat performance — is it market saturation, a lack of new customer acquisition, or a seasonal factor not visible in this 2-year window?

## Tools Used
SQL (PostgreSQL) for data cleaning and querying, Python (Pandas) for exploratory analysis, and Power BI for the interactive dashboard.
