CREATE TABLE "temp_import_crimes"(
    "date_reported" TEXT,
    "city_block" TEXT,
    "primary_type" TEXT,
    "primary_description" TEXT,
    "location_description" TEXT,
    "arrest" TEXT,
    "domestic" TEXT,
    "community_area" INTEGER,
    "year" INTEGER,
    "latitude" REAL,
    "longitude" REAL,
    "location" TEXT
    );
.import --csv --skip 1 chicago_crime_2018.csv temp_import_crimes
.import --csv --skip 1 chicago_crime_2019.csv temp_import_crimes
.import --csv --skip 1 chicago_crime_2020.csv temp_import_crimes
.import --csv --skip 1 chicago_crime_2021.csv temp_import_crimes
.import --csv --skip 1 chicago_crime_2022.csv temp_import_crimes
.import --csv --skip 1 chicago_crime_2023.csv temp_import_crimes

--change city_block to "street_name"
CREATE TABLE "chicago_crimes" (
    "crime_id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "date_reported" TEXT,
    "street_name" TEXT, 
    "primary_type" TEXT,
    "primary_description" TEXT,
    "location_description" TEXT,
    "arrest" TEXT,
    "domestic" TEXT,
    "community_area" INTEGER,
    "year" INTEGER,
    "latitude" REAL,
    "longitude" REAL,
    "crime_location" TEXT,
    FOREIGN KEY("date_reported") REFERENCES "weather"("date"),
    FOREIGN KEY("community_area") REFERENCES "communities"("id")
    );
-- Updating empty with NULL
UPDATE "temp_import_crimes"
SET "date_reported" = NULL
WHERE "date_reported" = '';

UPDATE "temp_import_crimes"
SET "city_block" = NULL
WHERE "city_block" = '';

UPDATE "temp_import_crimes"
SET "primary_type" = NULL
WHERE "primary_type" = '';

UPDATE "temp_import_crimes"
SET "primary_description" = NULL
WHERE "primary_description" = '';

UPDATE "temp_import_crimes" 
SET "location_description" = NULL
WHERE "location_description" = '';

UPDATE "temp_import_crimes"
SET "arrest" = NULL
WHERE "arrest" = '';

UPDATE "temp_import_crimes"
SET "domestic" = NULL
WHERE "domestic" = '';

UPDATE "temp_import_crimes"
SET "community_area" = NULL
WHERE "community_area" = '';

UPDATE "temp_import_crimes"
SET "year" = NULL
WHERE "year" = '';

UPDATE "temp_import_crimes"
SET "latitude" = NULL
WHERE "latitude" = '';

UPDATE "temp_import_crimes"
SET "longitude" = NULL
WHERE "longitude"= '';

UPDATE "temp_import_crimes" 
SET "location" = NULL
WHERE "location" = '';

--this will need to adjust format of city_block/street name "strip" also will have to strip date to assign forein key for weather table
INSERT INTO "chicago_crimes"(
    "date_reported",
    "street_name",
    "primary_type",
    "primary_description",
    "location_description",
    "arrest",
    "domestic",
    "community_area",
    "year",
    "latitude",
    "longitude",
    "crime_location"
    )
    SELECT
        substr(x."date_reported", 1, 10), --just in case Im extracting date because later it's assigned to "weather"."date"
        TRIM(LOWER(x."city_block")),
        TRIM(LOWER(x."primary_type")),
        TRIM(LOWER(x."primary_description")),
        TRIM(LOWER(x."location_description")),
        x."arrest",
        x."domestic",
        x."community_area",
        x."year",
        x."latitude",
        x."longitude",
        x."location"
    FROM "temp_import_crimes" AS x
    ORDER BY "date_reported";

--temporary weather table
CREATE TABLE "temp_weather"(
    "date" TEXT,
    "temp_high" INTEGER,
    "temp_low" INTEGER,
    "average" REAL,
    "precipitation" REAL
    );
.import --csv --skip 1 chicago_temps_18-23.csv temp_weather

CREATE TABLE "weather"(
    "date" TEXT PRIMARY KEY,
    "temp_high" INTEGER,
    "temp_low" INTEGER,
    "average_temp" REAL,
    "precipitation" REAL
    );
--inserting into main weather table
INSERT INTO "weather" (
    "date",
    "temp_high",
    "temp_low",
    "average_temp",
    "precipitation"
    )
    SELECT
        x."date",
        x."temp_high",
        x."temp_low",
        x."average",
        x."precipitation"
    FROM "temp_weather" AS x;

--create temporary table to import comunity
CREATE TABLE "temp_community" (
    "community_id" INTEGER PRIMARY KEY,
    "name" TEXT,
    "population" INTEGER,
    "area_sq_mi" REAL,
    "density" REAL
    );
.import --csv --skip 1 chicago_areas.csv temp_community

CREATE TABLE "communities" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT,
    "population" INTEGER,
    "area_sq_mi" REAL,
    "density" REAL
    );

INSERT INTO "communities"(
    "id",
    "name",
    "population",
    "area_sq_mi",
    "density"
    )
    SELECT
        x."community_id",
        x."name",
        x."population",
        x."area_sq_mi",
        x."density"
    FROM "temp_community" AS x;

--Drop temporary tables
DROP TABLE "temp_import_crimes";
DROP TABLE "temp_weather";
DROP TABLE "temp_community";