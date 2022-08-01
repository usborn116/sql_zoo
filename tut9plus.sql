SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'SPAIN'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn

SELECT name, DAY(whn), confirmed,
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn

SELECT name, DAY(whn), confirmed -
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS new
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn

SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'), confirmed -
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS new
 FROM covid
WHERE name = 'Italy'
AND WEEKDAY(whn) = 0 AND YEAR(whn) = 2020
ORDER BY whn

SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'), 
 tw.confirmed -
   LAG(tw.confirmed, 1) OVER (PARTITION BY name ORDER BY tw.whn) AS new
 FROM covid tw LEFT JOIN covid lw ON 
  DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
   AND tw.name=lw.name
WHERE tw.name = 'Italy'
AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn

SELECT 
   name,
   confirmed,
   RANK() OVER (ORDER BY confirmed DESC) rc,
   deaths,
   RANK() OVER (ORDER BY deaths DESC) rd
  FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC

SELECT world.name,
       ROUND(100000*confirmed/population,0) infection_rates_per_100000,
       RANK() OVER (ORDER BY confirmed/population) rank_infection_rates
  FROM covid JOIN world ON covid.name = world.name
 WHERE whn = '2020-04-20' AND population > 10000000
 ORDER BY population DESC;

SELECT name, date, peakNewCases
FROM
(
	SELECT name, date, peakNewCases, RANK() OVER (PARTITION BY name ORDER BY peakNewCases DESC) AS r
	FROM
	(
		SELECT name, DATE_FORMAT(whn,'%Y-%m-%d') AS date, confirmed - (LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)) AS peakNewCases
		FROM covid
	) TAB
	WHERE peakNewCases >= 1000
) TAB
WHERE r = 1
ORDER BY date