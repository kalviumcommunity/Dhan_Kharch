-- Create Users table
CREATE TABLE Users (
    User_ID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Role ENUM('User', 'Admin') NOT NULL
);

-- Create Categories table
CREATE TABLE Categories (
    Category_ID INT AUTO_INCREMENT PRIMARY KEY,
    Category_Name VARCHAR(50) NOT NULL
);

-- Create Expenses table
CREATE TABLE Expenses (
    Expense_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT,
    Expense_Description VARCHAR(255) NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Expense_Date DATE NOT NULL,
    Category_ID INT,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Category_ID) REFERENCES Categories(Category_ID)
);

-- Create Budgets table
CREATE TABLE Budgets (
    Budget_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT,
    Category_ID INT,
    Budget_Amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Category_ID) REFERENCES Categories(Category_ID)
);
