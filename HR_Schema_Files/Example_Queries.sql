/*
 * Example queries to explore SQL explain plans.
 * SQL Live worksheet available online: https://www.oracle.com/technetwork/database/application-development/livesql/index.html
 */
 
--| Query single table
SELECT
	job_title,
	min_salary,
	max_salary
FROM hr.jobs;

--| Simple filter
SELECT
	job_title,
	min_salary,
	max_salary
FROM hr.jobs
WHERE min_salary >= 5000;
	
--| Join two tables	
SELECT 
	a.region_name,
    b.country_id,
    b.country_name
FROM hr.regions a
INNER JOIN hr.countries b
	ON a.region_id = b.region_id;
	

--| Join multiple tables
SELECT 
	a.region_name,
	b.country_id,
	b.country_name,
	c.street_address,
	c.postal_code,
	c.city,
	c.state_province
FROM hr.regions a
INNER JOIN hr.countries b
    ON a.region_id = b.region_id
INNER JOIN hr.locations c
    ON b.country_id = b. country_id;
	
--| Analytic function
SELECT 
	first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    MAX(salary) OVER (PARTITION BY job_id) AS max_salary_per_job
FROM hr.employees;

--| Group by
SELECT 
    job_id,
    MAX(salary) AS max_salary
FROM hr.employees
GROUP BY job_id;
	
	
/*
 * Generating Explain Plan 
 */
EXPLAIN PLAN FOR

<INSERT SQL QUERY HERE>;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

--| Working example
EXPLAIN PLAN FOR
SELECT
	job_title,
	min_salary,
	max_salary
FROM hr.jobs;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

--| Expanded plan
SELECT plan_table_output FROM TABLE(DBMS_XPLAN.DISPLAY('plan_table', null, 'typical +note'));