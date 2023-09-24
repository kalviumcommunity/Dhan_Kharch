-- Active: 1695541481884@@127.0.0.1@3306@Dhan_Kharch
CREATE TABLE UserRoles (
  role_ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
  role_name ENUM('admin', 'user')
);

CREATE TABLE Users (
  user_ID INT PRIMARY KEY,
  username VARCHAR(255),
  email_id VARCHAR(255) UNIQUE,
  role_ID INT,
  FOREIGN KEY (role_ID) REFERENCES UserRoles(role_ID)
);

CREATE TABLE Accounts (
  account_no INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
  balance DECIMAL(10, 2),
  user_ID INT,
  FOREIGN KEY (user_ID) REFERENCES Users(user_ID)
);

CREATE TABLE Categories (
  category_ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
  category_name VARCHAR(255) UNIQUE
);

CREATE TABLE Budgets (
  budget_ID INT PRIMARY KEY,
  category_ID INT,
  budget_amount DECIMAL(10, 2),
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (category_ID) REFERENCES Categories(category_ID)
);

CREATE TABLE UserBudgets (
  user_budget_ID INT PRIMARY KEY,
  user_ID INT,
  budget_ID INT,
  FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
  FOREIGN KEY (budget_ID) REFERENCES Budgets(budget_ID)
);

CREATE TABLE Transactions (
  transaction_ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
  account_no INT,
  date DATETIME,
  description VARCHAR(255),
  type ENUM('income', 'expense'),
  amount DECIMAL(10, 2),
  budget_ID INT,
  FOREIGN KEY (account_no) REFERENCES Accounts(account_no),
  FOREIGN KEY (budget_ID) REFERENCES Budgets(budget_ID)
);

SHOW TABLES;