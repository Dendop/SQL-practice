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
SELECT "communities"."name", "communities"."population", "communities"."density", COUNT(*) AS "number_of_crimes"
FROM "chicago_crimes"
JOIN "communities" ON "communities"."id" = "chicago_crimes"."community_area"
GROUP BY "communities"."name", "communities"."population", "communities"."density"
ORDER BY "number_of_crimes" ASC
LIMIT 10;

