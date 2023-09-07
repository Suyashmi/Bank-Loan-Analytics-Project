use bank_analytics;

Create Table Finance_1
(id int, member_id int, loan_amnt int, funded_amnt double, funded_amnt_inv double, term varchar(50), int_rate text, installment double, 
grade Text, sub_grade Text, home_ownership Varchar(50), annual_inc int, verification_status Varchar(50), issue_d date, loan_status varchar(50), 
purpose varchar(50), zip_code varchar(50), addr_state varchar(50));

Create Table Finance_2
(id int, revol_bal int,	total_pymnt	double, total_pymnt_inv double,	total_rec_prncp int, total_rec_int double, last_pymnt_d	date, 
last_pymnt_amnt double, last_credit_pull_d date);

Select * from finance_1;
Select * from finance_2;

#Total number of loan applicants.
Select count(id) from finance_1;

#Total funded amount.
Select sum(funded_amnt) from finance_1;

#Total payments received.
Select sum(total_pymnt) from finance_2;

#Total Funded Amount
Select sum(Funded_amnt) from Finance_1;

#Average DTI
SELECT Avg(annual_inc/loan_amnt) AS avg_debt_to_income_ratio
FROM finance_1;


#Year wise Loan Amount.
Select year(issue_d) as Issue_Year, sum(loan_amnt) as Loan_Amount
From finance_1
Group by year(issue_d);

#Loan Status
SELECT loan_status, COUNT(*) AS num_loans
FROM finance_1
GROUP BY loan_status;

#Total Payment Status
Select Verification_status, total_pymnt
from bank_analytics.finance_1
Join bank_analytics.finance_2
On finance_1.id = finance_2.id
Group by verification_status
order by total_pymnt;

#Grade wise revolving balance
Select grade, revol_bal
from bank_analytics.finance_1
Join bank_analytics.finance_2
On finance_1.id = finance_2.id
Group by grade
Order by grade;

#Sub_grade wise Revolving Balance
Select sub_grade, revol_bal
from bank_analytics.finance_1
Join bank_analytics.finance_2
On finance_1.id = finance_2.id
Group by sub_grade
Order by sub_grade;

#Loan Status vs Last Credit Pull Date
SELECT year(last_credit_pull_d), loan_status, COUNT(*) AS num_loans
FROM bank_analytics.finance_1
Join bank_analytics.finance_2
On finance_1.id = finance_2.id
GROUP BY year(last_credit_pull_d), loan_status
Order by Year(last_credit_pull_d);

#State wise Loan Status
Select addr_state, loan_status, count(*) as num_loans
from bank_analytics.finance_1
Join bank_analytics.finance_2
On finance_1.id = finance_2.id
Group by addr_state, loan_status
Order by addr_state;

#Home Ownership vs Last Payment Date
SELECT home_ownership, year(last_pymnt_d), COUNT(*) AS num_loans
FROM bank_analytics.finance_1
Join bank_analytics.finance_2
On finance_1.id = finance_2.id
GROUP BY home_ownership, year(last_pymnt_d)
Order by year(last_pymnt_d);

