/*Top 5 Portfolios by Profit/Loss*/
SELECT Portfolio_ID, Profit_Loss
FROM PORTFOLIO
ORDER BY Profit_Loss DESC
LIMIT 5;

/*Total Quantity Held for Each Ticker Code*/
SELECT O.Ticker_Code, SUM(G.Alloted) AS Total_Quantity_Held
FROM OWNS AS O
JOIN GOES AS G ON O.Portfolio_ID = G.Portfolio_ID AND O.Ticker_Code = G.Ticker_Code
GROUP BY O.Ticker_Code;

/*Portfolios Holding Stocks of Company X (here X = Sun Pharma)*/
SELECT DISTINCT Portfolio_ID
FROM OWNS
WHERE Ticker_Code IN (
    SELECT Ticker_Code
    FROM STOCK
    WHERE Corporate_ID = (
        SELECT Corporate_ID
        FROM COMPANY
        WHERE Company_Name = 'Sun Pharma'
    )
);

/*Distinct company names of the stocks owned by the portfolio with the ID 3001*/
SELECT DISTINCT c.Company_Name
FROM COMPANY c
JOIN STOCK s ON c.Corporate_ID = s.Corporate_ID
JOIN OWNS o ON s.Ticker_Code = o.Ticker_Code
WHERE o.Portfolio_ID = 3001;

/*Current Price of Bharti Airtel Stocks*/
SELECT s.Ticker_Code, t.Close_Day AS Current_Price
FROM STOCK s
JOIN TECHNICALS t ON s.Ticker_Code = t.Ticker_Code
JOIN COMPANY c ON s.Corporate_ID = c.Corporate_ID
WHERE c.Company_Name = 'Bharti Airtel';

/*List all the companies traded on BSE and NSE both */
SELECT com.Company_Name 
FROM (
SELECT s.Corporate_ID,s.Ticker_Code
FROM STOCK s
JOIN STOCK_LISTED_IN sli1 ON s.Ticker_Code = sli1.Ticker_Code AND sli1.Listed_In = 'BSE'
JOIN STOCK_LISTED_IN sli2 ON s.Ticker_Code = sli2.Ticker_Code AND sli2.Listed_In = 'NSE'
) p 
JOIN COMPANY com ON p.Corporate_ID = com.Corporate_ID;

/*Companies Owned by Customer X (here X = Sneha Gupta) */
SELECT DISTINCT s.Ticker_Code
FROM STOCK s
JOIN OWNS o ON s.Ticker_Code = o.Ticker_Code
JOIN CUSTOMER c ON o.Portfolio_ID = c.Portfolio_ID
WHERE c.Name = 'Sneha Gupta';

/*Which stock has the highest number of holders?*/
SELECT s.Ticker_Code, COUNT(o.Portfolio_ID) AS Holder_Count
FROM STOCK s
JOIN OWNS o ON s.Ticker_Code = o.Ticker_Code
GROUP BY s.Ticker_Code
ORDER BY Holder_Count DESC
LIMIT 1;

/*Which stock grew the most from their Lowest price?*/
SELECT s.Ticker_Code, (MAX(t.Close_Day) - MIN(t.Low_All_Time)) AS Growth
FROM STOCK s
JOIN TECHNICALS t ON s.Ticker_Code = t.Ticker_Code
GROUP BY s.Ticker_Code
ORDER BY Growth DESC
LIMIT 1;