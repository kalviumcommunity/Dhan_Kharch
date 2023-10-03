-- Active: 1695541481884@@127.0.0.1@3306@Dhan_Kharch
-- Retrieve User's Expenses with Categories
SELECT T.date, T.description, T.amount, C.category_name
FROM Transactions T
INNER JOIN Accounts A ON T.account_no = A.account_no
INNER JOIN Users U ON A.user_ID = U.user_ID
INNER JOIN Budgets B ON T.budget_ID = B.budget_ID
INNER JOIN Categories C ON B.category_ID = C.category_ID
WHERE U.username = 'Jane';

-- Calculate Total Expenses for a User
SELECT SUM(T.amount) AS total_expenses
FROM Transactions T
INNER JOIN Accounts A ON T.account_no = A.account_no
WHERE A.user_ID = 1
AND T.type = 'expense';

-- Retrieve User's Budgets and Remaining Balance
SELECT B.budget_ID, C.category_name, B.budget_amount,
       (B.budget_amount - IFNULL(SUM(T.amount), 0)) AS remaining_balance
FROM Budgets B
INNER JOIN Categories C ON B.category_ID = C.category_ID
LEFT JOIN Transactions T ON B.budget_ID = T.budget_ID
INNER JOIN UserBudgets UB ON B.budget_ID = UB.budget_ID
WHERE B.start_date <= NOW() AND B.end_date >= NOW()
AND UB.user_ID = 1
GROUP BY B.budget_ID, C.category_name, B.budget_amount;

-- Find Transactions Exceeding Budgets
SELECT T.transaction_ID, T.date, T.description, T.amount, C.category_name
FROM Transactions T
INNER JOIN Budgets B ON T.budget_ID = B.budget_ID
INNER JOIN Categories C ON B.category_ID = C.category_ID
INNER JOIN Accounts A ON T.account_no = A.account_no
WHERE A.user_ID = 1
AND T.type = 'expense'
AND T.amount > B.budget_amount;

-- Retrieve Users with their Roles
SELECT U.username, U.email_id, UR.role_name
FROM Users U
INNER JOIN UserRoles UR ON U.role_ID = UR.role_ID;

-- Subquery: Find Users with No Expenses
SELECT U.username, U.email_id
FROM Users U
WHERE NOT EXISTS (
  SELECT 1
  FROM Transactions T
  INNER JOIN Accounts A ON T.account_no = A.account_no
  WHERE A.user_ID = U.user_ID
);