-- Delete existing roles
DROP ROLE IF EXISTS dk_admin@localhost;
DROP ROLE IF EXISTS dk_manager@localhost;
DROP ROLE IF EXISTS dk_user@localhost;
DROP ROLE IF EXISTS dk_guest@localhost;

-- Create new roles at localhost
CREATE ROLE dk_admin@localhost;
CREATE ROLE dk_manager@localhost;
CREATE ROLE dk_user@localhost;
CREATE ROLE dk_guest@localhost;

-- Unlock all roles and set passwords
ALTER USER 'dk_admin'@'localhost' IDENTIFIED BY 'admin@dk' ACCOUNT UNLOCK;
ALTER USER 'dk_manager'@'localhost' IDENTIFIED BY 'manager@dk' ACCOUNT UNLOCK;
ALTER USER 'dk_user'@'localhost' IDENTIFIED BY 'user@dk' ACCOUNT UNLOCK;
ALTER USER 'dk_guest'@'localhost' IDENTIFIED BY 'guest@dk' ACCOUNT UNLOCK;

-- Grant privileges to dk_admin role
GRANT ALL PRIVILEGES ON dhan_kharch.* TO dk_admin@localhost;

-- Grant privileges to dk_manager role
GRANT SELECT, INSERT, UPDATE, DELETE ON dhan_kharch.Users TO dk_manager@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON dhan_kharch.Accounts TO dk_manager@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON dhan_kharch.UserBudgets TO dk_manager@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON dhan_kharch.Transactions TO dk_manager@localhost;

-- Grant privileges to user role
GRANT SELECT, INSERT, UPDATE, DELETE ON dhan_kharch.Budgets TO dk_user@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON dhan_kharch.Categories TO dk_user@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON dhan_kharch.Transactions TO dk_user@localhost;
GRANT SELECT, INSERT, UPDATE ON dhan_kharch.Accounts TO dk_user@localhost;
GRANT SELECT ON dhan_kharch.Users TO dk_user@localhost;
REVOKE DELETE ON dhan_kharch.Users FROM dk_user@localhost;
REVOKE DELETE ON dhan_kharch.Accounts FROM dk_user@localhost;
REVOKE DELETE ON dhan_kharch.Budgets FROM dk_user@localhost;
REVOKE DELETE ON dhan_kharch.Categories FROM dk_user@localhost;

-- Grant privileges to dk_guest role
GRANT SELECT ON dhan_kharch.* TO dk_guest@localhost;
REVOKE INSERT, UPDATE, DELETE ON dhan_kharch.* FROM dk_guest@localhost;