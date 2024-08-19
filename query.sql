use classicmodels;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT * from customers;
select * from employees;
select COUNT(*) from employees;
-- 1 
-- 2 tables: customer, employee 

select c.customerName as 'Customer Name', CONCAT(e.lastName, ', ', e.firstName) as 'Sales Rep'
from customers c 
join employees e 
where c.customerName = 'Alpha Cognac'
order by c.customerName;

select c.customerName as 'Customer Name', CONCAT(e.lastName, ', ', e.firstName) as 'Sales Rep'
from customers c
join employees e on c.salesRepEmployeeNumber = e.employeeNumber
order by e.lastName;

select c.customerName as 'Customer Name', CONCAT(e.lastName, ', ', e.firstName) as 'Sales Rep'
from customers c
join employees e on c.salesRepEmployeeNumber = e.employeeNumber
where e.employeeNumber = 1370
order by c.customerName;

select c.customerName as 'Customer Name', CONCAT(e.lastName, ', ', e.firstName) as 'Sales Rep'
from customers c
join employees e on c.salesRepEmployeeNumber = e.employeeNumber
where c.customerName = 'Mini'
order by c.customerName;

select * from employees where lastName = 'Hernandez';

-- 2  
/* total quanitity, total sale Generated =total quanitiy * price each, product name, total ordered, total sale */

select * from orderDetails;
select * from products;

select 
	p.productName as 'Product name',
	SUM(o.quantityOrdered) as 'Total # Ordered', 
    SUM(o.quantityOrdered * o.priceEach) as 'Total Sale'
from products p 
left join orderdetails o 
on o.productCode = p.productCode
group by o.productCode, p.buyPrice
order by 3 desc;

select 
	p.productName as 'Product name',
	SUM(o.quantityOrdered) as 'Total # Ordered', 
    SUM(o.quantityOrdered * o.priceEach) as 'Total Sale'
from products p 
left join orderdetails o 
on o.productCode = p.productCode
group by o.productCode, p.buyPrice
order by sum(o.quantityOrdered * o.priceEach) desc;

-- 3 
/*
	GET: 
	order status
    number of orders with that specific status
    
    SORT BY:
    status
*/

select * from orders where customerNumber = 131;

select status as 'Order Status', COUNT(orderNumber) as 'Total Orders'
from orders
group by status
order by status;



-- 4
/*
	GET: 
	for each product 
    total num of prod sold of each prod
*/

select * from productlines;
select * from products;

select 
	p.productLine as 'product line', 
    count(o.quantityOrdered) as 'total sold'
from products p
	inner join orderdetails o 
	on o.productCode = p.productCode
group by p.productLine
order by 2 desc;

select 
     pl.productLine as 'Product Line', 
     count(od.productCode) as 'total Sold'
from productLines pl 
	join products p 
on pl.productLine=p.productLine
	JOIN orderdetails od on p.productCode=od.productCode
group by pl.productLine
order by 2 desc;



-- 5 
/*
	GET
    month 
    year 
    total sale forEach Month
*/
select * from orders;

select 
	MONTHNAME(paymentDate) as 'Month', 
    YEAR(paymentDate) as 'Year', 
    format(SUM(amount), 2) as 'Payments Recieved'
from payments
group by year(paymentDate), monthname(paymentDate) 
order by paymentDate;


-- 6
/* 
	GET
    name
    productline
    scale 
    vendor
*/

select * from products;
select * from productLines;

select productName, productLine, productScale, productVendor
from products 
where productLine = 'Classic Cars' OR productLine = 'Vintage Cars'
order by productName asc, productLine desc;


SELECT 
	p.productName Name, 
    p.productLine AS 'Product Line', 
    p.productScale AS 'Scale', 
    p.productVendor AS 'Vendor' 
FROM productlines l inner JOIN products p 
WHERE l.productLine = "Classic Cars" OR l.productLine = "Vintage Cars"
ORDER BY p.productLine DESC, p.productName ASC;







