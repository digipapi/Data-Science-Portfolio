create database HR_DB;
use HR_DB;
-- Understanding the data
describe hr_data;

select *
from hr_data
limit 50;

-- rename column headers
alter table hr_data 
rename column  id to Employee_ID;

alter table hr_data 
rename column  first_name to First_Name;

alter table hr_data 
rename column  last_name to Last_Name;

alter table hr_data 
rename column  birthdate to Birth_Date;

alter table hr_data 
rename column  gender to Gender;

alter table hr_data 
rename column  race to Race_Ethnicity;

alter table hr_data 
rename column  department to Department;

alter table hr_data 
rename column  jobtitle to Job_Title;

alter table hr_data 
rename column  location to Location;

alter table hr_data 
rename column  hire_date to Hire_Date;

alter table hr_data 
rename column  termdate to Term_Date;

alter table hr_data 
rename column  location_city to City;

alter table hr_data 
rename column  location_state to State;
--
describe hr_data;

-- update '' to '/'
update hr_data set Birth_Date = replace(Birth_Date, '-', '/');
-- change column data type to date
update hr_data
set Birth_Date = str_to_date(Birth_Date, '%m/%d/%Y');

-- update '-' to '/'
update hr_data set Hire_Date = replace(Hire_Date, '-', '/');
-- change column data type to date
update hr_data
set Hire_Date = str_to_date(Hire_Date, '%m/%d/%Y');

-- update '-' to '/'
-- update hr_data set Term_Date = replace(Term_Date, '-', '/');
-- change column data type to date
-- update hr_data
-- set Term_Date = str_to_date(Term_Date, '%Y/%m/%d %H:%i:%s');

-- 1 Gender breakdown of employees
select Gender, count(Employee_ID) as Number_Of_Employees
from hr_data
group by Gender
order by count(Employee_ID) desc;

-- 2 Racial breakdown of employees
select Race_Ethnicity, count(Employee_ID) as Number_Of_Employees
from hr_data
group by Race_Ethnicity
order by count(Employee_ID) desc;

-- 3 Age distribution of employees
select year(Birth_Date) as Birth_Year, timestampdiff(Year, Birth_Date, curdate()) as Age, count(Employee_ID) as Number_Of_Employees
from hr_data
group by year(Birth_Date)
order by Age asc;

-- 4 Group employees by location
select Location, count(Employee_ID) as Number_Of_Employees
from hr_data
group by Location
order by count(Employee_ID) desc;

-- 5 Gender distribution of employees across departments and job titles
select Department, Gender, COUNT(Employee_ID) as Number_Of_Employees
from hr_data
group by Department, Gender
order by Department;

select Job_Title, Gender, COUNT(Employee_ID) as Number_Of_Employees
from hr_data
group by Job_Title, Gender
order by Job_Title;

-- 6 Distribution of job titles across the company
select Job_Title, count(Employee_ID) as Number_Of_Employees
from hr_data
group by Job_Title
order by count(Employee_ID) desc;

-- 7 Turnover by department
select Department, count(Term_Date) as Turnover_Rate
from hr_data
where Term_Date != ''
group by Department
order by count(Term_Date) desc;

-- 8 Distribution of employees across locations by state
select State, count(Employee_ID) as Number_Of_Employees
from hr_data
group by State
order by count(Employee_ID) desc;

-- 9 Change in employee count overtime based on hire and term dates
select year(Hire_Date) as Hire_Year, count(Hire_Date) as Count_Of_Employees
from hr_data
group by year(Hire_Date)
order by Hire_Date;

select year(Term_Date) as Term_Year, count(Term_Date) as Count_Of_Employees
from hr_data 
where Term_Date != ''
group by year(Term_Date)
order by Term_Date;

-- 10 Tenure distribution by department
select Department, year(Term_Date) as Term_Year, year(Hire_Date) as Hire_Year, year(Term_Date) - year(Hire_Date) as Tenure, count(Employee_ID) as Count_Of_Employees
from hr_data
where Term_Date != ''
group by Department
order by Tenure desc;

describe hr_data;