-- ============================================
-- Bookstore Management System
-- Database Schema
-- ============================================

CREATE DATABASE IF NOT EXISTS dbmss_project;

USE dbmss_project;
CREATE TABLE Books (
    Book_ID INT PRIMARY KEY,
    Title TEXT,
    Author TEXT,
    Genre TEXT,
    Published_Year INT,
    Price DOUBLE,
    Stock INT DEFAULT 0,

    CONSTRAINT chk_books_price CHECK (Price >= 0),
    CONSTRAINT chk_books_stock CHECK (Stock >= 0)
);

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(50),
    Country VARCHAR(50),

    CONSTRAINT UQ_Customers_Email UNIQUE (Email)
);
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Book_ID INT,
    Customer_ID INT,
    Order_Date DATE,
    Quantity INT DEFAULT 1,
    Total_Amount DOUBLE,

    CONSTRAINT chk_orders_quantity CHECK (Quantity > 0),
    CONSTRAINT chk_orders_total_amount CHECK (Total_Amount >= 0)
);