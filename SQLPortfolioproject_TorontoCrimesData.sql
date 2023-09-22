/* Data insights into Toronto crimes data */
--IF OBJECT_ID('CrimesByCategory', 'V') IS NOT NULL
--DROP VIEW CrimesByCategory;

-- Create the view
-- This shows crimes by Category

CREATE VIEW CrimesByCategory AS
SELECT
    MCI_CATEGORY, 
    COUNT(MCI_CATEGORY) AS CountofCrimeCategory
FROM TorontoCrimeData
GROUP BY MCI_CATEGORY

-- Total Crimes by Neighbourhood with percentages
CREATE VIEW CrimesByNeighbourhood AS
select NEIGHBOURHOOD_140, 
	COUNT(OFFENCE) as CountofOffence,
	COUNT(OFFENCE) * 100.0 / SUM(COUNT(OFFENCE)) OVER () as Percentage
from TorontoCrimeData
group by NEIGHBOURHOOD_140

-- Total offences versus population of each Toronto neighbourhood
CREATE VIEW OffenceVSPopulation AS
select TC.NEIGHBOURHOOD_140,
       COUNT(TC.OFFENCE) AS CountofOffence,
       TP.Total_Population,
       (COUNT(TC.OFFENCE) * 100.0) / TP.Total_Population as OffensesPerPopulation
from TorontoCrimeData TC
join TorontoPopulation TP ON TC.NEIGHBOURHOOD_140 = TP.NEIGHBOURHOOD_140
group by TC.NEIGHBOURHOOD_140, TP.Total_Population

-- Total Crimes by year
CREATE VIEW TotalCrimesPerYear AS
select OCC_YEAR, COUNT(OFFENCE) as CountofOffence
from TorontoCrimeData
where OCC_YEAR is not null
group by OCC_YEAR

-- Total and Average daily crimes occurrence
SELECT
    COUNT(*) AS TotalOccurrences,
    COUNT(*) * 1.0 / DATEDIFF(day, MIN(OCC_DATE), MAX(OCC_DATE)) AS AvgDailyOccurrence
FROM TorontoCrimeData


SELECT * FROM CrimesByCategory
SELECT * FROM CrimesByNeighbourhood
SELECT * FROM OffenceVSPopulation
SELECT * FROM TotalCrimesPerYear