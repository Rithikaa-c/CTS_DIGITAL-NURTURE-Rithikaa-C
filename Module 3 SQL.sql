CREATE DATABASE BankDataBase;
USE BankDataBase;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Age INT,
    Balance DECIMAL(10,2),
    IsVIP BOOLEAN DEFAULT FALSE
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    InterestRate DECIMAL(5,2),
    DueDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers(Name,Age,Balance)
VALUES
('Rahul',65,15000),
('Priya',45,8000),
('Arun',70,25000),
('Sneha',30,12000),
('Karthik',61,9500);

INSERT INTO Loans(CustomerID,InterestRate,DueDate)
VALUES
(1,9.5,DATE_ADD(CURDATE(),INTERVAL 15 DAY)),
(2,10.0,DATE_ADD(CURDATE(),INTERVAL 40 DAY)),
(3,8.5,DATE_ADD(CURDATE(),INTERVAL 20 DAY)),
(4,11.0,DATE_ADD(CURDATE(),INTERVAL 10 DAY)),
(5,9.0,DATE_ADD(CURDATE(),INTERVAL 25 DAY));

DELIMITER $$

CREATE PROCEDURE DiscountInterest()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE vLoanID INT;
    DECLARE vAge INT;

    DECLARE cur CURSOR FOR
    SELECT l.LoanID, c.Age
    FROM Loans l
    JOIN Customers c
    ON l.CustomerID = c.CustomerID;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP

        FETCH cur INTO vLoanID, vAge;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF vAge > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE LoanID = vLoanID;
        END IF;

    END LOOP;

    CLOSE cur;

END$$

DELIMITER ;

CALL DiscountInterest();

SELECT * FROM Loans;

DELIMITER $$

CREATE PROCEDURE PromoteVIP()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE vCustomerID INT;
    DECLARE vBalance DECIMAL(10,2);

    DECLARE cur CURSOR FOR
    SELECT CustomerID,Balance
    FROM Customers;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP

        FETCH cur INTO vCustomerID,vBalance;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF vBalance > 10000 THEN

            UPDATE Customers
            SET IsVIP = TRUE
            WHERE CustomerID=vCustomerID;

        END IF;

    END LOOP;

    CLOSE cur;

END$$

DELIMITER ;

CALL PromoteVIP();

SELECT * FROM Customers;

DELIMITER $$

CREATE PROCEDURE LoanReminder()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE vName VARCHAR(50);
    DECLARE vLoanID INT;
    DECLARE vDueDate DATE;

    DECLARE cur CURSOR FOR

    SELECT c.Name,l.LoanID,l.DueDate
    FROM Customers c
    JOIN Loans l
    ON c.CustomerID=l.CustomerID
    WHERE l.DueDate BETWEEN CURDATE()
    AND DATE_ADD(CURDATE(),INTERVAL 30 DAY);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;

    OPEN cur;

    read_loop: LOOP

        FETCH cur INTO vName,vLoanID,vDueDate;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT CONCAT(
        'Reminder: Dear ',
        vName,
        ', Loan ID ',
        vLoanID,
        ' is due on ',
        vDueDate
        ) AS Reminder;

    END LOOP;

    CLOSE cur;

END$$

DELIMITER ;

CALL LoanReminder();

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(50),
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Accounts(CustomerName,AccountType,Balance)
VALUES
('Rahul','Savings',10000),
('Priya','Savings',15000),
('Arun','Current',20000),
('Sneha','Savings',12000),
('Karthik','Current',18000);

INSERT INTO Employees(EmployeeName,Department,Salary)
VALUES
('John','HR',40000),
('Alice','IT',50000),
('David','IT',55000),
('Maria','Finance',45000),
('Steve','HR',42000);

DELIMITER $$

CREATE PROCEDURE ProcessMonthlyInterest()
BEGIN

    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType='Savings';

END$$

DELIMITER ;

CALL ProcessMonthlyInterest();

SELECT * FROM Accounts;

DELIMITER $$

CREATE PROCEDURE UpdateEmployeeBonus(

IN deptName VARCHAR(50),
IN bonusPercent DECIMAL(5,2)

)

BEGIN

    UPDATE Employees
    SET Salary = Salary + (Salary * bonusPercent /100)
    WHERE Department = deptName;

END$$

DELIMITER ;

CALL UpdateEmployeeBonus('IT',10);

SELECT * FROM Employees;

SET SQL_SAFE_UPDATES = 0;

DELIMITER $$

CREATE PROCEDURE TransferFunds(

IN FromAccount INT,
IN ToAccount INT,
IN Amount DECIMAL(10,2)

)

BEGIN

DECLARE SourceBalance DECIMAL(10,2);

SELECT Balance
INTO SourceBalance
FROM Accounts
WHERE AccountID=FromAccount;

IF SourceBalance >= Amount THEN

    UPDATE Accounts
    SET Balance=Balance-Amount
    WHERE AccountID=FromAccount;

    UPDATE Accounts
    SET Balance=Balance+Amount
    WHERE AccountID=ToAccount;

    SELECT 'Transfer Successful' AS Message;

ELSE

    SELECT 'Insufficient Balance' AS Message;

END IF;

END$$

DELIMITER ;

CALL TransferFunds(1,2,2000);