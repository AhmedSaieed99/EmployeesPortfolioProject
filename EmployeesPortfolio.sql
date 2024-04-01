--Introducing Employees Data...
Select *
from EmployeeData
order by ExitDate desc


--As Asia is the largest continent we need to filter Asian employees details in the company 
Select EmployeeID, FullName, JobTitle, Department, Ethnicity
from EmployeeData
where Ethnicity = 'Asian'

--How many Asian is working in the company?
Select Ethnicity, count(*) as NumberOfAsians
from EmployeeData
group by Ethnicity
having ethnicity = 'Asian'

--Detecting other ethnicities
Select Ethnicity, count(*) as NumberOfOthers
from EmployeeData
group by Ethnicity
having Ethnicity != 'Asian'
order by NumberOfOthers desc


--Let's now calculate the Net Salary of each employee by adding the Bonus on the Annual Salary
Select EmployeeID, FullName, JobTitle, Department, AnnualSalary, BonusPercent, (cast(AnnualSalary as int) * BonusPercent) as BonusValue, (cast(AnnualSalary as int) * BonusPercent) + (AnnualSalary) as NetSalary
from EmployeeData
order by 1,2 asc

--We just want to know which department has the highest bonus percentage, and who's the employee that earns this highest bonus
Select FullName, JobTitle, Department, max(BonusPercent) as HighestBonus
from EmployeeData
group by FullName, JobTitle, Department
order by HighestBonus desc
--As Per Analysis, we found out there're more than one Vice President with common highest bonus amount


--Which business unit has employees aging more than 60 Years Old?
Select BusinessUnit, count(Age) as TotalEmployeesOverSixty
from EmployeeData
group by BusinessUnit, Age
having Age >= 60
order by TotalEmployeesOverSixty desc


--Some employees have left the company, so we can calculate the Exact Working Period for each employee
Select EmployeeID, FullName, HireDate, ExitDate, DATEDIFF(month,HireDate,ExitDate) as ExactPeriodMonthly, DATEDIFF(month,HireDate,ExitDate) / 12 as ExactPeriodYearly
from EmployeeData
where ExitDate is not null
order by ExactPeriodMonthly desc

--Cities that has longest working periods by employees(In Months)
select distinct City, sum(DATEDIFF(month,HireDate,ExitDate)) as WorkingMonths, country
from EmployeeData
group by City, country
order by WorkingMonths desc


--Departments which have the highest number of employees that did left, quit or retired...etc
Select distinct Department, count(ExitDate) as QuitEmployees
from EmployeeData
group by Department
order by QuitEmployees desc

--If I just want to create a new table for additional Employees as an example...
drop table if exists PlusEmployees
create table PlusEmployees(
EmployeeID varchar(100), FullName varchar(100), JobTitle varchar(100), Department varchar(100), BusinessUnit varchar(100), Gender varchar(100), Ethnicity varchar(100), Age int
)
insert into PlusEmployees values('E495860', 'Chris Wahlborg' , 'Human Resource Manager', 'Human Resources', 'Research & Development', 'Male', 'Caucasian', 34)
select * from PlusEmployees
--We can add the previous data of Employees to the new table
insert into PlusEmployees
select EmployeeID, FullName, JobTitle, Department, BusinessUnit, Gender, Ethnicity, Age
from EmployeeData

