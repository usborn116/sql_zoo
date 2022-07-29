SELECT SUM(population)
FROM world

SELECT DISTINCT continent
FROM world

SELECT SUM(gdp)
FROM world WHERE continent = 'Africa'

SELECT COUNT(*)
FROM world WHERE area >= 1000000

SELECT SUM(population)
FROM world WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

SELECT continent, COUNT(name)
FROM world GROUP BY continent

SELECT continent, COUNT(name)
FROM world WHERE population >= 10000000 GROUP BY continent

SELECT continent
FROM world x WHERE (SELECT SUM(population) 
FROM world y WHERE x.continent = y.continent) >= 100000000 
GROUP BY continent