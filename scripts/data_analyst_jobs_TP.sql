-- 1. How many rows are in the data_analyst_jobs table? 
-- 1793

SELECT COUNT(*)
FROM data_analyst_jobs;

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting 
-- on the 10th row? 
-- ExxonMobil

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
-- Tennessee = 21, Tennesse & Kentucky = 27

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN';

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN'
OR location = 'KY';

-- 4. How many postings in Tennessee have a star rating above 4?
-- 3

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN'
AND star_rating > 4;

-- 5. How many postings in the dataset have a review count between 500 and 1000?
-- 151

SELECT COUNT (*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

-- 6. Show the average star rating for companies in each state. The output should show the state as 
-- state and the average rating for the state as avg_rating. Which state shows the highest average rating?
-- Nebraska

SELECT data_analyst_jobs.location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY state
ORDER BY avg_rating DESC;

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there?
-- 881

SELECT DISTINCT title
FROM data_analyst_jobs;

-- 8. How many unique job titles are there for California companies?
-- 230

SELECT DISTINCT title, location
FROM data_analyst_jobs
WHERE location = 'CA';

-- 9. Find the name of each company and its average star rating for all companies that have more 
-- than 5000 reviews across all locations. How many companies are there with more that 5000 reviews 
-- across all locations?
-- 71

SELECT company, SUM(data_analyst_jobs.review_count) AS total_review_count, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(data_analyst_jobs.review_count) > 5000
ORDER BY SUM(data_analyst_jobs.review_count);

-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company 
-- with more than 5000 reviews across all locations in the dataset has the highest star rating? What is 
-- that rating?
-- Google, ~4.3

SELECT company, SUM(data_analyst_jobs.review_count) AS total_review_count, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(data_analyst_jobs.review_count) > 5000
ORDER BY AVG(star_rating) DESC;

-- 11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
-- 774

SELECT DISTINCT	title
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

-- 12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 
-- What word do these positions have in common?
-- 4, Data

SELECT DISTINCT	title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%'
	AND title NOT ILIKE '%Analytics%';
	
-- Bonus: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs 
-- by industry (domain) that require SQL and have been posted longer than 3 weeks.
-- Disregard any postings where the domain is NULL.
-- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
-- Which three industries are in the top 4 on this list? How many jobs have been listed for more than 
-- 3 weeks for each of the top 4?
-- Internet & Software - 62, Banks & Financial Services - 61, Consulting & Business Services - 57, Health Care - 52

SELECT Domain, COUNT(title) AS total_jobs
	 FROM 
	 (SELECT domain, title
	  FROM data_analyst_jobs
	  WHERE skill ILIKE '%SQL%'
	 AND days_since_posting > 21
	 AND domain IS NOT null) AS sub
GROUP BY domain
ORDER BY total_jobs DESC;