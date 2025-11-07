This project analysis e-commerce database for maven fuzzy factory, an online retailer that sells teddy bears. It includes detailed marketing data on website sessions and pageviews by user, as well as their orders and returns. Perfect for analyzing and optimizing marketing channels, measuring and testing website conversion performance, and understanding the impact of new product launches.

Recommended Analysis
What is the trend in website sessions and order volume?

What is the session-to-order conversion rate? How has it trended?

Which marketing channels have been most successful?

How has the revenue per order evolved? What about revenue per session?"

🧩 1. Customer & Session Analysis
🔹 a. Website traffic

How many website sessions do we get per day/week/month?

What % of sessions come from mobile vs. desktop?

What % of sessions are repeat users?

🔹 b. User behavior

What’s the average number of pageviews per session?

What are the most visited pages (from website_pageviews)?

How many sessions result in an order (conversion rate)?

💰 2. Sales & Revenue Analysis
🔹 a. Overall performance

Total revenue, total orders, total items sold

Average order value (AOV) → AVG(price_usd) per order

Revenue trend over time (daily, weekly, monthly)

🔹 b. Product performance

Which products generate the most revenue or profit (price_usd - cogs_usd)?

Which products are most frequently purchased together (primary + non-primary items)?

What is the profit margin per product?

📈 3. Marketing & Conversion Funnel

If you have UTM data (source, campaign, content):

Which marketing source (e.g., Google, Facebook) drives the most traffic?

Which campaign gives the highest conversion rate (sessions → orders)?

What’s the bounce rate — sessions with only one pageview?

💸 4. Refund & Returns Analysis

Use order_item_refunds:

What % of total sales are refunded?

Which products have the highest refund rate?

What’s the total amount refunded per month or campaign?

👥 5. Customer Lifetime Behavior

How many unique users have made at least one purchase?

What’s the average number of orders per user?

How many repeat buyers exist? (users with >1 order)

🧮 6. Operational KPIs

Gross Profit = SUM(price_usd - cogs_usd)

Profit Margin = Gross Profit / Total Revenue

Average Items per Order = AVG(items_purchased)

