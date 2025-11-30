use BankLoanDB;

select *
from bank_loan_data;

SELECT COUNT(id) AS Total_Loan_Applications 
FROM bank_loan_data;

SELECT COUNT(id) AS MTD_Total_Loan_Applications 
FROM bank_loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021;

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


SELECT SUM(total_payment) AS MTD_Total_Amount_received FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(total_payment) AS PMTD_Total_Amount_received FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


-- WE will get average interst rate 
SELECT ROUND(AVG(dti),4) * 100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- calculates the percentage of "good loans" in the dataset.
-- A good loan is defined as a loan with a status of 'Fully Paid' or 'Current'
SELECT 
    COUNT(CASE 
            WHEN loan_status IN ('Fully Paid', 'Current') THEN id 
         END) * 100.0 / COUNT(id) AS Good_loan_percentage
FROM bank_loan_data;

-- good loan persentage 
SELECT SUM(total_payment) AS Good_Loan_Recieved_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' oR loan_status = 'Current';

-- bad loan
select 
COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) AS Bad_Loans
from bank_loan_data;

-- bad loan persentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0)
        / COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- Loan status
SELECT
    loan_status,
    COUNT(id) AS LoanCount,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti * 100) AS DTI
FROM
    bank_loan_data
GROUP BY
    loan_status;

-- specific loan status for month 12
SELECT
loan_status,
SUM(total_payment) AS MTD_Total_Amount_Received,
SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;

-- Overview for month loan_applications
SELECT
MONTH(issue_date) AS Month_Number,
DATENAME(MONTH, issue_date) AS Month_Name,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);


-- Overview for term loan_applications
SELECT
term,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term;


-- Overview for employee loan_applications
SELECT
emp_length,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;


-- Overview for home ownership loan_applications
SELECT
home_ownership,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;


-- Overview for home ownership loan_applications for high grade employees
SELECT
home_ownership,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;


-- Overview for why he took the loan (Purpose)
SELECT
    purpose AS PURPOSE,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM 
    bank_loan_data
GROUP BY 
    purpose
ORDER BY 
    purpose;