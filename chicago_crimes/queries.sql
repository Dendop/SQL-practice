--1.List the total number of reported crimes between 2018-2023
SELECT COUNT("date_reported")
FROM "chicago_crimes";

--2. List the total amount if Homicides,Batteries,Assaults 2018-2023
SELECT "primary_type" AS "crimes",
        COUNT(*) AS "number_of_crimes"
FROM "chicago_crimes"
WHERE "primary_type" IN ('homicide','assault','battery')
GROUP BY "primary_type"
ORDER BY "number_of_crimes" DESC;

--3. Which are the top 3 most common crimes, and what is the percentage from total amount of reported crimes?
SELECT c."primary_type", 
        COUNT(c."crime_id") AS "number_of_crimes",
        x."total_crimes",
        ROUND(COUNT(c."crime_id") * 100 / x."total_crimes", 2) AS "percentage"
FROM "chicago_crimes" AS c,
     (SELECT COUNT(*) AS "total_crimes" FROM "chicago_crimes") AS x
GROUP BY c."primary_type"
ORDER BY "number_of_crimes" DESC
LIMIT 3;

--4. What are the top 10 communities that had the Most amount of crimes, include current population, density and order by the num of reported crimes
SELECT "communities"."name","communities"."population","communities"."density", COUNT(*) AS "reported_crimes"
FROM "chicago_crimes"
JOIN "communities" ON "communities"."id" = "chicago_crimes"."community_area"
GROUP BY "communities"."name", "communities"."population", "communities"."density"
ORDER BY "reported_crimes" DESC
LIMIT 10;


--5. What are the top ten communities that had the least amount of crimes? include the current pop,density and order by the num of reported crimes
--6. What month had the most crimes reported and what was the average and median temperature high in the last six years?
--7. What month had the most homicides reported and what was the average and median temperature high in the last six years?
--8. List the most violent year and the number of arrests with percentage. Order by the number of crimes in decending order. Determine the most violent year by the number of reported Homicides, Assaults and Battery for that year.
--9. List the day of the week, year, average precipitation, average high temperature and the highest number of reported crimes for days with and without precipitation.
--10. List the days with the most reported crimes when there is zero precipitation and the day when precipitation is greater than .5". Include the day of the week, high temperature, amount and precipitation and the total number of reported crimes for that day.
--11. List the most consecutive days where a homicide occured between 2018-2023 and the timeframe.
--12. What are the top 10 most common locations for reported crimes and the number of reported crime (add percentage) depending on the temperature?
--13. Calculate the year over year growth in the number of reported crimes.
--14. Calculate the year over year growth in the number of reported domestic violence crimes.
--15. Calculate the year over year growth in the number of reported domestic violence crimes.
--16. List the number of crimes reported and seasonal growth for each astronomical season and what was the average temperature for each season in 2020? Use a conditional statement to display either a Gain/Loss for the season and the season over season growth.