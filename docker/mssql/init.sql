CREATE DATABASE TestDB;
GO
USE TestDB;
GO
CREATE TABLE Customers (
    CustomerID int,
    CustomerName varchar(255),
    ContactName varchar(255),
    Country varchar(255)
);
GO
INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country)
VALUES (1, 'Cardinal', 'Tom B. Erichsen', 'Norway');
GO
