SELECT  
    d.dept_name, 
    ee.gender, 
    dm.emp_no, 
    dm.from_date, 
    dm.to_date, 
    e.calendar_year, 
    CASE 
        WHEN YEAR(dm.to_date) >= e.calendar_year AND YEAR(dm.from_date) <= e.calendar_year THEN 1 
        ELSE 0 
    END AS ‘Active’, dm.from_date AS ‘From Date’, dm.to_date AS ‘To Date’ 
FROM 
    (SELECT  
        YEAR(hire_date) AS calendar_year 
    FROM 
        t_employees 
    GROUP BY calendar_year) AS e 

CROSS JOIN t_dept_manager dm 
JOIN t_departments d ON dm.dept_no = d.dept_no 
JOIN t_employees ee ON dm.emp_no = ee.emp_no  
ORDER BY dm.emp_no, calendar_year;
-- This can be done without the subquery and the CROSS JOIN by changing the FROM statement.
-- The GROUP BY in the FROM statement eliminates the duplicates.  
-- Order of operations: FROM & JOIN, WHERE, GROUP BY, HAVING, SELECT & TOP, ORDER BY, UNION  