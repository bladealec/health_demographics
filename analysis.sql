SELECT *
FROM health_data;

-- 1. Find the top 3 countries with the largest increase in life expectancy from 2005 to 2010.

SELECT health_2010.country,
	   health_2005."Life expectancy" AS expectancy_2005,
	   health_2010."Life expectancy" AS expectancy_2010,
	   (health_2010."Life expectancy" - health_2005."Life expectancy") AS expectancy_diff

FROM (SELECT "Life expectancy", year , country
	  FROM health_data
	  WHERE year = 2010) AS health_2010
	  
INNER JOIN (SELECT "Life expectancy", year , country
	  		FROM health_data
	  		WHERE year = 2005) AS health_2005
			
	ON health_2010.country = health_2005.country
	
ORDER BY expectancy_diff DESC

LIMIT 3;


-- 2. Calculate the average 'Income composition of resources' for countries with a life expectancy above 75 in the year 2010.

SELECT AVG("Income composition of resources") AS "Avg income comp of resources", year
FROM health_data 
WHERE "Life expectancy" > 75
	AND year = 2010		
GROUP BY year;


-- 3. List the countries that had a decrease in 'Adult Mortality' from 2000 to 2010.

SELECT health_2010.country,
	   health_2000."Adult Mortality" AS adult_mortality_2005,
	   health_2010."Adult Mortality" AS adult_mortality_2010,
	   (health_2010."Adult Mortality" - health_2000."Adult Mortality") AS adult_mortality_diff

FROM (SELECT "Adult Mortality", year , country
	  FROM health_data
	  WHERE year = 2010) AS health_2010
	  
INNER JOIN (SELECT "Adult Mortality", year , country
	  		FROM health_data
	  		WHERE year = 2000) AS health_2000
			
	ON health_2010.country = health_2000.country
	
WHERE (health_2010."Adult Mortality" - health_2000."Adult Mortality") < 0	

ORDER BY adult_mortality_diff ASC;


-- 4. Determine the year with the highest total 'percentage expenditure' on healthcare in 'Developed' countries.

SELECT year,
	   SUM("percentage expenditure") AS total_perc_expenditure
FROM health_data
WHERE status LIKE 'Developed'
GROUP BY year
ORDER BY total_perc_expenditure DESC
LIMIT 1;


-- 5. Find the country with the highest 'Total expenditure' on healthcare as a percentage of GDP in 2014.

SELECT country, 
	   "Total expenditure",
	   gdp,
	   ("Total expenditure"/gdp) * 100 AS expenditure_per_gdp
	   
FROM health_data
WHERE year = 2014
ORDER BY expenditure_per_gdp DESC;


-- 6. Calculate the correlation coefficient between 'Income composition of resources' and 'Schooling' across all years and countries.

SELECT CORR("Income composition of resources", schooling)	   
FROM health_data;


-- 7. Identify the country that had the steepest increase in 'HIV/AIDS' rate from 2000 to 2010.

SELECT std_2000.country,
	   (std_2010."HIV/AIDS" - std_2000."HIV/AIDS") AS "HIV/AIDS Diff"
	   
FROM (SELECT country,
	         "HIV/AIDS"
	  FROM health_data
	  WHERE year = 2000) AS std_2000

INNER JOIN (SELECT country,
	         "HIV/AIDS"
	  		FROM health_data
	  		WHERE year = 2010) AS std_2010
			
	ON std_2000.country = std_2010.country
	
ORDER BY "HIV/AIDS Diff" DESC
LIMIT 1;


-- 8. Calculate the average 'BMI' for countries with a population above 100 million in the year 2013.

SELECT AVG(BMI) AS avg_bmi
FROM health_data
WHERE year = 2013
	  AND population >= 1000000;


-- 9. List the countries that had a decrease in 'thinness 1-19 years' from 2005 to 2010.

SELECT thin_2005.country

FROM (SELECT country, "thinness 1-19 years"
	  FROM health_data
	  WHERE year = 2005) AS thin_2005
	  
INNER JOIN (SELECT country, "thinness 1-19 years"
			FROM health_data
			WHERE year = 2010) AS thin_2010
			
		ON thin_2005.country = thin_2010.country
		
WHERE (thin_2010."thinness 1-19 years" - thin_2005."thinness 1-19 years") < 0;



-- 10. Find the year when the most countries had a 'Polio' vaccination coverage above 90%.

-- 11. Determine the country with the highest 'Alcohol' consumption that also had a 'Schooling' rate above the global average in 2012.

-- 12. Calculate the average 'Total expenditure' on healthcare as a percentage of GDP for 'Developed' countries in 2015.

-- 13. List the countries with the largest difference between 'thinness 1-19 years' and 'thinness 5-9 years' in the year 2014.

-- 14. Find the year when the average 'GDP' was highest for 'Developing' countries.

-- 15. Determine the country with the highest 'Hepatitis B' vaccination coverage in the year 2013.
