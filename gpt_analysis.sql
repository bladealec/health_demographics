-- 1. Find the top 3 countries with the largest increase in life expectancy from 2005 to 2010.
SELECT Country, (MAX("Life expectancy ") - MIN("Life expectancy ")) AS increase_in_life_expectancy
FROM health_data
WHERE Year IN (2005, 2010)
GROUP BY Country
ORDER BY increase_in_life_expectancy DESC
LIMIT 3;

-- 2. Calculate the average 'Income composition of resources' for countries with a life expectancy above 75 in the year 2010.
SELECT AVG("Income composition of resources") AS avg_income_composition
FROM health_data
WHERE "Life expectancy " > 75 AND Year = 2010;

-- 3. List the countries that had a decrease in 'Adult Mortality' from 2000 to 2010.
SELECT DISTINCT Country
FROM health_data
WHERE "Adult Mortality" > (SELECT "Adult Mortality" FROM health_data WHERE Year = 2000 AND Country = health_data.Country)
  AND Year = 2010;

-- 4. Determine the year with the highest total 'percentage expenditure' on healthcare in 'Developed' countries.
SELECT Year, SUM("percentage expenditure") AS total_expenditure
FROM health_data
WHERE Status = 'Developed'
GROUP BY Year
ORDER BY total_expenditure DESC
LIMIT 1;

-- 5. Find the country with the highest 'Total expenditure' on healthcare as a percentage of GDP in 2014.
SELECT Country
FROM health_data
WHERE Year = 2014
ORDER BY ("Total expenditure" / GDP) DESC
LIMIT 1;

-- 6. Calculate the correlation coefficient between 'Income composition of resources' and 'Schooling' across all years and countries.
SELECT CORR("Income composition of resources", Schooling) AS correlation_coefficient
FROM health_data;

-- 7. Identify the country that had the steepest increase in 'HIV/AIDS' rate from 2000 to 2010.
SELECT Country, MAX("HIV/AIDS" - LAG("HIV/AIDS", 1) OVER (PARTITION BY Country ORDER BY Year)) AS max_increase
FROM health_data
WHERE Year BETWEEN 2000 AND 2010
GROUP BY Country
ORDER BY max_increase DESC
LIMIT 1;

-- 8. Calculate the average 'BMI' for countries with a population above 100 million in the year 2013.
SELECT AVG(BMI) AS avg_bmi
FROM health_data
WHERE Year = 2013 AND Population > 1e8;

-- 9. List the countries that had a decrease in 'thinness 1-19 years' from 2005 to 2010.
SELECT DISTINCT Country
FROM health_data
WHERE "thinness  1-19 years" > (SELECT "thinness  1-19 years" FROM health_data WHERE Year = 2005 AND Country = health_data.Country)
  AND Year = 2010;

-- 10. Find the year when the most countries had a 'Polio' vaccination coverage above 90%.
SELECT Year, COUNT(*) AS countries_above_90_percent
FROM health_data
WHERE Polio > 90
GROUP BY Year
ORDER BY countries_above_90_percent DESC
LIMIT 1;

-- 11. Determine the country with the highest 'Alcohol' consumption that also had a 'Schooling' rate above the global average in 2012.
SELECT Country
FROM health_data
WHERE Year = 2012 AND "Alcohol" = (SELECT MAX("Alcohol") FROM health_data WHERE Year = 2012)
  AND Schooling > (SELECT AVG(Schooling) FROM health_data WHERE Year = 2012);

-- 12. Calculate the average 'Total expenditure' on healthcare as a percentage of GDP for 'Developed' countries in 2010.
SELECT AVG("Total expenditure" / GDP) AS avg_expenditure_percentage
FROM health_data
WHERE Status = 'Developed' AND Year = 2010;

-- 13. List the countries with the largest difference between 'thinness 1-19 years' and 'thinness 5-9 years' in the year 2012.
SELECT Country, ("thinness  1-19 years" - "thinness 5-9 years") AS difference
FROM health_data
WHERE Year = 2012
ORDER BY difference DESC
LIMIT 1;

-- 14. Find the year when the average 'GDP' was highest for 'Developing' countries.
SELECT Year, AVG(GDP) AS avg_gdp
FROM health_data
WHERE Status = 'Developing'
GROUP BY Year
ORDER BY avg_gdp DESC
LIMIT 1;

-- 15. Determine the country with the highest 'Hepatitis B' vaccination coverage in the year 2013.
SELECT Country
FROM health_data
WHERE Year = 2013
ORDER BY "Hepatitis B" DESC
LIMIT 1;
