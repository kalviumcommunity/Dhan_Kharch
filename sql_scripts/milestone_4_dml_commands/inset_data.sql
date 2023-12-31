-- Active: 1695541481884@@127.0.0.1@3306@Dhan_Kharch
INSERT INTO UserRoles (role_name) VALUES ('admin'), ('user');

INSERT INTO Users (user_ID, username, email_id, role_ID) VALUES
(1, 'John', 'john@example.com', 1),
(2, 'Jane', 'jane@example.com', 2),
(3, 'Bob', 'bob@example.com', 2);

INSERT INTO Users (user_ID, username, email_id, role_ID) VALUES
(4, 'Raju', 'raju@example.com', 2);

INSERT INTO Accounts (account_no, balance, user_ID) VALUES
(1001, 5000.00, 1),
(1002, 10000.00, 2),
(1003, 2500.00, 3);

INSERT INTO Categories (category_name) VALUES
('Groceries'),
('Entertainment'),
('Transportation'),
('Utilities');

INSERT INTO Budgets (budget_ID, category_ID, budget_amount, start_date, end_date) VALUES
(1, 1, 1000.00, '2023-10-01', '2023-10-31'),
(2, 2, 500.00, '2023-10-01', '2023-10-31'),
(3, 3, 750.00, '2023-10-01', '2023-10-31'),
(4, 4, 200.00, '2023-10-01', '2023-10-31');

INSERT INTO UserBudgets (user_budget_ID, user_ID, budget_ID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 1, 4),
(5, 2, 4),
(6, 3, 4);

INSERT INTO Transactions (account_no, date, description, type, amount, budget_ID) VALUES
(1001, '2023-10-01 10:00:00', 'Grocery shopping', 'expense', 100.00, 1),
(1002, '2023-10-02 15:00:00', 'Movie tickets', 'expense', 50.00, 2),
(1003, '2023-10-03 12:00:00', 'Gas refill', 'expense', 25.00, 3),
(1001, '2023-10-04 09:00:00', 'Electricity bill', 'expense', 50.00, 4),
(1002, '2023-10-05 14:00:00', 'Salary', 'income', 5000.00, NULL),
(1003, '2023-10-06 11:00:00', 'Internet bill', 'expense', 30.00, 4);

INSERT INTO Transactions (account_no, date, description, type, amount, budget_ID) VALUES
(1001, '2023-10-12 20:00:00', 'Maintanance Charge', 'expense', 300.00, 4);

-- Update the balance of each account based on the transactions
UPDATE Accounts AS a
JOIN Transactions AS t ON a.account_no = t.account_no
SET a.balance = CASE
    WHEN t.type = 'expense' THEN a.balance - t.amount
    WHEN t.type = 'income' THEN a.balance + t.amount
END;

-- Delete the transaction with transaction_ID = 2
DELETE FROM Transactions WHERE transaction_ID = 7;

-- Select all transactions for the current month
SELECT * FROM Transactions WHERE MONTH(date) = MONTH(CURRENT_DATE());

-- Select the total amount of income and expenses for each account
SELECT account_no, SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END) AS total_income, SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END) AS total_expenses FROM Transactions GROUP BY account_no;