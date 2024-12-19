/*	Question 01: 
	Using the customer table or tab, please write an SQL query that shows 
    Title, First Name and Last Name and Date of Birth for each of the customers.*/
    
Select title, firstname, lastname, dateofbirth
from customer;
    
    
/*	Question 02: 
	Using customer table or tab, please write an SQL query that shows the number of customers 
    in each customer group (Bronze, Silver & Gold). I can see visually that there are 4 Bronze, 
    3 Silver and 3 Gold but if there were a million customers how would I do this in Excel?*/

Select customergroup as "Customer Group", count(customergroup) as "Customers per Group"
from customer
group by CustomerGroup
order by count(CustomerGroup) desc;
    
/*	Question 03: 
	The CRM manager has asked me to provide a complete list of all data for those customers in 
	the customer table but I need to add the currency code of each player so she will be able to send 
    the right offer in the right currency. Note that the currency code does not exist in the customer 
    table but in the account table. Please write the SQL that would facilitate this.*/ 

Select customer.*, CurrencyCode
from customer inner join `account` a on customer.CustID = a.CustID;

    
/*	Question 04: 
	Now I need to provide a product manager with a summary report that shows, by product and by day
    how much money has been bet on a particular product. PLEASE note that the transactions are stored
    in the betting table and there is a product code in that table that is required to be looked up 
    (classid & categortyid) to determine which product family this belongs to. Please write the SQL that 
    would provide the report. */

-- Select p.ClassId, p.CategoryID, p.Product, BetDate, sum(bet_amt) as Total
-- from betting1 inner join product p on p.ClassId = betting1.ClassId
-- group by p.CLASSID, p.CATEGORYID, p.product, BetDate
-- order by Total desc;

Select p.Product, BetDate, sum(bet_amt) as Total
from betting1 inner join product p on p.ClassId = betting1.ClassId
group by BetDate, p.product
order by BetDate;
    


/*	Question 05: 	
	You’ve just provided the report from question 4 to the product manager, now he has emailed me and 
    wants it changed. Can you please amend the summary report so that it only summarizes transactions that 
    occurred on or after 1st November and he only wants to see Sportsbook transactions. Again, please write 
    the SQL below that will do this.*/
    
Select p.Product, BetDate, sum(bet_amt) as Total
from betting1 inner join product p on p.ClassId = betting1.ClassId
where 
	BetDate >= '2012-11-01' and
    p.Product = 'Sportsbook'
group by BetDate, p.product
order by BetDate;
    
/*	Question 06: 
	As often happens, the product manager has shown his new report to his director and now he 
    also wants different version of this report. This time, he wants the all of the products but split
    by the currencycode and customergroup of the customer, rather than by day and product. He would 
    also only like transactions that occurred after 1st December. Please write the SQL code that will do this. */

Select p.product, CurrencyCOde, customergroup, sum(bet_amt) as Total
from 
	betting1 inner join product p on p.ClassId = betting1.ClassId
	inner join `account` a on a.AccountNo = betting1.AccountNo
    inner join customer c on c.CustID = a.CustID
where 
	BetDate >= '2012-12-01' 
group by p.product, currencycode, customergroup;    

/*	Question 07: 
	Our VIP team have asked to see a report of all players regardless of whether they 
    have done anything in the complete timeframe or not. In our example, it is possible 
    that not all of the players have been active. Please write an SQL query that shows all players 
    Title, First Name and Last Name and a summary of their bet amount for the complete period of November. */
    
Select 
	a.custid as "Customer ID", 
    a.AccountNo as "Account Number", 
    concat(title, " ",firstname, " ", lastname) as `name`, 
    sum(bet_amt) as AMOUNT_SPENT, 
    b.product
from 
	customer c 
	left join `account` a on c.custid = a.custid
    left join betting1 b on b.accountno = a.accountno
where betdate like "2012-11-%"
group by a.custid, a.accountno, `name`, b.product
order by FirstName;
    
    
/*	Question 08: 
	Our marketing and CRM teams want to measure the number of players who play more than one product. 
    Can you please write 2 queries, one that shows the number of products per player and another that 
    shows players who play both Sportsbook and Vegas. */
    
Select 
	a.custid,
    a.accountno,
	concat(title, " ",firstname, " ", lastname) as NAME_, 
    count(distinct product) as ct 
from 
	customer c 
	left join `account` a on c.custid = a.custid
    left join betting1 b on b.accountno = a.accountno
group by a.custid, a.accountno, NAME_
HAVING 
   ct > 1
order by ct desc;

/******/

SELECT 
    c.CustID,
    a.accountno,
    CONCAT(c.Title, ' ', c.FirstName, ' ', c.LastName) AS Name
FROM 
    customer c
    INNER JOIN `account` a ON c.CustID = a.CustID
    INNER JOIN betting1 b ON b.AccountNo = a.AccountNo
WHERE 
    b.Product IN ('Sportsbook', 'Vegas')
GROUP BY 
    c.CustID, accountno, Name
HAVING 
    COUNT(DISTINCT b.Product) = 2;

    
/*	Question 09: Now our CRM team want to look at players who only play one product, 
	please write SQL code that shows the players who only play at sportsbook, use the 
    bet_amt > 0 as the key. Show each player and the sum of their bets for both products. */
    
-- Not sure about this query...
Select 
    a.custid,
    a.accountno,
    concat(title, " ",firstname, " ", lastname) as NAME_, 
    sum(bet_amt) as AMOUNT
from 
    customer c 
    left join `account` a on c.custid = a.custid
    left join betting1 b on b.accountno = a.accountno
where Bet_Amt>0
group by a.custid, a.accountno, NAME_, product
HAVING 
   count(distinct product) = 1 and
   product = "Sportsbook"
order by AMOUNT desc;


/*	Question 10: The last question requires us to calculate and determine a player’s favorite 
	product. This can be determined by the most money staked. Please write a query that will 
    show each players favorite product.	*/ 
    
-- github copilot gave me this one... i suspected that it could be solved with "with", but didnt know how
WITH PlayerProductAmounts AS (
    SELECT 
        c.CustID, 
        c.FirstName, 
        c.LastName,
        a.AccountNo, 
        b.Product, 
        SUM(b.Bet_Amt) AS TotalBetAmt
    FROM 
        customer c 
        LEFT JOIN `account` a ON c.CustID = a.CustID
        LEFT JOIN betting1 b ON b.AccountNo = a.AccountNo
    GROUP BY 
        c.CustID, 
        c.FirstName, 
        c.LastName,
        a.AccountNo, 
        b.Product
)
SELECT 
    CustID, 
    FirstName, 
    LastName,
    AccountNo, 
    Product, 
    TotalBetAmt
FROM 
    PlayerProductAmounts ppa
WHERE 
    TotalBetAmt = (
        SELECT 
            MAX(TotalBetAmt)
        FROM 
            PlayerProductAmounts
        WHERE 
            CustID = ppa.CustID
    )
ORDER BY 
    CustID;

/*Question 11: Write a query that returns the top 5 students based on GPA.*/
Select * 
from student
order by gpa desc
limit 5;


/*	Question 12: Write a query that returns the number of students in each school. 
	(a school should be in the output even if it has no students!).*/

select school.school_id, school_name, count(student.school_id) as school_count
from student right join school on student.school_id = school.school_id
group by school_id, school_name
order by school_count desc;

/*	Question 13: 
Write a query that returns the top 3 GPA students' name from each university.*/

-- github copilot gave me this one...
select student_id, student_name, student.school_id, school_name, gpa
from student right join school on student.school_id = school.school_id
order by gpa desc
;

WITH RankedStudents AS (
    SELECT 
        s.Student_Name,
        s.GPA,
        s.school_id,
        ROW_NUMBER() OVER (PARTITION BY s.school_id ORDER BY s.GPA DESC) AS r
    FROM 
        student s
)
SELECT 
    Student_Name,
    GPA,
    school.school_id,
    school_name
FROM 
    RankedStudents right join school on RankedStudents.school_id = school.school_id
WHERE 
    r <= 3s
ORDER BY 
    school.school_id, r;