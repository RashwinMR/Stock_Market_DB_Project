CREATE DATABASE STOCK_MARKET;
USE  STOCK_MARKET;

DROP TABLE OWNS;
DROP TABLE GOES;
DROP TABLE LISTINGS;
DROP TABLE EXCHANGE;
DROP TABLE USES;
DROP TABLE CUSTOMER;
DROP TABLE STOCK_INDICES;
DROP TABLE STOCK_LISTED_IN;
DROP TABLE TECHNICALS;
DROP TABLE PREFERRED;
DROP TABLE COMMON;
DROP TABLE STOCK;
DROP TABLE COMPANY_HELPLINES;
DROP TABLE COMPANY_FUNDAMENTALS;
DROP TABLE COMPANY;
DROP TABLE SECTOR_INDUSTRIES;
DROP TABLE SECTOR;
DROP TABLE PORTFOLIO;
DROP TABLE BROKER;
DROP TABLE DBA;

CREATE TABLE DBA
(
  Login_ID INT NOT NULL,
  Password VARCHAR(40) NOT NULL,
  Name VARCHAR(40) NOT NULL,
  DOB DATE NOT NULL,
  Phone_Number VARCHAR(10) NOT NULL,
  PRIMARY KEY (Login_ID)
);

CREATE TABLE BROKER
(
  Broker_ID INT NOT NULL,
  Password VARCHAR(40) NOT NULL,
  Name VARCHAR(40) NOT NULL,
  DOB DATE NOT NULL,
  Phone_Number VARCHAR(10) NOT NULL,
  PRIMARY KEY (Broker_ID)
);

CREATE TABLE PORTFOLIO
(
  Portfolio_ID INT NOT NULL,
  Amount_Invested BIGINT NOT NULL,
  Profit_Loss BIGINT NOT NULL,
  PRIMARY KEY (Portfolio_ID)
);

CREATE TABLE SECTOR
(
  Sector_Name VARCHAR(40) NOT NULL,
  Sector_Market_Cap BIGINT NOT NULL,
  Sector_PE DECIMAL(18, 2) NOT NULL,
  Sector_PB DECIMAL(18, 2) NOT NULL,
  Sector_Div_yield DECIMAL(18, 2) NOT NULL,
  PRIMARY KEY (Sector_Name)
);

CREATE TABLE SECTOR_INDUSTRIES
(
  Industries VARCHAR(40) NOT NULL,
  Sector_Name VARCHAR(40) NOT NULL,
  PRIMARY KEY (Industries, Sector_Name),
  FOREIGN KEY (Sector_Name) REFERENCES SECTOR(Sector_Name)
);

CREATE TABLE COMPANY
(
  Corporate_ID INT NOT NULL,
  Company_Name VARCHAR(40) NOT NULL,
  Headquarters VARCHAR(40) NOT NULL,
  CEO VARCHAR(40) NOT NULL,
  Sector_Name VARCHAR(40) NOT NULL,
  PRIMARY KEY (Corporate_ID),
  FOREIGN KEY (Sector_Name) REFERENCES SECTOR(Sector_Name)
);

CREATE TABLE COMPANY_FUNDAMENTALS
(
  Corporate_ID INT NOT NULL,
  Income BIGINT NOT NULL,
  Revenue BIGINT NOT NULL,
  EBITDA BIGINT NOT NULL,
  Debt BIGINT NOT NULL,
  Dividend BIGINT NOT NULL,
  PRIMARY KEY (Corporate_ID),
  FOREIGN KEY (Corporate_ID) REFERENCES COMPANY(Corporate_ID)
);

CREATE TABLE COMPANY_HELPLINES
(
  Helpline_Number VARCHAR(10) NOT NULL,
  Corporate_ID INT NOT NULL,
  PRIMARY KEY (Helpline_Number, Corporate_ID),
  FOREIGN KEY (Corporate_ID) REFERENCES COMPANY(Corporate_ID)
);

CREATE TABLE STOCK
(
  Ticker_Code VARCHAR(10) NOT NULL,
  Corporate_ID INT NOT NULL,
  PRIMARY KEY (Ticker_Code),
  FOREIGN KEY (Corporate_ID) REFERENCES COMPANY(Corporate_ID)
);

CREATE TABLE COMMON
(
  Ticker_Code VARCHAR(10) NOT NULL,
  Float_Value BIGINT NOT NULL,
  Outstanding BIGINT NOT NULL,
  Market_Val BIGINT NOT NULL,
  Votes_Share INT NOT NULL,
  EPS DECIMAL(18, 2) NOT NULL,
  Dividend_Yield DECIMAL(18, 2) NOT NULL,
  PRIMARY KEY (Ticker_Code),
  FOREIGN KEY (Ticker_Code) REFERENCES STOCK(Ticker_Code)
);

CREATE TABLE PREFERRED
(
  Ticker_Code VARCHAR(10) NOT NULL,
  Float_Value BIGINT NOT NULL,
  Outstanding BIGINT NOT NULL,
  Market_Val BIGINT NOT NULL,
  CallDate DATE NOT NULL,
  IsCumulative BOOL NOT NULL,
  Par_Value_Year DECIMAL(18, 2) NOT NULL,
  PRIMARY KEY (Ticker_Code),
  FOREIGN KEY (Ticker_Code) REFERENCES STOCK(Ticker_Code)
);

CREATE TABLE TECHNICALS
(
  Ticker_Code VARCHAR(10) NOT NULL,
  Low_All_Time DECIMAL(18, 2) NOT NULL,
  High_All_Time DECIMAL(18, 2) NOT NULL,
  Open_Day DECIMAL(18, 2) NOT NULL,
  Close_Day DECIMAL(18, 2) NOT NULL,
  IPO_Price DECIMAL(18, 2) NOT NULL,
  PRIMARY KEY (Ticker_Code),
  FOREIGN KEY (Ticker_Code) REFERENCES STOCK(Ticker_Code)
);

CREATE TABLE STOCK_LISTED_IN
(
  Listed_In VARCHAR(40) NOT NULL,
  Ticker_Code VARCHAR(10) NOT NULL,
  PRIMARY KEY (Listed_In, Ticker_Code),
  FOREIGN KEY (Ticker_Code) REFERENCES STOCK(Ticker_Code)
);

CREATE TABLE STOCK_INDICES
(
  Indices VARCHAR(40) NOT NULL,
  Ticker_Code VARCHAR(10) NOT NULL,
  PRIMARY KEY (Indices, Ticker_Code),
  FOREIGN KEY (Ticker_Code) REFERENCES STOCK(Ticker_Code)
);

CREATE TABLE CUSTOMER
(
  Customer_ID INT NOT NULL,
  Password VARCHAR(40) NOT NULL,
  Name VARCHAR(40) NOT NULL,
  DOB DATE NOT NULL,
  Phone_Number VARCHAR(10) NOT NULL,
  Portfolio_ID INT NOT NULL,
  PRIMARY KEY (Customer_ID),
  FOREIGN KEY (Portfolio_ID) REFERENCES PORTFOLIO(Portfolio_ID)
);

CREATE TABLE USES
(
  Customer_ID INT NOT NULL,
  Broker_ID INT NOT NULL,
  PRIMARY KEY (Customer_ID, Broker_ID),
  FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID),
  FOREIGN KEY (Broker_ID) REFERENCES BROKER(Broker_ID)
);

CREATE TABLE EXCHANGE
(
  Order_ID INT NOT NULL,
  Quantity BIGINT NOT NULL,
  Price DECIMAL(18, 2) NOT NULL,
  Time DATE NOT NULL,
  Buyer_Portfolio_ID INT NOT NULL,
  Seller_Portfolio_ID INT NOT NULL,
  Ticker_Code VARCHAR(10) NOT NULL,
  PRIMARY KEY (Order_ID),
  FOREIGN KEY (Buyer_Portfolio_ID) REFERENCES PORTFOLIO(Portfolio_ID),
  FOREIGN KEY (Seller_Portfolio_ID) REFERENCES PORTFOLIO(Portfolio_ID),
  FOREIGN KEY (Ticker_Code) REFERENCES STOCK(Ticker_Code)
);

CREATE TABLE LISTINGS
(
  Listing_No INT NOT NULL,
  Price DECIMAL(18, 2) NOT NULL,
  Time DATE NOT NULL,
  Ticker_Code VARCHAR(10) NOT NULL,
  Quantity BIGINT NOT NULL,
  PRIMARY KEY (Listing_No, Ticker_Code),
  FOREIGN KEY (Ticker_Code) REFERENCES STOCK(Ticker_Code)
);

CREATE TABLE GOES
(
  Portfolio_ID INT NOT NULL,
  Listing_No INT NOT NULL,
  Ticker_Code VARCHAR(10) NOT NULL,
  Alloted BIGINT NOT NULL,
  PRIMARY KEY (Portfolio_ID,Listing_No, Ticker_Code),
  FOREIGN KEY (Portfolio_ID) REFERENCES PORTFOLIO(Portfolio_ID),
  FOREIGN KEY (Listing_No, Ticker_Code) REFERENCES LISTINGS(Listing_No, Ticker_Code)
);

CREATE TABLE OWNS
(
   Portfolio_ID INT NOT NULL,
   Ticker_Code VARCHAR(10) NOT NULL,
   PRIMARY KEY (Portfolio_ID,Ticker_Code),
   FOREIGN KEY (Portfolio_ID) REFERENCES PORTFOLIO(Portfolio_ID),
   FOREIGN KEY (Ticker_Code) REFERENCES STOCK(Ticker_Code)
);

/* INSERTIONS */

INSERT INTO DBA (Login_ID, Password, Name, DOB, Phone_Number) 
VALUES 
(1001, 'securepass', 'Ajay Kumar', '1980-05-15', '9876543210'),
(1002, 'adminpass', 'Neha Sharma', '1985-09-20', '9876543211'),
(1003, 'root123', 'Rajesh Singh', '1990-11-10', '9876543212'),
(1004, 'sysadminpass', 'Pooja Patel', '1988-03-25', '9876543213'),
(1005, 'pass123', 'Amit Gupta', '1992-07-08', '9876543214');

INSERT INTO BROKER (Broker_ID, Password, Name, DOB, Phone_Number) 
VALUES 
(2001, 'brkr@123', 'Rahul Verma', '1982-08-18', '9876543220'),
(2002, 'sakshi@456', 'Sakshi Singh', '1987-10-25', '9876543221'),
(2003, 'anil@789', 'Anil Kumar', '1984-12-05', '9876543222'),
(2004, 'neha@xyz', 'Neha Sharma', '1989-04-15', '9876543223'),
(2005, 'raj@123', 'Raj Patel', '1986-06-30', '9876543224');

INSERT INTO PORTFOLIO (Portfolio_ID, Amount_Invested, Profit_Loss) 
VALUES 
(3001, 356000 , -13000),
(3002,307150, -72900), 
(3003, 237500, 56000), 
(3004, 635000, -421000),
(3005, 474000, -292000),
(3006, 178100, 41900),
(3007,191750, 32750); 

INSERT INTO SECTOR (Sector_Name, Sector_Market_Cap, Sector_PE, Sector_PB, Sector_Div_yield) 
VALUES 
('IT', 50000000000, 25.5, 4.5, 2.0),
('Automobile', 60000000000, 20.0, 3.8, 1.8),
('Pharmaceuticals', 40000000000, 30.0, 5.0, 2.5),
('Banking', 70000000000, 22.0, 3.2, 2.2),
('Telecom', 30000000000, 18.5, 3.0, 1.5);

INSERT INTO SECTOR_INDUSTRIES (Industries, Sector_Name) 
VALUES 
('Software', 'IT'),
('Software Service', 'IT'),
('Automobiles', 'Automobile'),
('Car Parts','Automobile'),
('Pharma Services', 'Pharmaceuticals'),
('Medicines','Pharmaceuticals'),
('Banks', 'Banking'),
('Telecommunication', 'Telecom');

INSERT INTO COMPANY (Corporate_ID, Company_Name, Headquarters, CEO, Sector_Name) 
VALUES 
(5001, 'TCS', 'Mumbai', 'Rajesh Gopinathan', 'IT'),
(5002, 'Maruti Suzuki', 'New Delhi', 'Kenichi Ayukawa', 'Automobile'),
(5003, 'Sun Pharma', 'Mumbai', 'Dilip Shanghvi', 'Pharmaceuticals'),
(5004, 'HDFC Bank', 'Mumbai', 'Sashidhar Jagdishan', 'Banking'),
(5005, 'Bharti Airtel', 'New Delhi', 'Gopal Vittal', 'Telecom');

INSERT INTO COMPANY_FUNDAMENTALS (Corporate_ID, Income, Revenue, EBITDA, Debt, Dividend) 
VALUES 
(5001, 10000000000, 5000000000, 3000000000, 2000000000, 50000000),
(5002, 15000000000, 7500000000, 4500000000, 3000000000, 75000000),
(5003, 8000000000, 4000000000, 2000000000, 1500000000, 40000000),
(5004, 12000000000, 6000000000, 3500000000, 2500000000, 60000000),
(5005, 9000000000, 4500000000, 2500000000, 1800000000, 45000000);

INSERT INTO COMPANY_HELPLINES (Helpline_Number, Corporate_ID) 
VALUES 
('1800123456', 5001),
('1800456789', 5002),
('1800567890', 5003),
('1800789456', 5004),
('1800789457', 5004),
('1800987654', 5005),
('1800987655', 5005);

INSERT INTO STOCK (Ticker_Code, Corporate_ID) 
VALUES 
('TCS1', 5001),
('MARUTI1', 5002),
('SUNPHARMA1', 5003),
('HDFCBANK1', 5004),
('BHARTIART1', 5005),
('TCS2', 5001),
('MARUTI2', 5002),
('SUNPHARMA2', 5003),
('HDFCBANK2', 5004),
('BHARTIART2', 5005);

INSERT INTO COMMON (Ticker_Code, Float_Value, Outstanding, Market_Val, Votes_Share, EPS, Dividend_Yield) 
VALUES 
('TCS1', 100000, 500000, 700, 10, 50.75, 2.0),
('MARUTI1', 250000, 400000, 600, 20, 35.50, 1.5),
('SUNPHARMA1', 20000, 30000, 4500, 10, 25.25, 1.0),
('HDFCBANK1', 35000, 60000, 9000, 15, 60.00, 2.5),
('BHARTIART1', 30000, 55000, 1800, 5, 55.75, 2.2);

INSERT INTO PREFERRED (Ticker_Code, Float_Value, Outstanding, Market_Val, CallDate, IsCumulative, Par_Value_Year) 
VALUES 
('TCS2', 10000, 15000, 500, '2026-01-01', true, 5.00),
('MARUTI2', 40000, 80000, 400, '2025-02-01', false, 4.00),
('SUNPHARMA2', 6000, 10000, 4000, '2025-01-15', true, 3.00),
('HDFCBANK2', 1200, 5000, 7500, '2028-06-01', false, 6.00),
('BHARTIART2', 5000, 10000, 1000, '2030-01-01', true, 5.50);

INSERT INTO TECHNICALS (Ticker_Code, Low_All_Time, High_All_Time, Open_Day, Close_Day, IPO_Price)
VALUES
('TCS1', 610, 720, 640, 700, 630),
('MARUTI1', 500, 600, 550, 600, 540),
('SUNPHARMA1', 4050, 4700, 4050, 4500, 4000),
('HDFCBANK1', 7000, 9000, 8000, 9000, 8100),
('BHARTIART1', 1600, 2000, 1650, 1800, 1620),
('TCS2', 400, 520, 470, 500, 450),
('MARUTI2', 320, 400, 380, 400, 360),
('SUNPHARMA2', 3500, 4500, 3200, 4000, 3600),
('HDFCBANK2', 6000, 8000, 6650, 7500, 6750),
('BHARTIART2', 700, 1010, 970, 1000, 900);

INSERT INTO STOCK_LISTED_IN (Listed_In, Ticker_Code) 
VALUES 
('NSE', 'TCS1'),
('BSE', 'TCS1'),
('BSE', 'MARUTI1'),
('NSE', 'SUNPHARMA1'),
('BSE', 'HDFCBANK1'),
('NSE', 'BHARTIART1'),
('BSE', 'MARUTI2'),
('NSE', 'SUNPHARMA2'),
('BSE', 'HDFCBANK2'),
('NSE', 'BHARTIART2');

INSERT INTO STOCK_INDICES (Indices, Ticker_Code) 
VALUES 
('NIFTY50', 'TCS1'),
('SENSEX', 'MARUTI1'),
('SENSEX', 'SUNPHARMA1'),
('NIFTY50', 'HDFCBANK1'),
('SENSEX', 'BHARTIART1'),
('SENSEX', 'MARUTI2'),
('SENSEX', 'SUNPHARMA2'),
('NIFTY50', 'HDFCBANK2'),
('SENSEX', 'BHARTIART2');

INSERT INTO CUSTOMER (Customer_ID, Password, Name, DOB, Phone_Number, Portfolio_ID) 
VALUES 
(6001, 'sneha@123', 'Sneha Gupta', '1993-07-20', '9876543330', 3001),
(6002, 'rakesh@456', 'Rakesh Patel', '1990-04-15', '9876543331', 3002),
(6003, 'priya@789', 'Priyanka Sharma', '1988-10-05', '9876543332', 3003),
(6004, 'manish@987', 'Manish Kumar', '1995-01-25', '9876543333', 3004),
(6005, 'neha@xyz', 'Neha Verma', '1992-03-30', '9876543334', 3005),
(6006, 'amit@123', 'Amit Singh', '1994-09-12', '9876543335', 3006),
(6007, 'riya@456', 'Riya Gupta', '1991-06-18', '9876543336', 3007);

INSERT INTO USES (Customer_ID, Broker_ID) 
VALUES 
(6001, 2004),
(6001, 2005),
(6002, 2001),
(6003, 2005),
(6004, 2002),
(6005, 2003),
(6006, 2004),
(6006, 2001);

INSERT INTO EXCHANGE (Order_ID, Quantity, Price, Time, Buyer_Portfolio_ID, Seller_Portfolio_ID, Ticker_Code) 
VALUES 
(7001, 100, 650, '2023-12-01', 3002, 3001, 'TCS1'),
(7002, 50, 350, '2024-02-20', 3003, 3002, 'MARUTI2'),
(7003, 200, 420, '2024-01-15', 3005, 3003, 'SUNPHARMA1'),
(7004, 150, 800, '2023-12-05', 3002, 3004, 'HDFCBANK1'),
(7005, 80, 850, '2022-12-05', 3004, 3005, 'BHARTIART2'),
(7006, 60, 100, '2021-08-12', 3001, 3003, 'SUNPHARMA1'),
(7007, 30, 700, '2023-11-05', 3001, 3007, 'TCS2'),
(7008, 20, 370, '2022-03-28', 3002, 3006, 'MARUTI1'),
(7009, 9, 750, '2021-09-17',  3002, 3007, 'MARUTI1'),
(7010,100, 450, '2023-05-09', 3006,3003, 'SUNPHARMA1'),
(7011, 40, 350, '2022-12-20', 3001, 3004, 'BHARTIART2'),
(7012, 100, 400, '2022-07-04', 3007,3005,'SUNPHARMA1'),
(7013,50, 400, '2021-02-14', 3003,3004, 'HDFCBANK1'),
(7014, 10, 1200 , '2023-10-30', 3007,3006,'BHARTIART1'),
(7015, 20, 1500, '2022-06-08', 3005, 3007, 'TCS2');

INSERT INTO LISTINGS (Listing_No, Price, Time, Ticker_Code, Quantity) 
VALUES 
(1, 630, '2023-11-30', 'TCS1', 50000),
(2, 680, '2024-01-30', 'TCS1', 50000),
(1, 360, '2024-01-15', 'MARUTI2', 40000),
(1, 200, '2023-10-30', 'SUNPHARMA1', 20000),
(1, 810, '2022-12-30', 'HDFCBANK1' , 35000),
(1, 900, '2021-06-30', 'BHARTIART2' , 5000),
(1, 650,'2022-07-20', 'MARUTI1', 20000),
(1,450,'2023-04-04','SUNPHARMA2',7000),
(1,700,'2021-05-06','HDFCBANK2', 16500),
(1,710,'2022-03-23','BHARTIART1',13000),
(2,550,'2024-08-19','MARUTI1',12000),
(1,500,'2024-03-30','TCS2',25000);

INSERT INTO GOES (Portfolio_ID, Listing_No, Ticker_Code, Alloted) 
VALUES 
(3001, 1, 'TCS1', 500),
(3002, 1, 'MARUTI2', 300),
(3003, 1, 'SUNPHARMA1', 1000),
(3004, 1, 'HDFCBANK1', 700),
(3005, 1, 'BHARTIART2', 400),
(3006, 1, 'BHARTIART1', 110),
(3007, 1, 'MARUTI1', 79),
(3006, 2, 'MARUTI1', 100),
(3007, 1, 'TCS2', 130);	

INSERT INTO OWNS (Portfolio_ID, Ticker_Code) 
VALUES
(3001, 'TCS1'),
(3001, 'BHARTIART2'),
(3001, 'TCS2'),
(3001, 'SUNPHARMA1'),
(3002,'MARUTI2'),
(3002,'TCS1'),
(3002,'HDFCBANK1'),
(3002,'MARUTI1'),
(3003, 'SUNPHARMA1'),
(3003,'MARUTI2'),
(3003,'HDFCBANK1'),
(3004,'HDFCBANK1'),
(3004,'BHARTIART2'),
(3005,'BHARTIART2'),
(3005,'SUNPHARMA1'),
(3005,'TCS2'),
(3006,'BHARTIART1'),
(3006,'MARUTI1'),
(3006,'SUNPHARMA1'),
(3007,'TCS2'),
(3007,'MARUTI1'),
(3007,'SUNPHARMA1'),
(3007,'BHARTIART1');