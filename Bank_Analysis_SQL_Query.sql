CREATE DATABASE BankingRiskDB;

USE BankingRiskDB;

CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50),
    CreditScore INT,
    RiskSegment VARCHAR(20)
);

CREATE TABLE Accounts (
    AccountID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10),
    AccountType VARCHAR(20),
    Balance DECIMAL(15,2)
);

CREATE TABLE Transactions (
    TransactionID VARCHAR(15) PRIMARY KEY,
    AccountID VARCHAR(10),
    Amount DECIMAL(15,2),
    Type VARCHAR(30),
    Channel VARCHAR(30),
    TransactionDate DATE
);

CREATE TABLE FraudCases (
    FraudID VARCHAR(10) PRIMARY KEY,
    TransactionID VARCHAR(15),
    FraudType VARCHAR(50),
    LossAmount DECIMAL(15,2)
);

CREATE TABLE Loans (
    LoanID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10),
    LoanAmount DECIMAL(15,2),
    LoanType VARCHAR(30),
    DefaultFlag INT
);

SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Accounts;

SELECT COUNT(*) FROM FraudCases;
SELECT COUNT(*) FROM Loans;
SELECT COUNT(*) FROM Cards;
SELECT COUNT(*) FROM Branches;

SELECT COUNT(*) FROM Transactions;

SELECT
    RiskSegment,
    COUNT(*) AS Customer_Count
FROM Customers
GROUP BY RiskSegment
ORDER BY Customer_Count DESC;

SELECT
    RiskSegment,
    ROUND(AVG(CreditScore),2) AS Avg_Credit_Score
FROM Customers
GROUP BY RiskSegment;


SELECT
    FraudType,
    SUM(LossAmount) AS Total_Loss
FROM FraudCases
GROUP BY FraudType
ORDER BY Total_Loss DESC;

SELECT
    LoanType,
    COUNT(*) AS Total_Loans,
    SUM(DefaultFlag) AS Defaults,
    ROUND(SUM(DefaultFlag)*100.0/COUNT(*),2) AS Default_Rate
FROM Loans
GROUP BY LoanType
ORDER BY Default_Rate DESC;


SELECT
    Channel,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Amount),2) AS Total_Amount
FROM Transactions
GROUP BY Channel
ORDER BY Total_Amount DESC;


SELECT
    TransactionID,
    Amount,
    Channel,
    Type
FROM Transactions
ORDER BY Amount DESC
LIMIT 10;

SELECT
CASE
    WHEN CreditScore < 550 THEN 'High Risk'
    WHEN CreditScore < 700 THEN 'Medium Risk'
    ELSE 'Low Risk'
END AS Risk_Band,
COUNT(*) AS Customers
FROM Customers
GROUP BY Risk_Band;

SELECT
COUNT(*) AS Fraud_Cases,
SUM(LossAmount) AS Total_Fraud_Loss,
AVG(LossAmount) AS Avg_Fraud_Loss
FROM FraudCases;


SELECT
MIN(Balance) AS Min_Balance,
AVG(Balance) AS Avg_Balance,
MAX(Balance) AS Max_Balance
FROM Accounts;

SELECT
City,
COUNT(*) AS Customers
FROM Customers
GROUP BY City
ORDER BY Customers DESC;


