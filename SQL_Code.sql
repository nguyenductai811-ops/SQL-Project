-- Total Sales: The overall revenue generated from all items sold.
SELECT CAST(SUM(Total_Sales) / 1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions FROM blinkit_data
  
-- Average Sales: The average revenue per sale.
SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales FROM blinkit_data
  
-- Number of Items: The total count of different items sold.
SELECT COUNT(*) AS No_Of_Items FROM blinkit_data
  
-- Average Rating: The average customer rating for items sold.
SELECT CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Avg_Rating FROM blinkit_data

/*
Total Sales by Fat Content:
Objective: Analyze the impact of fat content on total sales.
Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
*/
SELECT
    Item_Fat_Content,
    CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales,
    CAST(AVG(Total_Sales) AS DECIMAL(10, 1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC

/*Total Sales by Item Type:
Objective: Identify the performance of different item types in terms of total sales.
Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary Item Type.
*/
SELECT
    Item_Type,
    CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
    CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales_Thousands DESC

/*Fat Content by Outlet for Total Sales:
Objective: Compare total sales across different outlets segmented by fat content.
Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content and outet location.
*/
SELECT
    Outlet_Location_Type,
    ISNULL([Low Fat], 0) AS Low_Fat,
    ISNULL([Regular], 0) AS Regular
FROM
(
    SELECT
        Outlet_Location_Type,
        Item_Fat_Content,
        CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
    FROM
        blinkit_data
    GROUP BY
        Outlet_Location_Type,
        Item_Fat_Content
) AS SourceTable
PIVOT
(
    SUM(Total_Sales)
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY
    Outlet_Location_Type;

/*Total Sales by Outlet Establishment:
Objective: Evaluate how the age or type of outlet establishment influences total sales.
*/
SELECT
    Outlet_Establishment_Year,
    CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales,
    CAST(AVG(Total_Sales) AS DECIMAL(10, 1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Avg_Rating
FROM
    blinkit_data
GROUP BY
    Outlet_Establishment_Year
ORDER BY
    Total_Sales DESC





